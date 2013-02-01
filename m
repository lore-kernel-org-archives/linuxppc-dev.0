Return-Path: <stef.van.os@Prodrive.nl>
Received: from mail.prodrive.nl (mail.prodrive.nl [212.61.153.67])
 by ozlabs.org (Postfix) with ESMTP id D5F852C0292
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2013 03:03:32 +1100 (EST)
From: Stef van Os <stef.van.os@prodrive.nl>
To: Kumar Gala <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/1] powerpc/85xx: Board support for ppa8548
Date: Fri, 1 Feb 2013 16:36:53 +0100
Message-ID: <1359733013-722-1-git-send-email-stef.van.os@prodrive.nl>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, Stef van Os <stef.van.os@prodrive.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initial board support for the Prodrive PPA8548 AMC module. Board
is an MPC8548 AMC platform used in RapidIO systems. This module is
also used to test/work on mainline linux RapidIO software.

PPA8548 overview:
- 1.3 GHz Freescale PowerQUICC III MPC8548 processor
- 1 GB DDR2 @ 266 MHz
- 8 MB NOR flash
- Serial RapidIO 1.2
- 1 x 10/100/1000 BASE-T front ethernet
- 1 x 1000 BASE-BX ethernet on AMC connector

Signed-off-by: Stef van Os <stef.van.os@prodrive.nl>
---
 arch/powerpc/boot/dts/ppa8548.dts           |  238 +++++++++++++++++++++++++++
 arch/powerpc/configs/85xx/ppa8548_defconfig |   65 ++++++++
 arch/powerpc/platforms/85xx/Kconfig         |    7 +
 arch/powerpc/platforms/85xx/Makefile        |    1 +
 arch/powerpc/platforms/85xx/ppa8548.c       |  119 +++++++++++++
 5 files changed, 430 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ppa8548.dts
 create mode 100644 arch/powerpc/configs/85xx/ppa8548_defconfig
 create mode 100644 arch/powerpc/platforms/85xx/ppa8548.c

