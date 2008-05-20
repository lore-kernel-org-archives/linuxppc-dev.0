Return-Path: <rmachet@slac.stanford.edu>
Subject: [PATCH 2/5 v3] powerpc: boot code for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 20 May 2008 13:50:10 -0700
Message-Id: <1211316611.19212.41.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the C2K cPCI Single Board Computer from GEFanuc
(PowerPC MPC7448 with a Marvell MV64460 chipset)
All features of the board are not supported yet, but the board
boots, flash works, all Ethernet ports are working and PCI 
devices are all found (USB and SATA on PCI1 do not work yet).

Part 2 of 5: support for the board in arch/powerpc/boot.

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---
Changes:
v1: original patch
v2: changed stack size to be 4kB instead of 16kB (per
David Gibson suggestion). Also changed the way PCI buses
are detected, now the code is looking for an alias pciN
where N is the bus number.
v3: after removing the boot command from the DTS file I realized
that U-Boot was not transferring the command line properly. To have
the kernel and U-boot be able to exchange info I must use the cuImage
target.

 Makefile     |    3
 cuboot-c2k.c |  190 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7822d25..8c10fa3 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -63,7 +63,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
 		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
-		fixed-head.S ep88xc.c ep405.c \
+		fixed-head.S ep88xc.c ep405.c cuboot-c2k.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S
@@ -263,6 +263,7 @@ image-$(CONFIG_KSI8560)			+= cuImage.ksi8560
 # Board ports in arch/powerpc/platform/embedded6xx/Kconfig
 image-$(CONFIG_STORCENTER)		+= cuImage.storcenter
 image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
