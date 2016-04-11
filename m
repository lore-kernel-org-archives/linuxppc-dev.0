Return-Path: <alessio.bogani@elettra.eu>
Received: from elettra.eu (m1.elettra.trieste.it [140.105.206.201])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qkC1D11R1zDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 00:21:33 +1000 (AEST)
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH v1 1/1] powerpc/86xx: Add support for Emerson/Artesyn MVME7100
Date: Mon, 11 Apr 2016 16:21:22 +0200
Message-Id: <1460384482-21320-1-git-send-email-alessio.bogani@elettra.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Artesyn MVME7100 Single Board Computer.

The MVME7100 is a 6U form factor VME64 computer with:

    - A two e600 cores Freescale MPC8641D CPU
    - 2 GB of DDR2 onboard memory
    - Four Gigabit Ethernets
    - Five 16550 compatible UARTs
    - One USB 2.0 port
    - Two PCI/PCI eXpress Mezzanine Card (PMC/XMC) Slots
    - A DS1375 Real Time Clock (RTC)
    - 512 KB of Non-Volatile Memory (NVRAM)
    - Two 64 KB EEPROMs
    - 128 MB NOR and 4/8 GB NAND Flash

This patch is based on linux-4.6 and has been only boot tested.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
This patch requires https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-April/141385.html to be built.

Limitations:
    This patch covers only models 171 and 173
    No plans to support CPLD timers.

Know issues:
    All four PHYs work in polling mode

Configuration is missing for:
    PCI IDSEL and PCI Interrupt definition

