Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF0812C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 07:34:15 +1100 (EST)
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3YlRH82Ymbz4KK28
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:12 +0100 (CET)
Received: from localhost (p4FDE760D.dip.t-dialin.net [79.222.118.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3YlRH76bWWzbbfY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:11 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] mpc5121: remove obsolete cell-index property from PSC
 clock code
Date: Mon, 14 Jan 2013 21:34:07 +0100
Message-Id: <1358195648-18678-3-git-send-email-agust@denx.de>
In-Reply-To: <1358195648-18678-1-git-send-email-agust@denx.de>
References: <1358195648-18678-1-git-send-email-agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't use cell-index from device tree, obtain the PSC number
from PSCx register offset.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/clock.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index 9f771e0..d0095c8 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -680,13 +680,12 @@ static void psc_calc_rate(struct clk *clk, int pscnum, struct device_node *np)
 static void psc_clks_init(void)
 {
 	struct device_node *np;
-	const u32 *cell_index;
 	struct platform_device *ofdev;
+	u32 reg;
 
 	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
-		cell_index = of_get_property(np, "cell-index", NULL);
-		if (cell_index) {
-			int pscnum = *cell_index;
+		if (!of_property_read_u32(np, "reg", &reg)) {
+			int pscnum = (reg & 0xf00) >> 8;
 			struct clk *clk = psc_dev_clk(pscnum);
 
 			clk->flags = CLK_HAS_RATE | CLK_HAS_CTRL;
-- 
1.7.5.4
