Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 65D2167B22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 03:36:07 +1000 (EST)
Message-ID: <425D5885.2040605@ru.mvista.com>
Date: Wed, 13 Apr 2005 21:36:05 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
References: <425D35E0.4040305@nm.ru>
In-Reply-To: <425D35E0.4040305@nm.ru>
Content-Type: multipart/mixed; boundary="------------010801020202030803000904"
Cc: "Kumar Gala"@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to the stock
 linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010801020202030803000904
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Kumar,
This patch adds support for the MPC8272ADS PCI bridge.

The previous one is cleaned up after the final review.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 

Sincerely, 
Vitaly


--------------010801020202030803000904
Content-Type: text/x-patch;
 name="8272PCI.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="8272PCI.patch"

===== arch/ppc/Kconfig 1.109 vs edited =====
--- 1.109/arch/ppc/Kconfig	2005-04-04 07:03:47 +04:00
+++ edited/arch/ppc/Kconfig	2005-04-12 16:47:48 +04:00
@@ -1123,7 +1123,7 @@
 
 config PCI_8260
 	bool
-	depends on PCI && 8260 && !8272
+	depends on PCI && 8260 
 	default y
 
 config 8260_PCI9
===== arch/ppc/platforms/pq2ads.h 1.3 vs edited =====
--- 1.3/arch/ppc/platforms/pq2ads.h	2005-01-16 01:01:51 +03:00
+++ edited/arch/ppc/platforms/pq2ads.h	2005-04-13 20:38:43 +04:00
@@ -49,10 +49,10 @@
 /* PCI interrupt controller */
 #define PCI_INT_STAT_REG	0xF8200000
 #define PCI_INT_MASK_REG	0xF8200004
-#define PIRQA			(NR_SIU_INTS + 0)
-#define PIRQB			(NR_SIU_INTS + 1)
-#define PIRQC			(NR_SIU_INTS + 2)
-#define PIRQD			(NR_SIU_INTS + 3)
+#define PIRQA			(NR_CPM_INTS + 0)
+#define PIRQB			(NR_CPM_INTS + 1)
+#define PIRQC			(NR_CPM_INTS + 2)
+#define PIRQD			(NR_CPM_INTS + 3)
 
 /*
  * PCI memory map definitions for MPC8266ADS-PCI.
@@ -71,6 +71,7 @@
 /* window for a PCI master to access MPC8266 memory */
 #define PCI_SLV_MEM_LOCAL	0x00000000	/* Local base */
 #define PCI_SLV_MEM_BUS		0x00000000	/* PCI base */
+#define PCI_SLV_MEM_SIZE	0x10000000	/* 256 Mb */
 
 /* window for the processor to access PCI memory with prefetching */
 #define PCI_MSTR_MEM_LOCAL	0x80000000	/* Local base */
@@ -83,9 +84,75 @@
 #define PCI_MSTR_MEMIO_SIZE	0x20000000	/* 512MB */
 
 /* window for the processor to access PCI I/O */
+#if !defined(CONFIG_ADS8272) && !defined(CONFIG_PQ2FADS)
+
 #define PCI_MSTR_IO_LOCAL	0xF4000000	/* Local base */
 #define PCI_MSTR_IO_BUS         0x00000000	/* PCI base   */
 #define PCI_MSTR_IO_SIZE        0x04000000	/* 64MB */
