Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CDD4367B3E
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 17:07:30 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5D7I8Wx009276
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 00:18:08 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k5D77Odv015054
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 02:07:26 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673069C3F3F@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
Subject: [PATCH/2.6.17-rc6 2/4 v2] Powerpc: Add tsi108 pci and platform d
	evice data register  function
Date: Tue, 13 Jun 2006 15:07:23 +0800
MIME-Version: 1.0
Content-Type: text/plain
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

Add Tundra Semiconductor tsi108  pci and platform device data register function support.
 
 Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
 Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com>
 
 ---

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 4c2b356..ad2da20 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o

diff --git a/arch/powerpc/sysdev/tsi108_dev.c b/arch/powerpc/sysdev/tsi108_dev.c
new file mode 100644
index 0000000..a56c6f9
--- /dev/null
+++ b/arch/powerpc/sysdev/tsi108_dev.c
@@ -0,0 +1,145 @@
+/*
+ * tsi108/109 device setup code
+ *
+ * Maintained by Roy Zang < tie-fei.zang@freescale.com >
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/major.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <asm/tsi108.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(fmt); } while(0)
+#else
+#define DBG(fmt...) do { } while(0)
+#endif
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
+static int __init tsi108_eth_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i;
+	struct platform_device *tsi_eth_dev;
+	struct resource res;
+	int ret;
+	
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "network", "tsi-ethernet")) != NULL;
+	     i++) {
+		struct resource r[2];
+		struct device_node *phy;
+		hw_info tsi_eth_data;
+		unsigned int *id;
+		unsigned int *phy_id;
+		void *mac_addr;
+		phandle *ph;
+		
+		memset(r, 0, sizeof(r));
+		memset(&tsi_eth_data, 0, sizeof(tsi_eth_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		DBG("%s: name:start->end = %s:0x%lx-> 0x%lx\n", 
+			__FUNCTION__,r[0].name, r[0].start, r[0].end);
+		if (ret)
+			goto err;
+		
+		r[1].name = "tx";
+		r[1].start = np->intrs[0].line;
+		r[1].end = np->intrs[0].line;
+		r[1].flags = IORESOURCE_IRQ;
+		
+		tsi_eth_dev =
+		    platform_device_register_simple("tsi-ethernet", i, &r[0],
+						    np->n_intrs + 1);
+
+		if (IS_ERR(tsi_eth_dev)) {
+			ret = PTR_ERR(tsi_eth_dev);
+			goto err;
+		}
+		
+		mac_addr = get_property(np, "address", NULL);
+		memcpy(tsi_eth_data.mac_addr, mac_addr, 6);
+
+		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		phy = of_find_node_by_phandle(*ph);
+		
+		if (phy == NULL) {
+			ret = -ENODEV;
+			goto unreg;
+		}
+
+		id = (u32 *) get_property(phy, "reg", NULL);
+		phy_id = (u32 *) get_property(phy, "phy-id", NULL);
+		ret = of_address_to_resource(phy, 0, &res);
+		if (ret) {
+			of_node_put(phy);
+			goto unreg;
+		}
+		tsi_eth_data.regs = r[0].start;
+		tsi_eth_data.phyregs = res.start;
+		tsi_eth_data.phy = *phy_id;
+		tsi_eth_data.irq_num = np->intrs[0].line;
+		of_node_put(phy);
+		ret =
+		    platform_device_add_data(tsi_eth_dev, &tsi_eth_data,
+					     sizeof(hw_info));
+		if (ret)
+			goto unreg;
+	}
+	return 0;
+unreg:
+	platform_device_unregister(tsi_eth_dev);
+err:
+	return ret;
+}
+
+arch_initcall(tsi108_eth_of_init);
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
new file mode 100644
index 0000000..f43d181
--- /dev/null
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -0,0 +1,412 @@
+/*
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
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/tsi108.h>
+#include <asm/tsi108_irq.h>
+#include <asm/prom.h>
+
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(x...) printk(x)
+#else
+#define DBG(x...)
+#endif
+
+#define tsi_mk_config_addr(bus, devfunc, offset) \
+	((((bus)<<16) | ((devfunc)<<8) | (offset & 0xfc)) + tsi108_pci_cfg_base)
+
+u32 tsi108_pci_cfg_base;
+u32 tsi108_csr_vir_base;
+
+extern u32 get_vir_csrbase(void);
+extern u32 tsi108_read_reg(u32 reg_offset);
+extern void tsi108_write_reg(u32 reg_offset, u32 val);
+
+int
+tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfunc,
+			   int offset, int len, u32 val)
+{
+	volatile unsigned char *cfg_addr;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfunc))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
+							devfunc, offset) |
+							(offset & 0x03));
+
+#ifdef DEBUG
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
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
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
+#ifdef DEBUG
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
+void tsi108_clear_pci_cfg_error(void)
+{
+	tsi108_clear_pci_error(TSI108_PCI_CFG_BASE_PHYS);
+}
+
+static struct pci_ops tsi108_direct_pci_ops = {
+	tsi108_direct_read_config,
+	tsi108_direct_write_config
+};
+
+int __init tsi108_setup_pci(struct device_node *dev)
+{
+	int len;
+	struct pci_controller *hose;
+	struct resource rsrc;
+	int *bus_range;
+	int primary = 0, has_address = 0;
+	
+	/* PCI Config mapping */
+	tsi108_pci_cfg_base = (u32)ioremap(TSI108_PCI_CFG_BASE_PHYS,
+			TSI108_PCI_CFG_SIZE);
+	DBG("TSI_PCI: %s tsi108_pci_cfg_base=0x%x\n", __FUNCTION__,
+	    tsi108_pci_cfg_base);
+
+	/* Fetch host bridge registers address */
+	has_address = (of_address_to_resource(dev, 0, &rsrc) == 0);
+
+	/* Get bus range if any */
+	bus_range = (int *)get_property(dev, "bus-range", &len);
+	if (bus_range == NULL || len < 2 * sizeof(int)) {
+		printk(KERN_WARNING "Can't get bus-range for %s, assume"
+		       " bus 0\n", dev->full_name);
+	}
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose) {
+		printk("PCI Host bridge init failed\n");
+		return -ENOMEM;
+	}
+	hose->arch_data = dev;
+	hose->set_cfg_type = 1;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	(hose)->ops = &tsi108_direct_pci_ops;
+
+	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08lx. "
+	       "Firmware bus number: %d->%d\n",
+	       rsrc.start, hose->first_busno, hose->last_busno);
+
+	/* Interpret the "ranges" property */
+	/* This also maps the I/O region and sets isa_io/mem_base */
+	pci_process_bridge_OF_ranges(hose, dev, primary);
+	return 0;
+}
+
+/*
+ * Low level utility functions
+ */
+
+static void tsi108_pci_int_mask(u_int irq)
+{
+	u_int irp_cfg;
+	int int_line = (irq - IRQ_PCI_INTAD_BASE);
+
+	irp_cfg = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
+	mb();
+	irp_cfg |= (1 << int_line);	/* INTx_DIR = output */
+	irp_cfg &= ~(3 << (8 + (int_line * 2)));	/* INTx_TYPE = unused */
+	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL, irp_cfg);
+	mb();
+	irp_cfg = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
+}
+
+static void tsi108_pci_int_unmask(u_int irq)
+{
+	u_int irp_cfg;
+	int int_line = (irq - IRQ_PCI_INTAD_BASE);
+
+	irp_cfg = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
+	mb();
+	irp_cfg &= ~(1 << int_line);
+	irp_cfg |= (3 << (8 + (int_line * 2)));
+	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL, irp_cfg);
+	mb();
+}
+
+static void init_pci_source(void)
+{
+	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL,
+			0x0000ff00);
+	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE, 
+			TSI108_PCI_IRP_ENABLE_P_INT);
+	mb();
+}
+
+static inline int get_pci_source(void)
+{
+	u_int temp = 0;
+	int irq = -1;
+	int i;
+	u_int pci_irp_stat;
+	static int mask = 0;
+
+	/* Read PCI/X block interrupt status register */
+	pci_irp_stat = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_STAT);
+	mb();
+
+	if (pci_irp_stat & TSI108_PCI_IRP_STAT_P_INT) {
+		/* Process Interrupt from PCI bus INTA# - INTD# lines */
+		temp =
+		    tsi108_read_reg(TSI108_PCI_OFFSET +
+				    TSI108_PCI_IRP_INTAD) & 0xf;
+		mb();
+		for (i = 0; i < 4; i++, mask++) {
+			if (temp & (1 << mask % 4)) {
+				irq = IRQ_PCI_INTA + mask % 4;
+				mask++;
+				break;
+			}
+		}
+
+		/* Disable interrupts from PCI block */
+		temp = tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE);
+		tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE, 
+				temp & ~TSI108_PCI_IRP_ENABLE_P_INT);
+		mb();
+		(void)tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE);
+		mb();
+	}
+#ifdef DEBUG
+	else {
+		printk("TSI108_PIC: error in TSI108_PCI_IRP_STAT\n");
+		pci_irp_stat =
+		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_STAT);
+		temp =
+		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_INTAD);
+		mb();
+		printk(">> stat=0x%08x intad=0x%08x ", pci_irp_stat, temp);
+		temp =
+		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_CFG_CTL);
+		mb();
+		printk("cfg_ctl=0x%08x ", temp);
+		temp =
+		    tsi108_read_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE);
+		mb();
+		printk("irp_enable=0x%08x\n", temp);
+	}
+#endif	/* end of DEBUG */
+
+	return irq;
+}
+
+
+/*
+ * Linux descriptor level callbacks
+ */
+
+static void tsi108_pci_irq_enable(u_int irq)
+{
+	tsi108_pci_int_unmask(irq);
+}
+
+static void tsi108_pci_irq_disable(u_int irq)
+{
+	tsi108_pci_int_mask(irq);
+}
+
+static void tsi108_pci_irq_ack(u_int irq)
+{
+	tsi108_pci_int_mask(irq);
+}
+
+static void tsi108_pci_irq_end(u_int irq)
+{
+	tsi108_pci_int_unmask(irq);
+
+	/* Enable interrupts from PCI block */
+	tsi108_write_reg(TSI108_PCI_OFFSET + TSI108_PCI_IRP_ENABLE, 
+			 tsi108_read_reg(TSI108_PCI_OFFSET + 
+					 TSI108_PCI_IRP_ENABLE) |
+			 TSI108_PCI_IRP_ENABLE_P_INT);
+	mb();
+}
+
+/*
+ * Interrupt controller descriptor for cascaded PCI interrupt controller.
+ */
+
+struct hw_interrupt_type tsi108_pci_irq = {
+	.typename = "tsi108_PCI_int",
+	.enable = tsi108_pci_irq_enable,
+	.disable = tsi108_pci_irq_disable,
+	.ack = tsi108_pci_irq_ack,
+	.end = tsi108_pci_irq_end,
+};
+
+/*
+ * Exported functions
+ */
+
+/*
+ * The Tsi108 PCI interrupts initialization routine.
+ * 
+ * The INTA# - INTD# interrupts on the PCI bus are reported by the PCI block
+ * to the MPIC using single interrupt source (IRQ_TSI108_PCI). Therefore the 
+ * PCI block has to be treated as a cascaded interrupt controller connected
+ * to the MPIC.
+ */
+
+void __init tsi108_pci_int_init(void)
+{
+	u_int i;
+
+	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
+
+	for (i = 0; i < NUM_PCI_IRQS; i++) {
+		irq_desc[i + IRQ_PCI_INTAD_BASE].handler = &tsi108_pci_irq;
+		irq_desc[i + IRQ_PCI_INTAD_BASE].status |= IRQ_LEVEL;
+	}
+
+	init_pci_source();
+}
+
+int tsi108_irq_cascade(struct pt_regs *regs, void *unused)
+{
+	return get_pci_source();
+}
diff --git a/include/asm-powerpc/tsi108.h b/include/asm-powerpc/tsi108.h
new file mode 100644
index 0000000..c4c278d
--- /dev/null
+++ b/include/asm-powerpc/tsi108.h
@@ -0,0 +1,109 @@
+/*
+ * include/asm-ppc/tsi108.h
+ *
+ * common routine and memory layout for Tundra TSI108(Grendel) host bridge
+ * memory controller.
+ *
+ * Author: Jacob Pan (jacob.pan@freescale.com)
+ *	   Alex Bounine (alexandreb@tundra.com)
+ * 2004 (c) Freescale Semiconductor Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __PPC_KERNEL_TSI108_H
+#define __PPC_KERNEL_TSI108_H
+
+#include <asm/pci-bridge.h>
+
+/* Size of entire register space */
+#define TSI108_REG_SIZE		(0x10000)
+
+/* Sizes of register spaces for individual blocks */
+#define TSI108_HLP_SIZE		0x1000
+#define TSI108_PCI_SIZE		0x1000
+#define TSI108_CLK_SIZE		0x1000
+#define TSI108_PB_SIZE		0x1000
+#define TSI108_SD_SIZE		0x1000
+#define TSI108_DMA_SIZE		0x1000
+#define TSI108_ETH_SIZE		0x1000
+#define TSI108_I2C_SIZE		0x400
+#define TSI108_MPIC_SIZE	0x400
+#define TSI108_UART0_SIZE	0x200
+#define TSI108_GPIO_SIZE	0x200
+#define TSI108_UART1_SIZE	0x200
+
+/* Offsets within Tsi108(A) CSR space for individual blocks */
+#define TSI108_HLP_OFFSET	0x0000
+#define TSI108_PCI_OFFSET	0x1000
+#define TSI108_CLK_OFFSET	0x2000
+#define TSI108_PB_OFFSET	0x3000
+#define TSI108_SD_OFFSET	0x4000
+#define TSI108_DMA_OFFSET	0x5000
+#define TSI108_ETH_OFFSET	0x6000
+#define TSI108_I2C_OFFSET	0x7000
+#define TSI108_MPIC_OFFSET	0x7400
+#define TSI108_UART0_OFFSET	0x7800
+#define TSI108_GPIO_OFFSET	0x7A00
+#define TSI108_UART1_OFFSET	0x7C00
+
+/* Tsi108 registers used by common code components */
+#define TSI108_PCI_CSR		(0x004)
+#define TSI108_PCI_IRP_CFG_CTL	(0x180)
+#define TSI108_PCI_IRP_STAT	(0x184)
+#define TSI108_PCI_IRP_ENABLE	(0x188)
+#define TSI108_PCI_IRP_INTAD	(0x18C)
+
+#define TSI108_PCI_IRP_STAT_P_INT	(0x00400000)
+#define TSI108_PCI_IRP_ENABLE_P_INT	(0x00400000)
+
+#define TSI108_CG_PWRUP_STATUS	(0x234)
+
+#define TSI108_PB_ISR		(0x00C)
+#define TSI108_PB_ERRCS		(0x404)
+#define TSI108_PB_AERR		(0x408)
+
+#define TSI108_PB_ERRCS_ES		(1 << 1)
+#define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
+
+#define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
+#define TSI108_PCI_CFG_SIZE		(0x01000000)
+/* Global variables */
+
+extern u32 tsi108_pci_cfg_base;
+/* Exported functions */
+
+extern int tsi108_bridge_init(struct pci_controller *hose, uint phys_csr_base);
+extern unsigned long tsi108_get_mem_size(void);
+extern unsigned long tsi108_get_cpu_clk(void);
+extern unsigned long tsi108_get_sdc_clk(void);
+extern int tsi108_direct_write_config(struct pci_bus *bus, unsigned int devfn,
+				      int offset, int len, u32 val);
+extern int tsi108_direct_read_config(struct pci_bus *bus, unsigned int devfn,
+				     int offset, int len, u32 * val);
+extern void tsi108_clear_pci_error(u32 pci_cfg_base);
+
+extern phys_addr_t get_csrbase(void);
+
+typedef struct {
+	u32 regs;		/* hw registers base address */
+	u32 phyregs;		/* phy registers base address */
+	u16 phy;		/* phy address */
+	u16 irq_num;		/* irq number */
+	u8 mac_addr[6];		/* phy mac address */
+} hw_info;
+
+extern u32 get_vir_csrbase(void);
+extern u32 tsi108_csr_vir_base;
+
+extern inline u32 tsi108_read_reg(u32 reg_offset)
+{
+	return in_be32((volatile u32 *)(tsi108_csr_vir_base + reg_offset));
+}
+
+extern inline void tsi108_write_reg(u32 reg_offset, u32 val)
+{
+	out_be32((volatile u32 *)(tsi108_csr_vir_base + reg_offset), val);
+}
+
+#endif				/* __PPC_KERNEL_TSI108_H */
