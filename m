Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4963CDDF.1040101@am.sony.com>
Date: Tue, 6 Jan 2009 13:32:15 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 3/6] mtd/ps3vram: Remove ps3vram debug routines
References: <4963CA52.9030902@am.sony.com>
In-Reply-To: <4963CA52.9030902@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: David Woodhouse <David.Woodhouse@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Jim Paris <jim@jtan.com>, linuxppc-dev@ozlabs.org,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove the ps3vram debug routines ps3vram_dump_ring() and
ps3vram_dump_reports().  These routines are not needed.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/mtd/devices/ps3vram.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

--- a/drivers/mtd/devices/ps3vram.c
+++ b/drivers/mtd/devices/ps3vram.c
@@ -87,9 +87,6 @@ struct ps3vram_priv {
 #define DMA_NOTIFIER_HANDLE_BASE 0x66604200 /* first DMA notifier handle */
 #define DMA_NOTIFIER_OFFSET_BASE 0x1000     /* first DMA notifier offset */
 #define DMA_NOTIFIER_SIZE        0x40
-
-#define NUM_NOTIFIERS		16
-
 #define NOTIFIER 7	/* notifier used for completion report */
 
 /* A trailing '-' means to subtract off ps3fb_videomemory.size */
@@ -131,28 +128,6 @@ static int ps3vram_notifier_wait(struct 
 	return -1;
 }
 
-static void ps3vram_dump_ring(struct mtd_info *mtd)
-{
-	struct ps3vram_priv *priv = mtd->priv;
-	uint32_t *fifo;
-
-	pr_info("PUT = %08x GET = %08x\n", priv->ctrl[CTRL_PUT],
-		priv->ctrl[CTRL_GET]);
-	for (fifo = priv->fifo_base; fifo < priv->fifo_ptr; fifo++)
-		pr_info("%p: %08x\n", fifo, *fifo);
-}
-
-static void ps3vram_dump_reports(struct mtd_info *mtd)
-{
-	struct ps3vram_priv *priv = mtd->priv;
-	int i;
-
-	for (i = 0; i < NUM_NOTIFIERS; i++) {
-		uint32_t *n = ps3vram_get_notifier(priv->reports, i);
-		pr_info("%p: %08x\n", n, *n);
-	}
-}
-
 static void ps3vram_init_ring(struct mtd_info *mtd)
 {
 	struct ps3vram_priv *priv = mtd->priv;
@@ -284,8 +259,6 @@ static int ps3vram_upload(struct mtd_inf
 	ps3vram_fire_ring(mtd);
 	if (ps3vram_notifier_wait(mtd, 200) < 0) {
 		pr_err("notifier timeout\n");
-		ps3vram_dump_ring(mtd);
-		ps3vram_dump_reports(mtd);
 		return -1;
 	}
 
@@ -317,8 +290,6 @@ static int ps3vram_download(struct mtd_i
 	ps3vram_fire_ring(mtd);
 	if (ps3vram_notifier_wait(mtd, 200) < 0) {
 		pr_err("notifier timeout\n");
-		ps3vram_dump_ring(mtd);
-		ps3vram_dump_reports(mtd);
 		return -1;
 	}
 

-- 
