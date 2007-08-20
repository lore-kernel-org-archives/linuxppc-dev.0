Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8C73DDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:17 +1000 (EST)
Date: Mon, 20 Aug 2007 12:40:02 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 13/20] bootwrapper: Add PowerQUICC II (82xx with CPM) cuboot
	support.
Message-ID: <20070820174002.GL30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows booting on legacy, non-device-tree aware versions of U-boot.

It also fixes up the hardware to match the PCI and chipselect information
in the device tree, as u-boot is inconsistent in setting these up
correctly (or at all).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile     |    3 +-
 arch/powerpc/boot/cuboot-pq2.c |  283 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/devtree.c    |    6 +-
 arch/powerpc/boot/ops.h        |    9 ++
 arch/powerpc/platforms/Kconfig |    1 +
 5 files changed, 298 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-pq2.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e75c92b..4ab5f75 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -48,7 +48,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		cpm-serial.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c cuboot-8xx.c
+		ps3-head.S ps3-hvcall.S ps3.c cuboot-8xx.c cuboot-pq2.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -141,6 +141,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
+image-$(CONFIG_8260)			+= cuImage.pq2
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
 image-$(CONFIG_EBONY)			+= treeImage.ebony cuImage.ebony
diff --git a/arch/powerpc/boot/cuboot-pq2.c b/arch/powerpc/boot/cuboot-pq2.c
new file mode 100644
index 0000000..8021fd4
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -0,0 +1,283 @@
+/*
+ * Old U-boot compatibility for PowerQUICC II
+ * (a.k.a. 82xx with CPM, not the 8240 family of chips)
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "cuboot.h"
+#include "io.h"
+
+#define TARGET_CPM2
+#define TARGET_HAS_ETH1
+#include "ppcboot.h"
+
+static bd_t bd;
+
+struct cs_range {
+	u32 csnum;
+	u32 base; /* must be zero */
+	u32 addr;
+	u32 size;
+};
+
+struct pci_range {
+	u32 flags;
+	u32 pci_addr[2];
+	u32 phys_addr;
+	u32 size[2];
+};
+
+struct cs_range cs_ranges_buf[MAX_PROP_LEN / sizeof(struct cs_range)];
+struct pci_range pci_ranges_buf[MAX_PROP_LEN / sizeof(struct pci_range)];
+
+/* Different versions of u-boot put the BCSR in different places, and
+ * some don't set up the PCI PIC at all, so we assume the device tree is
+ * sane and update the BRx registers appropriately.
+ *
+ * For any node defined as compatible with fsl,pq2-chipselect,
+ * #address/#size must be 2/1 for chipselect bus, 1/1 for parent bus,
+ * and ranges must be for whole chip selects.
+ */
+static void update_cs_ranges(void)
+{
+	u32 ctrl_ph;
+	void *ctrl_node, *bus_node, *parent_node;
+	u32 *ctrl_addr;
+	unsigned long ctrl_size;
+	u32 naddr, nsize;
+	int len;
+	int i;
+
+	bus_node = finddevice("/chipselect");
+	if (!bus_node || !dt_is_compatible(bus_node, "fsl,pq2-chipselect"))
+		return;
+
+	dt_get_reg_format(bus_node, &naddr, &nsize);
+	if (naddr != 2 || nsize != 1)
+		goto err;
+
+	parent_node = get_parent(bus_node);
+	if (!parent_node)
+		goto err;
+
+	dt_get_reg_format(parent_node, &naddr, &nsize);
+	if (naddr != 1 || nsize != 1)
+		goto err;
+
+	len = getprop(bus_node, "fsl,ctrl", &ctrl_ph, 4);
+	if (len != 4)
+		goto err;
+
+	ctrl_node = find_node_by_prop_value(NULL, "linux,phandle",
+	                                    (char *)&ctrl_ph, 4);
+	if (!ctrl_node)
+		goto err;
+
+	if (!dt_is_compatible(ctrl_node, "fsl,pq2-chipselect-ctrl"))
+		goto err;
+
+	if (!dt_xlate_reg(ctrl_node, 0, (unsigned long *)&ctrl_addr,
+	                  &ctrl_size))
+		goto err;
+
+	len = getprop(bus_node, "ranges", cs_ranges_buf, sizeof(cs_ranges_buf));
+
+	for (i = 0; i < len / sizeof(struct cs_range); i++) {
+		u32 base, option;
+		int cs = cs_ranges_buf[i].csnum;
+		if (cs >= ctrl_size / 8)
+			goto err;
+
+		if (cs_ranges_buf[i].base != 0)
+			goto err;
+
+		base = in_be32(&ctrl_addr[cs * 2]);
+
+		/* If CS is already valid, use the existing flags.
+		 * Otherwise, guess a sane default.
+		 */
+		if (base & 1) {
+			base &= 0x7fff;
+			option = in_be32(&ctrl_addr[cs * 2 + 1]) & 0x7fff;
+		} else {
+			base = 0x1801;
+			option = 0x10;
+		}
+
+		out_be32(&ctrl_addr[cs * 2], 0);
+		out_be32(&ctrl_addr[cs * 2 + 1],
+		         option | ~(cs_ranges_buf[i].size - 1));
+		out_be32(&ctrl_addr[cs * 2], base | cs_ranges_buf[i].addr);
+	}
+
+	return;
+
+err:
+	printf("Bad /chipselect or fsl,pq2-chipselect-ctrl node\r\n");
+}
+
+/* Older u-boots don't set PCI up properly.  Update the hardware to match
+ * the device tree.  The prefetch mem region and non-prefetch mem region
+ * must be contiguous in the host bus.  As required by the PCI binding,
+ * PCI #addr/#size must be 3/2.  The parent bus must be 1/1.  Only
+ * 32-bit PCI is supported.  All three region types (prefetchable mem,
+ * non-prefetchable mem, and I/O) must be present.
+ */
+static void fixup_pci(void)
+{
+	struct pci_range *mem = NULL, *mmio = NULL,
+	                 *io = NULL, *mem_base = NULL;
+	u32 *pci_regs[3];
+	u8 *soc_regs;
+	int i, len;
+	void *ctrl_node, *bus_node, *parent_node, *soc_node;
+	u32 naddr, nsize, bus_ph, mem_log2;
+
+	ctrl_node = finddevice("/soc/pci");
+	if (!ctrl_node || !dt_is_compatible(ctrl_node, "fsl,pq2-pci"))
+		return;
+
+	soc_node = finddevice("/soc");
+	if (!soc_node || !dt_is_compatible(soc_node, "fsl,pq2-soc"))
+		goto err;
+
+	for (i = 0; i < 3; i++)
+		if (!dt_xlate_reg(ctrl_node, i,
+		                  (unsigned long *)&pci_regs[i], NULL))
+			goto err;
+
+	if (!dt_xlate_reg(soc_node, 0, (unsigned long *)&soc_regs, NULL))
+		goto err;
+
+	len = getprop(ctrl_node, "fsl,bus", &bus_ph, 4);
+	if (len != 4)
+		goto err;
+
+	bus_node = find_node_by_prop_value(NULL, "linux,phandle",
+	                                   (char *)&bus_ph, 4);
+	if (!bus_node)
+		goto err;
+
+	dt_get_reg_format(bus_node, &naddr, &nsize);
+	if (naddr != 3 || nsize != 2)
+		goto err;
+
+	parent_node = get_parent(bus_node);
+	if (!parent_node)
+		goto err;
+
+	dt_get_reg_format(parent_node, &naddr, &nsize);
+	if (naddr != 1 || nsize != 1)
+		goto err;
+
+	len = getprop(bus_node, "ranges", pci_ranges_buf,
+	              sizeof(pci_ranges_buf));
+
+	for (i = 0; i < len / sizeof(struct pci_range); i++) {
+		u32 flags = pci_ranges_buf[i].flags & 0x43000000;
+
+		if (flags == 0x42000000)
+			mem = &pci_ranges_buf[i];
+		else if (flags == 0x02000000)
+			mmio = &pci_ranges_buf[i];
+		else if (flags == 0x01000000)
+			io = &pci_ranges_buf[i];
+	}
+
+	if (!mem || !mmio || !io)
+		goto err;
+
+	if (mem->phys_addr + mem->size[1] == mmio->phys_addr)
+		mem_base = mem;
+	else if (mmio->phys_addr + mmio->size[1] == mem->phys_addr)
+		mem_base = mmio;
+	else
+		goto err;
+
+	out_be32(&pci_regs[1][0], mem_base->phys_addr | 1);
+	out_be32(&pci_regs[2][0], ~(mem->size[1] + mmio->size[1] - 1));
+
+	out_be32(&pci_regs[1][1], io->phys_addr | 1);
+	out_be32(&pci_regs[2][1], ~(io->size[1] - 1));
+
+	out_le32(&pci_regs[0][0], mem->pci_addr[1] >> 12);
+	out_le32(&pci_regs[0][2], mem->phys_addr >> 12);
+	out_le32(&pci_regs[0][4], (~(mem->size[1] - 1) >> 12) | 0xa0000000);
+
+	out_le32(&pci_regs[0][6], mmio->pci_addr[1] >> 12);
+	out_le32(&pci_regs[0][8], mmio->phys_addr >> 12);
+	out_le32(&pci_regs[0][10], (~(mmio->size[1] - 1) >> 12) | 0x80000000);
+
+	out_le32(&pci_regs[0][12], io->pci_addr[1] >> 12);
+	out_le32(&pci_regs[0][14], io->phys_addr >> 12);
+	out_le32(&pci_regs[0][16], (~(io->size[1] - 1) >> 12) | 0xc0000000);
+
+	/* Inbound translation */
+	out_le32(&pci_regs[0][58], 0);
+	out_le32(&pci_regs[0][60], 0);
+
+	mem_log2 = 1 << (__ilog2_u32(bd.bi_memsize - 1) + 1);
+	out_le32(&pci_regs[0][62], 0xa0000000 | ~((1 << (mem_log2 - 12)) - 1));
+
+	/* If PCI is disabled, drive RST high to enable. */
+	if (!(in_le32(&pci_regs[0][32]) & 1)) {
+		 /* Tpvrh (Power valid to RST# high) 100 ms */
+		udelay(100000);
+
+		out_le32(&pci_regs[0][32], 1);
+
+		/* Trhfa (RST# high to first cfg access) 2^25 clocks */
+		udelay(1020000);
+	}
+
+	/* Enable bus master and memory access */
+	out_le32(&pci_regs[0][64], 0x80000004);
+	out_le32(&pci_regs[0][65], in_le32(&pci_regs[0][65]) | 6);
+
+	/* Park the bus on PCI, and elevate PCI's arbitration priority,
+	 * as required by section 9.6 of the user's manual.
+	 */
+	out_8(&soc_regs[0x10028], 3);
+	out_be32((u32 *)&soc_regs[0x1002c], 0x01236745);
+
+	return;
+
+err:
+	printf("Bad PCI node\r\n");
+}
+
+static void pq2_platform_fixups(void)
+{
+	void *node;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr, bd.bi_enet1addr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 4, bd.bi_busfreq);
+
+	node = finddevice("/soc/cpm");
+	if (node) {
+		setprop(node, "clock-frequency", &bd.bi_cpmfreq, 4);
+		setprop(node, "fsl,brg-frequency", &bd.bi_brgfreq, 4);
+	}
+
+	update_cs_ranges();
+	fixup_pci();
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	CUBOOT_INIT();
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+	serial_console_init();
+	platform_ops.fixups = pq2_platform_fixups;
+}
diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 3a18bfe..e1b8122 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -114,7 +114,7 @@ void __dt_fixup_mac_addresses(u32 startindex, ...)
 
 #define MAX_ADDR_CELLS 4
 
