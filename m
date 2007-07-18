Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE3D3DE070
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:27 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1XLBC018551
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:33:22 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1XLok001261
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:21 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18epo007865
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:40 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 5138DAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:33:20 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1XK6m015313
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:33:20 -0500
Date: Tue, 17 Jul 2007 20:33:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 18/61] bootwrapper: Add PowerQUICC II (82xx with CPM) support
Message-ID: <20070718013320.GQ15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile     |    3 +-
 arch/powerpc/boot/cuboot-pq2.c |  217 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig |    1 +
 3 files changed, 220 insertions(+), 1 deletions(-)
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
index 0000000..74f793b
--- /dev/null
+++ b/arch/powerpc/boot/cuboot-pq2.c
@@ -0,0 +1,217 @@
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
+extern char _end[];
+extern char _dtb_start[], _dtb_end[];
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
+/* Different versions of u-boot put the BCSR in different places,
+ * so we check the BRx registers and update the ranges property
+ * appropriately.
+ *
+ * #address/#size must be 2/1 for chipselect bus, 1/1 for parent bus.
+ * Ranges must be for whole chip selects. */
+static void update_cs_ranges(void)
+{
+	u32 ctrl_ph;
+	void *ctrl_node, *bus_node;
+	u32 *ctrl_addr;
+	unsigned long ctrl_size;
+	int len;
+	int i;
+
+	bus_node = finddevice("/chipselect");
+	if (!bus_node || !dt_is_compatible(bus_node, "fsl,pq2-chipselect"))
+		return;
+
+	len = getprop(bus_node, "fsl,ctrl", &ctrl_ph, 4);
+	if (len != 4)
+		return;
+
+	ctrl_node = find_node_by_prop_value(NULL, "linux,phandle",
+	                                    (char *)&ctrl_ph, 4);
+	if (!ctrl_node)
+		return;
+
+	if (!dt_is_compatible(ctrl_node, "fsl,pq2-chipselect-ctrl"))
+		return;
+
+	if (!dt_xlate_reg(ctrl_node, 0, (unsigned long *)&ctrl_addr,
+	                  &ctrl_size))
+		return;
+
+	len = getprop(bus_node, "ranges", cs_ranges_buf, sizeof(cs_ranges_buf));
+
+	for (i = 0; i < len / sizeof(struct cs_range); i++) {
+		u32 base, option;
+		int cs = cs_ranges_buf[i].csnum;
+		if (cs >= ctrl_size / 8)
+			continue;
+
+		base = in_be32(&ctrl_addr[cs * 2]);
+
+		/* If CS is already valid, use the existing flags.
+		 * Otherwise, guess a sane default.
+		 */
+		if (base & 1) {
+			base &= 0x7fff;
+			option = in_be32(&ctrl_addr[cs * 2 + 1]);
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
+}
+
+/* Older u-boots don't set PCI up properly.  Update the hardware
+ * to match the device tree.  The prefetch mem region and non-prefetch
+ * mem region must be contiguous in the host bus.  PCI #addr/#size must
+ * be 3/2.  Parent #address-cells must be 1.  All addresses and sizes
+ * must fit in 32 bits.
+ */
+static void fixup_pci(void)
+{
+	struct pci_range *mem = NULL, *mmio = NULL,
+	                 *io = NULL, *mem_base = NULL;
+	u32 *pci_regs[3];
+	int i, len;
+
+	void *node = finddevice("/soc/pci");
+	if (!node || !dt_is_compatible(node, "fsl,pq2-pci"))
+		return;
+
+	for (i = 0; i < 3; i++)
+		if (!dt_xlate_reg(node, i, (unsigned long *)&pci_regs[i], NULL))
+			return;
+
+	len = getprop(node, "ranges", pci_ranges_buf, sizeof(pci_ranges_buf));
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
+		return;
+
+	if (mem->phys_addr + mem->size[1] == mmio->phys_addr)
+		mem_base = mem;
+	else if (mmio->phys_addr + mmio->size[1] == mem->phys_addr)
+		mem_base = mmio;
+	else
+		return;
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
+	/* FIXME: non-power-of-two memsizes */
+	out_le32(&pci_regs[0][62], 0xa0000000 | ((~(bd.bi_memsize - 1)) >> 12));
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
+}
+
+static void platform_fixups(void)
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
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 33545d3..76b3492 100644
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
