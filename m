Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 83B581007E4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 08:00:15 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] carma-fpga: fix race between data dumping and DMA callback
Date: Thu, 26 Jan 2012 13:00:14 -0800
Message-Id: <1327611614-18508-1-git-send-email-iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the system is under heavy load, we occasionally saw a problem where
the system would get a legitimate interrupt when they should be
disabled.

This was caused by the data_dma_cb() DMA callback unconditionally
re-enabling FPGA interrupts even when data dumping is disabled. When
data dumping was re-enabled, the irq handler would fire while a DMA was
in progress. The "BUG_ON(priv->inflight != NULL);" during the second
invocation of the DMA callback caused the system to crash.

To fix the issue, the priv->enabled boolean is moved under the
protection of the priv->lock spinlock. The DMA callback checks the
boolean to know whether to re-enable FPGA interrupts before it returns.

Now that it is fixed, the driver keeps FPGA interrupts disabled when it
expects that they are disabled, fixing the bug.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/misc/carma/carma-fpga.c |  101 +++++++++++++++++++++++---------------
 1 files changed, 61 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/carma/carma-fpga.c b/drivers/misc/carma/carma-fpga.c
index 4fd896d..0cfc5bf 100644
--- a/drivers/misc/carma/carma-fpga.c
+++ b/drivers/misc/carma/carma-fpga.c
@@ -560,6 +560,9 @@ static void data_enable_interrupts(struct fpga_device *priv)
 
 	/* flush the writes */
 	fpga_read_reg(priv, 0, MMAP_REG_STATUS);
+	fpga_read_reg(priv, 1, MMAP_REG_STATUS);
+	fpga_read_reg(priv, 2, MMAP_REG_STATUS);
+	fpga_read_reg(priv, 3, MMAP_REG_STATUS);
 
 	/* switch back to the external interrupt source */
 	iowrite32be(0x3F, priv->regs + SYS_IRQ_SOURCE_CTL);
@@ -591,8 +594,12 @@ static void data_dma_cb(void *data)
 	list_move_tail(&priv->inflight->entry, &priv->used);
 	priv->inflight = NULL;
 
