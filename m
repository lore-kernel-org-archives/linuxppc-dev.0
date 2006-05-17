Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 3EBB767BA4
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:14:14 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k4HAOLQt004137
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 03:24:21 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k4HAGQJe014790
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 05:16:28 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD46730626D61D@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH/2.6.17-rc4 3/10] Powerpc: Add tsi108 common function
Date: Wed, 17 May 2006 18:14:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Tundra Semiconductor tsi108 host bridge common function support.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>

---

 arch/powerpc/sysdev/Makefile        |    1 
 arch/powerpc/sysdev/tsi108_common.c |  224 +++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/tsi108_common.c

ab3b477b5924d2c9cbf6ba3ae4d95fe333c9bad9
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 4c2b356..8c0afb7 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_common.o tsi108_pic.o
diff --git a/arch/powerpc/sysdev/tsi108_common.c b/arch/powerpc/sysdev/tsi108_common.c
new file mode 100644
index 0000000..3c55f99
--- /dev/null
+++ b/arch/powerpc/sysdev/tsi108_common.c
@@ -0,0 +1,224 @@
+/*
+ * arch/ppc/syslib/tsi108_common.c
+ *
+ * Common routines for Tundra Semiconductor TSI108 host bridge.
+ *
+ * 2004-2005 (c) Tundra Semiconductor Corp.
+ * Author: Alex Bounine (alexandreb@tundra.com)
+ *
+ * This program is free software; you can redistribute it and/or modify it 
+ * under the terms of the GNU General Public License as published by the Free 
+ * Software Foundation; either version 2 of the License, or (at your option) 
+ * any later version.
+ * 
+ * This program is distributed in the hope that it will be useful, but WITHOUT 
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
+ * more details.
+ * 
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59 
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/tsi108.h>
+#include <asm/prom.h>
+
+u32 tsi108_pci_cfg_base;
+
+#undef TSI108_PCI_DEBUG
+
+#define tsi_mk_config_addr(bus, devfunc, offset) \
+	(((bus)<<16) | ((devfunc)<<8) | (offset & 0xfc)| tsi108_pci_cfg_base)
+
+static phys_addr_t tsi108_csr_base = -1;
+
+phys_addr_t get_csrbase(void)
+{
+	struct device_node *tsi;
+
+	if (tsi108_csr_base != -1)
+		return tsi108_csr_base;
+
+	tsi = of_find_node_by_type(NULL, "tsi-bridge");
+	if (tsi) {
+		unsigned int size;
+		void *prop = get_property(tsi, "reg", &size);
+		tsi108_csr_base = of_translate_address(tsi, prop);
+		of_node_put(tsi);
+	};
+	return tsi108_csr_base;
+}
+
+u32 get_vir_csrbase(void)
+{
+	return (u32) (ioremap(get_csrbase(), 0x10000));
+}
+
+EXPORT_SYMBOL(get_csrbase);
+EXPORT_SYMBOL(get_vir_csrbase);
+
+/*
+ * Prosessor Bus Clock (in MHz) defined by CG_PB_SELECT
+ * (based on recommended Tsi108 reference clock 33MHz)
+ */
+static int pb_clk_sel[8] = { 0, 0, 183, 100, 133, 167, 200, 233 };
+
+/*
+ * SDRAM Clock (in MHz) defined by CG_SD_SELECT
+ * (based on recommended Tsi108 reference clock 33MHz)
+ */
+static int sd_clk_sel[2][8] = {
+	{0, 0, 183, 100, 133, 167, 200, 233},	/* SYNC */
+	{0, 0, 0, 0, 133, 160, 200, 0}	/* ASYNC */
+};
+
+int
+tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfunc,
+			   int offset, int len, u32 val)
+{
+	volatile unsigned char *cfg_addr;
+
+	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
+							devfunc, offset) |
+				     (offset & 0x03));
+
+#ifdef TSI108_PCI_DEBUG
+	printk("PCI CFG write : ");
+	printk("%d:0x%x:0x%x ", bus->number, devfunc, offset);
+	printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
+	printk("data = 0x%08x\n", val);
+#endif
+
+	switch (len) {
+	case 1:
+		out_8((u8 *) cfg_addr, val);
+		break;
+	case 2:
+		out_le16((u16 *) cfg_addr, val);
+		break;
+	default:
+		out_le32((u32 *) cfg_addr, val);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+void tsi108_clear_pci_error(u32 pci_cfg_base)
+{
+	u32 err_stat, err_addr, pci_stat;
+
+	/*
+	 * Quietly clear PB and PCI error flags set as result
+	 * of PCI/X configuration read requests.
+	 */
+
+	/* Read PB Error Log Registers */
+
+	err_stat = tsi108_read_reg(TSI108_PB_OFFSET + TSI108_PB_ERRCS);
+	err_addr = tsi108_read_reg(TSI108_PB_OFFSET + TSI108_PB_AERR);
+
+	if (err_stat & TSI108_PB_ERRCS_ES) {
+		/* Clear error flag */
+		tsi108_write_reg(TSI108_PB_OFFSET + TSI108_PB_ERRCS,
+				 TSI108_PB_ERRCS_ES);
+
+		/* Clear read error reported in PB_ISR */
+		tsi108_write_reg(TSI108_PB_OFFSET + TSI108_PB_ISR,
+				 TSI108_PB_ISR_PBS_RD_ERR);
+
+		/* Clear PCI/X bus cfg errors if applicable */
+		if ((err_addr & 0xFF000000) == pci_cfg_base) {
+			pci_stat =
+			    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_CSR);
+			tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_CSR,
+					 pci_stat);
+		}
+	}
+
+	return;
+}
+
+#define __tsi108_read_pci_config(x, addr, op)		\
+	__asm__ __volatile__(				\
+		"	"op" %0,0,%1\n"		\
+		"1:	eieio\n"			\
+		"2:\n"					\
+		".section .fixup,\"ax\"\n"		\
+		"3:	li %0,-1\n"			\
+		"	b 2b\n"				\
+		".section __ex_table,\"a\"\n"		\
+		"	.align 2\n"			\
+		"	.long 1b,3b\n"			\
+		".text"					\
+		: "=r"(x) : "r"(addr))
+
+int
+tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
+			  int len, u32 * val)
+{
+	volatile unsigned char *cfg_addr;
+	u32 temp;
+
+	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
+							devfn,
+							offset) | (offset &
+								   0x03));
+
+	switch (len) {
+	case 1:
+		__tsi108_read_pci_config(temp, cfg_addr, "lbzx");
+		break;
+	case 2:
+		__tsi108_read_pci_config(temp, cfg_addr, "lhbrx");
+		break;
+	default:
+		__tsi108_read_pci_config(temp, cfg_addr, "lwbrx");
+		break;
+	}
+
+	*val = temp;
+
+#ifdef TSI108_PCI_DEBUG
+	if ((0xFFFFFFFF != temp) && (0xFFFF != temp) && (0xFF != temp)) {
+		printk("PCI CFG read : ");
+		printk("%d:0x%x:0x%x ", bus->number, devfn, offset);
+		printk("%d ADDR=0x%08x ", len, (uint) cfg_addr);
+		printk("data = 0x%x\n", *val);
+	}
+#endif
+	return PCIBIOS_SUCCESSFUL;
+}
+
+unsigned long tsi108_get_cpu_clk(void)
+{
+	/* Detect PB clock freq. */
+	u32 i = tsi108_read_reg(TSI108_CLK_OFFSET + TSI108_CG_PWRUP_STATUS);
+
+	i = (i >> 16) & 0x07;	/* Get PB PLL multiplier */
+	return (pb_clk_sel[i] * 1000000);
+}
+
+unsigned long tsi108_get_sdc_clk(void)
+{
+	u32 i, k;
+
+	/* Get SDC/PB clock freq. from CG settings */
+	i = tsi108_read_reg(TSI108_CLK_OFFSET + TSI108_CG_PWRUP_STATUS);
+	k = (i >> 16) & 0x07;	/* Get PB PLL multiplier */
+	i = (i >> 20) & 0x07;	/* Get SDC PLL multiplier */
+	k = (k == i) ? 0 : 1;	/* sync/async configuration */
+	return (sd_clk_sel[k][i] * 1000000);
+}
-- 
1.3.0
