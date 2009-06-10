Return-Path: <geert@sonycom.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 198D5B720C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 00:39:19 +1000 (EST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 15/33] ps3vram: Remove no longer used ps3vram_priv.ddr_base
Date: Wed, 10 Jun 2009 16:38:50 +0200
Message-Id: <1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
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
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
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

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Jim Paris <jim@jtan.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ps3vram.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 7d1c742..5f408c6 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -73,7 +73,6 @@ struct ps3vram_priv {
 	u64 context_handle;
 	u32 *ctrl;
 	u32 *reports;
-	u8 __iomem *ddr_base;
 	u8 *xdr_buf;
 
 	u32 *fifo_base;
@@ -702,19 +701,11 @@ static int __devinit ps3vram_probe(struct ps3_system_bus_device *dev)
 		goto out_free_context;
 	}
 
-	priv->ddr_base = ioremap_flags(ddr_lpar, ddr_size, _PAGE_NO_CACHE);
-
-	if (!priv->ddr_base) {
-		dev_err(&dev->core, "ioremap DDR failed\n");
-		error = -ENOMEM;
-		goto out_unmap_context;
-	}
-
 	priv->ctrl = ioremap(ctrl_lpar, 64 * 1024);
 	if (!priv->ctrl) {
 		dev_err(&dev->core, "ioremap CTRL failed\n");
 		error = -ENOMEM;
-		goto out_unmap_vram;
+		goto out_unmap_context;
 	}
 
 	priv->reports = ioremap(reports_lpar, reports_size);
@@ -791,8 +782,6 @@ out_unmap_reports:
 	iounmap(priv->reports);
 out_unmap_ctrl:
 	iounmap(priv->ctrl);
-out_unmap_vram:
-	iounmap(priv->ddr_base);
 out_unmap_context:
 	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF, xdr_lpar,
 			      XDR_BUF_SIZE, CBE_IOPTE_M);
@@ -822,7 +811,6 @@ static int ps3vram_remove(struct ps3_system_bus_device *dev)
 	ps3vram_cache_cleanup(dev);
 	iounmap(priv->reports);
 	iounmap(priv->ctrl);
-	iounmap(priv->ddr_base);
 	lv1_gpu_context_iomap(priv->context_handle, XDR_IOIF,
 			      ps3_mm_phys_to_lpar(__pa(priv->xdr_buf)),
 			      XDR_BUF_SIZE, CBE_IOPTE_M);
-- 
1.6.2.4
