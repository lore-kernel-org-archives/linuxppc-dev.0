Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id ECD12DDF04
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Apr 2007 19:08:35 +1000 (EST)
Received: from ubuntu (achn-4db49c99.pool.einsundeins.de [77.180.156.153])
	by post.webmailer.de (klopstock mo58) (RZmta 5.5)
	with ESMTP id J05a95j327iId7 for <linuxppc-dev@ozlabs.org>;
	Mon, 2 Apr 2007 11:08:31 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] ppc: Update PPC440SPe support
Date: Mon, 2 Apr 2007 11:09:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200704021109.47183.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ppc: Update PPC440SPe support

This patch updates the AMCC 440SPe support in arch/ppc. It's done in
preparation for the support of the new AMCC 440SPe eval board
katmai.

Signed-off-by: Stefan Roese <sr@denx.de>

---
commit c268079210504e5c5a2ae94aa449aa244545ba22
tree ff46ca68445236f1d359be13e814ea1046acb083
parent 2e175a90047a2dbc76fde169c990164895b25dfc
author Stefan Roese <sr@denx.de> Mon, 02 Apr 2007 10:44:13 +0200
committer Stefan Roese <sr@denx.de> Mon, 02 Apr 2007 10:44:13 +0200

 arch/ppc/platforms/4xx/ppc440spe.c |  242 ++++++++++++++++
 arch/ppc/platforms/4xx/ppc440spe.h |   29 +-
 arch/ppc/syslib/Makefile           |    6 
 arch/ppc/syslib/ppc440spe_pcie.c   |  549 ++++++++++++++++++++++++++++--------
 arch/ppc/syslib/ppc440spe_pcie.h   |   16 +
 include/asm-ppc/ibm44x.h           |   11 +
 6 files changed, 709 insertions(+), 144 deletions(-)

diff --git a/arch/ppc/platforms/4xx/ppc440spe.c b/arch/ppc/platforms/4xx/ppc440spe.c
index 1be5d1c..9f3954c 100644
--- a/arch/ppc/platforms/4xx/ppc440spe.c
+++ b/arch/ppc/platforms/4xx/ppc440spe.c
@@ -22,6 +22,13 @@
 #include <asm/ocp.h>
 #include <asm/ppc4xx_pic.h>
 
