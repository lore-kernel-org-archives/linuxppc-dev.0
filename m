Return-Path: <B45475@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E4052C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 14:59:48 +1000 (EST)
Received: from mail108-va3 (localhost [127.0.0.1])	by
 mail108-va3-R.bigfish.com (Postfix) with ESMTP id 060B7E0062	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 04:59:43 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.244])	by
 mail108-va3.bigfish.com (Postfix) with ESMTP id F2E7D38004F	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 04:59:40 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] powerpc/p1010rdb-pb:make a new dts for p1010rdb-pb
Date: Wed, 18 Sep 2013 12:54:57 +0800
Message-ID: <1379480097-11698-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1010RDB-PA and P1010RDB-PB boards use different external PHY
interrupt signals.
So make a new dts for P1010RDB-PB.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
Changes for v2:
	-Remove phy interrupts for p1010rdb-pb
Changes for v3:
	-Maintain the phy interrupts p1010rdb-pa and make a new device 
	tree for p1010rdb-pb

 arch/powerpc/boot/dts/p1010rdb-pa.dtsi | 11 ++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dts  | 67 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dtsi | 11 ++++++
 arch/powerpc/boot/dts/p1010rdb.dts     |  1 +
 arch/powerpc/boot/dts/p1010rdb.dtsi    |  3 --
 arch/powerpc/platforms/85xx/p1010rdb.c | 29 +++++++++++++++
 6 files changed, 119 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dtsi

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dtsi b/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
new file mode 100644
index 0000000..122996e
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
@@ -0,0 +1,11 @@
+&phy0 {
+	interrupts = <3 1 0 0>;
+};
+
+&phy1 {
+	interrupts = <2 1 0 0>;
+};
+
+&phy2 {
+	interrupts = <2 1 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dts b/arch/powerpc/boot/dts/p1010rdb-pb.dts
new file mode 100644
index 0000000..0213552
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pb.dts
@@ -0,0 +1,67 @@
+/*
+ * P1010 RDB-PB Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/p1010si-pre.dtsi"
+
+/ {
+	model = "fsl,P1010RDB-PB";
+	compatible = "fsl,P1010RDB-PB";
+
+	memory {
+		device_type = "memory";
+	};
+
+	board_ifc: ifc: ifc@ffe1e000 {
+		/* NOR, NAND Flashes and CPLD on board */
+		ranges = <0x0 0x0 0x0 0xee000000 0x02000000
+			  0x1 0x0 0x0 0xff800000 0x00010000
+			  0x3 0x0 0x0 0xffb00000 0x00000020>;
+		reg = <0x0 0xffe1e000 0 0x2000>;
+	};
+
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "p1010rdb.dtsi"
+/include/ "p1010rdb-pb.dtsi"
+/include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb-pb.dtsi b/arch/powerpc/boot/dts/p1010rdb-pb.dtsi
new file mode 100644
index 0000000..52cd22e
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1010rdb-pb.dtsi
@@ -0,0 +1,11 @@
+&phy0 {
+	interrupts = <0 1 0 0>;
+};
+
+&phy1 {
+	interrupts = <2 1 0 0>;
+};
+
+&phy2 {
+	interrupts = <1 1 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
index b868d22..0980ff0 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dts
+++ b/arch/powerpc/boot/dts/p1010rdb.dts
@@ -63,4 +63,5 @@
 };
 
 /include/ "p1010rdb.dtsi"
+/include/ "p1010rdb-pa.dtsi"
 /include/ "fsl/p1010si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 7fc3402..2433ae4 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -199,17 +199,14 @@
 
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
-			interrupts = <3 1 0 0>;
 			reg = <0x1>;
 		};
 
 		phy1: ethernet-phy@1 {
-			interrupts = <2 1 0 0>;
 			reg = <0x0>;
 		};
 
 		phy2: ethernet-phy@2 {
-			interrupts = <2 1 0 0>;
 			reg = <0x2>;
 		};
 
diff --git a/arch/powerpc/platforms/85xx/p1010rdb.c b/arch/powerpc/platforms/85xx/p1010rdb.c
index 0252961..7d9eab7 100644
--- a/arch/powerpc/platforms/85xx/p1010rdb.c
+++ b/arch/powerpc/platforms/85xx/p1010rdb.c
@@ -82,3 +82,32 @@ define_machine(p1010_rdb) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+machine_arch_initcall(p1010_rdb_pb, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1010_rdb_pb, swiotlb_setup_bus_notifier);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init p1010_rdb_pb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P1010RDB-PB"))
+		return 1;
+	return 0;
+}
+
+define_machine(p1010_rdb_pb) {
+	.name			= "P1010 RDB-PB",
+	.probe			= p1010_rdb_pb_probe,
+	.setup_arch		= p1010_rdb_setup_arch,
+	.init_IRQ		= p1010_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.8.0