Support is missing for:
    Cache and memory controllers (which are very similar to the 85xx ones
        but right now I don't know if we can re-use their support)
    Watchdog, USB, NVRAM, NOR, NAND, EEPROMs, VME, PMC/XMC and RTC

 arch/powerpc/boot/Makefile                   |   4 +
 arch/powerpc/boot/dts/fsl/mvme7100.dts       | 210 +++++++++++++++++++++++++++
 arch/powerpc/boot/mvme7100.c                 |  70 +++++++++
 arch/powerpc/boot/ppcboot.h                  |   2 +-
 arch/powerpc/boot/wrapper                    |   4 +
 arch/powerpc/configs/mpc86xx_basic_defconfig |   1 +
 arch/powerpc/platforms/86xx/Kconfig          |   7 +-
 arch/powerpc/platforms/86xx/Makefile         |   1 +
 arch/powerpc/platforms/86xx/mvme7100.c       | 122 ++++++++++++++++
 9 files changed, 419 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/mvme7100.dts
 create mode 100644 arch/powerpc/boot/mvme7100.c
 create mode 100644 arch/powerpc/platforms/86xx/mvme7100.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 6116510..9e61ae2 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -113,6 +113,7 @@ src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
 src-plat-$(CONFIG_PPC_PSERIES) += pseries-head.S
 src-plat-$(CONFIG_PPC_POWERNV) += pseries-head.S
 src-plat-$(CONFIG_PPC_IBM_CELL_BLADE) += pseries-head.S
+src-plat-$(CONFIG_MVME7100) += mvme7100.c
 
 src-wlib := $(sort $(src-wlib-y))
 src-plat := $(sort $(src-plat-y))
@@ -296,6 +297,9 @@ image-$(CONFIG_TQM8560)			+= cuImage.tqm8560
 image-$(CONFIG_SBC8548)			+= cuImage.sbc8548
 image-$(CONFIG_KSI8560)			+= cuImage.ksi8560
 
+# Board ports in arch/powerpc/platform/86xx/Kconfig
+image-$(CONFIG_MVME7100)                += dtbImage.mvme7100
+
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
diff --git a/arch/powerpc/boot/dts/fsl/mvme7100.dts b/arch/powerpc/boot/dts/fsl/mvme7100.dts
new file mode 100644
index 0000000..7a5ff82
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/mvme7100.dts
@@ -0,0 +1,210 @@
+/*
+ * Device tree source for the Emerson/Artesyn MVME7100
+ *
+ * Copyright 2016 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * Author: Alessio Igor Bogani <alessio.bogani@elettra.eu>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+/include/ "mpc8641si-pre.dtsi"
+
+/ {
+	model = "MVME7100";
+	compatible = "artesyn,MVME7100";
+
+	aliases {
+		pci1 = &pci1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x80000000>;
+	};
+
+	soc: soc@f1000000 {
+		ranges = <0x00000000 0xf1000000 0x00100000>;
+
+		i2c@3000 {
+			hwmon@4c {
+				compatible = "dallas,max6649";
+				reg = <0x4c>;
+			};
+
+			rtc@68 {
+				compatible = "dallas,ds1337";
+				reg = <0x68>;
+			};
+		};
+
+
+		enet0: ethernet@24000 {
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@24520 {
+			phy0: ethernet-phy@1 {
+				reg = <1>;
+			};
+			phy1: ethernet-phy@2 {
+				reg = <2>;
+			};
+			phy2: ethernet-phy@3 {
+				reg = <3>;
+			};
+			phy3: ethernet-phy@4 {
+				reg = <4>;
+			};
+		};
+
+		enet1: ethernet@25000 {
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@25520 {
+			status = "disabled";
+		};
+
+		enet2: ethernet@26000 {
+			phy-handle = <&phy2>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@26520 {
+			status = "disabled";
+		};
+
+		enet3: ethernet@27000 {
+			phy-handle = <&phy3>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		mdio@27520 {
+			status = "disabled";
+		};
+
+		serial1: serial@4600 {
+			status = "disabled";
+		};
+	};
+
+	lbc: localbus@f1005000 {
+		reg = <0xf1005000 0x1000>;
+
+		ranges = <0 0 0xf8000000 0x08000000	// NOR Flash (128MB)
+			  2 0 0xf2030000 0x00010000	// NAND Flash (8GB)
+			  3 0 0xf2400000 0x00080000	// MRAM (512KB)
+			  4 0 0xf2000000 0x00010000	// BCSR
+			  5 0 0xf2010000 0x00010000>;	// QUART
+
+		bcsr@4,f2000000 {
+			compatible = "fsl,mvme7100-bcsr";
+			reg = <4 0xf2000000 0x10000>;
+		};
+
+	       serial@5,1000 {
+			cell-index = <2>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <5 0x1000 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <11 1 0 0>;
+		};
+
+		serial@5,2000 {
+			cell-index = <3>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <5 0x2000 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <11 1 0 0>;
+		};
+
+		serial@5,3000 {
+			cell-index = <4>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <5 0x3000 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <11 1 0 0>;
+		};
+
+
+		serial@5,4000 {
+			cell-index = <5>;
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <5 0x4000 0x100>;
+			clock-frequency = <1843200>;
+			interrupts = <11 1 0 0>;
+		};
+	};
+
+	pci0: pcie@f1008000 {
+		reg = <0xf1008000 0x1000>;
+		ranges = <0x02000000 0x0 0x80000000 0x80000000 0x0 0x10000000
+			  0x42000000 0x0 0x90000000 0x90000000 0x0 0x40000000
+			  0x01000000 0x0 0x00000000 0xf0000000 0x0 0x00800000>;
+		pcie@0 {
+			ranges = <0x02000000 0x0 0x80000000
+				  0x02000000 0x0 0x80000000
+				  0x0 0x10000000
+
+				  0x42000000 0x0 0x90000000
+				  0x42000000 0x0 0x90000000
+				  0x0 0x40000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00800000>;
+		};
+	};
+
+	pci1: pcie@f1009000 {
+		compatible = "fsl,mpc8641-pcie";
+		device_type = "pci";
+		#size-cells = <2>;
+		#address-cells = <3>;
+		reg = <0xf1009000 0x1000>;
+		bus-range = <0 0xff>;
+		ranges = <0x02000000 0x0 0xd0000000 0xd0000000 0x0 0x10000000
+			  0x01000000 0x0 0x00000000 0xf0800000 0x0 0x00800000>;
+		clock-frequency = <100000000>;
+		interrupts = <25 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0x0000 0 0 1 &mpic 4 1
+			0x0000 0 0 2 &mpic 5 1
+			0x0000 0 0 3 &mpic 6 1
+			0x0000 0 0 4 &mpic 7 1
+			>;
+		pcie@0 {
+			reg = <0 0 0 0 0>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0xd0000000
+				  0x02000000 0x0 0xd0000000
+				  0x0 0x10000000
+
+				  0x01000000 0x0 0x00000000
+				  0x01000000 0x0 0x00000000
+				  0x0 0x00800000>;
+		};
+	};
+
+	chosen {
+		linux,stdout-path = &serial0;
+	};
+
+};
+
+/include/ "mpc8641si-post.dtsi"
diff --git a/arch/powerpc/boot/mvme7100.c b/arch/powerpc/boot/mvme7100.c
new file mode 100644
index 0000000..55149e6
--- /dev/null
+++ b/arch/powerpc/boot/mvme7100.c
@@ -0,0 +1,70 @@
+/*
+ * Motload compatibility for the Emerson/Artesyn MVME7100
+ *
+ * Copyright 2016 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * Author: Alessio Igor Bogani <alessio.bogani@elettra.eu>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+
+#define TARGET_MVME7100
+#define TARGET_HAS_ETH1
+#define TARGET_HAS_ETH2
+#define TARGET_HAS_ETH3
+#include "ppcboot.h"
+
+static bd_t bd;
+
+BSS_STACK(16384);
+
+static void mvme7100_fixups(void)
+{
+	void *devp;
+
+	unsigned long busfreq = bd.bi_busfreq * 1000000;
+	dt_fixup_cpu_clocks(bd.bi_intfreq * 1000000, busfreq / 4, busfreq);
+
+	devp = finddevice("/soc@f1000000");
+	if (devp)
+		setprop(devp, "bus-frequency", &busfreq, sizeof(busfreq));
+
+	devp = finddevice("/soc/serial@4500");
+	if (devp)
+		setprop(devp, "clock-frequency", &busfreq, sizeof(busfreq));
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+
+	dt_fixup_mac_address_by_alias("ethernet0", bd.bi_enetaddr);
+	dt_fixup_mac_address_by_alias("ethernet1", bd.bi_enet1addr);
+	dt_fixup_mac_address_by_alias("ethernet2", bd.bi_enet2addr);
+	dt_fixup_mac_address_by_alias("ethernet3", bd.bi_enet3addr);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+		   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	fdt_init(_dtb_start);
+	serial_console_init();
+	platform_ops.fixups = mvme7100_fixups;
+
+}
+
+asm("	.globl _zimage_start\n\
+	_zimage_start:\n\
+		mfmsr   10\n\
+		rlwinm  10,10,0,~(1<<15)        /* Clear MSR_EE */\n\
+		sync\n\
+		mtmsr   10\n\
+		isync\n\
+		b _zimage_start_lib\n\
+");
diff --git a/arch/powerpc/boot/ppcboot.h b/arch/powerpc/boot/ppcboot.h
index 6ae6f90..7b758be 100644
--- a/arch/powerpc/boot/ppcboot.h
+++ b/arch/powerpc/boot/ppcboot.h
@@ -43,7 +43,7 @@ typedef struct bd_info {
 	unsigned long	bi_sramstart;	/* start of SRAM memory */
 	unsigned long	bi_sramsize;	/* size	 of SRAM memory */
 #if defined(TARGET_8xx) || defined(TARGET_CPM2) || defined(TARGET_85xx) ||\
-	defined(TARGET_83xx)
+	defined(TARGET_83xx) || defined(TARGET_MVME7100)
 	unsigned long	bi_immr_base;	/* base of IMMR register */
 #endif
 #if defined(TARGET_PPC_MPC52xx)
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 6a19fce..5f461b0 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -302,6 +302,10 @@ mvme5100)
     platformo="$object/fixed-head.o $object/mvme5100.o"
     binary=y
     ;;
+mvme7100)
+    link_address='0x4000000'
+    binary=y
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
diff --git a/arch/powerpc/configs/mpc86xx_basic_defconfig b/arch/powerpc/configs/mpc86xx_basic_defconfig
index 33af5c5..3283f05 100644
--- a/arch/powerpc/configs/mpc86xx_basic_defconfig
+++ b/arch/powerpc/configs/mpc86xx_basic_defconfig
@@ -8,3 +8,4 @@ CONFIG_GEF_SBC610=y
 CONFIG_MPC8610_HPCD=y
 CONFIG_MPC8641_HPCN=y
 CONFIG_SBC8641D=y
