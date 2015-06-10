Return-Path: <geoff@infradead.org>
Message-Id: <890cb328d8a996f52117cc12a807fd55df644c34.1433959045.git.geoff@infradead.org>
In-Reply-To: <cover.1433959045.git.geoff@infradead.org>
References: <cover.1433959045.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/3] block/ps3vram: Fix sparse warnings
To: Jens Axboe <axboe@kernel.dk>
Cc: Jim Paris <jim@jtan.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, cbe-oss-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Wed, 10 Jun 2015 18:00:17 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix sparse warnings like these:

 drivers/block/ps3vram.c: warning: incorrect type in assignment (different address spaces)
 drivers/block/ps3vram.c:    expected unsigned int [usertype] *ctrl
 drivers/block/ps3vram.c:    got void [noderef] <asn:2>*

Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/block/ps3vram.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index ef45cfb..a7bf836 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -73,8 +73,8 @@ struct ps3vram_priv {
 
 	u64 memory_handle;
 	u64 context_handle;
-	u32 *ctrl;
-	void *reports;
+	u32 __iomem *ctrl;
+	void __iomem *reports;
 	u8 *xdr_buf;
 
 	u32 *fifo_base;
@@ -104,7 +104,7 @@ static char *size = "256M";
 module_param(size, charp, 0);
 MODULE_PARM_DESC(size, "memory size");
 
-static u32 *ps3vram_get_notifier(void *reports, int notifier)
+static u32 __iomem *ps3vram_get_notifier(void __iomem *reports, int notifier)
 {
 	return reports + DMA_NOTIFIER_OFFSET_BASE +
 	       DMA_NOTIFIER_SIZE * notifier;
@@ -113,22 +113,22 @@ static u32 *ps3vram_get_notifier(void *reports, int notifier)
 static void ps3vram_notifier_reset(struct ps3_system_bus_device *dev)
 {
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
-	u32 *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
+	u32 __iomem *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
 	int i;
 
 	for (i = 0; i < 4; i++)
-		notify[i] = 0xffffffff;
+		iowrite32be(0xffffffff, notify + i);
 }
 
 static int ps3vram_notifier_wait(struct ps3_system_bus_device *dev,
 				 unsigned int timeout_ms)
 {
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
-	u32 *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
+	u32 __iomem *notify = ps3vram_get_notifier(priv->reports, NOTIFIER);
 	unsigned long timeout;
 
 	for (timeout = 20; timeout; timeout--) {
-		if (!notify[3])
+		if (!ioread32be(notify + 3))
 			return 0;
 		udelay(10);
 	}
@@ -136,7 +136,7 @@ static int ps3vram_notifier_wait(struct ps3_system_bus_device *dev,
 	timeout = jiffies + msecs_to_jiffies(timeout_ms);
 
 	do {
-		if (!notify[3])
+		if (!ioread32be(notify + 3))
 			return 0;
 		msleep(1);
 	} while (time_before(jiffies, timeout));
@@ -148,8 +148,8 @@ static void ps3vram_init_ring(struct ps3_system_bus_device *dev)
 {
 	struct ps3vram_priv *priv = ps3_system_bus_get_drvdata(dev);
 
-	priv->ctrl[CTRL_PUT] = FIFO_BASE + FIFO_OFFSET;
-	priv->ctrl[CTRL_GET] = FIFO_BASE + FIFO_OFFSET;
+	iowrite32be(FIFO_BASE + FIFO_OFFSET, priv->ctrl + CTRL_PUT);
+	iowrite32be(FIFO_BASE + FIFO_OFFSET, priv->ctrl + CTRL_GET);
 }
 
 static int ps3vram_wait_ring(struct ps3_system_bus_device *dev,
@@ -159,14 +159,14 @@ static int ps3vram_wait_ring(struct ps3_system_bus_device *dev,
 	unsigned long timeout = jiffies + msecs_to_jiffies(timeout_ms);
 
 	do {
-		if (priv->ctrl[CTRL_PUT] == priv->ctrl[CTRL_GET])
+		if (ioread32be(priv->ctrl + CTRL_PUT) == ioread32be(priv->ctrl + CTRL_GET))
 			return 0;
 		msleep(1);
 	} while (time_before(jiffies, timeout));
 
 	dev_warn(&dev->core, "FIFO timeout (%08x/%08x/%08x)\n",
-		 priv->ctrl[CTRL_PUT], priv->ctrl[CTRL_GET],
-		 priv->ctrl[CTRL_TOP]);
+		 ioread32be(priv->ctrl + CTRL_PUT), ioread32be(priv->ctrl + CTRL_GET),
+		 ioread32be(priv->ctrl + CTRL_TOP));
 
 	return -ETIMEDOUT;
 }
@@ -189,7 +189,7 @@ static void ps3vram_rewind_ring(struct ps3_system_bus_device *dev)
 
 	ps3vram_out_ring(priv, 0x20000000 | (FIFO_BASE + FIFO_OFFSET));
 
-	priv->ctrl[CTRL_PUT] = FIFO_BASE + FIFO_OFFSET;
+	iowrite32be(FIFO_BASE + FIFO_OFFSET, priv->ctrl + CTRL_PUT);
 
 	/* asking the HV for a blit will kick the FIFO */
 	status = lv1_gpu_fb_blit(priv->context_handle, 0, 0, 0, 0);
@@ -207,8 +207,8 @@ static void ps3vram_fire_ring(struct ps3_system_bus_device *dev)
 
 	mutex_lock(&ps3_gpu_mutex);
 
-	priv->ctrl[CTRL_PUT] = FIFO_BASE + FIFO_OFFSET +
-			       (priv->fifo_ptr - priv->fifo_base) * sizeof(u32);
+	iowrite32be(FIFO_BASE + FIFO_OFFSET + (priv->fifo_ptr - priv->fifo_base)
+		* sizeof(u32), priv->ctrl + CTRL_PUT);
 
 	/* asking the HV for a blit will kick the FIFO */
 	status = lv1_gpu_fb_blit(priv->context_handle, 0, 0, 0, 0);
-- 
2.1.0