+#if defined(CONFIG_AMCC_PPC440SPE_ADMA)
+#include <syslib/ppc440spe_pcie.h>
+#include <linux/async_tx.h>
+#include <linux/platform_device.h>
+#include <asm/ppc440spe_adma.h>
+#endif
+
 static struct ocp_func_emac_data ppc440spe_emac0_def = {
 	.rgmii_idx	= -1,		/* No RGMII */
 	.rgmii_mux	= -1,		/* No RGMII */
@@ -129,18 +136,247 @@ struct ocp_def core_ocp[] = {
 struct ppc4xx_uic_settings ppc4xx_core_uic_cfg[] __initdata = {
 	{ .polarity     = 0xffffffff,
 	  .triggering   = 0x010f0004,
-	  .ext_irq_mask = 0x00000000,
+	  .ext_irq_mask = 0x00402000,	/* IRQ15, IRQ14 */
 	},
 	{ .polarity     = 0xffffffff,
 	  .triggering   = 0x001f8040,
-	  .ext_irq_mask = 0x00007c30,   /* IRQ6 - IRQ7, IRQ8 - IRQ12 */
+	  .ext_irq_mask = 0x80007c30,   /* IRQ13, IRQ12 - IRQ8, IRQ7 - IRQ6 */
 	},
 	{ .polarity     = 0xffffffff,
 	  .triggering   = 0x00000000,
-	  .ext_irq_mask = 0x000000fc,   /* IRQ0 - IRQ5 */
+	  .ext_irq_mask = 0x000000fc,   /* IRQ5 - IRQ0 */
 	},
 	{ .polarity     = 0xffffffff,
 	  .triggering   = 0x00000000,
 	  .ext_irq_mask = 0x00000000,
 	},
 };
+
+#if defined(CONFIG_AMCC_PPC440SPE_ADMA)
+
+static u64 ppc440spe_adma_dmamask = DMA_32BIT_MASK;
+
+/* DMA and XOR platform devices' resources */
+static struct resource ppc440spe_dma_0_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = DMA0_CS_FIFO_NEED_SERVICE,
+		.end = DMA0_CS_FIFO_NEED_SERVICE,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct resource ppc440spe_dma_1_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = DMA1_CS_FIFO_NEED_SERVICE,
+		.end = DMA1_CS_FIFO_NEED_SERVICE,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+static struct resource ppc440spe_xor_resources[] = {
+	{
+		.flags = IORESOURCE_MEM,
+	},
+	{
+		.start = XOR_INTERRUPT,
+		.end = XOR_INTERRUPT,
+		.flags = IORESOURCE_IRQ
+	}
+};
+
+/* DMA and XOR platform devices' data */
+static struct ppc440spe_adma_platform_data ppc440spe_dma_0_data = {
+	.hw_id  = PPC440SPE_DMA0_ID,
+	.capabilities = DMA_CAP_MEMCPY | DMA_CAP_INTERRUPT,
+	.pool_size = PAGE_SIZE,
+};
+
+static struct ppc440spe_adma_platform_data ppc440spe_dma_1_data = {
+	.hw_id  = PPC440SPE_DMA1_ID,
+	.capabilities =  DMA_CAP_MEMCPY | DMA_CAP_INTERRUPT,
+	.pool_size = PAGE_SIZE,
+};
+
+static struct ppc440spe_adma_platform_data ppc440spe_xor_data = {
+	.hw_id  = PPC440SPE_XOR_ID,
+	.capabilities = DMA_CAP_XOR | DMA_CAP_INTERRUPT,
+	.pool_size = PAGE_SIZE,
+};
+
+/* DMA and XOR platform devices definitions */
+static struct platform_device ppc440spe_dma_0_channel = {
+	.name = "PPC440SPE-ADMA",
+	.id = PPC440SPE_DMA0_ID,
+	.num_resources = ARRAY_SIZE(ppc440spe_dma_0_resources),
+	.resource = ppc440spe_dma_0_resources,
+	.dev = {
+		.dma_mask = &ppc440spe_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &ppc440spe_dma_0_data,
+	},
+};
+
+static struct platform_device ppc440spe_dma_1_channel = {
+	.name = "PPC440SPE-ADMA",
+	.id = PPC440SPE_DMA1_ID,
+	.num_resources = ARRAY_SIZE(ppc440spe_dma_1_resources),
+	.resource = ppc440spe_dma_1_resources,
+	.dev = {
+		.dma_mask = &ppc440spe_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &ppc440spe_dma_1_data,
+	},
+};
+
+static struct platform_device ppc440spe_xor_channel = {
+	.name = "PPC440SPE-ADMA",
+	.id = PPC440SPE_XOR_ID,
+	.num_resources = ARRAY_SIZE(ppc440spe_xor_resources),
+	.resource = ppc440spe_xor_resources,
+	.dev = {
+		.dma_mask = &ppc440spe_adma_dmamask,
+		.coherent_dma_mask = DMA_64BIT_MASK,
+		.platform_data = (void *) &ppc440spe_xor_data,
+	},
+};
+
+/*
+ *  Init DMA0/1 and XOR engines; allocate memory for DMAx FIFOs; set platform_device
+ * memory resources addresses
+ */
+static void ppc440spe_configure_raid_devices(void)
+{
+	void *fifo_buf;
+	i2o_regs_t *i2o_reg;
+	dma_regs_t *dma_reg0, *dma_reg1;
+	xor_regs_t *xor_reg;
+	u32 mask;
+
+	/*
+	 * Map registers and allocate fifo buffer
+	 */
+	if (!(i2o_reg  = ioremap(I2O_MMAP_BASE, I2O_MMAP_SIZE))) {
+		printk(KERN_ERR "I2O registers mapping failed.\n");
+		return;
+	}
+	if (!(dma_reg0 = ioremap(DMA0_MMAP_BASE, DMA_MMAP_SIZE))) {
+		printk(KERN_ERR "DMA0 registers mapping failed.\n");
+		goto err1;
+	}
+	if (!(dma_reg1 = ioremap(DMA1_MMAP_BASE, DMA_MMAP_SIZE))) {
+		printk(KERN_ERR "DMA1 registers mapping failed.\n");
+		goto err2;
+	}
+	if (!(xor_reg  = ioremap(XOR_MMAP_BASE,XOR_MMAP_SIZE))) {
+		printk(KERN_ERR "XOR registers mapping failed.\n");
+		goto err3;
+	}
+
+	/*  Provide memory regions for DMA's FIFOs: I2O, DMA0 and DMA1 share
+	 * the base address of FIFO memory space.
+	 *  Actually we need twice more physical memory than programmed in the
+	 * <fsiz> register (because there are two FIFOs foreach DMA: CP and CS)
+	 */
+	fifo_buf = kmalloc((DMA0_FIFO_SIZE + DMA1_FIFO_SIZE)<<1, GFP_KERNEL);
+	if (!fifo_buf) {
+		printk(KERN_ERR "DMA FIFO buffer allocating failed.\n");
+		goto err4;
+	}
+
+	/*
+	 * Configure h/w
+	 */
+	/* Reset I2O/DMA */
+	SDR_WRITE(DCRN_SDR_SRST, DCRN_SDR_SRST_I2ODMA);
+	SDR_WRITE(DCRN_SDR_SRST, 0);
+
+	/* Reset XOR */
+	out_be32(&xor_reg->crsr, XOR_CRSR_XASR_BIT);
+	out_be32(&xor_reg->crrr, XOR_CRSR_64BA_BIT);
+
+	/* Setup the base address of mmaped registers */
+	mtdcr(DCRN_I2O0_IBAH, (u32)(I2O_MMAP_BASE >> 32));
+	mtdcr(DCRN_I2O0_IBAL, (u32)(I2O_MMAP_BASE) | I2O_REG_ENABLE);
+
+	/* SetUp FIFO memory space base address */
+	out_le32(&i2o_reg->ifbah, 0);
+	out_le32(&i2o_reg->ifbal, ((u32)__pa(fifo_buf)));
+
+	/* set zero FIFO size for I2O, so the whole fifo_buf is used by DMAs.
+	 * DMA0_FIFO_SIZE is defined in bytes, <fsiz> - in number of CDB pointers (8byte).
+	 * DMA FIFO Length = CSlength + CPlength, where
+	 *  CSlength = CPlength = (fsiz + 1) * 8.
+	 */
+	out_le32(&i2o_reg->ifsiz, 0);
+	out_le32(&dma_reg0->fsiz, DMA_FIFO_ENABLE | ((DMA0_FIFO_SIZE>>3) - 2));
+	out_le32(&dma_reg1->fsiz, DMA_FIFO_ENABLE | ((DMA1_FIFO_SIZE>>3) - 2));
+
+	/* Configure DMA engine */
+	out_le32(&dma_reg0->cfg, DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP | DMA_CFG_FALGN);
+	out_le32(&dma_reg1->cfg, DMA_CFG_DXEPR_HP | DMA_CFG_DFMPP_HP | DMA_CFG_FALGN);
+
+	/* Clear Status */
+	out_le32(&dma_reg0->dsts, ~0);
+	out_le32(&dma_reg1->dsts, ~0);
+
+	/* Unmask 'CS FIFO Attention' interrupts */
+	mask = in_le32(&i2o_reg->iopim) & ~(I2O_IOPIM_P0SNE | I2O_IOPIM_P1SNE);
+	out_le32(&i2o_reg->iopim, mask);
+
+	/* enable XOR engine interrupt */
+	out_be32(&xor_reg->ier, XOR_IE_CBCIE_BIT);
+
+	/*
+	 * Unmap I2O registers
+	 */
+	iounmap(i2o_reg);
+
+	/*
+	 * Set resource addresses
+	 */
+	ppc440spe_dma_0_channel.resource[0].start = (resource_size_t)(dma_reg0);
+	ppc440spe_dma_0_channel.resource[0].end =
+		ppc440spe_dma_0_channel.resource[0].start+DMA_MMAP_SIZE;
+
+	ppc440spe_dma_1_channel.resource[0].start = (resource_size_t)(dma_reg1);
+	ppc440spe_dma_1_channel.resource[0].end =
+		ppc440spe_dma_1_channel.resource[0].start+DMA_MMAP_SIZE;
+
+	ppc440spe_xor_channel.resource[0].start = (resource_size_t)(xor_reg);
+	ppc440spe_xor_channel.resource[0].end =
+		ppc440spe_xor_channel.resource[0].start+XOR_MMAP_SIZE;
+
+	return;
+err4:
+	iounmap(xor_reg);
+err3:
+	iounmap(dma_reg1);
+err2:
+	iounmap(dma_reg0);
+err1:
+	iounmap(i2o_reg);
+	return;
+}
+
+static struct platform_device *ppc440spe_devs[] __initdata = {
+	&ppc440spe_dma_0_channel,
+	&ppc440spe_dma_1_channel,
+	&ppc440spe_xor_channel,
+};
+
+static int __init ppc440spe_register_raid_devices(void)
+{
+	ppc440spe_configure_raid_devices();
+	platform_add_devices(ppc440spe_devs, ARRAY_SIZE(ppc440spe_devs));
+
+	return 0;
+}
+
+arch_initcall(ppc440spe_register_raid_devices);
+#endif	/* CONFIG_AMCC_PPC440SPE_ADMA */
diff --git a/arch/ppc/platforms/4xx/ppc440spe.h b/arch/ppc/platforms/4xx/ppc440spe.h
index f1e867c..408e7c6 100644
--- a/arch/ppc/platforms/4xx/ppc440spe.h
+++ b/arch/ppc/platforms/4xx/ppc440spe.h
@@ -17,7 +17,6 @@
 #ifndef __PPC_PLATFORMS_PPC440SPE_H
 #define __PPC_PLATFORMS_PPC440SPE_H
 
-
 #include <asm/ibm44x.h>
 
 /* UART */
@@ -28,23 +27,28 @@
 #define UART1_INT		1
 #define UART2_INT		37
 
+/* GPIO macro register defines */
+#define GPIO_BASE		0x00000004f0000700ULL
+#define GPIO0_OR_OFFS		0x0
+#define GPIO0_IR_OFFS		0x1C
+
 /* Clock and Power Management */
 #define IBM_CPM_IIC0		0x80000000	/* IIC interface */
 #define IBM_CPM_IIC1		0x40000000	/* IIC interface */
 #define IBM_CPM_PCI		0x20000000	/* PCI bridge */
-#define IBM_CPM_CPU		    0x02000000	/* processor core */
-#define IBM_CPM_DMA		    0x01000000	/* DMA controller */
-#define IBM_CPM_BGO		    0x00800000	/* PLB to OPB bus arbiter */
-#define IBM_CPM_BGI		    0x00400000	/* OPB to PLB bridge */
-#define IBM_CPM_EBC		    0x00200000	/* External Bux Controller */
-#define IBM_CPM_EBM		    0x00100000	/* Ext Bus Master Interface */
-#define IBM_CPM_DMC		    0x00080000	/* SDRAM peripheral controller */
-#define IBM_CPM_PLB		    0x00040000	/* PLB bus arbiter */
+#define IBM_CPM_CPU		0x02000000	/* processor core */
+#define IBM_CPM_DMA		0x01000000	/* DMA controller */
+#define IBM_CPM_BGO		0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_BGI		0x00400000	/* OPB to PLB bridge */
+#define IBM_CPM_EBC		0x00200000	/* External Bux Controller */
+#define IBM_CPM_EBM		0x00100000	/* Ext Bus Master Interface */
+#define IBM_CPM_DMC		0x00080000	/* SDRAM peripheral controller */
+#define IBM_CPM_PLB		0x00040000	/* PLB bus arbiter */
 #define IBM_CPM_SRAM		0x00020000	/* SRAM memory controller */
-#define IBM_CPM_PPM		    0x00002000	/* PLB Performance Monitor */
+#define IBM_CPM_PPM		0x00002000	/* PLB Performance Monitor */
 #define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
 #define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
-#define IBM_CPM_GPT		    0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
 #define IBM_CPM_UART0		0x00000200	/* serial port 0 */
 #define IBM_CPM_UART1		0x00000100	/* serial port 1 */
 #define IBM_CPM_UART2		0x00000100	/* serial port 1 */
@@ -59,5 +63,6 @@
 				| IBM_CPM_TAHOE0 | IBM_CPM_TAHOE1 \
 				| IBM_CPM_EMAC0 | IBM_CPM_EMAC1 \
 			  	| IBM_CPM_EMAC2 | IBM_CPM_EMAC3 )
-#endif /* __PPC_PLATFORMS_PPC440SP_H */
+
+#endif /* __PPC_PLATFORMS_PPC440SPE_H */
 #endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index 0991111..333f51a 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -28,7 +28,6 @@ endif
 endif
 obj-$(CONFIG_44x)		+= ppc4xx_pic.o
 obj-$(CONFIG_40x)		+= ppc4xx_setup.o
-obj-$(CONFIG_GEN_RTC)		+= todc_time.o
 obj-$(CONFIG_PPC4xx_DMA)	+= ppc4xx_dma.o
 obj-$(CONFIG_PPC4xx_EDMA)	+= ppc4xx_sgdma.o
 ifeq ($(CONFIG_40x),y)
@@ -48,9 +47,9 @@ obj-$(CONFIG_CHESTNUT)		+= mv64360_pic.o pci_auto.o
 obj-$(CONFIG_GT64260)		+= gt64260_pic.o
 obj-$(CONFIG_LOPEC)		+= pci_auto.o todc_time.o
 obj-$(CONFIG_HDPU)		+= pci_auto.o
-obj-$(CONFIG_LUAN)		+= pci_auto.o todc_time.o
-obj-$(CONFIG_YUCCA)		+= pci_auto.o todc_time.o
 obj-$(CONFIG_KATANA)		+= pci_auto.o
+obj-$(CONFIG_KATMAI)		+= pci_auto.o
+obj-$(CONFIG_LUAN)		+= pci_auto.o todc_time.o
 obj-$(CONFIG_MV64360)		+= mv64360_pic.o
 obj-$(CONFIG_MV64X60)		+= mv64x60.o mv64x60_win.o
 obj-$(CONFIG_MVME5100)		+= open_pic.o todc_time.o \
@@ -70,6 +69,7 @@ obj-$(CONFIG_SBC82xx)		+= todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o pci_auto.o \
 				   todc_time.o
 obj-$(CONFIG_TAISHAN)		+= pci_auto.o
+obj-$(CONFIG_YUCCA)		+= pci_auto.o todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o pq2_devices.o pq2_sys.o \
 				   ppc_sys.o
 obj-$(CONFIG_PCI_8260)		+= m82xx_pci.o pci_auto.o
diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
index dd5d4b9..2aa0486 100644
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -24,9 +24,19 @@ pcie_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		     int len, u32 *val)
 {
 	struct pci_controller *hose = bus->sysdata;
-
-	if (PCI_SLOT(devfn) != 1)
+#ifdef CONFIG_PCIE_ENDPOINT
+	/*
+	 * Endpoint can not generate upstream(remote) config cycles.
+	 */
+	return PCIBIOS_DEVICE_NOT_FOUND;
+#endif
+	if (!((PCI_SLOT(devfn) == 1) && (PCI_FUNC(devfn) == 0)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * 440SPE rev B implements only one function per port
+	 */
+	if (ppc440spe_revB())
+		devfn = 0;
 
 	offset += devfn << 12;
 
@@ -45,9 +55,6 @@ pcie_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		*val = in_le32(hose->cfg_data + offset);
 		break;
 	}
-
-	if (0) printk("%s: read %x(%d) @ %x\n", __func__, *val, len, offset);
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -56,9 +63,20 @@ pcie_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		      int len, u32 val)
 {
 	struct pci_controller *hose = bus->sysdata;
+#ifdef CONFIG_PCIE_ENDPOINT
+	/*
+	 * Endpoint can not generate upstream(remote) config cycles.
+	 */
+	return PCIBIOS_DEVICE_NOT_FOUND;
+#endif
 
-	if (PCI_SLOT(devfn) != 1)
+	if (!((PCI_SLOT(devfn) == 1) && (PCI_FUNC(devfn) == 0)))
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	/*
+	 * 440SPE rev B implements only one function per port
+	 */
+	if (ppc440spe_revB())
+		devfn = 0;
 
 	offset += devfn << 12;
 
@@ -92,13 +110,80 @@ enum {
 	LNKW_X8			= 0x8
 };
 
-static void check_error(void)
+int
+ppc440spe_revB(void)
+{
+	if (mfspr(SPRN_PVR) == 0x53421891)
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Set up UTL registers
+ */
+static void
+ppc440spe_setup_utl(u32 port)
+{
+	void __iomem *utl_base;
+
+	/*
+	 * Map UTL at 0xc_1000_n000
+	 */
+	switch (port) {
+	case 0:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE0), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE0), 0x10000000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE0), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE0), 0x68782800);
+		break;
+
+	case 1:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE1), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE1), 0x10001000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE1), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE1), 0x68782800);
+		break;
+
+	case 2:
+		mtdcr(DCRN_PEGPL_REGBAH(PCIE2), 0x0000000c);
+		mtdcr(DCRN_PEGPL_REGBAL(PCIE2), 0x10002000);
+		mtdcr(DCRN_PEGPL_REGMSK(PCIE2), 0x00007001);
+		mtdcr(DCRN_PEGPL_SPECIAL(PCIE2), 0x68782800);
+		break;
+	}
+	utl_base = ioremap64(0xc10000000ull + 0x1000 * port, 0x100);
+	
+	/*
+	 * Set buffer allocations and then assert VRB and TXE.
+	 */
+	out_be32(utl_base + PEUTL_OUTTR,   0x08000000);
+	out_be32(utl_base + PEUTL_INTR,    0x02000000);
+	out_be32(utl_base + PEUTL_OPDBSZ,  0x10000000);
+	out_be32(utl_base + PEUTL_PBBSZ,   0x53000000);
+	out_be32(utl_base + PEUTL_IPHBSZ,  0x08000000);
+	out_be32(utl_base + PEUTL_IPDBSZ,  0x10000000);
+	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
+	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
+
+	iounmap(utl_base);
+}
+
+static int check_error(void)
 {
 	u32 valPE0, valPE1, valPE2;
+	int err = 0;
 
 	/* SDR0_PEGPLLLCT1 reset */
 	if (!(valPE0 = SDR_READ(PESDR0_PLLLCT1) & 0x01000000)) {
-		printk(KERN_INFO "PCIE: SDR0_PEGPLLLCT1 reset error 0x%8x\n", valPE0);
+		/*
+		 * the PCIe core was probably already initialised
+		 * by firmware - let's re-reset RCSSET regs
+		 */
+		pr_debug("PCIE: SDR0_PLLLCT1 already reset.\n");
+		SDR_WRITE(PESDR0_RCSSET, 0x01010000);
+		SDR_WRITE(PESDR1_RCSSET, 0x01010000);
+		SDR_WRITE(PESDR2_RCSSET, 0x01010000);
 	}
 
 	valPE0 = SDR_READ(PESDR0_RCSSET);
@@ -110,6 +195,7 @@ static void check_error(void)
 	     !(valPE1 & 0x01000000) ||
 	     !(valPE2 & 0x01000000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstgu error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET rstdl */
@@ -117,6 +203,7 @@ static void check_error(void)
 	     !(valPE1 & 0x00010000) ||
 	     !(valPE2 & 0x00010000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstdl error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET rstpyn */
@@ -124,6 +211,7 @@ static void check_error(void)
 	     (valPE1 & 0x00001000) ||
 	     (valPE2 & 0x00001000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstpyn error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET hldplb */
@@ -131,6 +219,7 @@ static void check_error(void)
 	     (valPE1 & 0x10000000) ||
 	     (valPE2 & 0x10000000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET hldplb error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET rdy */
@@ -138,6 +227,7 @@ static void check_error(void)
 	     (valPE1 & 0x00100000) ||
 	     (valPE2 & 0x00100000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rdy error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET shutdown */
@@ -145,44 +235,93 @@ static void check_error(void)
 	     (valPE1 & 0x00000100) ||
 	     (valPE2 & 0x00000100)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET shutdown error\n");
+		err = -1;
 	}
+	return err;
 }
 
 /*
- * Initialize PCI Express core as described in User Manual section 27.12.1
+ * Initialize PCI Express core as described in User Manual
  */
-int ppc440spe_init_pcie(void)
+static int
+ppc440spe_init_pcie(void)
 {
+	int time_out = 20;
+
 	/* Set PLL clock receiver to LVPECL */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) | 1 << 28);
 
-	check_error();
+	if (check_error())
+		return -1;
 
-	printk(KERN_INFO "PCIE initialization OK\n");
-
-	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000))
-		printk(KERN_INFO "PESDR_PLLCT2 resistance calibration failed (0x%08x)\n",
+	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000)) {
+		printk(KERN_INFO "PCIE: PESDR_PLLCT2 resistance calibration "
+				"failed (0x%08x)\n",
 		       SDR_READ(PESDR0_PLLLCT2));
+		return -1;
+	}
 
 	/* De-assert reset of PCIe PLL, wait for lock */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) & ~(1 << 24));
 	udelay(3);
 
