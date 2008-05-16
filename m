Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B3F6DDEE0
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 10:23:15 +1000 (EST)
Subject: [PATCH 2/5] powerpc: boot code for the C2K
From: Remi Machet <rmachet@slac.stanford.edu>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 15 May 2008 17:23:40 -0700
Message-Id: <1210897421.13992.14.camel@pcds-ts102.slac.stanford.edu>
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
 Makefile |    3
 c2k.c    |  238 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7822d25..232a9b3 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -63,7 +63,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
 		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
-		fixed-head.S ep88xc.c ep405.c \
+		fixed-head.S ep88xc.c ep405.c c2k.c \
 		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S
@@ -197,6 +197,7 @@ image-$(CONFIG_PPC_HOLLY)		+= zImage.holly
 image-$(CONFIG_PPC_PRPMC2800)		+= dtbImage.prpmc2800
 image-$(CONFIG_PPC_ISERIES)		+= zImage.iseries
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
+image-$(CONFIG_PPC_C2K)			+= dtbImage.c2k
 
 #
 # Targets which embed a device tree blob
diff --git a/arch/powerpc/boot/c2k.c b/arch/powerpc/boot/c2k.c
new file mode 100644
index 0000000..e0a587a
--- /dev/null
+++ b/arch/powerpc/boot/c2k.c
@@ -0,0 +1,238 @@
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
+
+#define KB        1024U
+#define MB        (KB*KB)
+
+BSS_STACK(16*KB);
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
+	int hose;
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
+	while (1) {
+		devp = find_node_by_compatible(devp, "marvell,mv64360-pci");
+		if (devp == NULL)
+			break;
+
+		rc = getprop(devp, "cell-index", &hose, sizeof(hose));
+		if (rc != sizeof(hose))
+			hose = 0;
+
+		if (hose >= 2)
+			fatal("Error: Only 2 PCI controllers are supported at" \
+				" this time.\n");
+
+		mv64x60_config_pci_windows(bridge_base, bridge_pbase, hose, 0,
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
+			mv64x60_config_cpu2pci_window(bridge_base, hose,
+				pci_base_hi, pci_base_lo, cpu_base, size, tbl);
+		}
+
+		enables &= ~(3<<(9+hose*5)); /* Enable cpu->pci<hose> i/o,
+						cpu->pci<hose> mem0 */
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
+#define HEAP_SIZE	(16*MB)
+static struct gunzip_state gzstate;
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+			unsigned long r6, unsigned long r7)
+{
+	struct elf_info ei;
+	char *heap_start, *dtb;
+	int dt_size = _dtb_end - _dtb_start;
+	void *vmlinuz_addr = _vmlinux_start;
+	unsigned long vmlinuz_size = _vmlinux_end - _vmlinux_start;
+	char elfheader[256];
+
+	if (dt_size <= 0) /* No fdt */
+		exit();
+
+	/*
+	 * Start heap after end of the kernel (after decompressed to
+	 * address 0) or the end of the zImage, whichever is higher.
+	 * That's so things allocated by simple_alloc won't overwrite
+	 * any part of the zImage and the kernel won't overwrite the dtb
+	 * when decompressed & relocated.
+	 */
+	gunzip_start(&gzstate, vmlinuz_addr, vmlinuz_size);
+	gunzip_exactly(&gzstate, elfheader, sizeof(elfheader));
+
+	if (!parse_elf32(elfheader, &ei))
+		exit();
+
+	heap_start = (char *)(ei.memsize + ei.elfoffset); /* end of kernel*/
+	heap_start = max(heap_start, (char *)_end); /* end of zImage */
+
+	if ((unsigned)simple_alloc_init(heap_start, HEAP_SIZE, 2*KB, 16)
+			> (128*MB))
+		exit();
+
+	/* Relocate dtb to safe area past end of zImage & kernel */
+	dtb = malloc(dt_size);
+	if (!dtb)
+		exit();
+	memmove(dtb, _dtb_start, dt_size);
+	fdt_init(dtb);
+
+	bridge_base = mv64x60_get_bridge_base();
+
+	platform_ops.fixups = c2k_fixups;
+	platform_ops.exit = c2k_reset;
+
+	if (serial_console_init() < 0)
+		exit();
+}
+
+/* _zimage_start called very early--need to turn off external interrupts */
+asm ("	.globl _zimage_start\n\
+	_zimage_start:\n\
+		mfmsr	10\n\
+		rlwinm	10,10,0,~(1<<15)	/* Clear MSR_EE */\n\
+		sync\n\
+		mtmsr	10\n\
+		isync\n\
+		b _zimage_start_lib\n\
+");