+
+#else /* CONFIG_ADS8272 or CONFIG_PQ2FADS */
+
+#define PCI_MSTR_IO_LOCAL	0xF6000000	/* Local base */
+#define PCI_MSTR_IO_BUS         0x00000000	/* PCI base   */
+#define PCI_MSTR_IO_SIZE        0x02000000	/* 64MB */
+
+/*-----------------------------------------------------------------------
+ * SIUMCR - SIU Module Configuration Register				 4-31
+ */
+#define SIUMCR_BBD	0x80000000	/* Bus Busy Disable		*/
+#define SIUMCR_ESE	0x40000000	/* External Snoop Enable	*/
+#define SIUMCR_PBSE	0x20000000	/* Parity Byte Select Enable	*/
+#define SIUMCR_CDIS	0x10000000	/* Core Disable			*/
+#define SIUMCR_DPPC00	0x00000000	/* Data Parity Pins Configuration*/
+#define SIUMCR_DPPC01	0x04000000	/* - " -			*/
+#define SIUMCR_DPPC10	0x08000000	/* - " -			*/
+#define SIUMCR_DPPC11	0x0c000000	/* - " -			*/
+#define SIUMCR_L2CPC00	0x00000000	/* L2 Cache Pins Configuration	*/
+#define SIUMCR_L2CPC01	0x01000000	/* - " -			*/
+#define SIUMCR_L2CPC10	0x02000000	/* - " -			*/
+#define SIUMCR_L2CPC11	0x03000000	/* - " -			*/
+#define SIUMCR_LBPC00	0x00000000	/* Local Bus Pins Configuration	*/
+#define SIUMCR_LBPC01	0x00400000	/* - " -			*/
+#define SIUMCR_LBPC10	0x00800000	/* - " -			*/
+#define SIUMCR_LBPC11	0x00c00000	/* - " -			*/
+#define SIUMCR_APPC00	0x00000000	/* Address Parity Pins Configuration*/
+#define SIUMCR_APPC01	0x00100000	/* - " -			*/
+#define SIUMCR_APPC10	0x00200000	/* - " -			*/
+#define SIUMCR_APPC11	0x00300000	/* - " -			*/
+#define SIUMCR_CS10PC00	0x00000000	/* CS10 Pin Configuration	*/
+#define SIUMCR_CS10PC01	0x00040000	/* - " -			*/
+#define SIUMCR_CS10PC10	0x00080000	/* - " -			*/
+#define SIUMCR_CS10PC11	0x000c0000	/* - " -			*/
+#define SIUMCR_BCTLC00	0x00000000	/* Buffer Control Configuration	*/
+#define SIUMCR_BCTLC01	0x00010000	/* - " -			*/
+#define SIUMCR_BCTLC10	0x00020000	/* - " -			*/
+#define SIUMCR_BCTLC11	0x00030000	/* - " -			*/
+#define SIUMCR_MMR00	0x00000000	/* Mask Masters Requests	*/
+#define SIUMCR_MMR01	0x00004000	/* - " -			*/
+#define SIUMCR_MMR10	0x00008000	/* - " -			*/
+#define SIUMCR_MMR11	0x0000c000	/* - " -			*/
+#define SIUMCR_LPBSE	0x00002000	/* LocalBus Parity Byte Select Enable*/
+
+/*-----------------------------------------------------------------------
+ * SCCR - System Clock Control Register					 9-8
+ */
+#define SCCR_PCI_MODE	0x00000100	/* PCI Mode	*/
+#define SCCR_PCI_MODCK	0x00000080	/* Value of PCI_MODCK pin	*/
+#define SCCR_PCIDF_MSK	0x00000078	/* PCI division factor	*/
+#define SCCR_PCIDF_SHIFT 3
+  
+#endif
+
+#if defined(CONFIG_ADS8272)
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ2
+#elif defined(CONFIG_PQ2FADS)
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ6
+#else
+#warning PCI Bridge will be without interrupts support
+#endif
+
+#define POTA_ADDR_SHIFT 	12
+#define PITA_ADDR_SHIFT 	12
 
 #define _IO_BASE		PCI_MSTR_IO_LOCAL
 #define _ISA_MEM_BASE		PCI_MSTR_MEMIO_LOCAL
===== arch/ppc/syslib/Makefile 1.51 vs edited =====
--- 1.51/arch/ppc/syslib/Makefile	2005-03-31 14:59:04 +04:00
+++ edited/arch/ppc/syslib/Makefile	2005-04-12 16:47:50 +04:00
@@ -82,6 +82,9 @@
 				   todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o
 obj-$(CONFIG_PCI_8260)		+= m8260_pci.o indirect_pci.o
+ifeq ($(CONFIG_ADS8272),y)
+obj-$(CONFIG_PCI)		+= pci_auto.o
+endif
 obj-$(CONFIG_8260_PCI9)		+= m8260_pci_erratum9.o
 obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
 ifeq ($(CONFIG_PPC_GEN550),y)