+	while(time_out) {
+		if (!(SDR_READ(PESDR0_PLLLCT3) & 0x10000000)) {
+			time_out--;
+			udelay(1);
+		} else
+			break;
+	}
+	if (!time_out) {
+		printk(KERN_INFO "PCIE: VCO output not locked\n");
+		return -1;
+	}
+	
+	pr_debug("PCIE initialization OK\n");
+
 	return 0;
 }
 
-int ppc440spe_init_pcie_rootport(int port)
+/*
+ *  Yucca board as End point and root point setup
+ *                    and
+ *    testing inbound and out bound windows
+ *
+ *  YUCCA board can be plugged into another yucca board or you can get PCI-E
+ *  cable which can be used to setup loop back from one port to another port.
+ *  Please rememeber that unless there is a endpoint plugged in to root port it
+ *  will not initialize. It is the same in case of endpoint , unless there is
+ *  root port attached it will not initialize.
+ *
+ *  In this release of software all the PCI-E ports are configured as either
+ *  endpoint or rootpoint.In future we will have support for selective ports
+ *  setup as endpoint and root point in single board.
+ *
+ *  Once your board came up as root point , you can verify by reading
+ *  /proc/bus/pci/devices. Where you can see the configuration registers
+ *  of end point device attached to the port.
+ *
+ *  Enpoint cofiguration can be verified by connecting Yucca board to any
+ *  host or another yucca board. Then try to scan the device. In case of
+ *  linux use "lspci" or appripriate os command.
+ *  
+ *  To verify the inbound and outbound windows on yucca to yucca configuration
+ *  windows already configured for memory region 0. On root point side memory
+ *  map the 36 bit address value 0x4 0000 0000(SRAM) then do the read write to
+ *  the memory mapped address. On endpoint board memory map the 0x4 0000 0000
+ *  read the data to verify if writes happened or not.For inbound window 
+ *  verificatio do the reverse way of write and read .
+ */
+int ppc440spe_init_pcie_root_or_endport(u32 port)
 {
 	static int core_init;
-	void __iomem *utl_base;
+	int attempts;
 	u32 val = 0;
-	int i;
 
 	if (!core_init) {
+		if(ppc440spe_init_pcie())
+			return -1;
 		++core_init;
-		i = ppc440spe_init_pcie();
-		if (i)
-			return i;
 	}
 
 	/*
@@ -193,14 +332,25 @@ int ppc440spe_init_pcie_rootport(int port)
 	 * - Set up UTL configuration.
 	 * - Increase SERDES drive strength to levels suggested by AMCC.
 	 * - De-assert RSTPYN, RSTDL and RSTGU.
+	 *
+	 * NOTICE for revB chip: PESDRn_UTLSET2 is not set - we leave it with
+	 * default setting 0x11310000. The register has new fields,
+	 * PESDRn_UTLSET2[LKINE] in particular: clearing it leads to PCIE core
+	 * hang.
 	 */
+
+#ifdef CONFIG_PCIE_ENDPOINT
+#define PTYPE_TYPE PTYPE_LEGACY_ENDPOINT
+#else
+#define PTYPE_TYPE PTYPE_ROOT_PORT
+#endif
 	switch (port) {
 	case 0:
-		SDR_WRITE(PESDR0_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X8 << 12);
-
-		SDR_WRITE(PESDR0_UTLSET1, 0x21222222);
-		SDR_WRITE(PESDR0_UTLSET2, 0x11000000);
+		SDR_WRITE(PESDR0_DLPSET, 1 << 24 | PTYPE_TYPE << 20 | LNKW_X8 << 12); 
 
+		SDR_WRITE(PESDR0_UTLSET1, 0x20222222);
+		if (!ppc440spe_revB())
+			SDR_WRITE(PESDR0_UTLSET2, 0x11000000);
 		SDR_WRITE(PESDR0_HSSL0SET1, 0x35000000);
 		SDR_WRITE(PESDR0_HSSL1SET1, 0x35000000);
 		SDR_WRITE(PESDR0_HSSL2SET1, 0x35000000);
@@ -215,11 +365,11 @@ int ppc440spe_init_pcie_rootport(int port)
 		break;
 
 	case 1:
-		SDR_WRITE(PESDR1_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X4 << 12);
-
-		SDR_WRITE(PESDR1_UTLSET1, 0x21222222);
-		SDR_WRITE(PESDR1_UTLSET2, 0x11000000);
+		SDR_WRITE(PESDR1_DLPSET, 1 << 24 | PTYPE_TYPE << 20 | LNKW_X4 << 12); 
 
+		SDR_WRITE(PESDR1_UTLSET1, 0x20222222);
+		if (!ppc440spe_revB())
+			SDR_WRITE(PESDR1_UTLSET2, 0x11000000);
 		SDR_WRITE(PESDR1_HSSL0SET1, 0x35000000);
 		SDR_WRITE(PESDR1_HSSL1SET1, 0x35000000);
 		SDR_WRITE(PESDR1_HSSL2SET1, 0x35000000);
@@ -230,11 +380,11 @@ int ppc440spe_init_pcie_rootport(int port)
 		break;
 
 	case 2:
-		SDR_WRITE(PESDR2_DLPSET, PTYPE_ROOT_PORT << 20 | LNKW_X4 << 12);
-
-		SDR_WRITE(PESDR2_UTLSET1, 0x21222222);
-		SDR_WRITE(PESDR2_UTLSET2, 0x11000000);
+		SDR_WRITE(PESDR2_DLPSET, 1 << 24 | PTYPE_TYPE << 20 | LNKW_X4 << 12); 
 
+		SDR_WRITE(PESDR2_UTLSET1, 0x20222222);
+		if (!ppc440spe_revB())
+			SDR_WRITE(PESDR2_UTLSET2, 0x11000000);
 		SDR_WRITE(PESDR2_HSSL0SET1, 0x35000000);
 		SDR_WRITE(PESDR2_HSSL1SET1, 0x35000000);
 		SDR_WRITE(PESDR2_HSSL2SET1, 0x35000000);
@@ -244,89 +394,107 @@ int ppc440spe_init_pcie_rootport(int port)
 			  (SDR_READ(PESDR2_RCSSET) & ~(1 << 24 | 1 << 16)) | 1 << 12);
 		break;
 	}
