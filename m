Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF1F4DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 01:38:49 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix MPC8572DS PCI protected interrupt sources
Date: Tue, 10 Mar 2009 09:38:43 -0500
Message-Id: <1236695923-20119-1-git-send-email-galak@kernel.crashing.org>
Cc: Ted Peters <ted.peters@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Ted Peters <ted.peters@freescale.com>

The PCI irqs for the protected sources where not correct for PCI PHBs

Signed-off-by: Ted Peters <ted.peters@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    2 +-
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index 15d9e35..32178bf 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -227,7 +227,7 @@
 			device_type = "open-pic";
 			protected-sources = <
 			31 32 33 37 38 39       /* enet2 enet3 */
-			76 77 78 79 27 42	/* dma2 pci2 serial*/
+			76 77 78 79 26 42	/* dma2 pci2 serial*/
 			0xe0 0xe1 0xe2 0xe3     /* msi */
 			0xe4 0xe5 0xe6 0xe7
 			>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index eace811..159cb3a 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -186,7 +186,7 @@
 			protected-sources = <
 			18 16 10 42 45 58	/* MEM L2 mdio serial crypto */
 			29 30 34 35 36 40	/* enet0 enet1 */
-			24 26 20 21 22 23	/* pcie0 pcie1 dma1 */
+			24 25 20 21 22 23	/* pci0 pci1 dma1 */
 			43			/* i2c */
 			0x1 0x2 0x3 0x4         /* pci slot */
 			0x9 0xa 0xb 0xc         /* usb */
-- 
1.5.6.6
