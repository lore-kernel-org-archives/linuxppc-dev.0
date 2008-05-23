Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41E3DDE1BD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 18:34:43 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4N8YbUJ005581
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:34:37 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4N8YUqc012505
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:34:36 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 4/4 V5] Enable MSI support for 85xxds board
Date: Fri, 23 May 2008 16:32:48 +0800
Message-Id: <1211531568-31402-4-git-send-email-Jason.jin@freescale.com>
In-Reply-To: <1211531568-31402-3-git-send-email-Jason.jin@freescale.com>
References: <1211531568-31402-1-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-2-git-send-email-Jason.jin@freescale.com>
	<1211531568-31402-3-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enabled MSI on 8544ds and 8572ds board.
So far only one MSI interrupt can generate on 8544 board.

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
In this version:
Add a flag MPIC_BROKEN_FRR_NIRQS in mpic_alloc making the mpic use
irq_count instead of FRR[NIRQ] to initialize the interrupt controller.
So the hwirq num need to be changed.

 arch/powerpc/boot/dts/mpc8544ds.dts      |   16 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8572ds.dts      |   16 ++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c |    4 +++-
 3 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 6a0d8db..1cfd970 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -219,6 +219,22 @@
 			device_type = "open-pic";
 			big-endian;
 		};
+
+		msi@41600 {
+			compatible = "fsl,mpc8544-msi", "fsl,mpic-msi";
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
 	};
 
 	pci0: pci@e0008000 {
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 66f27ab..174d51a 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -221,6 +221,22 @@
 			fsl,has-rstcr;
 		};
 
+		msi@41600 {
+			compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";
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
 		mpic: pic@40000 {
 			clock-frequency = <0>;
 			interrupt-controller;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index dfd8b4a..b010dc9 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -78,7 +78,8 @@ void __init mpc85xx_ds_pic_init(void)
 	}
 
 	mpic = mpic_alloc(np, r.start,
-			  MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			  MPIC_PRIMARY | MPIC_WANTS_RESET |
+			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
 			0, 256, " OpenPIC  ");
 	BUG_ON(mpic == NULL);
 
@@ -195,6 +196,7 @@ static int __init mpc85xxds_publish_devices(void)
 	return of_platform_bus_probe(NULL, mpc85xxds_ids, NULL);
 }
 machine_device_initcall(mpc8544_ds, mpc85xxds_publish_devices);
+machine_device_initcall(mpc8572_ds, mpc85xxds_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
-- 
1.5.4
