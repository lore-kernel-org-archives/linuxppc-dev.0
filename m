Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 1F327DDEA3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 19:14:00 +1000 (EST)
Date: Sat, 25 Aug 2007 11:13:58 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] atyfb: force 29MHz xtal on G3 PowerBooks
Message-ID: <20070825091358.GA12235@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The atyfb does not work on my 233MHz PowerBook with Mach64 LP, when the
kernel is booted from firmware. aty_ld_pll_ct() returns 0x22 and xtal
remains at 14.31818. When booted from MacOS, aty_ld_pll_ct() returns 0x3c
and xtal is changed to 29.498928.
Google indicates that all 4 PowerBook models need the higher value.

Signed-off-by: Olaf Hering <olaf@aepfle.de>

--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2411,7 +2411,7 @@ static int __devinit aty_init(struct fb_
 				diff1 = -diff1;
 			if (diff2 < 0)
 				diff2 = -diff2;
-			if (diff2 < diff1) {
+			if (diff2 < diff1 || (M64_HAS(G3_PB_1024x768))) {
 				par->ref_clk_per = 1000000000000ULL / 29498928;
 				xtal = "29.498928";
 			}