+image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
diff --git a/arch/powerpc/boot/cuboot-c2k.c b/arch/powerpc/boot/cuboot-c2k.c
new file mode 100644
index 0000000..e435949
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-c2k.c
@@ -0,0 +1,190 @@
+/*
+ * GEFanuc C2K platform code.
+ *
+ * Author: Remi Machet <rmachet@slac.stanford.edu>
+ *
+ * Originated from prpmc2800.c
+ *
+ * 2008 (c) Stanford University
+ * 2007 (c) MontaVista, Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "types.h"
+#include "stdio.h"
+#include "io.h"
+#include "ops.h"
+#include "elf.h"
+#include "gunzip_util.h"
+#include "mv64x60.h"
+#include "cuboot.h"
+#include "ppcboot.h"
+
+static u8 *bridge_base;
+
+static void c2k_bridge_setup(u32 mem_size)
+{
+	u32 i, v[30], enables, acc_bits;
+	u32 pci_base_hi, pci_base_lo, size, buf[2];
+	unsigned long cpu_base;
+	int rc;
+	void *devp, *mv64x60_devp;
+	u8 *bridge_pbase, is_coherent;
+	struct mv64x60_cpu2pci_win *tbl;
+	int bus;
+
+	bridge_pbase = mv64x60_get_bridge_pbase();
+	is_coherent = mv64x60_is_coherent();
+
+	if (is_coherent)
+		acc_bits = MV64x60_PCI_ACC_CNTL_SNOOP_WB
+			| MV64x60_PCI_ACC_CNTL_SWAP_NONE
+			| MV64x60_PCI_ACC_CNTL_MBURST_32_BYTES
+			| MV64x60_PCI_ACC_CNTL_RDSIZE_32_BYTES;
+	else
+		acc_bits = MV64x60_PCI_ACC_CNTL_SNOOP_NONE
+			| MV64x60_PCI_ACC_CNTL_SWAP_NONE
+			| MV64x60_PCI_ACC_CNTL_MBURST_128_BYTES
+			| MV64x60_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+
+	mv64x60_config_ctlr_windows(bridge_base, bridge_pbase, is_coherent);
+	mv64x60_devp = find_node_by_compatible(NULL, "marvell,mv64360");
+	if (mv64x60_devp == NULL)
+		fatal("Error: Missing marvell,mv64360 device tree node\n\r");
+
+	enables = in_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE));
+	enables |= 0x007ffe00; /* Disable all cpu->pci windows */
+	out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE), enables);
+
+	/* Get the cpu -> pci i/o & mem mappings from the device tree */
+	devp = NULL;
+	for (bus = 0; ; bus++) {
+		char name[] = "pci ";
+
+		name[strlen(name)-1] = bus+'0';
+
+		devp = find_node_by_alias(name);
+		if (devp == NULL)
+			break;
+
+		if (bus >= 2)
+			fatal("Error: Only 2 PCI controllers are supported at" \
+				" this time.\n");
+
+		mv64x60_config_pci_windows(bridge_base, bridge_pbase, bus, 0,
+				mem_size, acc_bits);
+
+		rc = getprop(devp, "ranges", v, sizeof(v));
+		if (rc == 0)
+			fatal("Error: Can't find marvell,mv64360-pci ranges"
+				" property\n\r");
+
+		/* Get the cpu -> pci i/o & mem mappings from the device tree */
+
+		for (i = 0; i < rc; i += 6) {
+			switch (v[i] & 0xff000000) {
+			case 0x01000000: /* PCI I/O Space */
+				tbl = mv64x60_cpu2pci_io;
+				break;
+			case 0x02000000: /* PCI MEM Space */
+				tbl = mv64x60_cpu2pci_mem;
+				break;
+			default:
+				continue;
+			}
+
+			pci_base_hi = v[i+1];
+			pci_base_lo = v[i+2];
+			cpu_base = v[i+3];
+			size = v[i+5];
+
+			buf[0] = cpu_base;
+			buf[1] = size;
+
+			if (!dt_xlate_addr(devp, buf, sizeof(buf), &cpu_base))
+				fatal("Error: Can't translate PCI address " \
+						"0x%x\n\r", (u32)cpu_base);
+
+			mv64x60_config_cpu2pci_window(bridge_base, bus,
+				pci_base_hi, pci_base_lo, cpu_base, size, tbl);
+		}
+
+		enables &= ~(3<<(9+bus*5)); /* Enable cpu->pci<bus> i/o,
+						cpu->pci<bus> mem0 */
+		out_le32((u32 *)(bridge_base + MV64x60_CPU_BAR_ENABLE),
+			enables);
+	};
+}
+
+static void c2k_fixups(void)
+{
+	u32 mem_size;
+
+	mem_size = mv64x60_get_mem_size(bridge_base);
+	c2k_bridge_setup(mem_size); /* Do necessary bridge setup */
+}
+
+#define MV64x60_MPP_CNTL_0	0xf000
+#define MV64x60_MPP_CNTL_2	0xf008
+#define MV64x60_GPP_IO_CNTL	0xf100
+#define MV64x60_GPP_LEVEL_CNTL	0xf110
+#define MV64x60_GPP_VALUE_SET	0xf118
+
+static void c2k_reset(void)
+{
+	u32 temp;
+
+	udelay(5000000);
+
+	if (bridge_base != 0) {
+		temp = in_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_0));
+		temp &= 0xFFFF0FFF;
+		out_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_0), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL));
+		temp |= 0x00000004;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL));
+		temp |= 0x00000004;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_2));
+		temp &= 0xFFFF0FFF;
+		out_le32((u32 *)(bridge_base + MV64x60_MPP_CNTL_2), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL));
+		temp |= 0x00080000;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_LEVEL_CNTL), temp);
+
+		temp = in_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL));
+		temp |= 0x00080000;
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_IO_CNTL), temp);
+
+		out_le32((u32 *)(bridge_base + MV64x60_GPP_VALUE_SET),
+				0x00080004);
+	}
+
+	for (;;);
+}
+
+static bd_t bd;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+
+	fdt_init(_dtb_start);
+
+	bridge_base = mv64x60_get_bridge_base();
+
+	platform_ops.fixups = c2k_fixups;
+	platform_ops.exit = c2k_reset;
+
+	if (serial_console_init() < 0)
+		exit();
+}
