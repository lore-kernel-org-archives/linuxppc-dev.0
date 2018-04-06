Return-Path: <remi@machet.us>
Received: from breton.machet.us (breton.mach-tb.org [184.75.240.185])
 by lists.ozlabs.org (Postfix) with ESMTP id 40HlYw048KzF1qH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Apr 2018 02:30:59 +1000 (AEST)
From: <remi@machet.us>
To: "'Mark Greer'" <mgreer@animalcreek.com>,
 "'Benjamin Herrenschmidt'" <benh@kernel.crashing.org>,
 "'Paul Mackerras'" <paulus@samba.org>,
 "'Michael Ellerman'" <mpe@ellerman.id.au>
Cc: "'Dale Farnsworth'" <dale@farnsworth.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
References: <20180406011720.7728-1-mgreer@animalcreek.com>
 <20180406011720.7728-2-mgreer@animalcreek.com>
In-Reply-To: <20180406011720.7728-2-mgreer@animalcreek.com>
Subject: RE: [PATCH 1/5] powerpc/embedded6xx: Remove C2K board support
Date: Fri, 6 Apr 2018 12:23:23 -0400
Message-ID: <043801d3cdc3$97874da0$c695e8e0$@machet.us>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Acked-by: Remi Machet <remi@machet.us>

-----Original Message-----
From: Mark Greer <mgreer@animalcreek.com> 
Sent: Thursday, April 5, 2018 9:17 PM
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>; Paul Mackerras
<paulus@samba.org>; Michael Ellerman <mpe@ellerman.id.au>
Cc: Remi Machet <rmachet@nvidia.com>; Dale Farnsworth <dale@farnsworth.org>;
linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Mark Greer
<mgreer@animalcreek.com>
Subject: [PATCH 1/5] powerpc/embedded6xx: Remove C2K board support

The C2K platform appears to be orphaned so remove code supporting it.

CC: Remi Machet <rmachet@nvidia.com>
Signed-off-by: Mark Greer <mgreer@animalcreek.com>
---
 arch/powerpc/boot/Makefile                  |   5 +-
 arch/powerpc/boot/cuboot-c2k.c              | 189 --------------
 arch/powerpc/boot/dts/c2k.dts               | 366
--------------------------
 arch/powerpc/configs/c2k_defconfig          | 390
----------------------------
 arch/powerpc/platforms/embedded6xx/Kconfig  |  10 -
 arch/powerpc/platforms/embedded6xx/Makefile |   1 -
 arch/powerpc/platforms/embedded6xx/c2k.c    | 148 -----------
 7 files changed, 2 insertions(+), 1107 deletions(-)  delete mode 100644
arch/powerpc/boot/cuboot-c2k.c  delete mode 100644
arch/powerpc/boot/dts/c2k.dts  delete mode 100644
arch/powerpc/configs/c2k_defconfig
 delete mode 100644 arch/powerpc/platforms/embedded6xx/c2k.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile index
26d5d2a5b8e9..70bf9b409fae 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -143,8 +143,8 @@ src-plat-$(CONFIG_PPC_82xx) += cuboot-pq2.c fixed-head.S
ep8248e.c cuboot-824x.c
 src-plat-$(CONFIG_PPC_83xx) += cuboot-83xx.c fixed-head.S redboot-83xx.c
 src-plat-$(CONFIG_FSL_SOC_BOOKE) += cuboot-85xx.c cuboot-85xx-cpm2.c
 src-plat-$(CONFIG_EMBEDDED6xx) += cuboot-pq2.c cuboot-mpc7448hpc2.c \
-					cuboot-c2k.c gamecube-head.S \
-					gamecube.c wii-head.S wii.c holly.c
\
+					gamecube-head.S gamecube.c \
+					wii-head.S wii.c holly.c \
 					fixed-head.S mvme5100.c
 src-plat-$(CONFIG_AMIGAONE) += cuboot-amigaone.c
 src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
@@ -339,7 +339,6 @@ image-$(CONFIG_MVME7100)                +=
dtbImage.mvme7100
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
-image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
 image-$(CONFIG_GAMECUBE)		+= dtbImage.gamecube
 image-$(CONFIG_WII)			+= dtbImage.wii
 image-$(CONFIG_MVME5100)		+= dtbImage.mvme5100
