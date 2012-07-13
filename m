Return-Path: <B04825@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BEA502C02FF
 for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2012 08:40:50 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: remove P1020RDB and P2020RDB CAMP device trees
Date: Fri, 13 Jul 2012 17:40:43 -0500
Message-ID: <1342219243-8061-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We only need two examples of CAMP device trees in the upstream kernel.

Co-operative Asymmetric Multi-Processing (CAMP) is a technique where two
or more operating systems (typically multiple copies of the same Linux kernel)
are loaded into memory, and each kernel is given a subset of the available
cores to execute on.  For example, on a four-core system, one kernel runs on
cores 0 and 1, and the other runs on cores 2 and 3.

The devices are also partitioned among the operating systems, and this is
done with customized device trees.  Each kernel gets its own device tree
that has only the devices that it should know about.

Unfortunately, this approach is very hackish.  The kernels are trusted to
only access devices in their respective device trees, and the partitioning
only works for devices that can be handled.  Crafting the device trees is a
tricky process, and getting U-Boot to load and start all kernels is cumbersome.

But most importantly, each CAMP setup is very application-specific, since
the actual partitioning of resources is done in the DTS by the system
designer.  Therefore, it doesn't make a lot of sense to have a lot of CAMP
device trees, since we only expect them to be used as examples.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |   63 -----------
 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts |  141 -------------------------
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |   67 ------------
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |  125 ----------------------
 4 files changed, 0 insertions(+), 396 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
 delete mode 100644 arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
 delete mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
 delete mode 100644 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts

diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
deleted file mode 100644
index 41b4585..0000000
--- a/arch/powerpc/boot/dts/p1020rdb_camp_core0.dts
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * P1020 RDB  Core0 Device Tree Source in CAMP mode.
- *
- * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
- * can be shared, all the other devices must be assigned to one core only.
- * This dts file allows core0 to have memory, l2, i2c, spi, gpio, tdm, dma, usb,
- * eth1, eth2, sdhc, crypto, global-util, message, pci0, pci1, msi.
- *
- * Please note to add "-b 0" for core0's dts compiling.
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/include/ "p1020rdb.dts"
-
-/ {
-	model = "fsl,P1020RDB";
-	compatible = "fsl,P1020RDB", "fsl,MPC85XXRDB-CAMP";
-
-	aliases {
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		serial0 = &serial0;
-		pci0 = &pci0;
-		pci1 = &pci1;
-	};
-
-	cpus {
-		PowerPC,P1020@1 {
-			status = "disabled";
-		};
-	};
-
-	memory {
-		device_type = "memory";
-	};
-
-	localbus@ffe05000 {
-		status = "disabled";
-	};
-
-	soc@ffe00000 {
-		serial1: serial@4600 {
-			status = "disabled";
-		};
-
-		enet0: ethernet@b0000 {
-			status = "disabled";
-		};
-
-		mpic: pic@40000 {
-			protected-sources = <
-			42 29 30 34	/* serial1, enet0-queue-group0 */
-			17 18 24 45	/* enet0-queue-group1, crypto */
-			>;
-		};
-	};
-};
diff --git a/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
deleted file mode 100644
index 5174538..0000000
--- a/arch/powerpc/boot/dts/p1020rdb_camp_core1.dts
+++ /dev/null
@@ -1,141 +0,0 @@
-/*
- * P1020 RDB Core1 Device Tree Source in CAMP mode.
- *
- * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
- * can be shared, all the other devices must be assigned to one core only.
- * This dts allows core1 to have l2, eth0, crypto.
- *
- * Please note to add "-b 1" for core1's dts compiling.
- *
- * Copyright 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/include/ "p1020rdb.dts"
-
-/ {
-	model = "fsl,P1020RDB";
-	compatible = "fsl,P1020RDB", "fsl,MPC85XXRDB-CAMP";
-
-	aliases {
-		ethernet0 = &enet0;
-		serial0 = &serial1;
-		};
-
-	cpus {
-		PowerPC,P1020@0 {
-			status = "disabled";
-		};
-	};
-
-	memory {
-		device_type = "memory";
-	};
-
-	localbus@ffe05000 {
-		status = "disabled";
-	};
-
-	soc@ffe00000 {
-		ecm-law@0 {
-			status = "disabled";
-		};
-
-		ecm@1000 {
-			status = "disabled";
-		};
-
-		memory-controller@2000 {
-			status = "disabled";
-		};
-
-		i2c@3000 {
-			status = "disabled";
-		};
-
-		i2c@3100 {
-			status = "disabled";
-		};
-
-		serial0: serial@4500 {
-			status = "disabled";
-		};
-
-		spi@7000 {
-			status = "disabled";
-		};
-
-		gpio: gpio-controller@f000 {
-			status = "disabled";
-		};
-
-		dma@21300 {
-			status = "disabled";
-		};
-
-		mdio@24000 {
-			status = "disabled";
-		};
-
-		mdio@25000 {
-			status = "disabled";
-		};
-
-		enet1: ethernet@b1000 {
-			status = "disabled";
-		};
-
-		enet2: ethernet@b2000 {
-			status = "disabled";
-		};
-
-		usb@22000 {
-			status = "disabled";
-		};
-
-		sdhci@2e000 {
-			status = "disabled";
-		};
-
-		mpic: pic@40000 {
-			protected-sources = <
-			16 		/* ecm, mem, L2, pci0, pci1 */
-			43 42 59	/* i2c, serial0, spi */
-			47 63 62 	/* gpio, tdm */
-			20 21 22 23	/* dma */
-			03 02 		/* mdio */
-			35 36 40	/* enet1-queue-group0 */
-			51 52 67	/* enet1-queue-group1 */
-			31 32 33	/* enet2-queue-group0 */
-			25 26 27	/* enet2-queue-group1 */
-			28 72 58 	/* usb, sdhci, crypto */
-			0xb0 0xb1 0xb2	/* message */
-			0xb3 0xb4 0xb5
-			0xb6 0xb7
-			0xe0 0xe1 0xe2	/* msi */
-			0xe3 0xe4 0xe5
-			0xe6 0xe7		/* sdhci, crypto , pci */
-			>;
-		};
-
-		msi@41600 {
-			status = "disabled";
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			status = "disabled";
-		};
-	};
-
-	pci0: pcie@ffe09000 {
-		status = "disabled";
-	};
-
-	pci1: pcie@ffe0a000 {
-		status = "disabled";
-	};
-};
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
deleted file mode 100644
index 66aac86..0000000
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- * P2020 RDB  Core0 Device Tree Source in CAMP mode.
- *
- * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
- * can be shared, all the other devices must be assigned to one core only.
- * This dts file allows core0 to have memory, l2, i2c, spi, gpio, dma1, usb,
- * eth1, eth2, sdhc, crypto, global-util, pci0.
- *
- * Copyright 2009-2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/include/ "p2020rdb.dts"
-
-/ {
-	model = "fsl,P2020RDB";
-	compatible = "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
-
-	cpus {
-		PowerPC,P2020@1 {
-			status = "disabled";
-		};
-	};
-
-	localbus@ffe05000 {
-		status = "disabled";
-	};
-
-	soc@ffe00000 {
-		serial1: serial@4600 {
-			status = "disabled";
-		};
-
-		dma@c300 {
-			status = "disabled";
-		};
-
-		enet0: ethernet@24000 {
-			status = "disabled";
-		};
-
-		mpic: pic@40000 {
-			protected-sources = <
-			42 76 77 78 79 /* serial1 , dma2 */
-			29 30 34 26 /* enet0, pci1 */
-			0xe0 0xe1 0xe2 0xe3 /* msi */
-			0xe4 0xe5 0xe6 0xe7
-			>;
-		};
-
-		msi@41600 {
-			status = "disabled";
-		};
-	};
-
-	pci0: pcie@ffe08000 {
-		status = "disabled";
-	};
-
-	pci2: pcie@ffe0a000 {
-		status = "disabled";
-	};
-};
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
deleted file mode 100644
index 9bd8ef4..0000000
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * P2020 RDB Core1 Device Tree Source in CAMP mode.
- *
- * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
- * can be shared, all the other devices must be assigned to one core only.
- * This dts allows core1 to have l2, dma2, eth0, pci1, msi.
- *
- * Please note to add "-b 1" for core1's dts compiling.
- *
- * Copyright 2009-2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/include/ "p2020rdb.dts"
-
-/ {
-	model = "fsl,P2020RDB";
-	compatible = "fsl,P2020RDB", "fsl,MPC85XXRDB-CAMP";
-
-	cpus {
-		PowerPC,P2020@0 {
-			status = "disabled";
-		};
-	};
-
-	localbus@ffe05000 {
-		status = "disabled";
-	};
-
-	soc@ffe00000 {
-		ecm-law@0 {
-			status = "disabled";
-		};
-
-		ecm@1000 {
-			status = "disabled";
-		};
-
-		memory-controller@2000 {
-			status = "disabled";
-		};
-
-		i2c@3000 {
-			status = "disabled";
-		};
-
-		i2c@3100 {
-			status = "disabled";
-		};
-
-		serial0: serial@4500 {
-			status = "disabled";
-		};
-
-		spi@7000 {
-			status = "disabled";
-		};
-
-		gpio: gpio-controller@f000 {
-			status = "disabled";
-		};
-
-		dma@21300 {
-			status = "disabled";
-		};
-
-		usb@22000 {
-			status = "disabled";
-		};
-
-		mdio@24520 {
-			status = "disabled";
-		};
-
-		mdio@25520 {
-			status = "disabled";
-		};
-
-		mdio@26520 {
-			status = "disabled";
-		};
-
-		enet1: ethernet@25000 {
-			status = "disabled";
-		};
-
-		enet2: ethernet@26000 {
-			status = "disabled";
-		};
-
-		sdhci@2e000 {
-			status = "disabled";
-		};
-
-		crypto@30000 {
-			status = "disabled";
-		};
-
-		mpic: pic@40000 {
-			protected-sources = <
-			17 18 43 42 59 47 /*ecm, mem, i2c, serial0, spi,gpio */
-			16 20 21 22 23 28 	/* L2, dma1, USB */
-			03 35 36 40 31 32 33 	/* mdio, enet1, enet2 */
-			72 45 58 25 		/* sdhci, crypto , pci */
-			>;
-		};
-
-		global-utilities@e0000 {	//global utilities block
-			status = "disabled";
-		};
-
-	};
-
-	pci0: pcie@ffe08000 {
-		status = "disabled";
-	};
-
-	pci1: pcie@ffe09000 {
-		status = "disabled";
-	};
-};
-- 
1.7.3.4
