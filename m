Subject: Re: 8266 PCI on 2.6.x
From: David Woodhouse <dwmw2@infradead.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DAFE@ismail.innsys.innovsys.com>
References: 
	 <DCEAAC0833DD314AB0B58112AD99B93B06DAFE@ismail.innsys.innovsys.com>
Content-Type: text/plain
Message-Id: <1087477539.19489.2894.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 14:05:39 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2004-06-11 at 16:27 -0500, Rune Torgersen wrote:
> I am trying to get it to work on 2.6.6 and 2.6.7rc3 (both mainstream
> and linuxppc-2.5), but the workaround for PCI errata 9 hangs on
> anything newer that 2.6.5...

The out-of-line read[bwl] functions are doing the IDMA thing even for
non-PCI addresses. I suspect that's probably what causes your problem.

My current 82xx PCI bk tree is at bk://linux-mtd.bkbits.net/new82xx-2.6

Add your board support to it if necessary, and try with this patch:

The workaround really doesn't make me happy though.

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2004-06-17 14:01:00 +01:00
+++ b/arch/ppc/Kconfig	2004-06-17 14:01:00 +01:00
@@ -1026,6 +1026,29 @@
 	depends on PCI && 8260 && !8272
 	default y

+config 8260_PCI9
+	bool "  Enable workaround for MPC826x erratum PCI 9"
+	depends on PCI_8260
+	default y
+
+choice
+	prompt "  IDMA channel for PCI 9 workaround"
+	depends on 8260_PCI9
+
+config 8260_PCI9_IDMA1
+	bool "IDMA1"
+
+config 8260_PCI9_IDMA2
+	bool "IDMA2"
+
+config 8260_PCI9_IDMA3
+	bool "IDMA3"
+
+config 8260_PCI9_IDMA4
+	bool "IDMA4"
+
+endchoice
+
 config PCI_PERMEDIA
 	bool "PCI for Permedia2"
 	depends on !4xx && !8xx && APUS
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2004-06-17 14:01:00 +01:00
+++ b/arch/ppc/syslib/Makefile	2004-06-17 14:01:00 +01:00
@@ -68,6 +68,7 @@
 				   todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o cpm2_pic.o
 obj-$(CONFIG_PCI_8260)		+= m8260_pci.o indirect_pci.o
+obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o
 ifeq ($(CONFIG_PPC_GEN550),y)
 obj-$(CONFIG_KGDB)		+= gen550_kgdb.o gen550_dbg.o
diff -Nru a/arch/ppc/syslib/m8260_pci.c b/arch/ppc/syslib/m8260_pci.c
--- a/arch/ppc/syslib/m8260_pci.c	2004-06-17 14:01:00 +01:00
+++ b/arch/ppc/syslib/m8260_pci.c	2004-06-17 14:01:00 +01:00
@@ -164,9 +164,9 @@
 	hose->bus_offset = 0;
 	hose->last_busno = 0xff;