diff --git a/arch/powerpc/boot/cuboot-c2k.c b/arch/powerpc/boot/cuboot-c2k.c
deleted file mode 100644 index 9309c51f1d65..000000000000
--- a/arch/powerpc/boot/cuboot-c2k.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- * GEFanuc C2K platform code.
- *
- * Author: Remi Machet <rmachet@slac.stanford.edu>
- *
- * Originated from prpmc2800.c
- *
- * 2008 (c) Stanford University
- * 2007 (c) MontaVista, Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- */
-
-#include "types.h"
-#include "stdio.h"
-#include "io.h"
-#include "ops.h"
-#include "elf.h"
-#include "mv64x60.h"
-#include "cuboot.h"
-#include "ppcboot.h"
-
-static u8 *bridge_base;
-
-static void c2k_bridge_setup(u32 mem_size) -{
-	u32 i, v[30], enables, acc_bits;
-	u32 pci_base_hi, pci_base_lo, size, buf[2];
-	unsigned long cpu_base;
-	int rc;
-	void *devp, *mv64x60_devp;
-	u8 *bridge_pbase, is_coherent;
-	struct mv64x60_cpu2pci_win *tbl;
-	int bus;
-
-	bridge_pbase = mv64x60_get_bridge_pbase();
-	is_coherent = mv64x60_is_coherent();
-
-	if (is_coherent)
-		acc_bits = MV64x60_PCI_ACC_CNTL_SNOOP_WB
-			| MV64x60_PCI_ACC_CNTL_SWAP_NONE
-			| MV64x60_PCI_ACC_CNTL_MBURST_32_BYTES
-			| MV64x60_PCI_ACC_CNTL_RDSIZE_32_BYTES;
-	else
-		acc_bits = MV64x60_PCI_ACC_CNTL_SNOOP_NONE
-			| MV64x60_PCI_ACC_CNTL_SWAP_NONE
-			| MV64x60_PCI_ACC_CNTL_MBURST_128_BYTES
-			| MV64x60_PCI_ACC_CNTL_RDSIZE_256_BYTES;
-
-	mv64x60_config_ctlr_windows(bridge_base, bridge_pbase, is_coherent);
-	mv64x60_devp = find_node_by_compatible(NULL, "marvell,mv64360");
-	if (mv64x60_devp == NULL)
-		fatal("Error: Missing marvell,mv64360 device tree
node\n\r");
-
-	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE));
-	enables |= 0x007ffe00; /* Disable all cpu->pci windows */
-	out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE), enables);
-
-	/* Get the cpu -> pci i/o & mem mappings from the device tree */
-	devp = NULL;
-	for (bus = 0; ; bus++) {
-		char name[] = "pci ";
-
-		name[strlen(name)-1] = bus+'0';
-
-		devp = find_node_by_alias(name);
-		if (devp == NULL)
-			break;
-
-		if (bus >= 2)
-			fatal("Error: Only 2 PCI controllers are supported
at" \
-				" this time.\n");
-
-		mv64x60_config_pci_windows(bridge_base, bridge_pbase, bus,
0,
-				mem_size, acc_bits);
-
-		rc = getprop(devp, "ranges", v, sizeof(v));
-		if (rc == 0)
-			fatal("Error: Can't find marvell,mv64360-pci ranges"
-				" property\n\r");
-
-		/* Get the cpu -> pci i/o & mem mappings from the device
tree */
-
-		for (i = 0; i < rc; i += 6) {
-			switch (v[i] & 0xff000000) {
-			case 0x01000000: /* PCI I/O Space */
-				tbl = mv64x60_cpu2pci_io;
-				break;
-			case 0x02000000: /* PCI MEM Space */
-				tbl = mv64x60_cpu2pci_mem;
-				break;
-			default:
-				continue;
-			}
-
-			pci_base_hi = v[i+1];
-			pci_base_lo = v[i+2];
-			cpu_base = v[i+3];
-			size = v[i+5];
-
-			buf[0] = cpu_base;
-			buf[1] = size;
-
-			if (!dt_xlate_addr(devp, buf, sizeof(buf),
&cpu_base))
-				fatal("Error: Can't translate PCI address "
\
-						"0x%x\n\r", (u32)cpu_base);
-
-			mv64x60_config_cpu2pci_window(bridge_base, bus,
-				pci_base_hi, pci_base_lo, cpu_base, size,
tbl);
-		}
-
-		enables &= ~(3<<(9+bus*5)); /* Enable cpu->pci<bus> i/o,
-						cpu->pci<bus> mem0 */
-		out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE),
-			enables);
-	};
-}
-
-static void c2k_fixups(void)
-{
-	u32 mem_size;
-
-	mem_size = mv64x60_get_mem_size(bridge_base);
-	c2k_bridge_setup(mem_size); /* Do necessary bridge setup */
-}
-
-#define MV64x60_MPP_CNTL_0	0xf000
-#define MV64x60_MPP_CNTL_2	0xf008
-#define MV64x60_GPP_IO_CNTL	0xf100
-#define MV64x60_GPP_LEVEL_CNTL	0xf110
-#define MV64x60_GPP_VALUE_SET	0xf118
-
-static void c2k_reset(void)
-{
-	u32 temp;
-
-	udelay(5000000);
-
-	if (bridge_base != 0) {
-		temp = in_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_0));
-		temp &= 0xFFFF0FFF;
-		out_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_0), temp);
-
-		temp = in_le32((u32 *)(bridge_base +
MV64x60_GPP_LEVEL_CNTL));
-		temp |= 0x00000004;
-		out_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL),
temp);
-
-		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL));
-		temp |= 0x00000004;
-		out_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL), temp);
-
-		temp = in_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_2));
-		temp &= 0xFFFF0FFF;
-		out_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_2), temp);
-
-		temp = in_le32((u32 *)(bridge_base +
MV64x60_GPP_LEVEL_CNTL));
-		temp |= 0x00080000;
-		out_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL),
temp);
-
-		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL));
-		temp |= 0x00080000;
-		out_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL), temp);
-
-		out_le32((u32 *)(bridge_base + MV64x60_GPP_VALUE_SET),
-				0x00080004);
-	}
-
-	for (;;);
-}
-
-static bd_t bd;
-
-void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-			unsigned long r6, unsigned long r7)
-{
-	CUBOOT_INIT();
-
-	fdt_init(_dtb_start);
-
-	bridge_base = mv64x60_get_bridge_base();
-
-	platform_ops.fixups = c2k_fixups;
-	platform_ops.exit = c2k_reset;
-
-	if (serial_console_init() < 0)
-		exit();
-}
diff --git a/arch/powerpc/boot/dts/c2k.dts b/arch/powerpc/boot/dts/c2k.dts
deleted file mode 100644 index c5beb72d18b7..000000000000
--- a/arch/powerpc/boot/dts/c2k.dts
+++ /dev/null
@@ -1,366 +0,0 @@
-/* Device Tree Source for GEFanuc C2K
- *
- * Author: Remi Machet <rmachet@slac.stanford.edu>
- *
- * Originated from prpmc2800.dts
- *
- * 2008 (c) Stanford University
- * 2007 (c) MontaVista, Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- */
-
-/dts-v1/;
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	model = "C2K";
-	compatible = "GEFanuc,C2K";
-	coherency-off;
-
-	aliases {
-		pci0 = &PCI0;
-		pci1 = &PCI1;
-	};
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "PowerPC,7447";
-			reg = <0>;
-			clock-frequency = <996000000>;	/* 996 MHz */
-			bus-frequency = <166666667>;	/* 166.6666 MHz */
-			timebase-frequency = <41666667>;	/*
166.6666/4 MHz */
-			i-cache-line-size = <32>;
-			d-cache-line-size = <32>;
-			i-cache-size = <32768>;
-			d-cache-size = <32768>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0x00000000 0x40000000>;	/* 1GB */
-	};
-
-	system-controller@d8000000 { /* Marvell Discovery */
-		#address-cells = <1>;
-		#size-cells = <1>;
-		model = "mv64460";
-		compatible = "marvell,mv64360";
-		clock-frequency = <166666667>;		/* 166.66... MHz */
-		reg = <0xd8000000 0x00010000>;
-		virtual-reg = <0xd8000000>;
-		ranges = <0xd4000000 0xd4000000 0x01000000	/* PCI 0 I/O
Space */
-			  0x80000000 0x80000000 0x08000000	/* PCI 0 MEM
Space */
-			  0xd0000000 0xd0000000 0x01000000	/* PCI 1 I/O
Space */
-			  0xa0000000 0xa0000000 0x08000000	/* PCI 1 MEM
Space */
-			  0xd8100000 0xd8100000 0x00010000	/* FPGA */
-			  0xd8110000 0xd8110000 0x00010000	/* FPGA
USARTs */
-			  0xf8000000 0xf8000000 0x08000000	/* User
FLASH */
-			  0x00000000 0xd8000000 0x00010000	/* Bridge's
regs */
-			  0xd8140000 0xd8140000 0x00040000>;	/*
Integrated SRAM */
-
-		mdio@2000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "marvell,mv64360-mdio";
-			reg = <0x2000 4>;
-			PHY0: ethernet-phy@0 {
-				interrupts = <76>;	/* GPP 12 */
-				interrupt-parent = <&PIC>;
-				reg = <0>;
-			};
-			PHY1: ethernet-phy@1 {
-				interrupts = <76>;	/* GPP 12 */
-				interrupt-parent = <&PIC>;
-				reg = <1>;
-			};
-			PHY2: ethernet-phy@2 {
-				interrupts = <76>;	/* GPP 12 */
-				interrupt-parent = <&PIC>;
-				reg = <2>;
-			};
-		};
-
-		ethernet-group@2000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "marvell,mv64360-eth-group";
-			reg = <0x2000 0x2000>;
-			ethernet@0 {
-				device_type = "network";
-				compatible = "marvell,mv64360-eth";
-				reg = <0>;
-				interrupts = <32>;
-				interrupt-parent = <&PIC>;
-				phy = <&PHY0>;
-				local-mac-address = [ 00 00 00 00 00 00 ];
-			};
-			ethernet@1 {
-				device_type = "network";
-				compatible = "marvell,mv64360-eth";
-				reg = <1>;
-				interrupts = <33>;
-				interrupt-parent = <&PIC>;
-				phy = <&PHY1>;
-				local-mac-address = [ 00 00 00 00 00 00 ];
-			};
-			ethernet@2 {
-				device_type = "network";
-				compatible = "marvell,mv64360-eth";
-				reg = <2>;
-				interrupts = <34>;
-				interrupt-parent = <&PIC>;
-				phy = <&PHY2>;
-				local-mac-address = [ 00 00 00 00 00 00 ];
-			};
-		};
-
-		SDMA0: sdma@4000 {
-			compatible = "marvell,mv64360-sdma";
-			reg = <0x4000 0xc18>;
-			virtual-reg = <0xd8004000>;
-			interrupt-base = <0>;
-			interrupts = <36>;
-			interrupt-parent = <&PIC>;
-		};
-
-		SDMA1: sdma@6000 {
-			compatible = "marvell,mv64360-sdma";
-			reg = <0x6000 0xc18>;
-			virtual-reg = <0xd8006000>;
-			interrupt-base = <0>;
-			interrupts = <38>;
-			interrupt-parent = <&PIC>;
-		};
-
-		BRG0: brg@b200 {
-			compatible = "marvell,mv64360-brg";
-			reg = <0xb200 0x8>;
-			clock-src = <8>;
-			clock-frequency = <133333333>;
-			current-speed = <115200>;
-		};
-
-		BRG1: brg@b208 {
-			compatible = "marvell,mv64360-brg";
-			reg = <0xb208 0x8>;
-			clock-src = <8>;
-			clock-frequency = <133333333>;
-			current-speed = <115200>;
-		};
-
-		CUNIT: cunit@f200 {
-			reg = <0xf200 0x200>;
-		};
-
-		MPSCROUTING: mpscrouting@b400 {
-			reg = <0xb400 0xc>;
-		};
-
-		MPSCINTR: mpscintr@b800 {
-			reg = <0xb800 0x100>;
-			virtual-reg = <0xd800b800>;
-		};
-
-		MPSC0: mpsc@8000 {
-			compatible = "marvell,mv64360-mpsc";
-			reg = <0x8000 0x38>;
-			virtual-reg = <0xd8008000>;
-			sdma = <&SDMA0>;
-			brg = <&BRG0>;
-			cunit = <&CUNIT>;
-			mpscrouting = <&MPSCROUTING>;
-			mpscintr = <&MPSCINTR>;
-			cell-index = <0>;
-			interrupts = <40>;
-			interrupt-parent = <&PIC>;
-		};
-
-		MPSC1: mpsc@9000 {
-			compatible = "marvell,mv64360-mpsc";
-			reg = <0x9000 0x38>;
-			virtual-reg = <0xd8009000>;
-			sdma = <&SDMA1>;
-			brg = <&BRG1>;
-			cunit = <&CUNIT>;
-			mpscrouting = <&MPSCROUTING>;
-			mpscintr = <&MPSCINTR>;
-			cell-index = <1>;
-			interrupts = <42>;
-			interrupt-parent = <&PIC>;
-		};
-
-		wdt@b410 {			/* watchdog timer */
-			compatible = "marvell,mv64360-wdt";
-			reg = <0xb410 0x8>;
-		};
-
-		i2c@c000 {
-			compatible = "marvell,mv64360-i2c";
-			reg = <0xc000 0x20>;
-			virtual-reg = <0xd800c000>;
-			interrupts = <37>;
-			interrupt-parent = <&PIC>;
-		};
-
-		PIC: pic {
-			#interrupt-cells = <1>;
-			#address-cells = <0>;
-			compatible = "marvell,mv64360-pic";
-			reg = <0x0000 0x88>;
-			interrupt-controller;
-		};
-
-		mpp@f000 {
-			compatible = "marvell,mv64360-mpp";
-			reg = <0xf000 0x10>;
-		};
-
-		gpp@f100 {
-			compatible = "marvell,mv64360-gpp";
-			reg = <0xf100 0x20>;
-		};
-
-		PCI0: pci@80000000 {
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			compatible = "marvell,mv64360-pci";
-			reg = <0x0cf8 0x8>;
-			ranges = <0x01000000 0x0 0x00000000 0xd4000000 0x0
0x01000000
-				  0x02000000 0x0 0x80000000 0x80000000 0x0
0x08000000>;
-			bus-range = <0 255>;
-			clock-frequency = <66000000>;
-			interrupt-pci-iack = <0x0c34>;
-			interrupt-parent = <&PIC>;
-			interrupt-map-mask = <0x0000 0x0 0x0 0x7>;
-			interrupt-map = <
-				/* Only one interrupt line for PMC0 slot
(INTA) */
-				0x0000 0 0 1 &PIC 88
-			>;
-		};
-
-
-		PCI1: pci@a0000000 {
-			#address-cells = <3>;
-			#size-cells = <2>;
-			#interrupt-cells = <1>;
-			device_type = "pci";
-			compatible = "marvell,mv64360-pci";
-			reg = <0x0c78 0x8>;
-			ranges = <0x01000000 0x0 0x00000000 0xd0000000 0x0
0x01000000
-				  0x02000000 0x0 0x80000000 0xa0000000 0x0
0x08000000>;
-			bus-range = <0 255>;
-			clock-frequency = <66000000>;
-			interrupt-pci-iack = <0x0cb4>;
-			interrupt-parent = <&PIC>;
-			interrupt-map-mask = <0xf800 0x00 0x00 0x7>;
-			interrupt-map = <
-				/* IDSEL 0x01: PMC1 ? */
-				0x0800 0 0 1 &PIC 88
-				/* IDSEL 0x02: cPCI bridge */
-				0x1000 0 0 1 &PIC 88
-				/* IDSEL 0x03: USB controller */
-				0x1800 0 0 1 &PIC 91
-				/* IDSEL 0x04: SATA controller */
-				0x2000 0 0 1 &PIC 95
-			>;
-		};
-
-		cpu-error@70 {
-			compatible = "marvell,mv64360-cpu-error";
-			reg = <0x0070 0x10 0x0128 0x28>;
-			interrupts = <3>;
-			interrupt-parent = <&PIC>;
-		};
-
-		sram-ctrl@380 {
-			compatible = "marvell,mv64360-sram-ctrl";
-			reg = <0x0380 0x80>;
-			interrupts = <13>;
-			interrupt-parent = <&PIC>;
-		};
-
-		pci-error@1d40 {
-			compatible = "marvell,mv64360-pci-error";
-			reg = <0x1d40 0x40 0x0c28 0x4>;
-			interrupts = <12>;
-			interrupt-parent = <&PIC>;
-		};
-
-		pci-error@1dc0 {
-			compatible = "marvell,mv64360-pci-error";
-			reg = <0x1dc0 0x40 0x0ca8 0x4>;
-			interrupts = <16>;
-			interrupt-parent = <&PIC>;
-		};
-
-		mem-ctrl@1400 {
-			compatible = "marvell,mv64360-mem-ctrl";
-			reg = <0x1400 0x60>;
-			interrupts = <17>;
-			interrupt-parent = <&PIC>;
-		};
-		/* Devices attached to the device controller */
-		devicebus@45c {
-			#address-cells = <2>;
-			#size-cells = <1>;
-			compatible = "marvell,mv64306-devctrl";
-			reg = <0x45C 0x88>;
-			interrupts = <1>;
-			interrupt-parent = <&PIC>;
-			ranges = 	<0 0 0xd8100000 0x10000
-					 2 0 0xd8110000 0x10000
-					 4 0 0xf8000000 0x8000000>;
-			fpga@0,0 {
-				compatible = "sbs,fpga-c2k";
-				reg = <0 0 0x10000>;
-			};
-			fpga_usart@2,0 {
-				compatible = "sbs,fpga_usart-c2k";
-				reg = <2 0 0x10000>;
-			};
-			nor_flash@4,0 {
-				compatible = "cfi-flash";
-				reg = <4 0 0x8000000>; /* 128MB */
-				bank-width = <4>;
-				device-width = <1>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				partition@0 {
-					label = "boot";
-					reg = <0x00000000 0x00080000>;
-				};
-				partition@40000 {
-					label = "kernel";
-					reg = <0x00080000 0x00400000>;
-				};
-				partition@440000 {
-					label = "initrd";
-					reg = <0x00480000 0x00B80000>;
-				};
-				partition@1000000 {
-					label = "rootfs";
-					reg = <0x01000000 0x06800000>;
-				};
-				partition@7800000 {
-					label = "recovery";
-					reg = <0x07800000 0x00800000>;
-					read-only;
-				};
-			};
-		};
-	};
-	chosen {
-		stdout-path = &MPSC0;
-	};
-};
diff --git a/arch/powerpc/configs/c2k_defconfig
b/arch/powerpc/configs/c2k_defconfig
deleted file mode 100644
index 4bb832a41d55..000000000000
--- a/arch/powerpc/configs/c2k_defconfig
+++ /dev/null
@@ -1,390 +0,0 @@
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_AUDIT=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_PROFILING=y
-CONFIG_OPROFILE=m
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_OSF_PARTITION=y
-CONFIG_MAC_PARTITION=y
-CONFIG_BSD_DISKLABEL=y
-CONFIG_MINIX_SUBPARTITION=y
-CONFIG_SOLARIS_X86_PARTITION=y
-CONFIG_UNIXWARE_DISKLABEL=y
-CONFIG_SGI_PARTITION=y
-CONFIG_SUN_PARTITION=y
-# CONFIG_PPC_CHRP is not set
-# CONFIG_PPC_PMAC is not set
-CONFIG_EMBEDDED6xx=y
-CONFIG_PPC_C2K=y
-CONFIG_CPU_FREQ=y
-CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
-CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
-CONFIG_CPU_FREQ_GOV_POWERSAVE=m
-CONFIG_CPU_FREQ_GOV_ONDEMAND=m
-CONFIG_GEN_RTC=y
-CONFIG_HIGHMEM=y
-CONFIG_PREEMPT_VOLUNTARY=y
-CONFIG_BINFMT_MISC=y
-CONFIG_PM=y
-CONFIG_PCI_MSI=y
-CONFIG_HOTPLUG_PCI=y
-CONFIG_HOTPLUG_PCI_SHPC=m
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_NET_KEY=m
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_NET_IPIP=m
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_SYN_COOKIES=y
-CONFIG_INET_AH=m
-CONFIG_INET_ESP=m
-CONFIG_INET_IPCOMP=m
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_TUNNEL=m
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_XT_MATCH_SCTP is not set -CONFIG_IP_NF_IPTABLES=m
-CONFIG_IP_NF_MATCH_ECN=m -CONFIG_IP_NF_MATCH_TTL=m -CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_REJECT=m -CONFIG_IP_NF_MANGLE=m
-CONFIG_IP_NF_TARGET_ECN=m -CONFIG_IP_NF_RAW=m -CONFIG_IP_NF_ARPTABLES=m
-CONFIG_IP_NF_ARPFILTER=m -CONFIG_IP_NF_ARP_MANGLE=m
-CONFIG_IP6_NF_IPTABLES=m -CONFIG_IP6_NF_MATCH_EUI64=m
-CONFIG_IP6_NF_MATCH_FRAG=m -CONFIG_IP6_NF_MATCH_OPTS=m
-CONFIG_IP6_NF_MATCH_HL=m -CONFIG_IP6_NF_MATCH_IPV6HEADER=m
-CONFIG_IP6_NF_MATCH_RT=m -CONFIG_IP6_NF_FILTER=m -CONFIG_IP6_NF_MANGLE=m
-CONFIG_IP6_NF_RAW=m -CONFIG_BRIDGE_NF_EBTABLES=m
-CONFIG_BRIDGE_EBT_BROUTE=m -CONFIG_BRIDGE_EBT_T_FILTER=m
-CONFIG_BRIDGE_EBT_T_NAT=m -CONFIG_BRIDGE_EBT_802_3=m
-CONFIG_BRIDGE_EBT_AMONG=m -CONFIG_BRIDGE_EBT_ARP=m -CONFIG_BRIDGE_EBT_IP=m
-CONFIG_BRIDGE_EBT_LIMIT=m -CONFIG_BRIDGE_EBT_MARK=m
-CONFIG_BRIDGE_EBT_PKTTYPE=m -CONFIG_BRIDGE_EBT_STP=m
-CONFIG_BRIDGE_EBT_VLAN=m -CONFIG_BRIDGE_EBT_ARPREPLY=m
-CONFIG_BRIDGE_EBT_DNAT=m -CONFIG_BRIDGE_EBT_MARK_T=m
-CONFIG_BRIDGE_EBT_REDIRECT=m -CONFIG_BRIDGE_EBT_SNAT=m
-CONFIG_BRIDGE_EBT_LOG=m -CONFIG_IP_SCTP=m -CONFIG_ATM=m -CONFIG_ATM_CLIP=m
-CONFIG_ATM_LANE=m -CONFIG_ATM_BR2684=m -CONFIG_BRIDGE=m
-CONFIG_VLAN_8021Q=m -CONFIG_NET_SCHED=y -CONFIG_NET_SCH_CBQ=m
-CONFIG_NET_SCH_HTB=m -CONFIG_NET_SCH_HFSC=m -CONFIG_NET_SCH_ATM=m
-CONFIG_NET_SCH_PRIO=m -CONFIG_NET_SCH_RED=m -CONFIG_NET_SCH_SFQ=m
-CONFIG_NET_SCH_TEQL=m -CONFIG_NET_SCH_TBF=m -CONFIG_NET_SCH_GRED=m
-CONFIG_NET_SCH_DSMARK=m -CONFIG_NET_SCH_NETEM=m -CONFIG_NET_CLS_TCINDEX=m
-CONFIG_NET_CLS_ROUTE4=m -CONFIG_NET_CLS_FW=m -CONFIG_NET_CLS_U32=m
-CONFIG_CLS_U32_PERF=y -CONFIG_NET_CLS_RSVP=m -CONFIG_NET_CLS_RSVP6=m
-CONFIG_NET_CLS_IND=y -CONFIG_BT=m -CONFIG_BT_RFCOMM=m
-CONFIG_BT_RFCOMM_TTY=y -CONFIG_BT_BNEP=m -CONFIG_BT_BNEP_MC_FILTER=y
-CONFIG_BT_BNEP_PROTO_FILTER=y -CONFIG_BT_HIDP=m -CONFIG_BT_HCIUART=m
-CONFIG_BT_HCIUART_H4=y -CONFIG_BT_HCIUART_BCSP=y -CONFIG_BT_HCIBCM203X=m
-CONFIG_BT_HCIBFUSB=m -CONFIG_BT_HCIVHCI=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_MTD=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_COMPLEX_MAPPINGS=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=16384
-CONFIG_SCSI=m
-CONFIG_BLK_DEV_SD=m
-CONFIG_CHR_DEV_ST=m
-CONFIG_CHR_DEV_OSST=m
-CONFIG_BLK_DEV_SR=m
-CONFIG_BLK_DEV_SR_VENDOR=y
-CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_CONSTANTS=y
-CONFIG_SCSI_LOGGING=y
-CONFIG_SCSI_ISCSI_ATTRS=m
-CONFIG_BLK_DEV_3W_XXXX_RAID=m
-CONFIG_SCSI_3W_9XXX=m
-CONFIG_SCSI_ACARD=m
-CONFIG_SCSI_AACRAID=m
-CONFIG_SCSI_AIC7XXX=m
-CONFIG_AIC7XXX_CMDS_PER_DEVICE=4
-CONFIG_AIC7XXX_RESET_DELAY_MS=15000
-# CONFIG_AIC7XXX_DEBUG_ENABLE is not set -# CONFIG_AIC7XXX_REG_PRETTY_PRINT
is not set -CONFIG_SCSI_AIC79XX=m
-CONFIG_AIC79XX_CMDS_PER_DEVICE=4
-CONFIG_AIC79XX_RESET_DELAY_MS=15000
-# CONFIG_AIC79XX_DEBUG_ENABLE is not set -# CONFIG_AIC79XX_REG_PRETTY_PRINT
is not set -CONFIG_SCSI_ARCMSR=m -CONFIG_MEGARAID_NEWGEN=y
-CONFIG_MEGARAID_MM=m -CONFIG_MEGARAID_MAILBOX=m -CONFIG_MEGARAID_SAS=m
-CONFIG_SCSI_FUTURE_DOMAIN=m -CONFIG_SCSI_GDTH=m -CONFIG_SCSI_IPS=m
-CONFIG_SCSI_INITIO=m -CONFIG_SCSI_SYM53C8XX_2=m -CONFIG_SCSI_QLOGIC_1280=m
-CONFIG_NETDEVICES=y -CONFIG_BONDING=m -CONFIG_DUMMY=m -CONFIG_NETCONSOLE=m
-CONFIG_TUN=m -# CONFIG_ATM_DRIVERS is not set -CONFIG_MV643XX_ETH=y
-CONFIG_VITESSE_PHY=y -CONFIG_INPUT_EVDEV=y -# CONFIG_INPUT_KEYBOARD is not
set -# CONFIG_INPUT_MOUSE is not set -CONFIG_INPUT_MISC=y
-CONFIG_INPUT_UINPUT=m -# CONFIG_SERIO is not set -# CONFIG_LEGACY_PTYS is
not set -CONFIG_SERIAL_NONSTANDARD=y -CONFIG_SERIAL_MPSC=y
-CONFIG_SERIAL_MPSC_CONSOLE=y -CONFIG_NVRAM=m -CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=8192
-CONFIG_I2C=m
-CONFIG_I2C_CHARDEV=m
-CONFIG_I2C_MV64XXX=m
-CONFIG_HWMON=m
-CONFIG_SENSORS_ADM1021=m
-CONFIG_SENSORS_ADM1025=m
-CONFIG_SENSORS_ADM1026=m
-CONFIG_SENSORS_ADM1031=m
-CONFIG_SENSORS_DS1621=m
-CONFIG_SENSORS_GL518SM=m
-CONFIG_SENSORS_MAX1619=m
-CONFIG_SENSORS_LM75=m
-CONFIG_SENSORS_LM77=m
-CONFIG_SENSORS_LM78=m
-CONFIG_SENSORS_LM80=m
-CONFIG_SENSORS_LM83=m
-CONFIG_SENSORS_LM85=m
-CONFIG_SENSORS_LM87=m
-CONFIG_SENSORS_LM90=m
-CONFIG_SENSORS_PCF8591=m
-CONFIG_SENSORS_VIA686A=m
-CONFIG_SENSORS_W83781D=m
-CONFIG_SENSORS_W83L785TS=m
-CONFIG_WATCHDOG=y
-CONFIG_SOFT_WATCHDOG=m
-CONFIG_PCIPCWATCHDOG=m
-CONFIG_WDTPCI=m
-CONFIG_USBPCWATCHDOG=m
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_USB=m
-CONFIG_USB_MON=m
-CONFIG_USB_EHCI_HCD=m
-CONFIG_USB_EHCI_ROOT_HUB_TT=y
-CONFIG_USB_OHCI_HCD=m
-CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
-CONFIG_USB_UHCI_HCD=m
-CONFIG_USB_ACM=m
-CONFIG_USB_PRINTER=m
-CONFIG_USB_STORAGE=m
-CONFIG_USB_STORAGE_DATAFAB=m
-CONFIG_USB_STORAGE_FREECOM=m
-CONFIG_USB_STORAGE_ISD200=m
-CONFIG_USB_STORAGE_SDDR09=m
-CONFIG_USB_STORAGE_SDDR55=m
-CONFIG_USB_STORAGE_JUMPSHOT=m
-CONFIG_USB_MDC800=m
-CONFIG_USB_MICROTEK=m
-CONFIG_USB_SERIAL=m
-CONFIG_USB_SERIAL_GENERIC=y
-CONFIG_USB_SERIAL_BELKIN=m
-CONFIG_USB_SERIAL_WHITEHEAT=m
-CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
-CONFIG_USB_SERIAL_EMPEG=m
-CONFIG_USB_SERIAL_FTDI_SIO=m
-CONFIG_USB_SERIAL_VISOR=m
-CONFIG_USB_SERIAL_IPAQ=m
-CONFIG_USB_SERIAL_IR=m
-CONFIG_USB_SERIAL_EDGEPORT=m
-CONFIG_USB_SERIAL_EDGEPORT_TI=m
-CONFIG_USB_SERIAL_KEYSPAN_PDA=m
-CONFIG_USB_SERIAL_KEYSPAN=m
-CONFIG_USB_SERIAL_KLSI=m
-CONFIG_USB_SERIAL_KOBIL_SCT=m
-CONFIG_USB_SERIAL_MCT_U232=m
-CONFIG_USB_SERIAL_PL2303=m
-CONFIG_USB_SERIAL_SAFE=m
-CONFIG_USB_SERIAL_SAFE_PADDED=y
-CONFIG_USB_SERIAL_CYBERJACK=m
-CONFIG_USB_SERIAL_XIRCOM=m
-CONFIG_USB_SERIAL_OMNINET=m
-CONFIG_USB_EMI62=m
-CONFIG_USB_RIO500=m
-CONFIG_USB_LEGOTOWER=m
-CONFIG_USB_LCD=m
-CONFIG_USB_LED=m
-CONFIG_USB_TEST=m
-CONFIG_USB_ATM=m
-CONFIG_USB_SPEEDTOUCH=m
-CONFIG_INFINIBAND=m
-CONFIG_INFINIBAND_USER_MAD=m
-CONFIG_INFINIBAND_USER_ACCESS=m
-CONFIG_INFINIBAND_MTHCA=m
-CONFIG_INFINIBAND_IPOIB=m
-CONFIG_INFINIBAND_IPOIB_CM=y
-CONFIG_INFINIBAND_SRP=m
-CONFIG_DMADEVICES=y
-CONFIG_EXT4_FS=m
-CONFIG_EXT4_FS_POSIX_ACL=y
-CONFIG_EXT4_FS_SECURITY=y
-CONFIG_QUOTA=y
-CONFIG_QFMT_V2=y
-CONFIG_AUTOFS4_FS=m
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
-CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_HFS_FS=m
-CONFIG_HFSPLUS_FS=m
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=m
-CONFIG_VXFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_CIFS=m
-CONFIG_CIFS_XATTR=y
-CONFIG_CIFS_POSIX=y
-CONFIG_NLS=y
-CONFIG_NLS_DEFAULT="utf8"
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_737=m
-CONFIG_NLS_CODEPAGE_775=m
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_CODEPAGE_852=m
-CONFIG_NLS_CODEPAGE_855=m
-CONFIG_NLS_CODEPAGE_857=m
-CONFIG_NLS_CODEPAGE_860=m
-CONFIG_NLS_CODEPAGE_861=m
-CONFIG_NLS_CODEPAGE_862=m
-CONFIG_NLS_CODEPAGE_863=m
-CONFIG_NLS_CODEPAGE_864=m
-CONFIG_NLS_CODEPAGE_865=m
-CONFIG_NLS_CODEPAGE_866=m
-CONFIG_NLS_CODEPAGE_869=m
-CONFIG_NLS_CODEPAGE_936=m
-CONFIG_NLS_CODEPAGE_950=m
-CONFIG_NLS_CODEPAGE_932=m
-CONFIG_NLS_CODEPAGE_949=m
-CONFIG_NLS_CODEPAGE_874=m
-CONFIG_NLS_ISO8859_8=m
-CONFIG_NLS_CODEPAGE_1250=m
-CONFIG_NLS_CODEPAGE_1251=m
-CONFIG_NLS_ASCII=y
-CONFIG_NLS_ISO8859_1=m
-CONFIG_NLS_ISO8859_2=m
-CONFIG_NLS_ISO8859_3=m
-CONFIG_NLS_ISO8859_4=m
-CONFIG_NLS_ISO8859_5=m
-CONFIG_NLS_ISO8859_6=m
-CONFIG_NLS_ISO8859_7=m
-CONFIG_NLS_ISO8859_9=m
-CONFIG_NLS_ISO8859_13=m
-CONFIG_NLS_ISO8859_14=m
-CONFIG_NLS_ISO8859_15=m
-CONFIG_NLS_KOI8_R=m
-CONFIG_NLS_KOI8_U=m
-CONFIG_CRC_CCITT=m
-CONFIG_CRC_T10DIF=m
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_STACK_USAGE=y
-CONFIG_DEBUG_HIGHMEM=y
-CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_DEBUG_SPINLOCK=y
-CONFIG_BOOTX_TEXT=y
-CONFIG_PPC_EARLY_DEBUG=y
-CONFIG_SECURITY=y
-CONFIG_SECURITY_NETWORK=y
-CONFIG_SECURITY_SELINUX=y
-CONFIG_SECURITY_SELINUX_BOOTPARAM=y
-CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA1=y
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_TWOFISH=m
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig
b/arch/powerpc/platforms/embedded6xx/Kconfig
index 9fb2d5912c5a..8ea16db5ff48 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -48,16 +48,6 @@ config PPC_HOLLY
 	  Select PPC_HOLLY if configuring for an IBM 750GX/CL Eval
 	  Board with TSI108/9 bridge (Hickory/Holly)
 