+CONFIG_MVME7100=y
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 1afd1e4..32874bf 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -61,6 +61,11 @@ config GEF_SBC610
 	help
 	  This option enables support for the GE SBC610.
 
+config MVME7100
+        bool "Artesyn MVME7100"
+        help
+          This option enables support for the Emerson/Artesyn MVME7100 board.
+
 endif
 
 config MPC8641
@@ -69,7 +74,7 @@ config MPC8641
 	select FSL_PCI if PCI
 	select PPC_UDBG_16550
 	select MPIC
-	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610 || GEF_SBC310 || GEF_PPC9A
+	default y if MPC8641_HPCN || SBC8641D || GEF_SBC610 || GEF_SBC310 || GEF_PPC9A || MVME7100
 
 config MPC8610
 	bool
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 2d889ad..01958fe 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_MPC8610_HPCD)	+= mpc8610_hpcd.o
 obj-$(CONFIG_GEF_SBC610)	+= gef_sbc610.o
 obj-$(CONFIG_GEF_SBC310)	+= gef_sbc310.o
 obj-$(CONFIG_GEF_PPC9A)		+= gef_ppc9a.o
+obj-$(CONFIG_MVME7100)          += mvme7100.o
diff --git a/arch/powerpc/platforms/86xx/mvme7100.c b/arch/powerpc/platforms/86xx/mvme7100.c
new file mode 100644
index 0000000..270eb43
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/mvme7100.c
@@ -0,0 +1,122 @@
+/*
+ * Board setup routines for the Emerson/Artesyn MVME7100
+ *
+ * Copyright 2016 Elettra-Sincrotrone Trieste S.C.p.A.
+ *
+ * Author: Alessio Igor Bogani <alessio.bogani@elettra.eu>
+ *
+ * Based on earlier code by:
+ *
+ *	Ajit Prem <ajit.prem@emerson.com>
+ *	Copyright 2008 Emerson
+ *
+ * USB host fixup is borrowed by:
+ *
+ *	Martyn Welch <martyn.welch@ge.com>
+ *	Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/of_platform.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+
+#include "mpc86xx.h"
+
+#define MVME7100_INTERRUPT_REG_2_OFFSET	0x05
+#define MVME7100_DS1375_MASK		0x40
+#define MVME7100_MAX6649_MASK		0x20
+#define MVME7100_ABORT_MASK		0x10
+
+/*
+ * Setup the architecture
+ */
+static void __init mvme7100_setup_arch(void)
+{
+	u8 reg;
+	struct device_node *regs;
+	void __iomem *mvme7100_regs = NULL;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mvme7100_setup_arch()", 0);
+
+#ifdef CONFIG_SMP
+	mpc86xx_smp_init();
+#endif
+
+	fsl_pci_assign_primary();
+
+	/* Remap BCSR registers */
+	regs = of_find_compatible_node(NULL, NULL, "bcsr");
+	if (regs) {
+		mvme7100_regs = of_iomap(regs, 0);
+		of_node_put(regs);
+	}
+
+	if (mvme7100_regs) {
+		/* Disable ds1375, max6649, and abort interrupts */
+		reg = readb(mvme7100_regs + MVME7100_INTERRUPT_REG_2_OFFSET);
+		reg |= MVME7100_DS1375_MASK | MVME7100_MAX6649_MASK
+			| MVME7100_ABORT_MASK;
+		writeb(reg, mvme7100_regs + MVME7100_INTERRUPT_REG_2_OFFSET);
+	} else
+		pr_warn("Unable to map board registers\n");
+
+	pr_info("MVME7100 board from Artesyn\n");
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mvme7100_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "artesyn,MVME7100"))
+		return 0;
+
+	_set_L2CR(_get_L2CR() | L2CR_L2E);
+	return 1;
+}
+
+static void mvme7100_usb_host_fixup(struct pci_dev *pdev)
+{
+	unsigned int val;
+
+	if (!machine_is(mvme7100))
+		return;
+
+	/* Ensure only ports 1 & 2 are enabled */
+	pci_read_config_dword(pdev, 0xe0, &val);
+	pci_write_config_dword(pdev, 0xe0, (val & ~7) | 0x2);
+
+	/* System clock is 48-MHz Oscillator and EHCI Enabled. */
+	pci_write_config_dword(pdev, 0xe4, 1 << 5);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_USB,
+	mvme7100_usb_host_fixup);
+
+machine_arch_initcall(mvme7100, mpc86xx_common_publish_devices);
+
+define_machine(mvme7100) {
+	.name			= "MVME7100",
+	.probe			= mvme7100_probe,
+	.setup_arch		= mvme7100_setup_arch,
+	.init_IRQ		= mpc86xx_init_irq,
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.time_init		= mpc86xx_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+};
-- 
2.8.0
