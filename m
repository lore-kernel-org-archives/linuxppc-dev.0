Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id ABEB31007D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 07:59:55 +1100 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] carma-fpga: fix lockdep warning
Date: Thu, 26 Jan 2012 12:59:54 -0800
Message-Id: <1327611594-18455-1-git-send-email-iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Lockdep occasionally complains with the message:
INFO: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected

This is caused by calling videobuf_dma_unmap() under spin_lock_irq(). To
fix the warning, we drop the lock before unmapping and freeing the
buffer.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/misc/carma/carma-fpga.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/carma/carma-fpga.c b/drivers/misc/carma/carma-fpga.c
index 14e974b2..4fd896d 100644
--- a/drivers/misc/carma/carma-fpga.c
+++ b/drivers/misc/carma/carma-fpga.c
@@ -1079,6 +1079,7 @@ static ssize_t data_read(struct file *filp, char __user *ubuf, size_t count,
 	struct fpga_reader *reader = filp->private_data;
 	struct fpga_device *priv = reader->priv;
 	struct list_head *used = &priv->used;
+	bool drop_buffer = false;
 	struct data_buf *dbuf;
 	size_t avail;
 	void *data;
@@ -1166,10 +1167,12 @@ have_buffer:
 	 * One of two things has happened, the device is disabled, or the
 	 * device has been reconfigured underneath us. In either case, we
 	 * should just throw away the buffer.
+	 *
+	 * Lockdep complains if this is done under the spinlock, so we
+	 * handle it during the unlock path.
 	 */
 	if (!priv->enabled || dbuf->size != priv->bufsize) {
-		videobuf_dma_unmap(priv->dev, &dbuf->vb);
-		data_free_buffer(dbuf);
+		drop_buffer = true;
 		goto out_unlock;
 	}
 
@@ -1178,6 +1181,12 @@ have_buffer:
 
 out_unlock:
 	spin_unlock_irq(&priv->lock);
+
+	if (drop_buffer) {
+		videobuf_dma_unmap(priv->dev, &dbuf->vb);
+		data_free_buffer(dbuf);
+	}
+
 	return count;
 }
 
-- 
1.7.3.4
