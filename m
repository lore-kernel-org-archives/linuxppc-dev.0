Return-Path: <B45475@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3F742C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 14:08:55 +1000 (EST)
Received: from mail206-va3 (localhost [127.0.0.1])	by
 mail206-va3-R.bigfish.com (Postfix) with ESMTP id 1CB33BC009B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 04:08:50 +0000 (UTC)
Received: from VA3EHSMHS008.bigfish.com (unknown [10.7.14.250])	by
 mail206-va3.bigfish.com (Postfix) with ESMTP id 4D1CF14004D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Sep 2013 04:08:47 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] powerpc/p1010rdb-pb:make a new dts for p1010rdb-pb
Date: Wed, 18 Sep 2013 12:04:03 +0800
Message-ID: <1379477043-9654-1-git-send-email-B45475@freescale.com>
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
Changes for v3
	-Maintain the phy interrupts p1010rdb-pa and make a new device 
	tree for p1010rdb-pb

 arch/powerpc/boot/dts/p1010rdb-pa.dtsi |  11 ++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dts  |  67 +++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1010rdb-pb.dtsi |  11 ++++++
 arch/powerpc/boot/dts/p1010rdb.dts     |   1 +
 arch/powerpc/boot/dts/p1010rdb.dtsi    |   3 --
 arch/powerpc/boot/p1010rdb-pb.dtb      | Bin 0 -> 14030 bytes
 arch/powerpc/boot/p1010rdb.dtb         | Bin 0 -> 14030 bytes
 arch/powerpc/platforms/85xx/p1010rdb.c |  29 ++++++++++++++
 8 files changed, 119 insertions(+), 3 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pa.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dts
 create mode 100644 arch/powerpc/boot/dts/p1010rdb-pb.dtsi
 create mode 100644 arch/powerpc/boot/p1010rdb-pb.dtb
 create mode 100644 arch/powerpc/boot/p1010rdb.dtb

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
 
diff --git a/arch/powerpc/boot/p1010rdb-pb.dtb b/arch/powerpc/boot/p1010rdb-pb.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..3d9865f45acf180ca5154948b43203701a0c247a
GIT binary patch
literal 14030
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

literal 0
HcmV?d00001

diff --git a/arch/powerpc/boot/p1010rdb.dtb b/arch/powerpc/boot/p1010rdb.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..435166cb47f2b3adf04fe9e10376f5737d795962
GIT binary patch
literal 14030
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
PZ<aSB@MZ-5e<Sce9HbcW

literal 0
HcmV?d00001

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