-
 	mdelay(1000);
 
 	switch (port) {
-	case 0: val = SDR_READ(PESDR0_RCSSTS); break;
-	case 1: val = SDR_READ(PESDR1_RCSSTS); break;
-	case 2: val = SDR_READ(PESDR2_RCSSTS); break;
+	case 0:
+		val = SDR_READ(PESDR0_RCSSTS);
+		break;
+		
+	case 1:
+		val = SDR_READ(PESDR1_RCSSTS);
+		break;
+		
+	case 2:
+		val = SDR_READ(PESDR2_RCSSTS);
+		break;
 	}
 
-	if (!(val & (1 << 20)))
-		printk(KERN_INFO "PCIE%d: PGRST inactive\n", port);
-	else
-		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n", port, val);
-
-	switch (port) {
-	case 0: printk(KERN_INFO "PCIE0: LOOP %08x\n", SDR_READ(PESDR0_LOOP)); break;
-	case 1: printk(KERN_INFO "PCIE1: LOOP %08x\n", SDR_READ(PESDR1_LOOP)); break;
-	case 2: printk(KERN_INFO "PCIE2: LOOP %08x\n", SDR_READ(PESDR2_LOOP)); break;
+	if (val & (1 << 20)) {
+		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n",
+				port, val);
+		return -1;
 	}
 
 	/*
-	 * Map UTL registers at 0xc_1000_0n00
+	 * Verify link is up
 	 */