-static void get_reg_format(void *node, u32 *naddr, u32 *nsize)
+void dt_get_reg_format(void *node, u32 *naddr, u32 *nsize)
 {
 	if (getprop(node, "#address-cells", naddr, 4) != 4)
 		*naddr = 2;
@@ -224,7 +224,7 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 	if (!parent)
 		return 0;
 
-	get_reg_format(parent, &naddr, &nsize);
+	dt_get_reg_format(parent, &naddr, &nsize);
 
 	if (nsize > 2)
 		return 0;
@@ -252,7 +252,7 @@ static int dt_xlate(void *node, int res, int reglen, unsigned long *addr,
 		if (!parent)
 			break;
 
-		get_reg_format(parent, &naddr, &nsize);
+		dt_get_reg_format(parent, &naddr, &nsize);
 
 		buflen = getprop(node, "ranges", prop_buf,
 				sizeof(prop_buf));
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index e4b6139..45c2268 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -89,6 +89,7 @@ extern void flush_cache(void *, unsigned long);
 int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr);
 int dt_is_compatible(void *node, const char *compat);
+void dt_get_reg_format(void *node, u32 *naddr, u32 *nsize);
 
 static inline void *finddevice(const char *name)
 {
@@ -206,4 +207,12 @@ extern char _initrd_end[];
 extern char _dtb_start[];
 extern char _dtb_end[];
 
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	int bit;
+	asm ("cntlzw %0,%1" : "=r" (bit) : "r" (n));
+	return 31 - bit;
+}
+
 #endif /* _PPC_BOOT_OPS_H_ */
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 94b12dc..524a954 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -19,6 +19,7 @@ config EMBEDDED6xx
 config PPC_82xx
 	bool "Freescale 82xx"
 	depends on 6xx
+	select WANT_DEVICE_TREE
 
 config PPC_83xx
 	bool "Freescale 83xx"
-- 
1.5.0.3