-config PPC_C2K
-	bool "SBS/GEFanuc C2K board"
-	depends on EMBEDDED6xx
-	select MV64X60
-	select NOT_COHERENT_CACHE
-	select MTD_CFI_I4
-	help
-	  This option enables support for the GE Fanuc C2K board (formerly
-	  an SBS board).
-
 config MVME5100
 	bool "Motorola/Emerson MVME5100"
 	depends on EMBEDDED6xx
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile
b/arch/powerpc/platforms/embedded6xx/Makefile
index 12154e3257ad..e656ae9f23c6 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_MPC7448HPC2)	+= mpc7448_hpc2.o
 obj-$(CONFIG_LINKSTATION)	+= linkstation.o ls_uart.o
 obj-$(CONFIG_STORCENTER)	+= storcenter.o
 obj-$(CONFIG_PPC_HOLLY)		+= holly.o
-obj-$(CONFIG_PPC_C2K)		+= c2k.o
 obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
 obj-$(CONFIG_GAMECUBE_COMMON)	+= flipper-pic.o
 obj-$(CONFIG_GAMECUBE)		+= gamecube.o
diff --git a/arch/powerpc/platforms/embedded6xx/c2k.c
b/arch/powerpc/platforms/embedded6xx/c2k.c
deleted file mode 100644
index d19e4e759597..000000000000
--- a/arch/powerpc/platforms/embedded6xx/c2k.c
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- * Board setup routines for the GEFanuc C2K board
- *
- * Author: Remi Machet <rmachet@slac.stanford.edu>
- *
- * Originated from prpmc2800.c
- *
- * 2008 (c) Stanford University
- * 2007 (c) MontaVista, Software, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- */
-
-#include <linux/stddef.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/seq_file.h>
-#include <linux/time.h>
-#include <linux/of.h>
-
-#include <asm/machdep.h>
-#include <asm/prom.h>
-#include <asm/time.h>
-
-#include <mm/mmu_decl.h>
-
-#include <sysdev/mv64x60.h>
-
-#define MV64x60_MPP_CNTL_0	0x0000
-#define MV64x60_MPP_CNTL_2	0x0008
-
-#define MV64x60_GPP_IO_CNTL	0x0000
-#define MV64x60_GPP_LEVEL_CNTL	0x0010
-#define MV64x60_GPP_VALUE_SET	0x0018
-
-static void __iomem *mv64x60_mpp_reg_base; -static void __iomem
*mv64x60_gpp_reg_base;
-
-static void __init c2k_setup_arch(void) -{
-	struct device_node *np;
-	phys_addr_t paddr;
-	const unsigned int *reg;
-
-	/*
-	 * ioremap mpp and gpp registers in case they are later
-	 * needed by c2k_reset_board().
-	 */
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-mpp");
-	reg = of_get_property(np, "reg", NULL);
-	paddr = of_translate_address(np, reg);
-	of_node_put(np);
-	mv64x60_mpp_reg_base = ioremap(paddr, reg[1]);
-
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64360-gpp");
-	reg = of_get_property(np, "reg", NULL);
-	paddr = of_translate_address(np, reg);
-	of_node_put(np);
-	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
-
-#ifdef CONFIG_PCI
-	mv64x60_pci_init();
-#endif
-}
-
-static void c2k_reset_board(void)
-{
-	u32 temp;
-
-	local_irq_disable();
-
-	temp = in_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_0);
-	temp &= 0xFFFF0FFF;
-	out_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_0, temp);
-
-	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL);
-	temp |= 0x00000004;
-	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL, temp);
-
-	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL);
-	temp |= 0x00000004;
-	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL, temp);
-
-	temp = in_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_2);
-	temp &= 0xFFFF0FFF;
-	out_le32(mv64x60_mpp_reg_base + MV64x60_MPP_CNTL_2, temp);
-
-	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL);
-	temp |= 0x00080000;
-	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_LEVEL_CNTL, temp);
-
-	temp = in_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL);
-	temp |= 0x00080000;
-	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_IO_CNTL, temp);
-
-	out_le32(mv64x60_gpp_reg_base + MV64x60_GPP_VALUE_SET, 0x00080004);
-}
-
-static void __noreturn c2k_restart(char *cmd) -{
-	c2k_reset_board();
-	msleep(100);
-	panic("restart failed\n");
-}
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-#define COHERENCY_SETTING "off"
-#else
-#define COHERENCY_SETTING "on"
-#endif
-
-void c2k_show_cpuinfo(struct seq_file *m) -{
-	seq_printf(m, "Vendor\t\t: GEFanuc\n");
-	seq_printf(m, "coherency\t: %s\n", COHERENCY_SETTING);
-}
-
-/*
- * Called very early, device-tree isn't unflattened
- */
-static int __init c2k_probe(void)
-{
-	if (!of_machine_is_compatible("GEFanuc,C2K"))
-		return 0;
-
-	printk(KERN_INFO "Detected a GEFanuc C2K board\n");
-
-	_set_L2CR(0);
-	_set_L2CR(L2CR_L2E | L2CR_L2PE | L2CR_L2I);
-
-	mv64x60_init_early();
-
-	return 1;
-}
-
-define_machine(c2k) {
-	.name			= "C2K",
-	.probe			= c2k_probe,
-	.setup_arch		= c2k_setup_arch,
-	.show_cpuinfo		= c2k_show_cpuinfo,
-	.init_IRQ		= mv64x60_init_irq,
-	.get_irq		= mv64x60_get_irq,
-	.restart		= c2k_restart,
-	.calibrate_decr		= generic_calibrate_decr,
-};
--
2.16.2