===== arch/ppc/syslib/m8260_pci.c 1.2 vs edited =====
--- 1.2/arch/ppc/syslib/m8260_pci.c	2004-06-17 16:57:15 +04:00
+++ edited/arch/ppc/syslib/m8260_pci.c	2005-04-13 20:38:02 +04:00
@@ -1,4 +1,7 @@
 /*
+ * 2005 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
  * (C) Copyright 2003
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  *
@@ -28,6 +31,8 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/byteorder.h>
 #include <asm/io.h>
@@ -38,12 +43,144 @@
 #include <asm/immap_cpm2.h>
 #include <asm/mpc8260.h>
 
+#if !defined(CONFIG_ADS8272) && !defined(CONFIG_PQ2FADS)
 #include "m8260_pci.h"
+#endif
+
+/*
+ * Interrupt routing
+ */
+
+static inline int
+pq2pci_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
+{
+	static char pci_irq_table[][4] =
+	/*
+	 *	PCI IDSEL/INTPIN->INTLINE
+	 * 	  A      B      C      D
+	 */
+	{
+		{ PIRQA, PIRQB, PIRQC, PIRQD },	/* IDSEL 22 - PCI slot 0 */
+		{ PIRQD, PIRQA, PIRQB, PIRQC },	/* IDSEL 23 - PCI slot 1 */
+		{ PIRQC, PIRQD, PIRQA, PIRQB },	/* IDSEL 24 - PCI slot 2 */
+	};
+
+	const long min_idsel = 22, max_idsel = 24, irqs_per_slot = 4;
+	return PCI_IRQ_TABLE_LOOKUP;
+}
+
+static void
+pq2pci_mask_irq(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG |=  (1 << (31 - bit));
+	return;
+}
+
+static void
+pq2pci_unmask_irq(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG &= ~(1 << (31 - bit));
+	return;
+}
+
+static void
+pq2pci_mask_and_ack(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG |=  (1 << (31 - bit));
+	return;
+}
+
+static void
+pq2pci_end_irq(unsigned int irq)
+{
+	int bit = irq - NR_CPM_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG &= ~(1 << (31 - bit));
+	return;
+}
+
+struct hw_interrupt_type pq2pci_ic = {
+	"PQ2 PCI",
+	NULL,
+	NULL,
+	pq2pci_unmask_irq,
+	pq2pci_mask_irq,
+	pq2pci_mask_and_ack,
+	pq2pci_end_irq,
+	0
+};
+
+static irqreturn_t
+pq2pci_irq_demux(int irq, void *dev_id, struct pt_regs *regs)
+{
+	unsigned long stat, mask, pend;
+	int bit;
+
+	for(;;) {
+		stat = *(volatile unsigned long *) PCI_INT_STAT_REG;
+		mask = *(volatile unsigned long *) PCI_INT_MASK_REG;
+		pend = stat & ~mask & 0xf0000000;
+		if (!pend)
+			break;
+		for (bit = 0; pend != 0; ++bit, pend <<= 1) {
+			if (pend & 0x80000000)
+				__do_IRQ(NR_CPM_INTS + bit, regs);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction pq2pci_irqaction = {
+	.handler = pq2pci_irq_demux,
+	.flags 	 = SA_INTERRUPT,
+	.mask	 = CPU_MASK_NONE,
+	.name	 = "PQ2 PCI cascade",
+};
+
+
+void
+pq2pci_init_irq(void)
+{
+	int irq;
+	volatile cpm2_map_t *immap = cpm2_immr;
+#ifdef CONFIG_ADS8272
+	/* configure chip select for PCI interrupt controller */
+	immap->im_memctl.memc_br3 = PCI_INT_STAT_REG | 0x00001801;
+	immap->im_memctl.memc_or3 = 0xffff8010;
+#endif
+	for (irq = NR_CPM_INTS; irq < NR_CPM_INTS + 4; irq++)
+                irq_desc[irq].handler = &pq2pci_ic;
+
+	/* make PCI IRQ level sensitive */ 
+	immap->im_intctl.ic_siexr &=
+		~(1 << (14 - (PCI_INT_TO_SIU - SIU_INT_IRQ1)));
+	
+	/* mask all PCI interrupts */
+	*(volatile unsigned long *) PCI_INT_MASK_REG |= 0xfff00000;
+
+	/* install the demultiplexer for the PCI cascade interrupt */
+	setup_irq(PCI_INT_TO_SIU, &pq2pci_irqaction);	
+	return;
+}
+
+static int                     
+pq2pci_exclude_device(u_char bus, u_char devfn)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
 
 
 /* PCI bus configuration registers.
  */
 
+#if !defined(CONFIG_ADS8272) && !defined(CONFIG_PQ2FADS)
 static void __init m8260_setup_pci(struct pci_controller *hose)
 {
 	volatile cpm2_map_t *immap = cpm2_immr;
@@ -146,10 +283,148 @@
 				tempShort | PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
 }
 
-void __init m8260_find_bridges(void)
+#else /* setup hardware for 8272ADS and PQ2FADS */
+
+static void 
+pq2ads_setup_pci(struct pci_controller *hose)
+{
+	__u32 val;
+	volatile cpm2_map_t *immap = cpm2_immr;
+	bd_t* binfo = (bd_t*) __res;
+	u32 sccr = immap->im_clkrst.car_sccr;
+	uint pci_div,freq,time;
+		/* PCI int lowest prio  */
+	/* Each 4 bits is a device bus request      and the MS 4bits
+	   is highest priority */
+	/* Bus                4bit value
+	   ---                ----------
+	   CPM high      	0b0000
+	   CPM middle           0b0001
+	   CPM low       	0b0010
+	   PCI reguest          0b0011
+	   Reserved      	0b0100
+	   Reserved      	0b0101
+	   Internal Core     	0b0110
+	   External Master 1 	0b0111
+	   External Master 2 	0b1000
+	   External Master 3 	0b1001
+	   The rest are reserved 
+	 */
+	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x61207893;
+	/* park bus on core  */
+	immap->im_siu_conf.siu_82xx.sc_ppc_acr = PPC_ACR_BUS_PARK_CORE;
+	/*
+	 * Set up master windows that allow the CPU to access PCI space. These
+	 * windows are set up using the two SIU PCIBR registers.
+	 */
+
+	immap->im_memctl.memc_pcimsk0 = ~(PCI_MSTR_IO_SIZE - 1U);
+	immap->im_memctl.memc_pcibr0  = PCI_MSTR_IO_LOCAL | PCIBR_ENABLE;
+	
+	immap->im_memctl.memc_pcimsk1 = ~(PCI_MSTR_MEM_SIZE + PCI_MSTR_MEMIO_SIZE - 1U);
+	immap->im_memctl.memc_pcibr1  = PCI_MSTR_MEM_LOCAL | PCIBR_ENABLE;
+#ifdef CONFIG_ADS8272
+	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.siu_82xx.sc_siumcr &
+				~SIUMCR_BBD &
+				~SIUMCR_ESE &
+				~SIUMCR_PBSE &
+				~SIUMCR_CDIS &
+				~SIUMCR_DPPC11 &
+				~SIUMCR_L2CPC11 &
+				~SIUMCR_LBPC11 &
+				~SIUMCR_APPC11 &
+				~SIUMCR_CS10PC11 &
+				~SIUMCR_BCTLC11 &
+				~SIUMCR_MMR11)
+			| SIUMCR_DPPC11 | SIUMCR_L2CPC01 | SIUMCR_LBPC00
+			| SIUMCR_APPC10 | SIUMCR_CS10PC00 | SIUMCR_BCTLC00 | SIUMCR_MMR11;
+#elif defined CONFIG_PQ2FADS
+	/*
+	 * Setting required to enable IRQ1-IRQ7 (SIUMCR [DPPC]),
+	 * and local bus for PCI (SIUMCR [LBPC]).
+	 */
+	immap->im_siu_conf.siu_82xx.sc_siumcr = (immap->im_siu_conf.sc_siumcr &
+				~SIUMCR_LBPC11 &
+				~SIUMCR_CS10PC11 &
+				~SIUMCR_LBPC11) |
+				SIUMCR_LBPC01 | SIUMCR_CS10PC01 | SIUMCR_APPC10;
+#endif
+        /* Enable PCI  */
+	immap->im_pci.pci_gcr = cpu_to_le32(PCIGCR_PCI_BUS_EN);
+	
+	pci_div = ( (sccr & SCCR_PCI_MODCK) ? 2 : 1) *
+			( ( (sccr & SCCR_PCIDF_MSK) >> SCCR_PCIDF_SHIFT) + 1);
+	freq = (uint)((2*binfo->bi_cpmfreq)/(pci_div));
+	time = (int)666666/freq;
+	/* due to PCI Local Bus spec, some devices needs to wait such a long 
+	time after RST 	deassertion. More specifically, 0.508s for 66MHz & twice more for 33 */
+	printk("%s: The PCI bus is %d Mhz.\nWaiting %s after deasserting RST...\n",__FILE__,freq,
+	(time==1) ? "0.5 seconds":"1 second" );
+	
+	{
+	    int i;
+	    for(i=0;i<(500*time);i++)
+		    udelay(1000);
+	}	
+						
+	/* setup ATU registers */
+	immap->im_pci.pci_pocmr0 = cpu_to_le32(POCMR_ENABLE | POCMR_PCI_IO |
+	                  ((~(PCI_MSTR_IO_SIZE - 1U)) >> POTA_ADDR_SHIFT));
+	immap->im_pci.pci_potar0 = cpu_to_le32(PCI_MSTR_IO_BUS >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar0 = cpu_to_le32(PCI_MSTR_IO_LOCAL >> POTA_ADDR_SHIFT);
+
+	/* Set-up non-prefetchable window */
+	immap->im_pci.pci_pocmr1 = cpu_to_le32(POCMR_ENABLE | ((~(PCI_MSTR_MEMIO_SIZE-1U)) >> POTA_ADDR_SHIFT));
+	immap->im_pci.pci_potar1 = cpu_to_le32(PCI_MSTR_MEMIO_BUS >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar1 = cpu_to_le32(PCI_MSTR_MEMIO_LOCAL >> POTA_ADDR_SHIFT);
+
+	/* Set-up prefetchable window */
+	immap->im_pci.pci_pocmr2 = cpu_to_le32(POCMR_ENABLE |POCMR_PREFETCH_EN |
+                  (~(PCI_MSTR_MEM_SIZE-1U) >> POTA_ADDR_SHIFT));
+	immap->im_pci.pci_potar2 = cpu_to_le32((PCI_MSTR_MEM_BUS) >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar2 = cpu_to_le32((PCI_MSTR_MEM_LOCAL) >> POTA_ADDR_SHIFT);
+
+ 	/* Inbound transactions from PCI memory space */
+	immap->im_pci.pci_picmr0 = cpu_to_le32(PICMR_ENABLE | PICMR_PREFETCH_EN |
+				    ((~(PCI_SLV_MEM_SIZE-1U)) >> PITA_ADDR_SHIFT));
+	immap->im_pci.pci_pibar0 = cpu_to_le32(PCI_SLV_MEM_BUS  >> PITA_ADDR_SHIFT);
+	immap->im_pci.pci_pitar0 = cpu_to_le32(PCI_SLV_MEM_LOCAL>> PITA_ADDR_SHIFT);
+
+#if defined CONFIG_ADS8272
+	/* PCI int highest prio  */
+	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x01236745;
+#elif defined CONFIG_PQ2FADS
+	immap->im_siu_conf.siu_82xx.sc_ppc_alrh = 0x03124567;
+#endif
+	/* park bus on PCI  */
+	immap->im_siu_conf.siu_82xx.sc_ppc_acr = PPC_ACR_BUS_PARK_PCI;
+
+	/* Enable bus mastering and inbound memory transactions */
+	early_read_config_dword(hose, hose->first_busno, 0, PCI_COMMAND, &val);
+	val &= 0xffff0000;
+   	val |= PCI_COMMAND_MEMORY|PCI_COMMAND_MASTER;
+	early_write_config_dword(hose, hose->first_busno, 0, PCI_COMMAND, val);	
+
+}  
+
+static void pq2ads_setup_hose(struct pci_controller * hose)
+{
+	hose->io_space.start =  MPC826x_PCI_LOWER_IO;
+	hose->io_space.end =  MPC826x_PCI_UPPER_IO;
+	hose->mem_space.start =  MPC826x_PCI_LOWER_MEM;
+	hose->mem_space.end =   MPC826x_PCI_UPPER_MMIO;
+	hose->io_base_virt =  (void*)MPC826x_PCI_IO_BASE;
+	isa_io_base = MPC826x_PCI_IO_BASE;
+}
+
+#endif
+
+
+void __init pq2_find_bridges(void)
 {
 	extern int pci_assign_all_busses;
 	struct pci_controller * hose;
+	int host_bridge;
 
 	pci_assign_all_busses = 1;
 
@@ -164,18 +439,45 @@
 	hose->bus_offset = 0;
 	hose->last_busno = 0xff;
 
+#ifdef CONFIG_ADS8272
+	hose->set_cfg_type = 1;
+#endif
+
 	setup_m8260_indirect_pci(hose, 
 				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_addr,
 				 (unsigned long)&cpm2_immr->im_pci.pci_cfg_data);
 
+	/* Make sure it is a supported bridge */
+	early_read_config_dword(hose,
+			        0,
+			        PCI_DEVFN(0,0),
+			        PCI_VENDOR_ID,
+			        &host_bridge);
+	switch (host_bridge) {
+		case PCI_DEVICE_ID_MPC8265:
+			break;
+		case PCI_DEVICE_ID_MPC8272:
+			break;
+		default:
+			printk("Attempting to use unrecognized host bridge ID"
+			       " 0x%08x.\n", host_bridge);
+			break;
+	}
+
+#if defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS)
+	pq2ads_setup_pci(hose);  
+	pq2ads_setup_hose(hose);  
+#else
 	m8260_setup_pci(hose);
+
         hose->pci_mem_offset = MPC826x_PCI_MEM_OFFSET;
 
-        isa_io_base =
+	isa_io_base =
                 (unsigned long) ioremap(MPC826x_PCI_IO_BASE,
                                         MPC826x_PCI_IO_SIZE);
         hose->io_base_virt = (void *) isa_io_base;
- 
+#endif
+
         /* setup resources */
         pci_init_resource(&hose->mem_resources[0],
 			  MPC826x_PCI_LOWER_MEM,
@@ -191,4 +493,15 @@
 			  MPC826x_PCI_LOWER_IO,
 			  MPC826x_PCI_UPPER_IO,
 			  IORESOURCE_IO, "PCI I/O");
+
+#if defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS)
+	ppc_md.pci_exclude_device = pq2pci_exclude_device;
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pci_map_irq = pq2pci_map_irq;
+	ppc_md.pcibios_fixup = NULL;
+	ppc_md.pcibios_fixup_bus = NULL;
+
+#endif
+
 }
===== arch/ppc/syslib/m8260_setup.c 1.30 vs edited =====
--- 1.30/arch/ppc/syslib/m8260_setup.c	2005-03-31 14:59:04 +04:00
+++ edited/arch/ppc/syslib/m8260_setup.c	2005-04-13 20:33:52 +04:00
@@ -34,7 +34,11 @@
 unsigned char __res[sizeof(bd_t)];
 
 extern void cpm2_reset(void);
+#if !defined(CONFIG_ADS8272) && !defined(CONFIG_PQ2FADS)
 extern void m8260_find_bridges(void);
+#endif
+extern void pq2_find_bridges(void);
+extern void pq2pci_init_irq(void);
 extern void idma_pci9_init(void);
 
 /* Place-holder for board-specific init */
@@ -56,7 +60,11 @@
 	idma_pci9_init();
 #endif
 #ifdef CONFIG_PCI_8260
+#if defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS)
+	pq2_find_bridges();
+#else
 	m8260_find_bridges();
+#endif 
 #endif
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start)
@@ -173,6 +181,12 @@
 	 * in case the boot rom changed something on us.
 	 */
 	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
+
+#if defined(CONFIG_PCI) && (defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS))
+ 	/* Initialize stuff for the 82xx CPLD IC and install demux  */
+ 	pq2pci_init_irq();
+#endif
+
 }
 
 /*
@@ -195,6 +209,9 @@
 m8260_map_io(void)
 {
 	uint addr;
+#if defined(CONFIG_PCI) && (defined(CONFIG_ADS8272) || defined(CONFIG_PQ2FADS))
+	io_block_mapping(0x80000000,0x80000000,0x10000000, _PAGE_IO);
+#endif
 
 	/* Map IMMR region to a 256MB BAT */
 	addr = (cpm2_immr != NULL) ? (uint)cpm2_immr : CPM_MAP_ADDR;
===== include/asm-ppc/m8260_pci.h 1.1 vs edited =====
--- 1.1/include/asm-ppc/m8260_pci.h	2004-06-17 02:56:05 +04:00
+++ edited/include/asm-ppc/m8260_pci.h	2005-04-12 17:17:29 +04:00
@@ -19,6 +19,7 @@
  * Define the vendor/device ID for the MPC8265.
  */
 #define	PCI_DEVICE_ID_MPC8265	((0x18C0 << 16) | PCI_VENDOR_ID_MOTOROLA)
+#define	PCI_DEVICE_ID_MPC8272	((0x18C1 << 16) | PCI_VENDOR_ID_MOTOROLA)
 
 #define M8265_PCIBR0	0x101ac
 #define M8265_PCIBR1	0x101b0

--------------010801020202030803000904--
