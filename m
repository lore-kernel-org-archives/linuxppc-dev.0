Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com
 [IPv6:2607:f8b0:4002:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2C0F1A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:33:14 +1100 (AEDT)
Received: by yks20 with SMTP id 20so7199086yks.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 05:33:12 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 2/9] fbdev: aty128fb: replace PPC_OF with PPC
Date: Thu, 12 Mar 2015 20:32:43 +0800
Message-Id: <1426163570-10281-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
References: <1426163570-10281-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/aty/aty128fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index aedf2fbf9bf6..0156954bf340 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -965,7 +965,7 @@ static void __iomem *aty128_find_mem_vbios(struct aty128fb_par *par)
 /* fill in known card constants if pll_block is not available */
 static void aty128_timings(struct aty128fb_par *par)
 {
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 	/* instead of a table lookup, assume OF has properly
 	 * setup the PLL registers and use their values
 	 * to set the XCLK values and reference divider values */
@@ -979,7 +979,7 @@ static void aty128_timings(struct aty128fb_par *par)
 	if (!par->constants.ref_clk)
 		par->constants.ref_clk = 2950;
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC
 	x_mpll_ref_fb_div = aty_ld_pll(X_MPLL_REF_FB_DIV);
 	xclk_cntl = aty_ld_pll(XCLK_CNTL) & 0x7;
 	Nx = (x_mpll_ref_fb_div & 0x00ff00) >> 8;
-- 
2.1.0
