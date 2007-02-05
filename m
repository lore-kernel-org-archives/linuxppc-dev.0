Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2DBF8DDECD
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 07:43:51 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l15KhjeQ001152
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 13:43:45 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l15Khi8D028859
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 14:43:45 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l15KPYmm013621
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 14:25:35 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 07C1B4B92C
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 14:43:40 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l15KhdQV003701
	for linuxppc-dev@ozlabs.org; Mon, 5 Feb 2007 14:43:39 -0600
Date: Mon, 5 Feb 2007 14:43:39 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] 83xx: Don't ioremap() from the reset function.
Message-ID: <20070205204339.GB3683@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ioremap() is not safe to call from interrupt context, so instead use the
whole-soc mapping to access the reset registers.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/83xx/misc.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f0c6df6..a4b14c1 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -23,18 +23,19 @@ void mpc83xx_restart(char *cmd)
 #define RST_OFFSET	0x00000900
 #define RST_PROT_REG	0x00000018
 #define RST_CTRL_REG	0x0000001c
-	__be32 __iomem *reg;
 
-	/* map reset register space */
-	reg = ioremap(get_immrbase() + 0x900, 0xff);
+	if (mpc83xx_immr) {
+		__be32 __iomem *reg = mpc83xx_immr + RST_OFFSET;
 
-	local_irq_disable();
+		local_irq_disable();
 
-	/* enable software reset "RSTE" */
-	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
+		/* enable software reset "RSTE" */
+		out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
+
+		/* set software hard reset */
+		out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
+	}
 
-	/* set software hard reset */
-	out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
 	for (;;) ;
 }
 
-- 
1.4.4
