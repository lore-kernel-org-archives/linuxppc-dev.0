Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9226CDE1A7
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 18:10:40 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4K8A7pc019020
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 01:10:27 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4K8A1Jh005417
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 03:10:06 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/4 V4] Enable MSI support for MPC8610HPCD board
Date: Tue, 20 May 2008 16:07:35 +0800
Message-Id: <1211270856-26579-3-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1211270856-26579-2-git-send-email-Jason.jin@freescale.com>
References: <1211270856-26579-1-git-send-email-Jason.jin@freescale.com>
	<1211270856-26579-2-git-send-email-Jason.jin@freescale.com>
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
In the V4 version,
Change the compatible name in dts.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   16 ++++++++++++++++
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    6 +++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 08a780d..0a70b30 100644
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
+				0xb0 0
+				0xb1 0
+				0xb2 0
+				0xb3 0
+				0xb4 0
+				0xb5 0
+				0xb6 0
+				0xb7 0>;
+			interrupt-parent = <&mpic>;
+		};
+
 		global-utilities@e0000 {
 			compatible = "fsl,mpc8610-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index dea1320..290d717 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -71,9 +71,13 @@ static void __init mpc86xx_hpcd_init_irq(void)
 	/* Alloc mpic structure and per isu has 16 INT entries. */
 	mpic1 = mpic_alloc(np, res.start,
 			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " MPIC     ");
+			64, 256, " MPIC     ");
 	BUG_ON(mpic1 == NULL);
 
+	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
+	mpic_assign_isu(mpic1, 1, res.start + 0x10800);
+	mpic_assign_isu(mpic1, 2, res.start + 0x11600);
+
 	mpic_init(mpic1);
 }
 
-- 
1.5.4