diff --git a/arch/powerpc/boot/dts/ppa8548.dts b/arch/powerpc/boot/dts/ppa8548.dts
new file mode 100644
index 0000000..5eaba83
--- /dev/null
+++ b/arch/powerpc/boot/dts/ppa8548.dts
@@ -0,0 +1,238 @@
+/*
+ * PPA8548 Device Tree Source (36-bit address map)
+ * Copyright 2013 Prodrive B.V.
+ *
+ * Based on:
+ * MPC8548 CDS Device Tree Source (36-bit address map)
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/include/ "fsl/e500v2_power_isa.dtsi"
+
+/ {
+	model = "ppa8548";
+	compatible = "ppa8548";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		ethernet0 = &enet0;
+		ethernet1 = &enet1;
+		rapidio0 = &rio;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8548@0 {
+			device_type = "cpu";
+			reg = <0x0>;
+			next-level-cache = <&L2>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0x0 0x40000000>;
+	};
+
+	board_lbc: lbc: localbus@fe0005000 {
+		reg = <0xf 0xe0005000 0 0x1000>;
+		ranges = <0x0 0x0 0xf 0xff800000 0x00800000>;
+	};
+
+	board_soc: soc: soc8548@fe0000000 {
+		ranges = <0 0xf 0xe0000000 0x100000>;
+	};
+
+	rio: rapidio@fe00c0000 {
+		reg = <0xf 0xe00c0000 0x0 0x11000>;
+		port1 {
+			ranges = <0x0 0x0 0x0 0x80000000 0x0 0x40000000>;
+		};
+	};
+};
+
+&lbc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,mpc8548-lbc", "fsl,pq3-localbus", "simple-bus";
+	interrupts = <19 2 0 0>;
+};
+
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <48 2 0 0>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	fsl,srio-rmu-handle = <&rmu>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "fsl,mpc8548-immr", "simple-bus";
+	bus-frequency = <0>;		// Filled out by uboot.
+
+	ecm-law@0 {
+		compatible = "fsl,ecm-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <10>;
+	};
+
+	ecm@1000 {
+		compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+		reg = <0x1000 0x1000>;
+		interrupts = <17 2 0 0>;
+	};
+
+	memory-controller@2000 {
+		compatible = "fsl,mpc8548-memory-controller";
+		reg = <0x2000 0x1000>;
+		interrupts = <18 2 0 0>;
+	};
+
+/include/ "fsl/pq3-i2c-0.dtsi"
+/include/ "fsl/pq3-i2c-1.dtsi"
+/include/ "fsl/pq3-duart-0.dtsi"
+
+	L2: l2-cache-controller@20000 {
+		compatible = "fsl,mpc8548-l2-cache-controller";
+		reg = <0x20000 0x1000>;
+		cache-line-size = <32>;	// 32 bytes
+		cache-size = <0x80000>; // L2, 512K
+		interrupts = <16 2 0 0>;
+	};
+
+/include/ "fsl/pq3-dma-0.dtsi"
+/include/ "fsl/pq3-etsec1-0.dtsi"
+/include/ "fsl/pq3-etsec1-1.dtsi"
+/include/ "fsl/pq3-etsec1-2.dtsi"
+/include/ "fsl/pq3-etsec1-3.dtsi"
+
+/include/ "fsl/pq3-sec2.1-0.dtsi"
+/include/ "fsl/pq3-mpic.dtsi"
+/include/ "fsl/pq3-rmu-0.dtsi"
+
+	global-utilities@e0000 {
+		compatible = "fsl,mpc8548-guts";
+		reg = <0xe0000 0x1000>;
+		fsl,has-rstcr;
+	};
+};
+
+&board_lbc {
+	nor@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x00800000>;
+		bank-width = <2>;
+		device-width = <2>;
+
+		partition@0 {
+			reg = <0x0 0x7A0000>;
+			label = "user";
+		};
+
+		partition@7A0000 {
+			reg = <0x7A0000 0x20000>;
+			label = "env";
+			read-only;
+		};
+
+		partition@7C0000 {
+			reg = <0x7C0000 0x40000>;
+			label = "u-boot";
+			read-only;
+		};
+	};
+};
+
+&board_soc {
+	i2c@3000 {
+		rtc@6f {
+			compatible = "intersil,isl1208";
+			reg = <0x6f>;
+		};
+	};
+
+	i2c@3100 {
+	};
+
+	ethernet@24000 {
+		status = "disabled";
+	};
+
+	mdio@24520 {
+		phy0: ethernet-phy@0 {
+			interrupts = <7 1 0 0>;
+			reg = <0x0>;
+			device_type = "ethernet-phy";
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <8 1 0 0>;
+			reg = <0x1>;
+			device_type = "ethernet-phy";
+		};
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet0: ethernet@25000 {
+		tbi-handle = <&tbi1>;
+		phy-handle = <&phy0>;
+	};
+
+	mdio@25520 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet1: ethernet@26000 {
+		tbi-handle = <&tbi2>;
+		phy-handle = <&phy1>;
+	};
+
+	mdio@26520 {
+		tbi2: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	ethernet@27000 {
+		status = "disabled";
+	};
+
+	mdio@27520 {
+		tbi3: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+};
+
diff --git a/arch/powerpc/configs/85xx/ppa8548_defconfig b/arch/powerpc/configs/85xx/ppa8548_defconfig
new file mode 100644
index 0000000..a11337d
--- /dev/null
+++ b/arch/powerpc/configs/85xx/ppa8548_defconfig
@@ -0,0 +1,65 @@
+CONFIG_PPC_85xx=y
+CONFIG_PPA8548=y
+CONFIG_DTC=y
+CONFIG_DEFAULT_UIMAGE=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_PCI is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_LOWMEM_SIZE_BOOL=y
+CONFIG_LOWMEM_SIZE=0x40000000
+CONFIG_LOWMEM_CAM_NUM_BOOL=y
+CONFIG_LOWMEM_CAM_NUM=4
+CONFIG_PAGE_OFFSET_BOOL=y
+CONFIG_PAGE_OFFSET=0xb0000000
+CONFIG_KERNEL_START_BOOL=y
+CONFIG_KERNEL_START=0xb0000000
+# CONFIG_PHYSICAL_START_BOOL is not set
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_PHYSICAL_ALIGN=0x04000000
+CONFIG_TASK_SIZE_BOOL=y
+CONFIG_TASK_SIZE=0xb0000000
+
+CONFIG_FSL_LBC=y
+CONFIG_FSL_DMA=y
+CONFIG_FSL_RIO=y
+
+CONFIG_RAPIDIO=y
+CONFIG_RAPIDIO_DMA_ENGINE=y
+CONFIG_RAPIDIO_TSI57X=y
+CONFIG_RAPIDIO_TSI568=y
+CONFIG_RAPIDIO_CPS_XX=y
+CONFIG_RAPIDIO_CPS_GEN2=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_PROC_DEVICETREE=y
+
+CONFIG_MTD=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+CONFIG_MTD_PHYSMAP_OF=y
+
+CONFIG_I2C=y
+CONFIG_I2C_MPC=y
+CONFIG_I2C_CHARDEV
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_DRV_ISL1208=y
+
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_NETDEVICES=y
+CONFIG_MII=y
+CONFIG_GIANFAR=y
+CONFIG_MARVELL_PHY=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 02d02a0..803bfed 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -191,6 +191,13 @@ config SBC8548
 	help
 	  This option enables support for the Wind River SBC8548 board
 
+config PPA8548
+	bool "Prodrive PPA8548"
+	help
+	  This option enables support for the Prodrive PPA8548 board.
+	select DEFAULT_UIMAGE
+	select HAS_RAPIDIO
+
 config GE_IMP3A
 	bool "GE Intelligent Platforms IMP3A"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 76f679c..d5f4195 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_P5040_DS)    += p5040_ds.o corenet_ds.o
 obj-$(CONFIG_STX_GP3)	  += stx_gp3.o
 obj-$(CONFIG_TQM85xx)	  += tqm85xx.o
 obj-$(CONFIG_SBC8548)     += sbc8548.o
+obj-$(CONFIG_PPA8548)     += ppa8548.o
 obj-$(CONFIG_SOCRATES)    += socrates.o socrates_fpga_pic.o
 obj-$(CONFIG_KSI8560)	  += ksi8560.o
 obj-$(CONFIG_XES_MPC85xx) += xes_mpc85xx.o
diff --git a/arch/powerpc/platforms/85xx/ppa8548.c b/arch/powerpc/platforms/85xx/ppa8548.c
new file mode 100644
index 0000000..80a9307
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/ppa8548.c
@@ -0,0 +1,119 @@
+/*
+ * ppa8548 setup and early boot code.
+ *
+ * Copyright 2009 Prodrive B.V..
+ *
+ * By Stef van Os (see MAINTAINERS for contact information)
+ *
+ * Based on the SBC8548 support - Copyright 2007 Wind River Systems Inc.
+ * Based on the MPC8548CDS support - Copyright 2005 Freescale Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
+
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/irq.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+
+static void __init ppa8548_pic_init(void)
+{
+	struct mpic *mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN,
+			0, 256, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+}
+
+/*
+ * Setup the architecture
+ */
+static void __init ppa8548_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("ppa8548_setup_arch()", 0);
+}
+
+static void ppa8548_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Prodrive B.V.\n");
+	seq_printf(m, "Machine\t\t: ppa8548\n");
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .type = "soc", },
+	{ .compatible = "simple-bus", },
+	{ .compatible = "gianfar", },
+	{ .compatible = "fsl,srio", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(ppa8548, declare_of_platform_devices);
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init ppa8548_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "ppa8548");
+}
+
+define_machine(ppa8548) {
+	.name		= "ppa8548",
+	.probe		= ppa8548_probe,
+	.setup_arch	= ppa8548_setup_arch,
+	.init_IRQ	= ppa8548_pic_init,
+	.show_cpuinfo	= ppa8548_show_cpuinfo,
+	.get_irq	= mpic_get_irq,
+	.restart	= fsl_rstcr_restart,
+	.calibrate_decr = generic_calibrate_decr,
+	.progress	= udbg_progress,
+};
-- 
1.7.2.5
