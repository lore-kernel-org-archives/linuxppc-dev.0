Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E0BF4DE101
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 19:29:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3I9SspB001091
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:28:55 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3I9SmEU027869
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 04:28:53 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] Enable MSI support for 85xxds board.
Date: Sat, 19 Apr 2008 17:27:47 +0800
Message-Id: <1208597267-30960-3-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1208597267-30960-2-git-send-email-Jason.jin@freescale.com>
References: <1208597267-30960-1-git-send-email-Jason.jin@freescale.com>
	<1208597267-30960-2-git-send-email-Jason.jin@freescale.com>
Cc: kumar.gala@freescale.com, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enabled MSI on 8544ds and 8572ds board.
only one MSI interrupt can generate on 8544 board.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 arch/powerpc/boot/dts/mpc8544ds.dts      |   16 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8572ds.dts      |   16 ++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    7 ++++++-
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 6a0d8db..1059281 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -219,6 +219,22 @@
 			device_type = "open-pic";
 			big-endian;
 		};
+
+		msi@41600 {
+			compatible = "fsl,MPIC-msi";
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
 	};
 
 	pci0: pci@e0008000 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 66f27ab..1c5ae9d 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -221,6 +221,22 @@
 			fsl,has-rstcr;
 		};
 
+		msi@41600 {
+			compatible = "fsl,MPIC-msi";
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
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index dfd8b4a..2696d2f 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -79,9 +79,13 @@ void __init mpc85xx_ds_pic_init(void)
 
 	mpic = mpic_alloc(np, r.start,
 			  MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			0, 256, " OpenPIC  ");
+			64, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 
+	mpic_assign_isu(mpic, 0, r.start + 0x10000);
+	mpic_assign_isu(mpic, 1, r.start + 0x10800);
+	mpic_assign_isu(mpic, 2, r.start + 0x11600);
+
 	mpic_init(mpic);
 
 #ifdef CONFIG_PPC_I8259
@@ -195,6 +199,7 @@ static int __init mpc85xxds_publish_devices(void)
 	return of_platform_bus_probe(NULL, mpc85xxds_ids, NULL);
 }
 machine_device_initcall(mpc8544_ds, mpc85xxds_publish_devices);
+machine_device_initcall(mpc8572_ds, mpc85xxds_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
-- 
1.5.4
