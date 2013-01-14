Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 152C02C009D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 07:40:05 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3YlRH915TRz3hhrp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:13 +0100 (CET)
Received: from localhost (p4FDE760D.dip.t-dialin.net [79.222.118.13])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA id 3YlRH907kvzbbfw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2013 21:34:12 +0100 (CET)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/4] mpc5121: don't check PSC ac97 using node name
Date: Mon, 14 Jan 2013 21:34:08 +0100
Message-Id: <1358195648-18678-4-git-send-email-agust@denx.de>
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

The .dtsi now names all PSC nodes as "psc", so this ac97
check won't work. Check for ac97 PSC using compatible
property.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/platforms/512x/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
index d0095c8..7937361 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -695,7 +695,7 @@ static void psc_clks_init(void)
 			 * AC97 is special rate clock does
 			 * not go through normal path
 			 */
-			if (strcmp("ac97", np->name) == 0)
+			if (of_device_is_compatible(np, "fsl,mpc5121-psc-ac97"))
 				clk->rate = ac97_clk.rate;
 			else
 				psc_calc_rate(clk, pscnum, np);
-- 
1.7.5.4
