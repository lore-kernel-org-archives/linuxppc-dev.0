Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C9E0DDF29
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 23:25:12 +1100 (EST)
Date: Fri, 14 Mar 2008 21:25:03 +0900 (JST)
Message-Id: <20080314.212503.-1962648783.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 5/11] celleb: move the SCC related code for celleb
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the SCC (Super Companion Chip) related code for celleb
into platforms/cell/.
All files in this patch are used by celleb-beat and celleb-native commonly.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/Makefile          |    5 
 arch/powerpc/platforms/cell/celleb_scc.h      |  145 ++++++++
 arch/powerpc/platforms/cell/celleb_scc_epci.c |  431 +++++++++++++++++++++++++
 arch/powerpc/platforms/cell/celleb_scc_sio.c  |  101 ++++++
 arch/powerpc/platforms/cell/celleb_scc_uhc.c  |   95 +++++
 arch/powerpc/platforms/celleb/Makefile        |    4 
 arch/powerpc/platforms/celleb/scc.h           |  145 --------
 arch/powerpc/platforms/celleb/scc_epci.c      |  437 --------------------------
 arch/powerpc/platforms/celleb/scc_sio.c       |  101 ------
 arch/powerpc/platforms/celleb/scc_uhc.c       |   95 -----
 10 files changed, 777 insertions(+), 782 deletions(-)

