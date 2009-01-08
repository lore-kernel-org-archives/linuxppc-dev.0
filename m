Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <4965553F.8050801@am.sony.com>
Date: Wed, 7 Jan 2009 17:22:07 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch] mtd/ps3vram: Use _PAGE_NO_CACHE in memory ioremap
References: <4963CDCA.4080802@am.sony.com>
In-Reply-To: <4963CDCA.4080802@am.sony.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: David Woodhouse <David.Woodhouse@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Jim Paris <jim@jtan.com>, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use _PAGE_NO_CACHE for gpu memory ioremap.  Also,
add __iomem attribute to gpu memory pointer and
change use of memset() to memset_io().

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 drivers/mtd/devices/ps3vram.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/mtd/devices/ps3vram.c
+++ b/drivers/mtd/devices/ps3vram.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
@@ -69,7 +70,7 @@ struct ps3vram_priv {
 	u64 context_handle;
 	u32 *ctrl;
 	u32 *reports;
-	u8 *base;
+	u8 __iomem *ddr_base;
 	u8 *xdr_buf;
 
 	u32 *fifo_base;
@@ -425,7 +426,7 @@ static int ps3vram_erase(struct mtd_info
 	ps3vram_cache_flush(mtd);
 
 	/* Set bytes to 0xFF */
-	memset(priv->base + instr->addr, 0xFF, instr->len);
+	memset_io(priv->ddr_base + instr->addr, 0xFF, instr->len);
 
 	mutex_unlock(&priv->lock);
 
@@ -628,8 +629,9 @@ static int __devinit ps3vram_probe(struc
 		goto out_free_context;
 	}
 
-	priv->base = ioremap(ddr_lpar, ddr_size);
-	if (!priv->base) {
+	priv->ddr_base = ioremap_flags(ddr_lpar, ddr_size, _PAGE_NO_CACHE);
+
+	if (!priv->ddr_base) {
 		dev_err(&dev->core, "%s:%d: ioremap failed\n", __func__,
 			__LINE__);
 		ret = -ENOMEM;
@@ -702,7 +704,7 @@ out_unmap_reports:
 out_unmap_ctrl:
 	iounmap(priv->ctrl);
 out_unmap_vram:
-	iounmap(priv->base);
+	iounmap(priv->ddr_base);
 out_free_context:
 	lv1_gpu_context_free(priv->context_handle);
 out_free_memory:
@@ -728,7 +730,7 @@ static int ps3vram_shutdown(struct ps3_s
 	ps3vram_cache_cleanup(&ps3vram_mtd);
 	iounmap(priv->reports);
 	iounmap(priv->ctrl);
-	iounmap(priv->base);
+	iounmap(priv->ddr_base);
 	lv1_gpu_context_free(priv->context_handle);
 	lv1_gpu_memory_free(priv->memory_handle);
 	ps3_close_hv_device(dev);