+	val = 0;
 	switch (port) {
 	case 0:
-		mtdcr(DCRN_PEGPL_REGBAH(PCIE0), 0x0000000c);
-		mtdcr(DCRN_PEGPL_REGBAL(PCIE0), 0x10000000);
-		mtdcr(DCRN_PEGPL_REGMSK(PCIE0), 0x00007001);
-		mtdcr(DCRN_PEGPL_SPECIAL(PCIE0), 0x68782800);
+		val = SDR_READ(PESDR0_LOOP);
 		break;
-
 	case 1:
-		mtdcr(DCRN_PEGPL_REGBAH(PCIE1), 0x0000000c);
-		mtdcr(DCRN_PEGPL_REGBAL(PCIE1), 0x10001000);
-		mtdcr(DCRN_PEGPL_REGMSK(PCIE1), 0x00007001);
-		mtdcr(DCRN_PEGPL_SPECIAL(PCIE1), 0x68782800);
+		val = SDR_READ(PESDR1_LOOP);
 		break;
-
 	case 2:
-		mtdcr(DCRN_PEGPL_REGBAH(PCIE2), 0x0000000c);
-		mtdcr(DCRN_PEGPL_REGBAL(PCIE2), 0x10002000);
-		mtdcr(DCRN_PEGPL_REGMSK(PCIE2), 0x00007001);
-		mtdcr(DCRN_PEGPL_SPECIAL(PCIE2), 0x68782800);
+		val = SDR_READ(PESDR2_LOOP);
+		break;
+	}
+	if (!(val & 0x00001000)) {
+		printk(KERN_INFO "PCIE: link is not up for port %d.\n", port);
+		return -1;
 	}