-	setup_indirect_pci(hose,
-			   (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
-			   (unsigned long)&cpm2_immr->im_pci.pci_cfg_data);
+	setup_m8260_indirect_pci(hose,
+				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
+				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_data);

 	m8260_setup_pci(hose);
         hose->pci_mem_offset = MPC826x_PCI_MEM_OFFSET;
diff -Nru a/arch/ppc/syslib/m8260_pci.h b/arch/ppc/syslib/m8260_pci.h
--- a/arch/ppc/syslib/m8260_pci.h	2004-06-17 14:01:00 +01:00
+++ b/arch/ppc/syslib/m8260_pci.h	2004-06-17 14:01:00 +01:00
@@ -65,4 +65,11 @@
 #define _IO_BASE isa_io_base
 #endif

+#ifdef CONFIG_8260_PCI9
+extern void setup_m8260_indirect_pci(struct pci_controller* hose,
+				     u32 cfg_addr, u32 cfg_data);
+#else
+#define setup_m8260_indirect_pci setup_indirect_pci
+#endif
+
 #endif /* _PPC_KERNEL_M8260_PCI_H */
diff -Nru a/arch/ppc/syslib/m8260_pci_erratum9.c b/arch/ppc/syslib/m8260_pci_erratum9.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/m8260_pci_erratum9.c	2004-06-17 14:01:00 +01:00
@@ -0,0 +1,474 @@
+/*
+ * arch/ppc/platforms/mpc8260_pci9.c
+ *
+ * Workaround for device erratum PCI 9.
+ * See Motorola's "XPC826xA Family Device Errata Reference."
+ * The erratum applies to all 8260 family Hip4 processors.  It is scheduled
+ * to be fixed in HiP4 Rev C.  Erratum PCI 9 states that a simultaneous PCI
+ * inbound write transaction and PCI outbound read transaction can result in a
+ * bus deadlock.  The suggested workaround is to use the IDMA controller to
+ * perform all reads from PCI configuration, memory, and I/O space.
+ *
+ * Author:  andy_lowe@mvista.com
+ *
+ * 2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include <asm/io.h>
+#include <asm/pci-bridge.h>
+#include <asm/machdep.h>
+#include <asm/byteorder.h>
+#include <asm/mpc8260.h>
+#include <asm/immap_cpm2.h>
+#include <asm/cpm2.h>
+
+#include "m8260_pci.h"
+
+#ifdef CONFIG_8260_PCI9
+/*#include <asm/mpc8260_pci9.h>*/ /* included in asm/io.h */
+
+#define IDMA_XFER_BUF_SIZE 64	/* size of the IDMA transfer buffer */
+
+/* define a structure for the IDMA dpram usage */
+typedef struct idma_dpram_s {
+	idma_t pram;				/* IDMA parameter RAM */
+	u_char xfer_buf[IDMA_XFER_BUF_SIZE];	/* IDMA transfer buffer */
+	idma_bd_t bd;				/* buffer descriptor */
+} idma_dpram_t;
+
+/* define offsets relative to start of IDMA dpram */
+#define IDMA_XFER_BUF_OFFSET (sizeof(idma_t))
+#define IDMA_BD_OFFSET (sizeof(idma_t) + IDMA_XFER_BUF_SIZE)
+
+/* define globals */
+static volatile idma_dpram_t *idma_dpram;
+
+/* Exactly one of CONFIG_8260_PCI9_IDMAn must be defined,
+ * where n is 1, 2, 3, or 4.  This selects the IDMA channel used for
+ * the PCI9 workaround.
+ */
+#ifdef CONFIG_8260_PCI9_IDMA1
+#define IDMA_CHAN 0
+#define PROFF_IDMA PROFF_IDMA1_BASE
+#define IDMA_PAGE CPM_CR_IDMA1_PAGE
+#define IDMA_SBLOCK CPM_CR_IDMA1_SBLOCK
+#endif
+#ifdef CONFIG_8260_PCI9_IDMA2
+#define IDMA_CHAN 1
+#define PROFF_IDMA PROFF_IDMA2_BASE
+#define IDMA_PAGE CPM_CR_IDMA2_PAGE
+#define IDMA_SBLOCK CPM_CR_IDMA2_SBLOCK
+#endif
+#ifdef CONFIG_8260_PCI9_IDMA3
+#define IDMA_CHAN 2
+#define PROFF_IDMA PROFF_IDMA3_BASE
+#define IDMA_PAGE CPM_CR_IDMA3_PAGE
+#define IDMA_SBLOCK CPM_CR_IDMA3_SBLOCK
+#endif
+#ifdef CONFIG_8260_PCI9_IDMA4
+#define IDMA_CHAN 3
+#define PROFF_IDMA PROFF_IDMA4_BASE
+#define IDMA_PAGE CPM_CR_IDMA4_PAGE
+#define IDMA_SBLOCK CPM_CR_IDMA4_SBLOCK
+#endif
+
+void idma_pci9_init(void)
+{
+	uint dpram_offset;
+	volatile idma_t *pram;
+	volatile im_idma_t *idma_reg;
+	volatile cpm2_map_t *immap = cpm2_immr;
+
+	/* allocate IDMA dpram */
+	dpram_offset = cpm2_dpalloc(sizeof(idma_dpram_t), 64);
+	idma_dpram =
+		(volatile idma_dpram_t *)&immap->im_dprambase[dpram_offset];
+
+	/* initialize the IDMA parameter RAM */
+	memset((void *)idma_dpram, 0, sizeof(idma_dpram_t));
+	pram = &idma_dpram->pram;
+	pram->ibase = dpram_offset + IDMA_BD_OFFSET;
+	pram->dpr_buf = dpram_offset + IDMA_XFER_BUF_OFFSET;
+	pram->ss_max = 32;
+	pram->dts = 32;
+
+	/* initialize the IDMA_BASE pointer to the IDMA parameter RAM */
+	*((ushort *) &immap->im_dprambase[PROFF_IDMA]) = dpram_offset;
+
+	/* initialize the IDMA registers */
+	idma_reg = (volatile im_idma_t *) &immap->im_sdma.sdma_idsr1;
+	idma_reg[IDMA_CHAN].idmr = 0;		/* mask all IDMA interrupts */
+	idma_reg[IDMA_CHAN].idsr = 0xff;	/* clear all event flags */
+
+	printk("<4>Using IDMA%d for MPC8260 device erratum PCI 9 workaround\n",
+		IDMA_CHAN + 1);
+
+	return;
+}
+
+/* Use the IDMA controller to transfer data from I/O memory to local RAM.
+ * The src address must be a physical address suitable for use by the DMA
+ * controller with no translation.  The dst address must be a kernel virtual
+ * address.  The dst address is translated to a physical address via
+ * virt_to_phys().
+ * The sinc argument specifies whether or not the source address is incremented
+ * by the DMA controller.  The source address is incremented if and only if sinc
+ * is non-zero.  The destination address is always incremented since the
+ * destination is always host RAM.
+ */
+static void
+idma_pci9_read(u8 *dst, u8 *src, int bytes, int unit_size, int sinc)
+{
+	unsigned long flags;
+	volatile idma_t *pram = &idma_dpram->pram;
+	volatile idma_bd_t *bd = &idma_dpram->bd;
+	volatile cpm2_map_t *immap = cpm2_immr;
+
+	local_irq_save(flags);
+
+	/* initialize IDMA parameter RAM for this transfer */
+	if (sinc)
+		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_SINC
+			  | IDMA_DCM_DINC | IDMA_DCM_SD_MEM2MEM;
+	else
+		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_DINC
+			  | IDMA_DCM_SD_MEM2MEM;
+	pram->ibdptr = pram->ibase;
+	pram->sts = unit_size;
+	pram->istate = 0;
+
+	/* initialize the buffer descriptor */
+	bd->dst = virt_to_phys(dst);
+	bd->src = (uint) src;
+	bd->len = bytes;
+	bd->flags = IDMA_BD_V | IDMA_BD_W | IDMA_BD_I | IDMA_BD_L | IDMA_BD_DGBL
+		  | IDMA_BD_DBO_BE | IDMA_BD_SBO_BE | IDMA_BD_SDTB;
+
+	/* issue the START_IDMA command to the CP */
+	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
+	immap->im_cpm.cp_cpcr = mk_cr_cmd(IDMA_PAGE, IDMA_SBLOCK, 0,
+					 CPM_CR_START_IDMA) | CPM_CR_FLG;
+	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
+
+	/* wait for transfer to complete */
+	while(bd->flags & IDMA_BD_V);
+
+	local_irq_restore(flags);
+
+	return;
+}
+
+/* Use the IDMA controller to transfer data from I/O memory to local RAM.
+ * The dst address must be a physical address suitable for use by the DMA
+ * controller with no translation.  The src address must be a kernel virtual
+ * address.  The src address is translated to a physical address via
+ * virt_to_phys().
+ * The dinc argument specifies whether or not the dest address is incremented
+ * by the DMA controller.  The source address is incremented if and only if sinc
+ * is non-zero.  The source address is always incremented since the
+ * source is always host RAM.
+ */
+static void
+idma_pci9_write(u8 *dst, u8 *src, int bytes, int unit_size, int dinc)
+{
+	unsigned long flags;
+	volatile idma_t *pram = &idma_dpram->pram;
+	volatile idma_bd_t *bd = &idma_dpram->bd;
+	volatile cpm2_map_t *immap = cpm2_immr;
+
+	local_irq_save(flags);
+
+	/* initialize IDMA parameter RAM for this transfer */
+	if (dinc)
+		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_SINC
+			  | IDMA_DCM_DINC | IDMA_DCM_SD_MEM2MEM;
+	else
+		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_SINC
+			  | IDMA_DCM_SD_MEM2MEM;
+	pram->ibdptr = pram->ibase;
+	pram->sts = unit_size;
+	pram->istate = 0;
+
+	/* initialize the buffer descriptor */
+	bd->dst = (uint) dst;
+	bd->src = virt_to_phys(src);
+	bd->len = bytes;
+	bd->flags = IDMA_BD_V | IDMA_BD_W | IDMA_BD_I | IDMA_BD_L | IDMA_BD_DGBL
+		  | IDMA_BD_DBO_BE | IDMA_BD_SBO_BE | IDMA_BD_SDTB;
+
+	/* issue the START_IDMA command to the CP */
+	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
+	immap->im_cpm.cp_cpcr = mk_cr_cmd(IDMA_PAGE, IDMA_SBLOCK, 0,
+					 CPM_CR_START_IDMA) | CPM_CR_FLG;
+	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
+
+	/* wait for transfer to complete */
+	while(bd->flags & IDMA_BD_V);
+
+	local_irq_restore(flags);
+
+	return;
+}
+
+/* Same as idma_pci9_read, but 16-bit little-endian byte swapping is performed
+ * if the unit_size is 2, and 32-bit little-endian byte swapping is performed if
+ * the unit_size is 4.
+ */
+static void
+idma_pci9_read_le(u8 *dst, u8 *src, int bytes, int unit_size, int sinc)
+{
+	int i;
+	u8 *p;
+
+	idma_pci9_read(dst, src, bytes, unit_size, sinc);
+	switch(unit_size) {
+		case 2:
+			for (i = 0, p = dst; i < bytes; i += 2, p += 2)
+				swab16s((u16 *) p);
+			break;
+		case 4:
+			for (i = 0, p = dst; i < bytes; i += 4, p += 4)
+				swab32s((u32 *) p);
+			break;
+		default:
+			break;
+	}
+}
+EXPORT_SYMBOL(idma_pci9_init);
+EXPORT_SYMBOL(idma_pci9_read);
+EXPORT_SYMBOL(idma_pci9_read_le);
+
+static inline int is_pci_mem(unsigned long addr)
+{
+	if (addr >= MPC826x_PCI_LOWER_MMIO &&
+	    addr <= MPC826x_PCI_UPPER_MMIO)
+		return 1;
+	if (addr >= MPC826x_PCI_LOWER_MEM &&
+	    addr <= MPC826x_PCI_UPPER_MEM)
+		return 1;
+	return 0;
+}
+
+#define is_pci_mem(pa) ( (pa > 0x80000000) && (pa < 0xc0000000))
+int readb(volatile unsigned char *addr)
+{
+	u8 val;
+	unsigned long pa = iopa((unsigned long) addr);
+
+	if (!is_pci_mem(pa))
+		return in_8(addr);
+
+	idma_pci9_read((u8 *)&val, (u8 *)pa, sizeof(val), sizeof(val), 0);
+	return val;
+}
+
+int readw(volatile unsigned short *addr)
+{
+	u16 val;
+	unsigned long pa = iopa((unsigned long) addr);
+
+	if (!is_pci_mem(pa))
+		return in_le16(addr);
+
+	idma_pci9_read((u8 *)&val, (u8 *)pa, sizeof(val), sizeof(val), 0);
+	return swab16(val);
+}
+
+unsigned readl(volatile unsigned *addr)
+{
+	u32 val;
+	unsigned long pa = iopa((unsigned long) addr);
+
+	if (!is_pci_mem(pa))
+		return in_le32(addr);
+
+	idma_pci9_read((u8 *)&val, (u8 *)pa, sizeof(val), sizeof(val), 0);
+	return swab32(val);
+}
+
+int inb(unsigned port)
+{
+	u8 val;
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)&val, (u8 *)addr, sizeof(val), sizeof(val), 0);
+	return val;
+}
+
+int inw(unsigned port)
+{
+	u16 val;
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)&val, (u8 *)addr, sizeof(val), sizeof(val), 0);
+	return swab16(val);
+}
+
+unsigned inl(unsigned port)
+{
+	u32 val;
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)&val, (u8 *)addr, sizeof(val), sizeof(val), 0);
+	return swab32(val);
+}
+
+void insb(unsigned port, void *buf, int ns)
+{
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)buf, (u8 *)addr, ns*sizeof(u8), sizeof(u8), 0);
+}
+
+void insw(unsigned port, void *buf, int ns)
+{
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)buf, (u8 *)addr, ns*sizeof(u16), sizeof(u16), 0);
+}
+
+void insl(unsigned port, void *buf, int nl)
+{
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)buf, (u8 *)addr, nl*sizeof(u32), sizeof(u32), 0);
+}
+
+void insw_ns(unsigned port, void *buf, int ns)
+{
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)buf, (u8 *)addr, ns*sizeof(u16), sizeof(u16), 0);
+}
+
+void insl_ns(unsigned port, void *buf, int nl)
+{
+	u8 *addr = (u8 *)(port + _IO_BASE);
+
+	idma_pci9_read((u8 *)buf, (u8 *)addr, nl*sizeof(u32), sizeof(u32), 0);
+}
+
+void *memcpy_fromio(void *dest, unsigned long src, size_t count)
+{
+	unsigned long pa = iopa((unsigned long) src);
+
+	if (is_pci_mem(pa))
+		idma_pci9_read((u8 *)dest, (u8 *)pa, count, 32, 1);
+	else
+		memcpy(dest, (void *)src, count);
+	return dest;
+}
+
+EXPORT_SYMBOL(readb);
+EXPORT_SYMBOL(readw);
+EXPORT_SYMBOL(readl);
+EXPORT_SYMBOL(inb);
+EXPORT_SYMBOL(inw);
+EXPORT_SYMBOL(inl);
+EXPORT_SYMBOL(insb);
+EXPORT_SYMBOL(insw);
+EXPORT_SYMBOL(insl);
+EXPORT_SYMBOL(insw_ns);
+EXPORT_SYMBOL(insl_ns);
+EXPORT_SYMBOL(memcpy_fromio);
+
+#endif	/* ifdef CONFIG_8260_PCI9 */
+
+/* Indirect PCI routines adapted from arch/ppc/kernel/indirect_pci.c.
+ * Copyright (C) 1998 Gabriel Paubert.
+ */
+#ifndef CONFIG_8260_PCI9
+#define cfg_read(val, addr, type, op)	*val = op((type)(addr))
+#else
+#define cfg_read(val, addr, type, op) \
+	idma_pci9_read_le((u8*)(val),(u8*)(addr),sizeof(*(val)),sizeof(*(val)),0)
+#endif
+
+#define cfg_write(val, addr, type, op)	op((type *)(addr), (val))
+
+static int indirect_write_config(struct pci_bus *pbus, unsigned int devfn, int where,
+			 int size, u32 value)
+{
+	struct pci_controller *hose = pbus->sysdata;
+	u8 cfg_type = 0;
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(pbus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (hose->set_cfg_type)
+		if (pbus->number != hose->first_busno)
+			cfg_type = 1;
+
+	out_be32(hose->cfg_addr,
+		 (((where & 0xfc) | cfg_type) << 24) | (devfn << 16)
+		 | ((pbus->number - hose->bus_offset) << 8) | 0x80);
+
+	switch (size)
+	{
+		case 1:
+			cfg_write(value, hose->cfg_data + (where & 3), u8, out_8);
+			break;
+		case 2:
+			cfg_write(value, hose->cfg_data + (where & 2), u16, out_le16);
+			break;
+		case 4:
+			cfg_write(value, hose->cfg_data + (where & 0), u32, out_le32);
+			break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int indirect_read_config(struct pci_bus *pbus, unsigned int devfn, int where,
+			 int size, u32 *value)
+{
+	struct pci_controller *hose = pbus->sysdata;
+	u8 cfg_type = 0;
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(pbus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (hose->set_cfg_type)
+		if (pbus->number != hose->first_busno)
+			cfg_type = 1;
+
+	out_be32(hose->cfg_addr,
+		 (((where & 0xfc) | cfg_type) << 24) | (devfn << 16)
+		 | ((pbus->number - hose->bus_offset) << 8) | 0x80);
+
+	switch (size)
+	{
+		case 1:
+			cfg_read(value, hose->cfg_data + (where & 3), u8 *, in_8);
+			break;
+		case 2:
+			cfg_read(value, hose->cfg_data + (where & 2), u16 *, in_le16);
+			break;
+		case 4:
+			cfg_read(value, hose->cfg_data + (where & 0), u32 *, in_le32);
+			break;
+	}
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops indirect_pci_ops =
+{
+	.read = indirect_read_config,
+	.write = indirect_write_config,
+};
+
+void
+setup_m8260_indirect_pci(struct pci_controller* hose, u32 cfg_addr, u32 cfg_data)
+{
+	hose->ops = &indirect_pci_ops;
+	hose->cfg_addr = (unsigned int *) ioremap(cfg_addr, 4);
+	hose->cfg_data = (unsigned char *) ioremap(cfg_data, 4);
+}
diff -Nru a/arch/ppc/syslib/m8260_setup.c b/arch/ppc/syslib/m8260_setup.c
--- a/arch/ppc/syslib/m8260_setup.c	2004-06-17 14:01:00 +01:00
+++ b/arch/ppc/syslib/m8260_setup.c	2004-06-17 14:01:00 +01:00
@@ -54,6 +54,7 @@

 extern void cpm2_reset(void);
 extern void m8260_find_bridges(void);
+extern void idma_pci9_init(void);

 static void __init
 m8260_setup_arch(void)
@@ -61,6 +62,10 @@
 	/* Reset the Communication Processor Module.
 	*/
 	cpm2_reset();
+#ifdef CONFIG_8260_PCI9
+	/* Initialise IDMA for PCI erratum workaround */
+	idma_pci9_init();
+#endif
 #ifdef CONFIG_PCI_8260
 	m8260_find_bridges();
 #endif
diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	2004-06-17 14:01:00 +01:00
+++ b/include/asm-ppc/io.h	2004-06-17 14:01:00 +01:00
@@ -138,18 +138,27 @@
 		: : "r" (val), "r" (port + _IO_BASE));	\
 }

-__do_in_asm(inb, "lbzx")
 __do_out_asm(outb, "stbx")
 #ifdef CONFIG_APUS
+__do_in_asm(inb, "lbzx")
 __do_in_asm(inw, "lhz%U1%X1")
 __do_in_asm(inl, "lwz%U1%X1")
 __do_out_asm(outl,"stw%U0%X0")
 __do_out_asm(outw, "sth%U0%X0")
+#elif defined (CONFIG_8260_PCI9)
+/* in asm cannot be defined if PCI9 workaround is used */
+#define inb(port)		in_8((u8 *)((port)+_IO_BASE))
+#define inw(port)		in_le16((u16 *)((port)+_IO_BASE))
+#define inl(port)		in_le32((u32 *)((port)+_IO_BASE))
+__do_out_asm(outw, "sthbrx")
+__do_out_asm(outl, "stwbrx")
 #else
+__do_in_asm(inb, "lbzx")
 __do_in_asm(inw, "lhbrx")
 __do_in_asm(inl, "lwbrx")
 __do_out_asm(outw, "sthbrx")
 __do_out_asm(outl, "stwbrx")
+
 #endif

 #define inb_p(port)		inb((port))
@@ -389,4 +398,9 @@
 }

 #endif /* _PPC_IO_H */
+
+#ifdef CONFIG_8260_PCI9
+#include <asm/mpc8260_pci9.h>
+#endif
+
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/mpc8260_pci9.h b/include/asm-ppc/mpc8260_pci9.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/mpc8260_pci9.h	2004-06-17 14:01:00 +01:00
@@ -0,0 +1,51 @@
+/* include/asm-ppc/mpc8260_pci9.h
+ *
+ * Undefine the PCI read* and in* macros so we can define them as functions
+ * that implement the workaround for the MPC8260 device erratum PCI 9.
+ *
+ * This header file should only be included at the end of include/asm-ppc/io.h
+ * and never included directly anywhere else.
+ *
+ * Author:  andy_lowe@mvista.com
+ *
+ * 2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef _PPC_IO_H
+#error "Do not include mpc8260_pci9.h directly."
+#endif
+
+#ifdef __KERNEL__
+#ifndef __CONFIG_8260_PCI9_DEFS
+#define __CONFIG_8260_PCI9_DEFS
+
+#undef readb
+#undef readw
+#undef readl
+#undef insb
+#undef insw
+#undef insl
+#undef inb
+#undef inw
+#undef inl
+#undef insw_ns
+#undef insl_ns
+#undef memcpy_fromio
+
+extern int readb(volatile unsigned char *addr);
+extern int readw(volatile unsigned short *addr);
+extern unsigned readl(volatile unsigned *addr);
+extern void insb(unsigned port, void *buf, int ns);
+extern void insw(unsigned port, void *buf, int ns);
+extern void insl(unsigned port, void *buf, int nl);
+extern int inb(unsigned port);
+extern int inw(unsigned port);
+extern unsigned inl(unsigned port);
+extern void insw_ns(unsigned port, void *buf, int ns);
+extern void insl_ns(unsigned port, void *buf, int nl);
+extern void *memcpy_fromio(void *dest, unsigned long src, size_t count);
+
+#endif /* !__CONFIG_8260_PCI9_DEFS */
+#endif /* __KERNEL__ */





 )


> Below is the function (uses IDMA to read PCI config registers)
> This function gets called when a readb, readw or readl is issued.
>
> On 2.6.6 & 7 it hangs on the line
> 	while(bd->flags & IDMA_BD_V);
>
> Problem is that this function works when the kernel is scanning the PCI
> bus, and initializing the IDE controller.
> It only hangs right before starting init.
>
> What changed between 2.6.5 and 2.6.6? I am doing diffs, and trying to
> see what changed that coud affect this, but have no clue what I'm
> looking for.
>
>
> /* Use the IDMA controller to transfer data from I/O memory to local
> RAM.
>  * The src address must be a physical address suitable for use by the
> DMA
>  * controller with no translation.  The dst address must be a kernel
> virtual
>  * address.  The dst address is translated to a physical address via
>  * virt_to_phys().
>  * The sinc argument specifies whether or not the source address is
> incremented
>  * by the DMA controller.  The source address is incremented if and only
> if sinc
>  * is non-zero.  The destination address is always incremented since the
>
>  * destination is always host RAM.
>  */
> static void
> idma_pci9_read(u8 *dst, u8 *src, int bytes, int unit_size, int sinc)
> {
> 	unsigned long flags;
> 	volatile idma_t *pram = &idma_dpram->pram;
> 	volatile idma_bd_t *bd = &idma_dpram->bd;
> 	volatile immap_t *immap = (immap_t *)IMAP_ADDR;
>
> 	local_irq_save(flags);
>
> 	/* initialize IDMA parameter RAM for this transfer */
> 	if (sinc)
> 		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_SINC
> 			  | IDMA_DCM_DINC | IDMA_DCM_SD_MEM2MEM;
> 	else
> 		pram->dcm = IDMA_DCM_DMA_WRAP_64 | IDMA_DCM_DINC
> 			  | IDMA_DCM_SD_MEM2MEM;
> 	pram->ibdptr = pram->ibase;
> 	pram->sts = unit_size;
> 	pram->istate = 0;
>
> 	/* initialize the buffer descriptor */
> 	bd->dst = virt_to_phys(dst);
> 	bd->src = (uint) src;
> 	bd->len = bytes;
> 	bd->flags = IDMA_BD_V | IDMA_BD_W | IDMA_BD_I | IDMA_BD_L |
> IDMA_BD_DGBL
> 		  | IDMA_BD_DBO_BE | IDMA_BD_SBO_BE | IDMA_BD_SDTB;
>
> 	/* issue the START_IDMA command to the CP */
> 	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
> 	immap->im_cpm.cp_cpcr = mk_cr_cmd(IDMA_PAGE, IDMA_SBLOCK, 0,
> 					 CPM_CR_START_IDMA) |
> CPM_CR_FLG;
> 	while (immap->im_cpm.cp_cpcr & CPM_CR_FLG);
>
> 	/* wait for transfer to complete */
> 	while(bd->flags & IDMA_BD_V);
>
> 	local_irq_restore(flags);
>
> 	return;
> }
>
>
>
> Linux version 2.6.6 (runet@ernie.innovsys.com) (gcc version 3.2.2
> 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_1)) #7 Fri Jun 11 16:12:24
> Innovative Systems LLC AP2 port
> Using IDMA4 for MPC8260 device erratum PCI 9 workaround
> On node 0 totalpages: 65536
>   DMA zone: 65536 pages, LIFO batch:16
>   Normal zone: 0 pages, LIFO batch:1
>   HighMem zone: 0 pages, LIFO batch:1
> Built 1 zonelists
> Kernel command line: console=ttyS0,115200 root=/dev/hda3 rw
> ip=172.23.11.125:172.23.14.39:172.23.8.150:255.255.248.0:gold4_cpu1:ethe
> PID hash table entries: 2048 (order 11: 16384 bytes)
> Warning: real time clock seems stuck!
> Memory: 257280k available (1664k kernel code, 436k data, 248k init, 0k
> highmem)
> Calibrating delay loop... 192.00 BogoMIPS
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> POSIX conformance testing by UNIFIX
> NET: Registered protocol family 16
> PCI: Probing PCI hardware
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> SiI680: IDE controller at PCI slot 0000:00:11.0
> SiI680: chipset revision 2
> SiI680: BASE CLOCK == 133
> SiI680: 100% native mode on irq 69
>     ide0: MMIO-DMA , BIOS settings: hda:pio, hdb:pio
>     ide1: MMIO-DMA , BIOS settings: hdc:pio, hdd:pio
> Probing IDE interface ide0...
> hda: Maxtor 5A250J0, ATA DISK drive
> Using anticipatory io scheduler
> ide0 at 0xd1000f80-0xd1000f87,0xd1000f8a on irq 69
> Probing IDE interface ide1...
> hda: max request size: 64KiB
> hda: 490234752 sectors (251000 MB) w/2048KiB Cache, CHS=30515/255/63,
> UDMA(133)
>  hda: hda1 hda2 hda3 hda4
> CPM UART driver version 0.02
> ttyS0 on SMC1 at 0x0000, BRG7
> ttyS1 on SCC1 at 0x0040, BRG8
> eth0: FCC ENET Version 0.3, 00:30:d7:00:01:09
> eth1: FCC ENET Version 0.3, 00:30:d7:00:01:0a
> NET: Registered protocol family 2
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 32768)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> IP-Config: Complete:
>       device=eth1, addr=172.23.11.125, mask=255.255.248.0,
> gw=172.23.8.150,
>      host=gold4_cpu1, domain=, nis-domain=(none),
>      bootserver=172.23.14.39, rootserver=172.23.14.39, rootpath=
> Rune Torgersen
> System Developer
> Innovative Systems LLC
> 1000 Innovative Drive
> Mitchell, SD 57301
> Ph: 605-995-6120
> www.innovsys.com
>

--
dwmw2

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
