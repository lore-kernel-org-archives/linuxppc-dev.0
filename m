Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0794F1A0EE1
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:22 +1100 (AEDT)
Received: by mail-yk0-f177.google.com with SMTP id 19so19088810ykq.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:19 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 03/15] fbdev: aty128fb: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:33 +0800
Message-Id: <1422712065-9403-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Paul Mackerras <paulus@samba.org>
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
1.9.3