-
-	utl_base = ioremap64(0xc10000000ull + 0x1000 * port, 0x100);
 
 	/*
-	 * Set buffer allocations and then assert VRB and TXE.
+	 * Setup UTL registers - but only on revA!
+	 * We use default settings for revB chip.
 	 */
-	out_be32(utl_base + PEUTL_OUTTR,   0x08000000);
-	out_be32(utl_base + PEUTL_INTR,    0x02000000);
-	out_be32(utl_base + PEUTL_OPDBSZ,  0x10000000);
-	out_be32(utl_base + PEUTL_PBBSZ,   0x53000000);
-	out_be32(utl_base + PEUTL_IPHBSZ,  0x08000000);
-	out_be32(utl_base + PEUTL_IPDBSZ,  0x10000000);
-	out_be32(utl_base + PEUTL_RCIRQEN, 0x00f00000);
-	out_be32(utl_base + PEUTL_PCTL,    0x80800066);
-
-	iounmap(utl_base);
+	if (!ppc440spe_revB())
+		ppc440spe_setup_utl(port);
 
 	/*
-	 * We map PCI Express configuration access into the 512MB regions
+	 * We map PCI Express configuration access into the 512MB regions.
+	 *
+	 * NOTICE: revB is very strict about PLB real addressess and ranges to
+	 * be mapped for config space; it seems to only work with d_nnnn_nnnn
+	 * range (hangs the core upon config transaction attempts when set
+	 * otherwise) while revA uses c_nnnn_nnnn.
+	 *
+	 * For revA:
 	 *     PCIE0: 0xc_4000_0000
 	 *     PCIE1: 0xc_8000_0000
 	 *     PCIE2: 0xc_c000_0000
+	 *
+	 * For revB:
+	 *     PCIE0: 0xd_0000_0000
+	 *     PCIE1: 0xd_2000_0000
+	 *     PCIE2: 0xd_4000_0000
 	 */
 	switch (port) {
 	case 0:
-		mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
-		mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
+		if (ppc440spe_revB()) {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000d);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x00000000);
+		} else {
+			/* revA */
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE0), 0x0000000c);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE0), 0x40000000);
+		}
 		mtdcr(DCRN_PEGPL_CFGMSK(PCIE0), 0xe0000001); /* 512MB region, valid */
 		break;
 
 	case 1:
-		mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
-		mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
+		if (ppc440spe_revB()) {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000d);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x20000000);
+		} else {
+			/* revA */
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE1), 0x0000000c);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE1), 0x80000000);
+		}
 		mtdcr(DCRN_PEGPL_CFGMSK(PCIE1), 0xe0000001); /* 512MB region, valid */
 		break;
 
 	case 2:
-		mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
-		mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
+		if (ppc440spe_revB()) {
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000d);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0x40000000);
+		} else {
+			/* revA */
+			mtdcr(DCRN_PEGPL_CFGBAH(PCIE2), 0x0000000c);
+			mtdcr(DCRN_PEGPL_CFGBAL(PCIE2), 0xc0000000);
+		}
 		mtdcr(DCRN_PEGPL_CFGMSK(PCIE2), 0xe0000001); /* 512MB region, valid */
 		break;
 	}
@@ -334,69 +502,100 @@ int ppc440spe_init_pcie_rootport(int port)
 	/*
 	 * Check for VC0 active and assert RDY.
 	 */
