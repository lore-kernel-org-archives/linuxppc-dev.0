Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B36D1B722D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:19 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 12/33] ps3vram: GPU memory mapping cleanup
Date: Wed, 10 Jun 2009 16:38:47 +0200
Message-Id: <1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-4-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-5-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-6-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-7-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
Sender: Geert Uytterhoeven <geert@sonycom.com>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Jens Axboe <axboe@kernel.dk>,
	cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  - Make the IOMMU flags used for mapping main memory into the GPU's I/O space
    explicit, instead of relying on the default in the hypervisor,
  - Add missing calls to lv1_gpu_context_iomap(..., CBE_IOPTE_M) to unmap the
    memory during cleanup.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
v2: Add CBE_ prefix

 drivers/block/ps3vram.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 48c92ae..4418d59 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -14,6 +14,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/firmware.h>
+#include <asm/iommu.h>
 #include <asm/lv1call.h>
 #include <asm/ps3.h>
 
@@ -623,8 +624,8 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	int error, status;
 	struct request_queue *queue;
 	struct gendisk *gendisk;
-	u64 ddr_lpar, ctrl_lpar, info_lpar, reports_lpar, ddr_size,
-	    reports_size;
+	u64 ddr_size, ddr_lpar, ctrl_lpar, info_lpar, reports_lpar,
+	    reports_size, xdr_lpar;
 	char *rest;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
@@ -696,9 +697,11 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	}
 
 	/* Map XDR buffer to RSX */
+	xdr_lpar = ps3_mm_phys_to_lpar(__pa(priv->xdr_buf));
 	status = lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF,
-				       ps3_mm_phys_to_lpar(__pa(priv->xdr_buf)),
-				       XDR_BUF_SIZE, 0);
+				       xdr_lpar, XDR_BUF_SIZE,
+				       CBE_IOPTE_PP_W | CBE_IOPTE_PP_R |
+				       CBE_IOPTE_M);
 	if (status) {
 		dev_err(&dev->core, "lv1_gpu_context_iomap failed %d\n",
 			status);
@@ -711,7 +714,7 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 	if (!priv->ddr_base) {
 		dev_err(&dev->core, "ioremap DDR failed\n");
 		error = -ENOMEM;
-		goto out_free_context;
+		goto out_unmap_context;
 	}
 
 	priv->ctrl = ioremap(ctrl_lpar, 64 * 1024);
@@ -797,6 +800,9 @@ out_unmap_ctrl:
 	iounmap(priv->ctrl);
 out_unmap_vram:
 	iounmap(priv->ddr_base);
+out_unmap_context:
+	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF, xdr_lpar,
+			      XDR_BUF_SIZE, CBE_IOPTE_M);
 out_free_context:
 	lv1_gpu_context_free(priv->context_handle);
 out_free_memory:
@@ -824,6 +830,9 @@ static int ps3vram_remove(struct ps3_system_bus_device *dev)
 	iounmap(priv->reports);
 	iounmap(priv->ctrl);
 	iounmap(priv->ddr_base);
+	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF,
+			      ps3_mm_phys_to_lpar(__pa(priv->xdr_buf)),
+			      XDR_BUF_SIZE, CBE_IOPTE_M);
 	lv1_gpu_context_free(priv->context_handle);
 	lv1_gpu_memory_free(priv->memory_handle);
 	ps3_close_hv_device(dev);
-- 
1.6.2.4