Index: b/arch/powerpc/platforms/cell/celleb_scc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_scc.h	2008-03-10 14:53:01.000000000 +0900
@@ -0,0 +1,145 @@
+/*
+ * SCC (Super Companion Chip) definitions
+ *
+ * (C) Copyright 2004-2006 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef _CELLEB_SCC_H
+#define _CELLEB_SCC_H
+
+#define PCI_VENDOR_ID_TOSHIBA_2                 0x102f
+#define PCI_DEVICE_ID_TOSHIBA_SCC_PCIEXC_BRIDGE 0x01b0
+#define PCI_DEVICE_ID_TOSHIBA_SCC_EPCI_BRIDGE   0x01b1
+#define PCI_DEVICE_ID_TOSHIBA_SCC_BRIDGE        0x01b2
+#define PCI_DEVICE_ID_TOSHIBA_SCC_GBE           0x01b3
+#define PCI_DEVICE_ID_TOSHIBA_SCC_ATA           0x01b4
+#define PCI_DEVICE_ID_TOSHIBA_SCC_USB2          0x01b5
+#define PCI_DEVICE_ID_TOSHIBA_SCC_USB           0x01b6
+#define PCI_DEVICE_ID_TOSHIBA_SCC_ENCDEC        0x01b7
+
+#define SCC_EPCI_REG            0x0000d000
+
+/* EPCI registers */
+#define SCC_EPCI_CNF10_REG      0x010
+#define SCC_EPCI_CNF14_REG      0x014
+#define SCC_EPCI_CNF18_REG      0x018
+#define SCC_EPCI_PVBAT          0x100
+#define SCC_EPCI_VPMBAT         0x104
+#define SCC_EPCI_VPIBAT         0x108
+#define SCC_EPCI_VCSR           0x110
+#define SCC_EPCI_VIENAB         0x114
+#define SCC_EPCI_VISTAT         0x118
+#define SCC_EPCI_VRDCOUNT       0x124
+#define SCC_EPCI_BAM0           0x12c
+#define SCC_EPCI_BAM1           0x134
+#define SCC_EPCI_BAM2           0x13c
+#define SCC_EPCI_IADR           0x164
+#define SCC_EPCI_CLKRST         0x800
+#define SCC_EPCI_INTSET         0x804
+#define SCC_EPCI_STATUS         0x808
+#define SCC_EPCI_ABTSET         0x80c
+#define SCC_EPCI_WATRP          0x810
+#define SCC_EPCI_DUMYRADR       0x814
+#define SCC_EPCI_SWRESP         0x818
+#define SCC_EPCI_CNTOPT         0x81c
+#define SCC_EPCI_ECMODE         0xf00
+#define SCC_EPCI_IOM_AC_NUM     5
+#define SCC_EPCI_IOM_ACTE(n)    (0xf10 + (n) * 4)
+#define SCC_EPCI_IOT_AC_NUM     4
+#define SCC_EPCI_IOT_ACTE(n)    (0xf30 + (n) * 4)
+#define SCC_EPCI_MAEA           0xf50
+#define SCC_EPCI_MAEC           0xf54
+#define SCC_EPCI_CKCTRL         0xff0
+
+/* bits for SCC_EPCI_VCSR */
+#define SCC_EPCI_VCSR_FRE       0x00020000
+#define SCC_EPCI_VCSR_FWE       0x00010000
+#define SCC_EPCI_VCSR_DR        0x00000400
+#define SCC_EPCI_VCSR_SR        0x00000008
+#define SCC_EPCI_VCSR_AT        0x00000004
+
+/* bits for SCC_EPCI_VIENAB/SCC_EPCI_VISTAT */
+#define SCC_EPCI_VISTAT_PMPE    0x00000008
+#define SCC_EPCI_VISTAT_PMFE    0x00000004
+#define SCC_EPCI_VISTAT_PRA     0x00000002
+#define SCC_EPCI_VISTAT_PRD     0x00000001
+#define SCC_EPCI_VISTAT_ALL     0x0000000f
+
+#define SCC_EPCI_VIENAB_PMPEE   0x00000008
+#define SCC_EPCI_VIENAB_PMFEE   0x00000004
+#define SCC_EPCI_VIENAB_PRA     0x00000002
+#define SCC_EPCI_VIENAB_PRD     0x00000001
+#define SCC_EPCI_VIENAB_ALL     0x0000000f
+
+/* bits for SCC_EPCI_CLKRST */
+#define SCC_EPCI_CLKRST_CKS_MASK 0x00030000
+#define SCC_EPCI_CLKRST_CKS_2   0x00000000
+#define SCC_EPCI_CLKRST_CKS_4   0x00010000
+#define SCC_EPCI_CLKRST_CKS_8   0x00020000
+#define SCC_EPCI_CLKRST_PCICRST 0x00000400
+#define SCC_EPCI_CLKRST_BC      0x00000200
+#define SCC_EPCI_CLKRST_PCIRST  0x00000100
+#define SCC_EPCI_CLKRST_PCKEN   0x00000001
+
+/* bits for SCC_EPCI_INTSET/SCC_EPCI_STATUS */
+#define SCC_EPCI_INT_2M         0x01000000
+#define SCC_EPCI_INT_RERR       0x00200000
+#define SCC_EPCI_INT_SERR       0x00100000
+#define SCC_EPCI_INT_PRTER      0x00080000
+#define SCC_EPCI_INT_SER        0x00040000
+#define SCC_EPCI_INT_PER        0x00020000
+#define SCC_EPCI_INT_PAI        0x00010000
+#define SCC_EPCI_INT_1M         0x00000100
+#define SCC_EPCI_INT_PME        0x00000010
+#define SCC_EPCI_INT_INTD       0x00000008
+#define SCC_EPCI_INT_INTC       0x00000004
+#define SCC_EPCI_INT_INTB       0x00000002
+#define SCC_EPCI_INT_INTA       0x00000001
+#define SCC_EPCI_INT_DEVINT     0x0000000f
+#define SCC_EPCI_INT_ALL        0x003f001f
+#define SCC_EPCI_INT_ALLERR     0x003f0000
+
+/* bits for SCC_EPCI_CKCTRL */
+#define SCC_EPCI_CKCTRL_CRST0   0x00010000
+#define SCC_EPCI_CKCTRL_CRST1   0x00020000
+#define SCC_EPCI_CKCTRL_OCLKEN  0x00000100
+#define SCC_EPCI_CKCTRL_LCLKEN  0x00000001
+
+#define SCC_EPCI_IDSEL_AD_TO_SLOT(ad)       ((ad) - 10)
+#define SCC_EPCI_MAX_DEVNU      SCC_EPCI_IDSEL_AD_TO_SLOT(32)
+
+/* bits for SCC_EPCI_CNTOPT */
+#define SCC_EPCI_CNTOPT_O2PMB   0x00000002
+
+/* UHC registers */
+#define SCC_UHC_CKRCTRL         0xff0
+#define SCC_UHC_ECMODE          0xf00
+
+/* bits for SCC_UHC_CKRCTRL */
+#define SCC_UHC_F48MCKLEN       0x00000001
+#define SCC_UHC_P_SUSPEND       0x00000002
+#define SCC_UHC_PHY_SUSPEND_SEL 0x00000004
+#define SCC_UHC_HCLKEN          0x00000100
+#define SCC_UHC_USBEN           0x00010000
+#define SCC_UHC_USBCEN          0x00020000
+#define SCC_UHC_PHYEN           0x00040000
+
+/* bits for SCC_UHC_ECMODE */
+#define SCC_UHC_ECMODE_BY_BYTE  0x00000555
+#define SCC_UHC_ECMODE_BY_WORD  0x00000aaa
+
+#endif /* _CELLEB_SCC_H */
Index: b/arch/powerpc/platforms/celleb/scc.h
===================================================================
--- a/arch/powerpc/platforms/celleb/scc.h	2008-03-10 14:28:08.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,145 +0,0 @@
-/*
- * SCC (Super Companion Chip) definitions
- *
- * (C) Copyright 2004-2006 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef _CELLEB_SCC_H
-#define _CELLEB_SCC_H
-
-#define PCI_VENDOR_ID_TOSHIBA_2                 0x102f
-#define PCI_DEVICE_ID_TOSHIBA_SCC_PCIEXC_BRIDGE 0x01b0
-#define PCI_DEVICE_ID_TOSHIBA_SCC_EPCI_BRIDGE   0x01b1
-#define PCI_DEVICE_ID_TOSHIBA_SCC_BRIDGE        0x01b2
-#define PCI_DEVICE_ID_TOSHIBA_SCC_GBE           0x01b3
-#define PCI_DEVICE_ID_TOSHIBA_SCC_ATA           0x01b4
-#define PCI_DEVICE_ID_TOSHIBA_SCC_USB2          0x01b5
-#define PCI_DEVICE_ID_TOSHIBA_SCC_USB           0x01b6
-#define PCI_DEVICE_ID_TOSHIBA_SCC_ENCDEC        0x01b7
-
-#define SCC_EPCI_REG            0x0000d000
-
-/* EPCI registers */
-#define SCC_EPCI_CNF10_REG      0x010
-#define SCC_EPCI_CNF14_REG      0x014
-#define SCC_EPCI_CNF18_REG      0x018
-#define SCC_EPCI_PVBAT          0x100
-#define SCC_EPCI_VPMBAT         0x104
-#define SCC_EPCI_VPIBAT         0x108
-#define SCC_EPCI_VCSR           0x110
-#define SCC_EPCI_VIENAB         0x114
-#define SCC_EPCI_VISTAT         0x118
-#define SCC_EPCI_VRDCOUNT       0x124
-#define SCC_EPCI_BAM0           0x12c
-#define SCC_EPCI_BAM1           0x134
-#define SCC_EPCI_BAM2           0x13c
-#define SCC_EPCI_IADR           0x164
-#define SCC_EPCI_CLKRST         0x800
-#define SCC_EPCI_INTSET         0x804
-#define SCC_EPCI_STATUS         0x808
-#define SCC_EPCI_ABTSET         0x80c
-#define SCC_EPCI_WATRP          0x810
-#define SCC_EPCI_DUMYRADR       0x814
-#define SCC_EPCI_SWRESP         0x818
-#define SCC_EPCI_CNTOPT         0x81c
-#define SCC_EPCI_ECMODE         0xf00
-#define SCC_EPCI_IOM_AC_NUM     5
-#define SCC_EPCI_IOM_ACTE(n)    (0xf10 + (n) * 4)
-#define SCC_EPCI_IOT_AC_NUM     4
-#define SCC_EPCI_IOT_ACTE(n)    (0xf30 + (n) * 4)
-#define SCC_EPCI_MAEA           0xf50
-#define SCC_EPCI_MAEC           0xf54
-#define SCC_EPCI_CKCTRL         0xff0
-
-/* bits for SCC_EPCI_VCSR */
-#define SCC_EPCI_VCSR_FRE       0x00020000
-#define SCC_EPCI_VCSR_FWE       0x00010000
-#define SCC_EPCI_VCSR_DR        0x00000400
-#define SCC_EPCI_VCSR_SR        0x00000008
-#define SCC_EPCI_VCSR_AT        0x00000004
-
-/* bits for SCC_EPCI_VIENAB/SCC_EPCI_VISTAT */
-#define SCC_EPCI_VISTAT_PMPE    0x00000008
-#define SCC_EPCI_VISTAT_PMFE    0x00000004
-#define SCC_EPCI_VISTAT_PRA     0x00000002
-#define SCC_EPCI_VISTAT_PRD     0x00000001
-#define SCC_EPCI_VISTAT_ALL     0x0000000f
-
-#define SCC_EPCI_VIENAB_PMPEE   0x00000008
-#define SCC_EPCI_VIENAB_PMFEE   0x00000004
-#define SCC_EPCI_VIENAB_PRA     0x00000002
-#define SCC_EPCI_VIENAB_PRD     0x00000001
-#define SCC_EPCI_VIENAB_ALL     0x0000000f
-
-/* bits for SCC_EPCI_CLKRST */
-#define SCC_EPCI_CLKRST_CKS_MASK 0x00030000
-#define SCC_EPCI_CLKRST_CKS_2   0x00000000
-#define SCC_EPCI_CLKRST_CKS_4   0x00010000
-#define SCC_EPCI_CLKRST_CKS_8   0x00020000
-#define SCC_EPCI_CLKRST_PCICRST 0x00000400
-#define SCC_EPCI_CLKRST_BC      0x00000200
-#define SCC_EPCI_CLKRST_PCIRST  0x00000100
-#define SCC_EPCI_CLKRST_PCKEN   0x00000001
-
-/* bits for SCC_EPCI_INTSET/SCC_EPCI_STATUS */
-#define SCC_EPCI_INT_2M         0x01000000
-#define SCC_EPCI_INT_RERR       0x00200000
-#define SCC_EPCI_INT_SERR       0x00100000
-#define SCC_EPCI_INT_PRTER      0x00080000
-#define SCC_EPCI_INT_SER        0x00040000
-#define SCC_EPCI_INT_PER        0x00020000
-#define SCC_EPCI_INT_PAI        0x00010000
-#define SCC_EPCI_INT_1M         0x00000100
-#define SCC_EPCI_INT_PME        0x00000010
-#define SCC_EPCI_INT_INTD       0x00000008
-#define SCC_EPCI_INT_INTC       0x00000004
-#define SCC_EPCI_INT_INTB       0x00000002
-#define SCC_EPCI_INT_INTA       0x00000001
-#define SCC_EPCI_INT_DEVINT     0x0000000f
-#define SCC_EPCI_INT_ALL        0x003f001f
-#define SCC_EPCI_INT_ALLERR     0x003f0000
-
-/* bits for SCC_EPCI_CKCTRL */
-#define SCC_EPCI_CKCTRL_CRST0   0x00010000
-#define SCC_EPCI_CKCTRL_CRST1   0x00020000
-#define SCC_EPCI_CKCTRL_OCLKEN  0x00000100
-#define SCC_EPCI_CKCTRL_LCLKEN  0x00000001
-
-#define SCC_EPCI_IDSEL_AD_TO_SLOT(ad)       ((ad) - 10)
-#define SCC_EPCI_MAX_DEVNU      SCC_EPCI_IDSEL_AD_TO_SLOT(32)
-
-/* bits for SCC_EPCI_CNTOPT */
-#define SCC_EPCI_CNTOPT_O2PMB   0x00000002
-
-/* UHC registers */
-#define SCC_UHC_CKRCTRL         0xff0
-#define SCC_UHC_ECMODE          0xf00
-
-/* bits for SCC_UHC_CKRCTRL */
-#define SCC_UHC_F48MCKLEN       0x00000001
-#define SCC_UHC_P_SUSPEND       0x00000002
-#define SCC_UHC_PHY_SUSPEND_SEL 0x00000004
-#define SCC_UHC_HCLKEN          0x00000100
-#define SCC_UHC_USBEN           0x00010000
-#define SCC_UHC_USBCEN          0x00020000
-#define SCC_UHC_PHYEN           0x00040000
-
-/* bits for SCC_UHC_ECMODE */
-#define SCC_UHC_ECMODE_BY_BYTE  0x00000555
-#define SCC_UHC_ECMODE_BY_WORD  0x00000aaa
-
-#endif /* _CELLEB_SCC_H */
Index: b/arch/powerpc/platforms/cell/celleb_scc_sio.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_scc_sio.c	2008-03-10 14:53:01.000000000 +0900
@@ -0,0 +1,101 @@
+/*
+ * setup serial port in SCC
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/console.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+
+/* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
+    mmio=0xfff000-0x1000,0xff2000-0x1000 */
+static int txx9_serial_bitmap __initdata;
+
+static struct {
+	uint32_t offset;
+	uint32_t index;
+} txx9_scc_tab[3] __initdata = {
+	{ 0x300, 0 },	/* 0xFFF300 */
+	{ 0x400, 0 },	/* 0xFFF400 */
+	{ 0x800, 1 }	/* 0xFF2800 */
+};
+
+static int __init txx9_serial_init(void)
+{
+	extern int early_serial_txx9_setup(struct uart_port *port);
+	struct device_node *node = NULL;
+	int i;
+	struct uart_port req;
+	struct of_irq irq;
+	struct resource res;
+
+	while ((node = of_find_compatible_node(node,
+				"serial", "toshiba,sio-scc")) != NULL) {
+		for (i = 0; i < ARRAY_SIZE(txx9_scc_tab); i++) {
+			if (!(txx9_serial_bitmap & (1<<i)))
+				continue;
+
+			if (of_irq_map_one(node, i, &irq))
+				continue;
+			if (of_address_to_resource(node,
+				txx9_scc_tab[i].index, &res))
+				continue;
+
+			memset(&req, 0, sizeof(req));
+			req.line = i;
+			req.iotype = UPIO_MEM;
+			req.mapbase = res.start + txx9_scc_tab[i].offset;
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+			req.membase = ioremap(req.mapbase, 0x24);
+#endif
+			req.irq = irq_create_of_mapping(irq.controller,
+				irq.specifier, irq.size);
+			req.flags |= UPF_IOREMAP | UPF_BUGGY_UART
+				/*HAVE_CTS_LINE*/;
+			req.uartclk = 83300000;
+			early_serial_txx9_setup(&req);
+		}
+	}
+
+	return 0;
+}
+
+static int __init txx9_serial_config(char *ptr)
+{
+	int	i;
+
+	for (;;) {
+		switch (get_option(&ptr, &i)) {
+		default:
+			return 0;
+		case 2:
+			txx9_serial_bitmap |= 1 << i;
+			break;
+		case 1:
+			txx9_serial_bitmap |= 1 << i;
+			return 0;
+		}
+	}
+}
+__setup("txx9_serial=", txx9_serial_config);
+
+console_initcall(txx9_serial_init);
Index: b/arch/powerpc/platforms/celleb/scc_sio.c
===================================================================
--- a/arch/powerpc/platforms/celleb/scc_sio.c	2008-03-10 14:51:51.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,101 +0,0 @@
-/*
- * setup serial port in SCC
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/console.h>
-
-#include <asm/io.h>
-#include <asm/prom.h>
-
-/* sio irq0=0xb00010022 irq0=0xb00010023 irq2=0xb00010024
-    mmio=0xfff000-0x1000,0xff2000-0x1000 */
-static int txx9_serial_bitmap __initdata;
-
-static struct {
-	uint32_t offset;
-	uint32_t index;
-} txx9_scc_tab[3] __initdata = {
-	{ 0x300, 0 },	/* 0xFFF300 */
-	{ 0x400, 0 },	/* 0xFFF400 */
-	{ 0x800, 1 }	/* 0xFF2800 */
-};
-
-static int __init txx9_serial_init(void)
-{
-	extern int early_serial_txx9_setup(struct uart_port *port);
-	struct device_node *node = NULL;
-	int i;
-	struct uart_port req;
-	struct of_irq irq;
-	struct resource res;
-
-	while ((node = of_find_compatible_node(node,
-				"serial", "toshiba,sio-scc")) != NULL) {
-		for (i = 0; i < ARRAY_SIZE(txx9_scc_tab); i++) {
-			if (!(txx9_serial_bitmap & (1<<i)))
-				continue;
-
-			if (of_irq_map_one(node, i, &irq))
-				continue;
-			if (of_address_to_resource(node,
-				txx9_scc_tab[i].index, &res))
-				continue;
-
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.mapbase = res.start + txx9_scc_tab[i].offset;
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-			req.membase = ioremap(req.mapbase, 0x24);
-#endif
-			req.irq = irq_create_of_mapping(irq.controller,
-				irq.specifier, irq.size);
-			req.flags |= UPF_IOREMAP | UPF_BUGGY_UART
-				/*HAVE_CTS_LINE*/;
-			req.uartclk = 83300000;
-			early_serial_txx9_setup(&req);
-		}
-	}
-
-	return 0;
-}
-
-static int __init txx9_serial_config(char *ptr)
-{
-	int	i;
-
-	for (;;) {
-		switch (get_option(&ptr, &i)) {
-		default:
-			return 0;
-		case 2:
-			txx9_serial_bitmap |= 1 << i;
-			break;
-		case 1:
-			txx9_serial_bitmap |= 1 << i;
-			return 0;
-		}
-	}
-}
-__setup("txx9_serial=", txx9_serial_config);
-
-console_initcall(txx9_serial_init);
Index: b/arch/powerpc/platforms/celleb/scc_uhc.c
===================================================================
--- a/arch/powerpc/platforms/celleb/scc_uhc.c	2008-03-10 14:28:08.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,95 +0,0 @@
-/*
- * SCC (Super Companion Chip) UHC setup
- *
- * (C) Copyright 2006-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-
-#include <asm/delay.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-
-#include "scc.h"
-
-#define UHC_RESET_WAIT_MAX 10000
-
-static inline int uhc_clkctrl_ready(u32 val)
-{
-	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
-	return((val & mask) == mask);
-}
-
-/*
- * UHC(usb host controller) enable function.
- * affect to both of OHCI and EHCI core module.
- */
-static void enable_scc_uhc(struct pci_dev *dev)
-{
-	void __iomem *uhc_base;
-	u32 __iomem *uhc_clkctrl;
-	u32 __iomem *uhc_ecmode;
-	u32 val = 0;
-	int i;
-
-	if (!machine_is(celleb_beat) &&
-	    !machine_is(celleb_native))
-		return;
-
-	uhc_base = ioremap(pci_resource_start(dev, 0),
-			   pci_resource_len(dev, 0));
-	if (!uhc_base) {
-		printk(KERN_ERR "failed to map UHC register base.\n");
-		return;
-	}
-	uhc_clkctrl = uhc_base + SCC_UHC_CKRCTRL;
-	uhc_ecmode  = uhc_base + SCC_UHC_ECMODE;
-
-	/* setup for normal mode */
-	val |= SCC_UHC_F48MCKLEN;
-	out_be32(uhc_clkctrl, val);
-	val |= SCC_UHC_PHY_SUSPEND_SEL;
-	out_be32(uhc_clkctrl, val);
-	udelay(10);
-	val |= SCC_UHC_PHYEN;
-	out_be32(uhc_clkctrl, val);
-	udelay(50);
-
-	/* disable reset */
-	val |= SCC_UHC_HCLKEN;
-	out_be32(uhc_clkctrl, val);
-	val |= (SCC_UHC_USBCEN | SCC_UHC_USBEN);
-	out_be32(uhc_clkctrl, val);
-	i = 0;
-	while (!uhc_clkctrl_ready(in_be32(uhc_clkctrl))) {
-		udelay(10);
-		if (i++ > UHC_RESET_WAIT_MAX) {
-			printk(KERN_ERR "Failed to disable UHC reset %x\n",
-			       in_be32(uhc_clkctrl));
-			break;
-		}
-	}
-
-	/* Endian Conversion Mode for Master ALL area */
-	out_be32(uhc_ecmode, SCC_UHC_ECMODE_BY_BYTE);
-
-	iounmap(uhc_base);
-}
-
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
-		 PCI_DEVICE_ID_TOSHIBA_SCC_USB, enable_scc_uhc);
Index: b/arch/powerpc/platforms/cell/celleb_scc_uhc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_scc_uhc.c	2008-03-10 14:53:01.000000000 +0900
@@ -0,0 +1,95 @@
+/*
+ * SCC (Super Companion Chip) UHC setup
+ *
+ * (C) Copyright 2006-2007 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+
+#include "celleb_scc.h"
+
+#define UHC_RESET_WAIT_MAX 10000
+
+static inline int uhc_clkctrl_ready(u32 val)
+{
+	const u32 mask = SCC_UHC_USBCEN | SCC_UHC_USBCEN;
+	return((val & mask) == mask);
+}
+
+/*
+ * UHC(usb host controller) enable function.
+ * affect to both of OHCI and EHCI core module.
+ */
+static void enable_scc_uhc(struct pci_dev *dev)
+{
+	void __iomem *uhc_base;
+	u32 __iomem *uhc_clkctrl;
+	u32 __iomem *uhc_ecmode;
+	u32 val = 0;
+	int i;
+
+	if (!machine_is(celleb_beat) &&
+	    !machine_is(celleb_native))
+		return;
+
+	uhc_base = ioremap(pci_resource_start(dev, 0),
+			   pci_resource_len(dev, 0));
+	if (!uhc_base) {
+		printk(KERN_ERR "failed to map UHC register base.\n");
+		return;
+	}
+	uhc_clkctrl = uhc_base + SCC_UHC_CKRCTRL;
+	uhc_ecmode  = uhc_base + SCC_UHC_ECMODE;
+
+	/* setup for normal mode */
+	val |= SCC_UHC_F48MCKLEN;
+	out_be32(uhc_clkctrl, val);
+	val |= SCC_UHC_PHY_SUSPEND_SEL;
+	out_be32(uhc_clkctrl, val);
+	udelay(10);
+	val |= SCC_UHC_PHYEN;
+	out_be32(uhc_clkctrl, val);
+	udelay(50);
+
+	/* disable reset */
+	val |= SCC_UHC_HCLKEN;
+	out_be32(uhc_clkctrl, val);
+	val |= (SCC_UHC_USBCEN | SCC_UHC_USBEN);
+	out_be32(uhc_clkctrl, val);
+	i = 0;
+	while (!uhc_clkctrl_ready(in_be32(uhc_clkctrl))) {
+		udelay(10);
+		if (i++ > UHC_RESET_WAIT_MAX) {
+			printk(KERN_ERR "Failed to disable UHC reset %x\n",
+			       in_be32(uhc_clkctrl));
+			break;
+		}
+	}
+
+	/* Endian Conversion Mode for Master ALL area */
+	out_be32(uhc_ecmode, SCC_UHC_ECMODE_BY_BYTE);
+
+	iounmap(uhc_base);
+}
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TOSHIBA_2,
+		 PCI_DEVICE_ID_TOSHIBA_SCC_USB, enable_scc_uhc);
Index: b/arch/powerpc/platforms/cell/celleb_scc_epci.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ b/arch/powerpc/platforms/cell/celleb_scc_epci.c	2008-03-10 14:54:51.000000000 +0900
@@ -0,0 +1,431 @@
+/*
+ * Support for SCC external PCI
+ *
+ * (C) Copyright 2004-2007 TOSHIBA CORPORATION
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#undef DEBUG
+
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/pci_regs.h>
+#include <linux/bootmem.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/pci-bridge.h>
+#include <asm/ppc-pci.h>
+
+#include "celleb_scc.h"
+#include "celleb_pci.h"
+
+#define MAX_PCI_DEVICES   32
+#define MAX_PCI_FUNCTIONS  8
+
+#define iob()  __asm__ __volatile__("eieio; sync":::"memory")
+
+static inline PCI_IO_ADDR celleb_epci_get_epci_base(
+					struct pci_controller *hose)
+{
+	/*
+	 * Note:
+	 * Celleb epci uses cfg_addr as a base address for
+	 * epci control registers.
+	 */
+
+	return hose->cfg_addr;
+}
+
+static inline PCI_IO_ADDR celleb_epci_get_epci_cfg(
+					struct pci_controller *hose)
+{
+	/*
+	 * Note:
+	 * Celleb epci uses cfg_data as a base address for
+	 * configuration area for epci devices.
+	 */
+
+	return hose->cfg_data;
+}
+
+static inline void clear_and_disable_master_abort_interrupt(
+					struct pci_controller *hose)
+{
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR reg;
+	epci_base = celleb_epci_get_epci_base(hose);
+	reg = epci_base + PCI_COMMAND;
+	out_be32(reg, in_be32(reg) | (PCI_STATUS_REC_MASTER_ABORT << 16));
+}
+
+static int celleb_epci_check_abort(struct pci_controller *hose,
+				   PCI_IO_ADDR addr)
+{
+	PCI_IO_ADDR reg;
+	PCI_IO_ADDR epci_base;
+	u32 val;
+
+	iob();
+	epci_base = celleb_epci_get_epci_base(hose);
+
+	reg = epci_base + PCI_COMMAND;
+	val = in_be32(reg);
+
+	if (val & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
+		out_be32(reg,
+			 (val & 0xffff) | (PCI_STATUS_REC_MASTER_ABORT << 16));
+
+		/* clear PCI Controller error, FRE, PMFE */
+		reg = epci_base + SCC_EPCI_STATUS;
+		out_be32(reg, SCC_EPCI_INT_PAI);
+
+		reg = epci_base + SCC_EPCI_VCSR;
+		val = in_be32(reg) & 0xffff;
+		val |= SCC_EPCI_VCSR_FRE;
+		out_be32(reg, val);
+
+		reg = epci_base + SCC_EPCI_VISTAT;
+		out_be32(reg, SCC_EPCI_VISTAT_PMFE);
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static PCI_IO_ADDR celleb_epci_make_config_addr(struct pci_bus *bus,
+		struct pci_controller *hose, unsigned int devfn, int where)
+{
+	PCI_IO_ADDR addr;
+
+	if (bus != hose->bus)
+		addr = celleb_epci_get_epci_cfg(hose) +
+		       (((bus->number & 0xff) << 16)
+			| ((devfn & 0xff) << 8)
+			| (where & 0xff)
+			| 0x01000000);
+	else
+		addr = celleb_epci_get_epci_cfg(hose) +
+		       (((devfn & 0xff) << 8) | (where & 0xff));
+
+	pr_debug("EPCI: config_addr = 0x%p\n", addr);
+
+	return addr;
+}
+
+static int celleb_epci_read_config(struct pci_bus *bus,
+			unsigned int devfn, int where, int size, u32 *val)
+{
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR addr;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+	/* allignment check */
+	BUG_ON(where % size);
+
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+	if (!celleb_epci_get_epci_cfg(hose))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == hose->first_busno && devfn == 0) {
+		/* EPCI controller self */
+
+		epci_base = celleb_epci_get_epci_base(hose);
+		addr = epci_base + where;
+
+		switch (size) {
+		case 1:
+			*val = in_8(addr);
+			break;
+		case 2:
+			*val = in_be16(addr);
+			break;
+		case 4:
+			*val = in_be32(addr);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+	} else {
+
+		clear_and_disable_master_abort_interrupt(hose);
+		addr = celleb_epci_make_config_addr(bus, hose, devfn, where);
+
+		switch (size) {
+		case 1:
+			*val = in_8(addr);
+			break;
+		case 2:
+			*val = in_le16(addr);
+			break;
+		case 4:
+			*val = in_le32(addr);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	pr_debug("EPCI: "
+		 "addr=0x%p, devfn=0x%x, where=0x%x, size=0x%x, val=0x%x\n",
+		 addr, devfn, where, size, *val);
+
+	return celleb_epci_check_abort(hose, NULL);
+}
+
+static int celleb_epci_write_config(struct pci_bus *bus,
+			unsigned int devfn, int where, int size, u32 val)
+{
+	PCI_IO_ADDR epci_base;
+	PCI_IO_ADDR addr;
+	struct device_node *node;
+	struct pci_controller *hose;
+
+	/* allignment check */
+	BUG_ON(where % size);
+
+	node = (struct device_node *)bus->sysdata;
+	hose = pci_find_hose_for_OF_device(node);
+
+
+	if (!celleb_epci_get_epci_cfg(hose))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (bus->number == hose->first_busno && devfn == 0) {
+		/* EPCI controller self */
+
+		epci_base = celleb_epci_get_epci_base(hose);
+		addr = epci_base + where;
+
+		switch (size) {
+		case 1:
+			out_8(addr, val);
+			break;
+		case 2:
+			out_be16(addr, val);
+			break;
+		case 4:
+			out_be32(addr, val);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+
+	} else {
+
+		clear_and_disable_master_abort_interrupt(hose);
+		addr = celleb_epci_make_config_addr(bus, hose, devfn, where);
+
+		switch (size) {
+		case 1:
+			out_8(addr, val);
+			break;
+		case 2:
+			out_le16(addr, val);
+			break;
+		case 4:
+			out_le32(addr, val);
+			break;
+		default:
+			return PCIBIOS_DEVICE_NOT_FOUND;
+		}
+	}
+
+	return celleb_epci_check_abort(hose, addr);
+}
+
+struct pci_ops celleb_epci_ops = {
+	.read = celleb_epci_read_config,
+	.write = celleb_epci_write_config,
+};
+
+/* to be moved in FW */
+static int __init celleb_epci_init(struct pci_controller *hose)
+{
+	u32 val;
+	PCI_IO_ADDR reg;
+	PCI_IO_ADDR epci_base;
+	int hwres = 0;
+
+	epci_base = celleb_epci_get_epci_base(hose);
+
+	/* PCI core reset(Internal bus and PCI clock) */
+	reg = epci_base + SCC_EPCI_CKCTRL;
+	val = in_be32(reg);
+	if (val == 0x00030101)
+		hwres = 1;
+	else {
+		val &= ~(SCC_EPCI_CKCTRL_CRST0 | SCC_EPCI_CKCTRL_CRST1);
+		out_be32(reg, val);
+
+		/* set PCI core clock */
+		val = in_be32(reg);
+		val |= (SCC_EPCI_CKCTRL_OCLKEN | SCC_EPCI_CKCTRL_LCLKEN);
+		out_be32(reg, val);
+
+		/* release PCI core reset (internal bus) */
+		val = in_be32(reg);
+		val |= SCC_EPCI_CKCTRL_CRST0;
+		out_be32(reg, val);
+
+		/* set PCI clock select */
+		reg = epci_base + SCC_EPCI_CLKRST;
+		val = in_be32(reg);
+		val &= ~SCC_EPCI_CLKRST_CKS_MASK;
+		val |= SCC_EPCI_CLKRST_CKS_2;
+		out_be32(reg, val);
+
+		/* set arbiter */
+		reg = epci_base + SCC_EPCI_ABTSET;
+		out_be32(reg, 0x0f1f001f);	/* temporary value */
+
+		/* buffer on */
+		reg = epci_base + SCC_EPCI_CLKRST;
+		val = in_be32(reg);
+		val |= SCC_EPCI_CLKRST_BC;
+		out_be32(reg, val);
+
+		/* PCI clock enable */
+		val = in_be32(reg);
+		val |= SCC_EPCI_CLKRST_PCKEN;
+		out_be32(reg, val);
+
+		/* release PCI core reset (all) */
+		reg = epci_base + SCC_EPCI_CKCTRL;
+		val = in_be32(reg);
+		val |= (SCC_EPCI_CKCTRL_CRST0 | SCC_EPCI_CKCTRL_CRST1);
+		out_be32(reg, val);
+
+		/* set base translation registers. (already set by Beat) */
+
+		/* set base address masks. (already set by Beat) */
+	}
+
+	/* release interrupt masks and clear all interrupts */
+	reg = epci_base + SCC_EPCI_INTSET;
+	out_be32(reg, 0x013f011f);	/* all interrupts enable */
+	reg = epci_base + SCC_EPCI_VIENAB;
+	val = SCC_EPCI_VIENAB_PMPEE | SCC_EPCI_VIENAB_PMFEE;
+	out_be32(reg, val);
+	reg = epci_base + SCC_EPCI_STATUS;
+	out_be32(reg, 0xffffffff);
+	reg = epci_base + SCC_EPCI_VISTAT;
+	out_be32(reg, 0xffffffff);
+
+	/* disable PCI->IB address translation */
+	reg = epci_base + SCC_EPCI_VCSR;
+	val = in_be32(reg);
+	val &= ~(SCC_EPCI_VCSR_DR | SCC_EPCI_VCSR_AT);
+	out_be32(reg, val);
+
+	/* set base addresses. (no need to set?) */
+
+	/* memory space, bus master enable */
+	reg = epci_base + PCI_COMMAND;
+	val = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	out_be32(reg, val);
+
+	/* endian mode setup */
+	reg = epci_base + SCC_EPCI_ECMODE;
+	val = 0x00550155;
+	out_be32(reg, val);
+
+	/* set control option */
+	reg = epci_base + SCC_EPCI_CNTOPT;
+	val = in_be32(reg);
+	val |= SCC_EPCI_CNTOPT_O2PMB;
+	out_be32(reg, val);
+
+	/* XXX: temporay: set registers for address conversion setup */
+	reg = epci_base + SCC_EPCI_CNF10_REG;
+	out_be32(reg, 0x80000008);
+	reg = epci_base + SCC_EPCI_CNF14_REG;
+	out_be32(reg, 0x40000008);
+
+	reg = epci_base + SCC_EPCI_BAM0;
+	out_be32(reg, 0x80000000);
+	reg = epci_base + SCC_EPCI_BAM1;
+	out_be32(reg, 0xe0000000);
+
+	reg = epci_base + SCC_EPCI_PVBAT;
+	out_be32(reg, 0x80000000);
+
+	if (!hwres) {
+		/* release external PCI reset */
+		reg = epci_base + SCC_EPCI_CLKRST;
+		val = in_be32(reg);
+		val |= SCC_EPCI_CLKRST_PCIRST;
+		out_be32(reg, val);
+	}
+
+	return 0;
+}
+
+int __init celleb_setup_epci(struct device_node *node,
+			     struct pci_controller *hose)
+{
+	struct resource r;
+
+	pr_debug("PCI: celleb_setup_epci()\n");
+
+	/*
+	 * Note:
+	 * Celleb epci uses cfg_addr and cfg_data member of
+	 * pci_controller structure in irregular way.
+	 *
+	 * cfg_addr is used to map for control registers of
+	 * celleb epci.
+	 *
+	 * cfg_data is used for configuration area of devices
+	 * on Celleb epci buses.
+	 */
+
+	if (of_address_to_resource(node, 0, &r))
+		goto error;
+	hose->cfg_addr = ioremap(r.start, (r.end - r.start + 1));
+	if (!hose->cfg_addr)
+		goto error;
+	pr_debug("EPCI: cfg_addr map 0x%016lx->0x%016lx + 0x%016lx\n",
+		 r.start, (unsigned long)hose->cfg_addr, (r.end - r.start + 1));
+
+	if (of_address_to_resource(node, 2, &r))
+		goto error;
+	hose->cfg_data = ioremap(r.start, (r.end - r.start + 1));
+	if (!hose->cfg_data)
+		goto error;
+	pr_debug("EPCI: cfg_data map 0x%016lx->0x%016lx + 0x%016lx\n",
+		 r.start, (unsigned long)hose->cfg_data, (r.end - r.start + 1));
+
+	hose->ops = &celleb_epci_ops;
+	celleb_epci_init(hose);
+
+	return 0;
+
+error:
+	if (hose->cfg_addr)
+		iounmap(hose->cfg_addr);
+
+	if (hose->cfg_data)
+		iounmap(hose->cfg_data);
+	return 1;
+}
Index: b/arch/powerpc/platforms/celleb/scc_epci.c
===================================================================
--- a/arch/powerpc/platforms/celleb/scc_epci.c	2008-03-10 14:52:04.000000000 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,437 +0,0 @@
-/*
- * Support for SCC external PCI
- *
- * (C) Copyright 2004-2007 TOSHIBA CORPORATION
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#undef DEBUG
-
-#include <linux/kernel.h>
-#include <linux/threads.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/pci_regs.h>
-#include <linux/bootmem.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/prom.h>
-#include <asm/machdep.h>
-#include <asm/pci-bridge.h>
-#include <asm/ppc-pci.h>
-
-#include "scc.h"
-#include "../cell/celleb_pci.h"
-#include "interrupt.h"
-
-#define MAX_PCI_DEVICES   32
-#define MAX_PCI_FUNCTIONS  8
-
-#define iob()  __asm__ __volatile__("eieio; sync":::"memory")
-
-static inline PCI_IO_ADDR celleb_epci_get_epci_base(
-					struct pci_controller *hose)
-{
-	/*
-	 * Note:
-	 * Celleb epci uses cfg_addr as a base address for
-	 * epci control registers.
-	 */
-
-	return hose->cfg_addr;
-}
-
-static inline PCI_IO_ADDR celleb_epci_get_epci_cfg(
-					struct pci_controller *hose)
-{
-	/*
-	 * Note:
-	 * Celleb epci uses cfg_data as a base address for
-	 * configuration area for epci devices.
-	 */
-
-	return hose->cfg_data;
-}
-
-static inline void clear_and_disable_master_abort_interrupt(
-					struct pci_controller *hose)
-{
-	PCI_IO_ADDR epci_base;
-	PCI_IO_ADDR reg;
-	epci_base = celleb_epci_get_epci_base(hose);
-	reg = epci_base + PCI_COMMAND;
-	out_be32(reg, in_be32(reg) | (PCI_STATUS_REC_MASTER_ABORT << 16));
-}
-
-static int celleb_epci_check_abort(struct pci_controller *hose,
-				   PCI_IO_ADDR addr)
-{
-	PCI_IO_ADDR reg;
-	PCI_IO_ADDR epci_base;
-	u32 val;
-
-	iob();
-	epci_base = celleb_epci_get_epci_base(hose);
-
-	reg = epci_base + PCI_COMMAND;
-	val = in_be32(reg);
-
-	if (val & (PCI_STATUS_REC_MASTER_ABORT << 16)) {
-		out_be32(reg,
-			 (val & 0xffff) | (PCI_STATUS_REC_MASTER_ABORT << 16));
-
-		/* clear PCI Controller error, FRE, PMFE */
-		reg = epci_base + SCC_EPCI_STATUS;
-		out_be32(reg, SCC_EPCI_INT_PAI);
-
-		reg = epci_base + SCC_EPCI_VCSR;
-		val = in_be32(reg) & 0xffff;
-		val |= SCC_EPCI_VCSR_FRE;
-		out_be32(reg, val);
-
-		reg = epci_base + SCC_EPCI_VISTAT;
-		out_be32(reg, SCC_EPCI_VISTAT_PMFE);
-		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static PCI_IO_ADDR celleb_epci_make_config_addr(
-					struct pci_bus *bus,
-					struct pci_controller *hose,
-					unsigned int devfn, int where)
-{
-	PCI_IO_ADDR addr;
-
-	if (bus != hose->bus)
-		addr = celleb_epci_get_epci_cfg(hose) +
-		       (((bus->number & 0xff) << 16)
-			| ((devfn & 0xff) << 8)
-			| (where & 0xff)
-			| 0x01000000);
-	else
-		addr = celleb_epci_get_epci_cfg(hose) +
-		       (((devfn & 0xff) << 8) | (where & 0xff));
-
-	pr_debug("EPCI: config_addr = 0x%p\n", addr);
-
-	return addr;
-}
-
-static int celleb_epci_read_config(struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 *val)
-{
-	PCI_IO_ADDR epci_base;
-	PCI_IO_ADDR addr;
-	struct device_node *node;
-	struct pci_controller *hose;
-
-	/* allignment check */
-	BUG_ON(where % size);
-
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-
-	if (!celleb_epci_get_epci_cfg(hose))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (bus->number == hose->first_busno && devfn == 0) {
-		/* EPCI controller self */
-
-		epci_base = celleb_epci_get_epci_base(hose);
-		addr = epci_base + where;
-
-		switch (size) {
-		case 1:
-			*val = in_8(addr);
-			break;
-		case 2:
-			*val = in_be16(addr);
-			break;
-		case 4:
-			*val = in_be32(addr);
-			break;
-		default:
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
-
-	} else {
-
-		clear_and_disable_master_abort_interrupt(hose);
-		addr = celleb_epci_make_config_addr(bus, hose, devfn, where);
-
-		switch (size) {
-		case 1:
-			*val = in_8(addr);
-			break;
-		case 2:
-			*val = in_le16(addr);
-			break;
-		case 4:
-			*val = in_le32(addr);
-			break;
-		default:
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
-	}
-
-	pr_debug("EPCI: "
-		 "addr=0x%p, devfn=0x%x, where=0x%x, size=0x%x, val=0x%x\n",
-		 addr, devfn, where, size, *val);
-
-	return celleb_epci_check_abort(hose, NULL);
-}
-
-static int celleb_epci_write_config(struct pci_bus *bus,
-			unsigned int devfn, int where, int size, u32 val)
-{
-	PCI_IO_ADDR epci_base;
-	PCI_IO_ADDR addr;
-	struct device_node *node;
-	struct pci_controller *hose;
-
-	/* allignment check */
-	BUG_ON(where % size);
-
-	node = (struct device_node *)bus->sysdata;
-	hose = pci_find_hose_for_OF_device(node);
-
-
-	if (!celleb_epci_get_epci_cfg(hose))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	if (bus->number == hose->first_busno && devfn == 0) {
-		/* EPCI controller self */
-
-		epci_base = celleb_epci_get_epci_base(hose);
-		addr = epci_base + where;
-
-		switch (size) {
-		case 1:
-			out_8(addr, val);
-			break;
-		case 2:
-			out_be16(addr, val);
-			break;
-		case 4:
-			out_be32(addr, val);
-			break;
-		default:
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
-
-	} else {
-
-		clear_and_disable_master_abort_interrupt(hose);
-		addr = celleb_epci_make_config_addr(bus, hose, devfn, where);
-
-		switch (size) {
-		case 1:
-			out_8(addr, val);
-			break;
-		case 2:
-			out_le16(addr, val);
-			break;
-		case 4:
-			out_le32(addr, val);
-			break;
-		default:
-			return PCIBIOS_DEVICE_NOT_FOUND;
-		}
-	}
-
-	return celleb_epci_check_abort(hose, addr);
-}
-
-struct pci_ops celleb_epci_ops = {
-	.read = celleb_epci_read_config,
-	.write = celleb_epci_write_config,
-};
-
-/* to be moved in FW */
-static int __init celleb_epci_init(struct pci_controller *hose)
-{
-	u32 val;
-	PCI_IO_ADDR reg;
-	PCI_IO_ADDR epci_base;
-	int hwres = 0;
-
-	epci_base = celleb_epci_get_epci_base(hose);
-
-	/* PCI core reset(Internal bus and PCI clock) */
-	reg = epci_base + SCC_EPCI_CKCTRL;
-	val = in_be32(reg);
-	if (val == 0x00030101)
-		hwres = 1;
-	else {
-		val &= ~(SCC_EPCI_CKCTRL_CRST0 | SCC_EPCI_CKCTRL_CRST1);
-		out_be32(reg, val);
-
-		/* set PCI core clock */
-		val = in_be32(reg);
-		val |= (SCC_EPCI_CKCTRL_OCLKEN | SCC_EPCI_CKCTRL_LCLKEN);
-		out_be32(reg, val);
-
-		/* release PCI core reset (internal bus) */
-		val = in_be32(reg);
-		val |= SCC_EPCI_CKCTRL_CRST0;
-		out_be32(reg, val);
-
-		/* set PCI clock select */
-		reg = epci_base + SCC_EPCI_CLKRST;
-		val = in_be32(reg);
-		val &= ~SCC_EPCI_CLKRST_CKS_MASK;
-		val |= SCC_EPCI_CLKRST_CKS_2;
-		out_be32(reg, val);
-
-		/* set arbiter */
-		reg = epci_base + SCC_EPCI_ABTSET;
-		out_be32(reg, 0x0f1f001f);	/* temporary value */
-
-		/* buffer on */
-		reg = epci_base + SCC_EPCI_CLKRST;
-		val = in_be32(reg);
-		val |= SCC_EPCI_CLKRST_BC;
-		out_be32(reg, val);
-
-		/* PCI clock enable */
-		val = in_be32(reg);
-		val |= SCC_EPCI_CLKRST_PCKEN;
-		out_be32(reg, val);
-
-		/* release PCI core reset (all) */
-		reg = epci_base + SCC_EPCI_CKCTRL;
-		val = in_be32(reg);
-		val |= (SCC_EPCI_CKCTRL_CRST0 | SCC_EPCI_CKCTRL_CRST1);
-		out_be32(reg, val);
-
-		/* set base translation registers. (already set by Beat) */
-
-		/* set base address masks. (already set by Beat) */
-	}
-
-	/* release interrupt masks and clear all interrupts */
-	reg = epci_base + SCC_EPCI_INTSET;
-	out_be32(reg, 0x013f011f);	/* all interrupts enable */
-	reg = epci_base + SCC_EPCI_VIENAB;
-	val = SCC_EPCI_VIENAB_PMPEE | SCC_EPCI_VIENAB_PMFEE;
-	out_be32(reg, val);
-	reg = epci_base + SCC_EPCI_STATUS;
-	out_be32(reg, 0xffffffff);
-	reg = epci_base + SCC_EPCI_VISTAT;
-	out_be32(reg, 0xffffffff);
-
-	/* disable PCI->IB address translation */
-	reg = epci_base + SCC_EPCI_VCSR;
-	val = in_be32(reg);
-	val &= ~(SCC_EPCI_VCSR_DR | SCC_EPCI_VCSR_AT);
-	out_be32(reg, val);
-
-	/* set base addresses. (no need to set?) */
-
-	/* memory space, bus master enable */
-	reg = epci_base + PCI_COMMAND;
-	val = PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
-	out_be32(reg, val);
-
-	/* endian mode setup */
-	reg = epci_base + SCC_EPCI_ECMODE;
-	val = 0x00550155;
-	out_be32(reg, val);
-
-	/* set control option */
-	reg = epci_base + SCC_EPCI_CNTOPT;
-	val = in_be32(reg);
-	val |= SCC_EPCI_CNTOPT_O2PMB;
-	out_be32(reg, val);
-
-	/* XXX: temporay: set registers for address conversion setup */
-	reg = epci_base + SCC_EPCI_CNF10_REG;
-	out_be32(reg, 0x80000008);
-	reg = epci_base + SCC_EPCI_CNF14_REG;
-	out_be32(reg, 0x40000008);
-
-	reg = epci_base + SCC_EPCI_BAM0;
-	out_be32(reg, 0x80000000);
-	reg = epci_base + SCC_EPCI_BAM1;
-	out_be32(reg, 0xe0000000);
-
-	reg = epci_base + SCC_EPCI_PVBAT;
-	out_be32(reg, 0x80000000);
-
-	if (!hwres) {
-		/* release external PCI reset */
-		reg = epci_base + SCC_EPCI_CLKRST;
-		val = in_be32(reg);
-		val |= SCC_EPCI_CLKRST_PCIRST;
-		out_be32(reg, val);
-	}
-
-	return 0;
-}
-
-int __init celleb_setup_epci(struct device_node *node,
-				struct pci_controller *hose)
-{
-	struct resource r;
-
-	pr_debug("PCI: celleb_setup_epci()\n");
-
-	/*
-	 * Note:
-	 * Celleb epci uses cfg_addr and cfg_data member of
-	 * pci_controller structure in irregular way.
-	 *
-	 * cfg_addr is used to map for control registers of
-	 * celleb epci.
-	 *
-	 * cfg_data is used for configuration area of devices
-	 * on Celleb epci buses.
-	 */
-
-	if (of_address_to_resource(node, 0, &r))
-		goto error;
-	hose->cfg_addr = ioremap(r.start, (r.end - r.start + 1));
-	if (!hose->cfg_addr)
-		goto error;
-	pr_debug("EPCI: cfg_addr map 0x%016lx->0x%016lx + 0x%016lx\n",
-		 r.start, (unsigned long)hose->cfg_addr,
-		(r.end - r.start + 1));
-
-	if (of_address_to_resource(node, 2, &r))
-		goto error;
-	hose->cfg_data = ioremap(r.start, (r.end - r.start + 1));
-	if (!hose->cfg_data)
-		goto error;
-	pr_debug("EPCI: cfg_data map 0x%016lx->0x%016lx + 0x%016lx\n",
-		 r.start, (unsigned long)hose->cfg_data,
-		(r.end - r.start + 1));
-
-	hose->ops = &celleb_epci_ops;
-	celleb_epci_init(hose);
-
-	return 0;
-
-error:
-	if (hose->cfg_addr)
-		iounmap(hose->cfg_addr);
-
-	if (hose->cfg_data)
-		iounmap(hose->cfg_data);
-	return 1;
-}
Index: b/arch/powerpc/platforms/cell/Makefile
===================================================================
--- a/arch/powerpc/platforms/cell/Makefile	2008-03-10 14:52:04.000000000 +0900
+++ b/arch/powerpc/platforms/cell/Makefile	2008-03-10 14:53:01.000000000 +0900
@@ -32,6 +32,9 @@
 # celleb stuff
 ifeq ($(CONFIG_PPC_CELLEB),y)
 obj-y					+= celleb_setup.o \
-					   celleb_pci.o \
+					   celleb_pci.o celleb_scc_epci.o \
+					   celleb_scc_uhc.o \
 					   io-workarounds.o spider-pci.o
+
+obj-$(CONFIG_SERIAL_TXX9)		+= celleb_scc_sio.o
 endif
Index: b/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- a/arch/powerpc/platforms/celleb/Makefile	2008-03-10 14:52:04.000000000 +0900
+++ b/arch/powerpc/platforms/celleb/Makefile	2008-03-10 14:53:01.000000000 +0900
@@ -1,8 +1,6 @@
 obj-y				+= interrupt.o iommu.o \
-				   htab.o beat.o hvCall.o \
-				   scc_epci.o scc_uhc.o
+				   htab.o beat.o hvCall.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
-obj-$(CONFIG_SERIAL_TXX9)	+= scc_sio.o
 obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o