+	attempts = 10;
 	switch (port) {
 	case 0:
-		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		while(!(SDR_READ(PESDR0_RCSSTS) & (1 << 16))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE0: VC0 not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
 		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);
 		break;
 	case 1:
-		if (!(SDR_READ(PESDR1_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		while(!(SDR_READ(PESDR1_RCSSTS) & (1 << 16))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE1: VC0 not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+
 		SDR_WRITE(PESDR1_RCSSET, SDR_READ(PESDR1_RCSSET) | 1 << 20);
 		break;
 	case 2:
-		if (!(SDR_READ(PESDR2_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		while(!(SDR_READ(PESDR2_RCSSTS) & (1 << 16))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE2: VC0 not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+
 		SDR_WRITE(PESDR2_RCSSET, SDR_READ(PESDR2_RCSSET) | 1 << 20);
 		break;
 	}
 
-#if 0
-	/* Dump all config regs */
-	for (i = 0x300; i <= 0x320; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x340; i <= 0x353; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x370; i <= 0x383; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x3a0; i <= 0x3a2; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x3c0; i <= 0x3c3; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-#endif
-
 	mdelay(100);
 
 	return 0;
 }
 
-void ppc440spe_setup_pcie(struct pci_controller *hose, int port)
+int ppc440spe_setup_pcie(struct pci_controller *hose, u32 port)
 {
 	void __iomem *mbase;
+	int attempts = 0;
+
+	if (ppc440spe_revB()) {
+		/*
+		 * NOTICE: revB is very strict about PLB real addressess and
+		 * sizes to be mapped for config space; it hangs the core upon
+		 * config transaction attempt if not set to 0xd_0010_0000,
+		 * 0xd_2010_0000, 0xd_4010_0000 respectively.
+		 */
+		hose->cfg_data = ioremap64(0xd00100000ull + port * 0x20000000,
+					0x400);
+
+		/* for accessing Local Config space we need to set A[35] */
+		mbase = ioremap64(0xd10000000ull + port * 0x20000000, 0x400);
+	} else {
+		/* revA */
+
+		/*
+		 * Map 16MB, which is enough for 4 bits of bus #
+		 */
+		hose->cfg_data = ioremap64(0xc40100000ull + port * 0x40000000,
+					0x01000000);
+		mbase = ioremap64(0xc50000000ull + port * 0x40000000, 0x1000);
+	}
 
-	/*
-	 * Map 16MB, which is enough for 4 bits of bus #
-	 */
-	hose->cfg_data = ioremap64(0xc40000000ull + port * 0x40000000,
-				   1 << 24);
 	hose->ops = &pcie_pci_ops;
 
+#ifndef CONFIG_PCIE_ENDPOINT
 	/*
 	 * Set bus numbers on our root port
 	 */
-	mbase = ioremap64(0xc50000000ull + port * 0x40000000, 4096);
-	out_8(mbase + PCI_PRIMARY_BUS, 0);
-	out_8(mbase + PCI_SECONDARY_BUS, 0);
-
+		out_8(mbase + PCI_PRIMARY_BUS, 0);
+		out_8(mbase + PCI_SECONDARY_BUS, 1);
+		out_8(mbase + PCI_SUBORDINATE_BUS, 1);
+#endif
 	/*
 	 * Set up outbound translation to hose->mem_space from PLB
 	 * addresses at an offset of 0xd_0000_0000.  We set the low
 	 * bits of the mask to 11 to turn off splitting into 8
 	 * subregions and to enable the outbound translation.
+	 * POMs are set different for root and endpoints to 
+	 * different window ranges fron inbound and out bound transactions.
 	 */
+#ifdef CONFIG_PCIE_ENDPOINT
+	out_le32(mbase + PECFG_POM0LAH, 0x0000fff8);
+	out_le32(mbase + PECFG_POM0LAL, 0x0001fff8);
+#else
 	out_le32(mbase + PECFG_POM0LAH, 0);
-	out_le32(mbase + PECFG_POM0LAL, hose->mem_space.start);
+	out_le32(mbase + PECFG_POM0LAL, hose->mem_space.start );
+#endif
 
 	switch (port) {
 	case 0:
@@ -404,38 +603,148 @@ void ppc440spe_setup_pcie(struct pci_controller *hose, int port)
 		mtdcr(DCRN_PEGPL_OMR1BAL(PCIE0),  hose->mem_space.start);
 		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE0), 0x7fffffff);
 		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE0),
-		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
+		      ~(BOARD_PCIE_MEM_SIZE - 1) | 3);
 		break;
 	case 1:
 		mtdcr(DCRN_PEGPL_OMR1BAH(PCIE1),  0x0000000d);
 		mtdcr(DCRN_PEGPL_OMR1BAL(PCIE1),  hose->mem_space.start);
 		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE1), 0x7fffffff);
 		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE1),
-		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
-
+		      ~(BOARD_PCIE_MEM_SIZE - 1) | 3);
 		break;
 	case 2:
 		mtdcr(DCRN_PEGPL_OMR1BAH(PCIE2),  0x0000000d);
 		mtdcr(DCRN_PEGPL_OMR1BAL(PCIE2),  hose->mem_space.start);
 		mtdcr(DCRN_PEGPL_OMR1MSKH(PCIE2), 0x7fffffff);
 		mtdcr(DCRN_PEGPL_OMR1MSKL(PCIE2),
-		      ~(hose->mem_space.end - hose->mem_space.start) | 3);
+		      ~(BOARD_PCIE_MEM_SIZE - 1) | 3);
 		break;
 	}
 
 	/* Set up 16GB inbound memory window at 0 */
-	out_le32(mbase + PCI_BASE_ADDRESS_0, 0);
-	out_le32(mbase + PCI_BASE_ADDRESS_1, 0);
+#ifndef CONFIG_PCIE_ENDPOINT
 	out_le32(mbase + PECFG_BAR0HMPA, 0x7fffffc);
 	out_le32(mbase + PECFG_BAR0LMPA, 0);
