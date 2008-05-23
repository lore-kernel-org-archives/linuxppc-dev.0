Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D5D5DE062
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:34:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4N8YZ5f006758
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:34:35 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4N8YUqa012505
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:34:34 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/4 V5] Enable MSI support for MPC8610HPCD board
Date: Fri, 23 May 2008 16:32:47 +0800
Message-Id: <1211531568-31402-3-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enable the MSI on 8610hpcd board.
Through the msi-available-ranges property, All the 256
msi interrupts can be tested on this board.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
In this version:
Add a flag MPIC_BROKEN_FRR_NIRQS in mpic_alloc making the mpic use
irq_count instead of FRR[NIRQ] to initialize the interrupt controller.
So the hwirq num need to be changed.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   16 ++++++++++++++++
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    3 ++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 08a780d..fa9c297 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -182,6 +182,22 @@
 			big-endian;
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x100>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0
+				0xe4 0
+				0xe5 0
+				0xe6 0
+				0xe7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8610-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index dea1320..eb16208 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -70,7 +70,8 @@ static void __init mpc86xx_hpcd_init_irq(void)
 
 	/* Alloc mpic structure and per isu has 16 INT entries. */
 	mpic1 = mpic_alloc(np, res.start,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			MPIC_PRIMARY | MPIC_WANTS_RESET |
+			MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " MPIC     ");
 	BUG_ON(mpic1 == NULL);
 
-- 
1.5.4
