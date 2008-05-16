Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCA72DDFE2
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 19:52:48 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4G9qgXs000201
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 02:52:42 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4G9qYLb013463
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 04:52:41 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 3/4 V3] Enable MSI support for MPC8610HPCD board
Date: Fri, 16 May 2008 17:50:46 +0800
Message-Id: <1210931447-16234-3-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
References: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com>
	<1210931447-16234-2-git-send-email-Jason.jin@freescale.com>
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
Change the compatible name in dts in V3 version.

 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   16 ++++++++++++++++
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    6 +++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index bba234e..8f09516 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -128,6 +128,22 @@
 			big-endian;
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8610-msi";
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
index 5e1e8cf..59f75f7 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -70,9 +70,13 @@ static void __init mpc86xx_hpcd_init_irq(void)
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
