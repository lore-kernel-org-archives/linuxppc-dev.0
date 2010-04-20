Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8C72B7D51
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 21:44:27 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3KBi939015985 for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 04:44:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o3KBrs2t014673
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 20 Apr 2010 06:54:00 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] mpc8572ds: change camp dtses for MSI sharing
Date: Tue, 20 Apr 2010 20:20:47 +0800
Message-Id: <1271766048-19272-4-git-send-email-leoli@freescale.com>
In-Reply-To: <1271766048-19272-3-git-send-email-leoli@freescale.com>
References: <1271766048-19272-1-git-send-email-leoli@freescale.com>
	<1271766048-19272-2-git-send-email-leoli@freescale.com>
	<1271766048-19272-3-git-send-email-leoli@freescale.com>
Cc: Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable the sharing of MSI interrupt through AMP OSes in the mpc8572ds
dtses.

Signed-off-by: Zhao Chenhui <b26998@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |   15 +++++++++++++--
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    7 ++-----
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index 5bd1011..3375c2a 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -215,6 +215,18 @@
 			clock-frequency = <0>;
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
+			reg = <0x41600 0x80>;
+			msi-available-ranges = <0 0x80>;
+			interrupts = <
+				0xe0 0
+				0xe1 0
+				0xe2 0
+				0xe3 0>;
+			interrupt-parent = <&mpic>;
+		};
+
 		global-utilities@e0000 {	//global utilities block
 			compatible = "fsl,mpc8572-guts";
 			reg = <0xe0000 0x1000>;
@@ -243,8 +255,7 @@
 			protected-sources = <
 			31 32 33 37 38 39       /* enet2 enet3 */
 			76 77 78 79 26 42	/* dma2 pci2 serial*/
-			0xe0 0xe1 0xe2 0xe3     /* msi */
-			0xe4 0xe5 0xe6 0xe7
+			0xe4 0xe5 0xe6 0xe7	/* msi */
 			>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index 0efc345..e7b477f 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -154,12 +154,8 @@
 		msi@41600 {
 			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
 			reg = <0x41600 0x80>;
-			msi-available-ranges = <0 0x100>;
+			msi-available-ranges = <0x80 0x80>;
 			interrupts = <
-				0xe0 0
-				0xe1 0
-				0xe2 0
-				0xe3 0
 				0xe4 0
 				0xe5 0
 				0xe6 0
@@ -190,6 +186,7 @@
 			0x1 0x2 0x3 0x4         /* pci slot */
 			0x9 0xa 0xb 0xc         /* usb */
 			0x6 0x7 0xe 0x5         /* Audio elgacy SATA */
+			0xe0 0xe1 0xe2 0xe3	/* msi */
 			>;
 		};
 	};
-- 
1.6.6-rc1.GIT