-	out_le32(mbase + PECFG_PIM0LAL, 0);
-	out_le32(mbase + PECFG_PIM0LAH, 0);
+#else
+	out_le32(mbase + PECFG_BAR0HMPA, 0xfffffffc);
+	out_le32(mbase + PECFG_BAR0LMPA, 0xffff0000);
+#endif
+	out_le32(mbase + PCI_BASE_ADDRESS_0, 0);
+	out_le32(mbase + PCI_BASE_ADDRESS_1, 0);
+
+	/*
+	 *  SRAM location 0x4 0000 0000 is target for inbound transefers
+	 */
+	out_le32(mbase + PECFG_PIM0LAL, 0x00000000);
+	out_le32(mbase + PECFG_PIM0LAH, 0x00000004);
+	out_le32(mbase + PECFG_PIM1LAL, 0x00000000);
+	out_le32(mbase + PECFG_PIM1LAH, 0x00000004);
+	out_le32(mbase + PECFG_PIM01SAH, 0xffff0000);
+	out_le32(mbase + PECFG_PIM01SAL, 0x00000000);
 	out_le32(mbase + PECFG_PIMEN, 0x1);
 
 	/* Enable I/O, Mem, and Busmaster cycles */
 	out_le16(mbase + PCI_COMMAND,
 		 in_le16(mbase + PCI_COMMAND) |
 		 PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+	attempts = 10;
+#ifndef CONFIG_PCIE_ENDPOINT
+	printk(KERN_INFO"PCIE:%d successfully set as rootpoint\n",port);
+	switch(port )
+	{
+		case 0:
+			out_le16(mbase + 0x200,0xaaa0);
+			out_le16(mbase + 0x202,0xbed0);
+			break;
+		case 1:
+			out_le16(mbase + 0x200,0xaaa1);
+			out_le16(mbase + 0x202,0xbed1);
+			break;
+		case 2:
+			out_le16(mbase + 0x200,0xaaa2);
+			out_le16(mbase + 0x202,0xbed2);
+			break;
+		default:
+			out_le16(mbase + 0x200,0xaaa3);
+			out_le16(mbase + 0x202,0xbed3);
+	}
+#else
+	switch (port) {
+	case 0:
+		while(!(SDR_READ(PESDR0_RCSSTS) & (1 << 8))) {
+			if (!(attempts--)) {
+				printk(KERN_INFO "PCIE0: BMEN is not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+		break;
+	case 1:
+		while(!(SDR_READ(PESDR1_RCSSTS) & (1 << 8))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE1: BEMEN not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+		break;
+	case 2:
+		while(!(SDR_READ(PESDR2_RCSSTS) & (1 << 8))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE2: BMEN is not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+		break;
+	}
+	printk(KERN_INFO"PCIE:%d successfully set as endpoint\n",port);
+	switch(port)
+	{
+		case 0:
+			out_le16(mbase + 0x200,0xeee0);
+			out_le16(mbase + 0x202,0xfed0);
+			break;
+		case 1:
+			out_le16(mbase + 0x200,0xeee1);
+			out_le16(mbase + 0x202,0xfed1);
+			break;
+		case 2:
+			out_le16(mbase + 0x200,0xeee2);
+			out_le16(mbase + 0x202,0xfed2);
+			break;
+		default :
+			out_le16(mbase + 0x200,0xeee3);
+			out_le16(mbase + 0x202,0xfed3);
+	}
+#endif
+	printk(KERN_INFO"vendor-id 0x%x\n",in_le16(mbase+0x0));
+	printk(KERN_INFO"device-id 0x%x\n",in_le16(mbase+0x2));
+	/*
+	 * This code works as is with yucca plugged in another yucca board or any endpoint device 
+	 * pugged in yucca board as root point device.
+	 * If you want to change configuration according to your configuration . Here are few gotch's.
+	 * There could be hangs due to different reasons
+	 * 1 -- It could be that endpoint is not initialyzed. So always initialize the endpoint first.
+	 * 2 -- May be your POM and BARs are not set properly
+	 * 3 -- careful with masks which decide window sizes
+	 * Here is the test code which used for testing sram read . This test dumps remote and local sram 
+	 * locations which help in comparing visually.
+	 * u32 *rsram,*lsram;
+	 * int i=0;
+	 * lsram = ioremap64(0x400000000 ,0x200); 
+     * #ifndef CONFIG_PCIE_ENDPOINT
+	 *    rsram = ioremap64(0xd00000000 + hose->mem_space.start,0x200);
+	 *	 if(port == 1)
+	 *		 for(i=0;i<20;i+=4) 
+	 *			 printk(KERN_INFO"endp sram 0x%x root sram 0x%x\n",*(rsram+i),*(lsram+i));
+     *#else
+	 *    rsram = ioremap64(0xd00000000 + hose->mem_space.start,0x200);
+	 *    for(i=0;i<20;i+=4) 
+	 *		 printk(KERN_INFO"rootp sram 0x%x endp sram 0x%x\n",*(rsram+i),*(lsram+i));
+     * #endif
+    */
 
 	iounmap(mbase);
+	return 0;
 }
diff --git a/arch/ppc/syslib/ppc440spe_pcie.h b/arch/ppc/syslib/ppc440spe_pcie.h
index 55b765a..e7099a3 100644
--- a/arch/ppc/syslib/ppc440spe_pcie.h
+++ b/arch/ppc/syslib/ppc440spe_pcie.h
@@ -13,6 +13,8 @@
 
 #define DCRN_SDR0_CFGADDR	0x00e
 #define DCRN_SDR0_CFGDATA	0x00f
+#define DCRN_I2O0_IBAL		0x066
+#define DCRN_I2O0_IBAH		0x067
 
 #define DCRN_PCIE0_BASE		0x100
 #define DCRN_PCIE1_BASE		0x120
@@ -136,14 +138,20 @@
  */
 #define PECFG_BAR0LMPA		0x210
 #define PECFG_BAR0HMPA		0x214
-#define PECFG_PIMEN		0x33c
+#define PECFG_BAR1MPA     	0x218
+#define PECFG_BAR2MPA     	0x220
+#define PECFG_PIMEN			0x33c
 #define PECFG_PIM0LAL		0x340
 #define PECFG_PIM0LAH		0x344
+#define PECFG_PIM1LAL       0x348
+#define PECFG_PIM1LAH       0x34c
+#define PECFG_PIM01SAL    	0x350
+#define PECFG_PIM01SAH      0x354
 #define PECFG_POM0LAL		0x380
 #define PECFG_POM0LAH		0x384
 
-int ppc440spe_init_pcie(void);
-int ppc440spe_init_pcie_rootport(int port);
-void ppc440spe_setup_pcie(struct pci_controller *hose, int port);
+int ppc440spe_revB(void);
+int ppc440spe_init_pcie_root_or_endport(u32 port);
+int ppc440spe_setup_pcie(struct pci_controller *hose, u32 port);
 
 #endif /* __PPC_SYSLIB_PPC440SPE_PCIE_H */
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
index 7818b54..38f5959 100644
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -85,7 +85,7 @@
  */
 #if defined(CONFIG_440SP) || defined(CONFIG_440SPE)
 #define PPC44x_IO_LO		0xf0000000UL
-#define PPC44x_IO_HI		0xf0000fffUL
+#define PPC44x_IO_HI		0xffffffffUL	/* used not only for PCI-IO but for EBC too */
 #define PPC44x_PCI0CFG_LO	0x0ec00000UL
 #define PPC44x_PCI0CFG_HI	0x0ec00007UL
 #define PPC44x_PCI1CFG_LO	0x1ec00000UL
@@ -556,12 +556,19 @@
 #define PCIX1_CFGD		0x1ec00004UL
 #define PCIX2_CFGD		0x2ec00004UL
 
+#if defined (CONFIG_440SPE)
+#define PCIX0_IO_BASE		0x0000000C08000000ULL
+#else
 #define PCIX0_IO_BASE		0x0000000908000000ULL
 #define PCIX1_IO_BASE		0x0000000908000000ULL
 #define PCIX2_IO_BASE		0x0000000908000000ULL
+#endif
+
 #define PCIX_IO_SIZE		0x00010000
 
-#ifdef CONFIG_440SP
+#if defined (CONFIG_440SPE)
+#define PCIX0_REG_BASE		0x0000000c0ec80000ULL
+#elif defined(CONFIG_440SP)
 #define PCIX0_REG_BASE		0x000000090ec80000ULL
 #else
 #define PCIX0_REG_BASE		0x000000020ec80000ULL