-	/* clear the FPGA status and re-enable interrupts */
-	data_enable_interrupts(priv);
+	/*
+	 * If data dumping is still enabled, then clear the FPGA
+	 * status registers and re-enable FPGA interrupts
+	 */
+	if (priv->enabled)
+		data_enable_interrupts(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -708,6 +715,15 @@ static irqreturn_t data_irq(int irq, void *dev_id)
 
 	spin_lock(&priv->lock);
 
+	/*
+	 * This is an error case that should never happen.
+	 *
+	 * If this driver has a bug and manages to re-enable interrupts while
+	 * a DMA is in progress, then we will hit this statement and should
+	 * start paying attention immediately.
+	 */
+	BUG_ON(priv->inflight != NULL);
+
 	/* hide the interrupt by switching the IRQ driver to GPIO */
 	data_disable_interrupts(priv);
 
@@ -762,11 +778,15 @@ out:
  */
 static int data_device_enable(struct fpga_device *priv)
 {
+	bool enabled;
 	u32 val;
 	int ret;
 
 	/* multiple enables are safe: they do nothing */
-	if (priv->enabled)
+	spin_lock_irq(&priv->lock);
+	enabled = priv->enabled;
+	spin_unlock_irq(&priv->lock);
+	if (enabled)
 		return 0;
 
 	/* check that the FPGAs are programmed */
@@ -797,6 +817,9 @@ static int data_device_enable(struct fpga_device *priv)
 		goto out_error;
 	}
 
+	/* prevent the FPGAs from generating interrupts */
+	data_disable_interrupts(priv);
+
 	/* hookup the irq handler */
 	ret = request_irq(priv->irq, data_irq, IRQF_SHARED, drv_name, priv);
 	if (ret) {
@@ -804,11 +827,13 @@ static int data_device_enable(struct fpga_device *priv)
 		goto out_error;
 	}
 
-	/* switch to the external FPGA IRQ line */
-	data_enable_interrupts(priv);
-
-	/* success, we're enabled */
+	/* allow the DMA callback to re-enable FPGA interrupts */
+	spin_lock_irq(&priv->lock);
 	priv->enabled = true;
+	spin_unlock_irq(&priv->lock);
+
+	/* allow the FPGAs to generate interrupts */
+	data_enable_interrupts(priv);
 	return 0;
 
 out_error:
@@ -834,41 +859,40 @@ out_error:
  */
 static int data_device_disable(struct fpga_device *priv)
 {
-	int ret;
+	spin_lock_irq(&priv->lock);
 
 	/* allow multiple disable */
-	if (!priv->enabled)
+	if (!priv->enabled) {
+		spin_unlock_irq(&priv->lock);
 		return 0;
+	}
+
+	/*
+	 * Mark the device disabled
+	 *
+	 * This stops DMA callbacks from re-enabling interrupts
+	 */
+	priv->enabled = false;
 
-	/* switch to the internal GPIO IRQ line */
+	/* prevent the FPGAs from generating interrupts */
 	data_disable_interrupts(priv);
 
+	/* wait until all ongoing DMA has finished */
+	while (priv->inflight != NULL) {
+		spin_unlock_irq(&priv->lock);
+		wait_event(priv->wait, priv->inflight == NULL);
+		spin_lock_irq(&priv->lock);
+	}
+
+	spin_unlock_irq(&priv->lock);
+
 	/* unhook the irq handler */
 	free_irq(priv->irq, priv);
 
-	/*
-	 * wait for all outstanding DMA to complete
-	 *
-	 * Device interrupts are disabled, therefore another buffer cannot
-	 * be marked inflight.
-	 */
-	ret = wait_event_interruptible(priv->wait, priv->inflight == NULL);
-	if (ret)
-		return ret;
-
 	/* free the correlation table */
 	sg_free_table(&priv->corl_table);
 	priv->corl_nents = 0;
 
-	/*
-	 * We are taking the spinlock not to protect priv->enabled, but instead
-	 * to make sure that there are no readers in the process of altering
-	 * the free or used lists while we are setting this flag.
-	 */
-	spin_lock_irq(&priv->lock);
-	priv->enabled = false;
-	spin_unlock_irq(&priv->lock);
-
 	/* free all buffers: the free and used lists are not being changed */
 	data_free_buffers(priv);
 	return 0;
@@ -896,15 +920,6 @@ static unsigned int list_num_entries(struct list_head *list)
 static int data_debug_show(struct seq_file *f, void *offset)
 {
 	struct fpga_device *priv = f->private;
-	int ret;
-
-	/*
-	 * Lock the mutex first, so that we get an accurate value for enable
-	 * Lock the spinlock next, to get accurate list counts
-	 */
-	ret = mutex_lock_interruptible(&priv->mutex);
-	if (ret)
-		return ret;
 
 	spin_lock_irq(&priv->lock);
 
@@ -917,7 +932,6 @@ static int data_debug_show(struct seq_file *f, void *offset)
 	seq_printf(f, "num_dropped: %d\n", priv->num_dropped);
 
 	spin_unlock_irq(&priv->lock);
-	mutex_unlock(&priv->mutex);
 	return 0;
 }
 
@@ -970,7 +984,13 @@ static ssize_t data_en_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct fpga_device *priv = dev_get_drvdata(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", priv->enabled);
+	int ret;
+
+	spin_lock_irq(&priv->lock);
+	ret = snprintf(buf, PAGE_SIZE, "%u\n", priv->enabled);
+	spin_unlock_irq(&priv->lock);
+
+	return ret;
 }
 
 static ssize_t data_en_set(struct device *dev, struct device_attribute *attr,
@@ -986,6 +1006,7 @@ static ssize_t data_en_set(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
+	/* protect against concurrent enable/disable */
 	ret = mutex_lock_interruptible(&priv->mutex);
 	if (ret)
 		return ret;
-- 
1.7.3.4
