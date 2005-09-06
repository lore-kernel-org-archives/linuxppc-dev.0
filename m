Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id CAF8D68113
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 00:04:02 +1000 (EST)
Message-ID: <431DA1D0.1050408@ru.mvista.com>
Date: Tue, 06 Sep 2005 18:04:00 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
References: <20050906133122.225a0922.ajz@cambridgebroadband.com>	<431D8F5B.9050803@ru.mvista.com>
	<20050906144845.1e603c72.ajz@cambridgebroadband.com>
In-Reply-To: <20050906144845.1e603c72.ajz@cambridgebroadband.com>
Content-Type: multipart/mixed; boundary="------------040005020007040707020607"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCI on MPC827x
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
--------------040005020007040707020607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alex Zeffertt wrote:
> On Tue, 06 Sep 2005 16:45:15 +0400
> Vitaly Bordug <vbordug@ru.mvista.com> wrote:
> 
> 
>>Alex Zeffertt wrote:
>>
>>>Hi list,
>>>
>>>Does the linuxppc kernel support PCI on PowerQUICC II chips?  If so, in which patch/release was
>>>it added?
>>>
>>
>>The PCI bridge for 8272ADS has been added in 2.6.12-rc6. This stuff 
>>should work on PQ2FADS as well.
> 
>  
> Thanks Vitaly.  Unfortunately we're using linux-2.4.25.
> 
> Has anybody backported the PCI bridge to 2.4?  If not, do you think it's a lot of work?
> 
> Alex
> 
> 
I've done it already. The source was in the latest linux-2.4, at the end 
of the bitkeeper times (I guess rsync copy from source.mvista.com is 
still available - refer to http://penguinppc.org/kernel/ for details).

This is one of the latest versions - AFAIR there were one issue on 
PQ2FADS that's not fixed here. Also, you may search list archives  - the 
patch should be there as well.

-- 
Sincerely,
Vitaly

--------------040005020007040707020607
Content-Type: text/x-patch;
 name="pq2-pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pq2-pci.patch"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/18 17:11:57+03:00 vbordug@ru.mvista.com 
#   Fixed compilation warnings for 8260-like boards when CONFIG_PCI=y
# 
# include/asm-ppc/mpc8260.h
#   2005/02/18 17:11:54+03:00 vbordug@ru.mvista.com +2 -0
#   Fixed compilation warnings when CONFIG_PCI=y
# 
# ChangeSet
#   2005/02/18 16:17:49+03:00 vbordug@ru.mvista.com 
#   Added support for PCI bridge on MPC8272 and PQ2FADS boards
# 
# arch/ppc/platforms/pq2ads.h
#   2005/02/18 16:17:47+03:00 vbordug@ru.mvista.com +88 -5
#   Added support for PCI bridge on MPC8272 and PQ2FADS
# 
# arch/ppc/platforms/Makefile
#   2005/02/18 16:17:47+03:00 vbordug@ru.mvista.com +5 -0
#   Added support for PCI bridge on MPC8272 and PQ2FADS
# 
# arch/ppc/kernel/m8260_setup.c
#   2005/02/18 16:17:47+03:00 vbordug@ru.mvista.com +17 -0
#   Added support for PCI bridge on MPC8272 and PQ2FADS
# 
# arch/ppc/kernel/Makefile
#   2005/02/18 16:17:47+03:00 vbordug@ru.mvista.com +8 -0
#   Modules needed for PCI Bridge support on MPC8272 and PQ2FADS
# 
# arch/ppc/platforms/pq2ads_pci.c
#   2005/02/18 16:15:29+03:00 vbordug@ru.mvista.com +361 -0
#   PCI Bridge setup routines for MPC8272ADS and PQ2FADS (initial revision)
# 
# arch/ppc/platforms/pq2ads_pci.c
#   2005/02/18 16:15:29+03:00 vbordug@ru.mvista.com +0 -0
#   BitKeeper file /home/common/work/community/kernel/linuxppc-2.4/arch/ppc/platforms/pq2ads_pci.c
# 
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2005-02-18 17:14:12 +03:00
+++ b/arch/ppc/kernel/Makefile	2005-02-18 17:14:12 +03:00
@@ -108,6 +108,14 @@
 obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
 endif
 
+ifeq ($(CONFIG_ADS8272),y)
+obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
+endif
+
+ifeq ($(CONFIG_PQ2FADS),y)
+obj-$(CONFIG_PCI)		+= indirect_pci.o pci_auto.o
+endif
+
 include $(TOPDIR)/Rules.make
 
 entry.o: entry.S ppc_defs.h
diff -Nru a/arch/ppc/kernel/m8260_setup.c b/arch/ppc/kernel/m8260_setup.c
--- a/arch/ppc/kernel/m8260_setup.c	2005-02-18 17:14:12 +03:00
+++ b/arch/ppc/kernel/m8260_setup.c	2005-02-18 17:14:12 +03:00
@@ -54,6 +54,7 @@
 unsigned char __res[sizeof(bd_t)];
 
 extern void cpm2_reset(void);
+extern void pq2ads_init_irq(void);
 
 static void __init
 m8260_setup_arch(void)
@@ -61,6 +62,12 @@
 	/* Reset the Communication Processor Module.
 	*/
 	cpm2_reset();
+
+#ifdef CONFIG_PCI
+	/* Lookup PCI host bridges */
+	m8260_find_bridges();
+#endif
+
 }
 
 static void
@@ -184,6 +191,13 @@
 	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
 	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
 	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
+#if defined (CONFIG_PCI) && ( defined (CONFIG_ADS8272) || defined (CONFIG_PQ2FADS) )
+	/* Install the handlers for the external interrupt controller on the
+	 * MPC8272ADS and PQ2FADS boards.
+	 */
+	pq2ads_init_irq();
+#endif
+
 
 }
 
@@ -209,6 +223,9 @@
 static void __init
 m8260_map_io(void)
 {
+#if defined (CONFIG_PCI) && ( defined (CONFIG_ADS8272) || defined (CONFIG_PQ2FADS) )
+	io_block_mapping(0x80000000, 0x80000000, 0x10000000, _PAGE_IO);
+#endif
 	io_block_mapping(0xf0000000, 0xf0000000, 0x10000000, _PAGE_IO);
 	io_block_mapping(0xe0000000, 0xe0000000, 0x10000000, _PAGE_IO);
 }
diff -Nru a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile	2005-02-18 17:14:12 +03:00
+++ b/arch/ppc/platforms/Makefile	2005-02-18 17:14:12 +03:00
@@ -98,6 +98,11 @@
 obj-$(CONFIG_MPC85xx_CDS)	+= mpc85xx_cds_common.o
 endif
 
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_ADS8272)		+= pq2ads_pci.o 
+obj-$(CONFIG_PQ2FADS)		+= pq2ads_pci.o 
+endif
+
 ifeq ($(CONFIG_SMP),y)
 obj-$(CONFIG_ALL_PPC)		+= pmac_smp.o chrp_smp.o
 endif
diff -Nru a/arch/ppc/platforms/pq2ads.h b/arch/ppc/platforms/pq2ads.h
--- a/arch/ppc/platforms/pq2ads.h	2005-02-18 17:14:12 +03:00
+++ b/arch/ppc/platforms/pq2ads.h	2005-02-18 17:14:12 +03:00
@@ -14,6 +14,10 @@
 
 #include <asm/ppcboot.h>
 
+#ifdef CONFIG_PCI
+#include <linux/pci_ids.h>
+#endif
+
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
  * registers that can be accessed as 8-, 16-, or 32-bit values.
@@ -40,7 +44,79 @@
 
 #define PHY_INTERRUPT	SIU_INT_IRQ7
 
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
+
 #ifdef CONFIG_PCI
+/*
+ * Define the vendor/device ID for the MPC82XX.
+ */
+#define	PCI_DEVICE_ID_MPC8265	((0x18C0 << 16) | PCI_VENDOR_ID_MOTOROLA)
+#define	PCI_DEVICE_ID_MPC8272	((0x18C1 << 16) | PCI_VENDOR_ID_MOTOROLA)
+
+
+/* Bit definitions for PCIBR registers */
+
+#define PCIBR_ENABLE        	0x00000001
+
+/* Bit definitions for POMCR registers */
+#define POCMR_ENABLE        	0x80000000
+#define POCMR_PCI_IO        	0x40000000
+#define POCMR_PREFETCH_EN   	0x20000000
+#define POTA_ADDR_SHIFT	    	12
+
+/* Bit definitions for PCI Inbound Comparison Mask registers */
+#define PICMR_ENABLE        	0x80000000
+#define PICMR_NO_SNOOP_EN   	0x40000000
+#define PICMR_PREFETCH_EN   	0x20000000
+#define PITA_ADDR_SHIFT	    	12
+
+/* Bit definitions for PCI_GCR register */
+
+#define PCIGCR_PCI_BUS_EN   	0x1
+
+/* Bus parking decides where the bus control sits when idle */
+/* If modifying memory controllers for PCI park on the core */
+
+#define PPC_ACR_BUS_PARK_CORE 	0x6
+#define PPC_ACR_BUS_PARK_PCI  	0x3
+
+
 /* PCI interrupt controller */
 #define PCI_INT_STAT_REG	0xF8200000
 #define PCI_INT_MASK_REG	0xF8200004
@@ -50,22 +126,23 @@
 #define PIRQD			(NR_SIU_INTS + 3)
 
 /*
- * PCI memory map definitions for MPC8266ADS-PCI.
+ * PCI memory map definitions for MPC82XXADS.
  *
  * processor view
  *	local address		PCI address		target
  *	0x80000000-0x9FFFFFFF	0x80000000-0x9FFFFFFF	PCI mem with prefetch
  *	0xA0000000-0xBFFFFFFF	0xA0000000-0xBFFFFFFF	PCI mem w/o prefetch
- *	0xF4000000-0xF7FFFFFF	0x00000000-0x03FFFFFF	PCI IO
+ *	0xF6000000-0xF7FFFFFF	0x00000000-0x01FFFFFF	PCI IO
  *
  * PCI master view
  *	local address		PCI address		target
- *	0x00000000-0x1FFFFFFF	0x00000000-0x1FFFFFFF	MPC8266 local memory
+ *	0x00000000-0x1FFFFFFF	0x00000000-0x1FFFFFFF	MPC82XXADS local memory
  */
 
 /* window for a PCI master to access MPC8266 memory */
 #define PCI_SLV_MEM_LOCAL	0x00000000	/* Local base */
 #define PCI_SLV_MEM_BUS		0x00000000	/* PCI base */
+#define PCI_SLV_MEM_SIZE	0x10000000	/* 256Mb */
 
 /* window for the processor to access PCI memory with prefetching */
 #define PCI_MSTR_MEM_LOCAL	0x80000000	/* Local base */
@@ -78,9 +155,15 @@
 #define PCI_MSTR_MEMIO_SIZE	0x20000000	/* 512MB */
 
 /* window for the processor to access PCI I/O */
-#define PCI_MSTR_IO_LOCAL	0xF4000000	/* Local base */
+#define PCI_MSTR_IO_LOCAL	0xF6000000	/* Local base */
 #define PCI_MSTR_IO_BUS         0x00000000	/* PCI base   */
-#define PCI_MSTR_IO_SIZE        0x04000000	/* 64MB */
+#define PCI_MSTR_IO_SIZE        0x02000000	/* 32MB */
+
+#if defined CONFIG_ADS8272
+#define PCI_INT_TO_SIU		SIU_INT_IRQ2
+#elif defined CONFIG_PQ2FADS
+#define PCI_INT_TO_SIU		SIU_INT_IRQ6
+#endif
 
 #define _IO_BASE		PCI_MSTR_IO_LOCAL
 #define _ISA_MEM_BASE		PCI_MSTR_MEMIO_LOCAL
diff -Nru a/arch/ppc/platforms/pq2ads_pci.c b/arch/ppc/platforms/pq2ads_pci.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/platforms/pq2ads_pci.c	2005-02-18 17:14:12 +03:00
@@ -0,0 +1,361 @@
+/*
+ * arch/ppc/platforms/pq2fads_pci.c
+ * 
+ * PCI Bridge setup routines for MPC8272 and PQ2FADS boards
+ * 
+ * Based on: PCI setup routines for the Motorola SPS MPC8266ADS-PCI 
+ * reference board by andy_lowe@mvista.com
+ *
+ * Author: Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * 2003 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+
+#include <asm/byteorder.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/immap_cpm2.h>
+//#include <asm/m8260_pci.h>
+#include <asm/delay.h>
+
+#include "pq2ads.h"
+
+extern void setup_m8260_indirect_pci(struct pci_controller* hose,
+				     u32 cfg_addr,
+				     u32 cfg_data);
+
+/*
+ * interrupt routing
+ */
+
+static inline int
+pq2ads_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
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
+pq2ads_mask_irq(unsigned int irq)
+{
+	int bit = irq - NR_SIU_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG |=  (1 << (31 - bit));
+	return;
+}
+
+static void
+pq2ads_unmask_irq(unsigned int irq)
+{
+	int bit = irq - NR_SIU_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG &= ~(1 << (31 - bit));
+	return;
+}
+
+static void
+pq2ads_mask_and_ack(unsigned int irq)
+{
+	int bit = irq - NR_SIU_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG |=  (1 << (31 - bit));
+	return;
+}
+
+static void
+pq2ads_end_irq(unsigned int irq)
+{
+	int bit = irq - NR_SIU_INTS;
+
+	*(volatile unsigned long *) PCI_INT_MASK_REG &= ~(1 << (31 - bit));
+	return;
+}
+
+struct hw_interrupt_type pq2ads_ic = {
+	"PQ2ADS PCI IC",
+	NULL,
+	NULL,
+	pq2ads_unmask_irq,
+	pq2ads_mask_irq,
+	pq2ads_mask_and_ack,
+	pq2ads_end_irq,
+	0
+};
+
+static void
+pci_irq_demux(int irq, void *dev_id, struct pt_regs *regs)
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
+				ppc_irq_dispatch_handler(regs, NR_SIU_INTS + bit);
+		}
+	}
+
+	return;
+}
+
+void
+pq2ads_init_irq(void)
+{
+	int irq;
+	volatile cpm2_map_t* immap = cpm2_immr;
+#ifdef CONFIG_ADS8272
+	/* configure chip select for PCI interrupt controller */
+	immap->im_memctl.memc_br3 = PCI_INT_STAT_REG | 0x00001801;
+	immap->im_memctl.memc_or3 = 0xffff8010;
+#elif defined CONFIG_PQ2FADS
+	/* configure chip select for PCI interrupt controller */
+	immap->im_memctl.memc_br8 = PCI_INT_STAT_REG | 0x00001801;
+	immap->im_memctl.memc_or8 = 0xffff8010;
+#else
+#error This software is not intended to support this chip!
+#endif
+
+	for (irq = NR_SIU_INTS; irq < NR_SIU_INTS + 4; irq++)
+                irq_desc[irq].handler = &pq2ads_ic;
+
+	/* make PCI IRQ level sensitive */ 
+	immap->im_intctl.ic_siexr &=
+		~(1 << (14 - (PCI_INT_TO_SIU - SIU_INT_IRQ1)));
+	
+	/* mask all PCI interrupts */
+	*(volatile unsigned long *) PCI_INT_MASK_REG |= 0xfff00000;
+
+	/* install the demultiplexer for the PCI cascade interrupt */
+	if (request_irq(PCI_INT_TO_SIU, pci_irq_demux, SA_INTERRUPT, 
+		"PCI IRQ demux", 0))
+	{
+		printk("Installation of PCI IRQ demux handler failed.\n");
+	}
+	return;
+}
+
+static int                     
+pq2ads_exclude_device(u_char bus, u_char devfn)
+{
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static void 
+pq2ads_hw_init(struct pci_controller *hose)
+{
+	__u32 val;
+	volatile cpm2_map_t *immap = cpm2_immr;
+	/* PCI int lowest prio  */
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
+	{
+	    /* give it some time */
+	    int i;
+	    for(i=0;i<100;i++)
+		udelay(100);
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
+	immap->im_pci.pci_potar2 = cpu_to_le32((PCI_MSTR_MEM_BUS+PCI_MSTR_MEM_SIZE) >> POTA_ADDR_SHIFT);
+	immap->im_pci.pci_pobar2 = cpu_to_le32((PCI_MSTR_MEM_LOCAL+PCI_MSTR_MEM_SIZE) >> POTA_ADDR_SHIFT);
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
+
+void __init
+m8260_find_bridges(void)
+{
+	struct pci_controller *hose;
+	int host_bridge;
+	volatile cpm2_map_t *immap = cpm2_immr;
+
+	hose = pcibios_alloc_controller();
+
+	if (!hose)
+		return;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+	hose->bus_offset   = 0;
+	hose->set_cfg_type = 1;
+
+	setup_indirect_pci(hose,
+				(ulong)&immap->im_pci.pci_cfg_addr,
+				(ulong)&immap->im_pci.pci_cfg_data);	
+	
+
+	/* Make sure it is a supported bridge */
+	early_read_config_dword(hose,
+			        0,
+			        PCI_DEVFN(0,0),
+			        PCI_VENDOR_ID,
+			        &host_bridge);
+
+	switch (host_bridge) {
+		case PCI_DEVICE_ID_MPC8265:
+			break;
+		case PCI_DEVICE_ID_MPC8272:
+			break;
+
+		default:
+			printk("Attempting to use unrecognized host bridge ID"
+			       " 0x%08x.\n", host_bridge);
+			break;
+	}
+
+	pq2ads_hw_init(hose);
+
+	hose->pci_mem_offset = PCI_MSTR_MEM_LOCAL - PCI_MSTR_MEM_BUS;
+	hose->io_space.start = PCI_MSTR_IO_BUS;
+	hose->io_space.end = PCI_MSTR_IO_BUS + PCI_MSTR_IO_SIZE - 1U;
+	hose->mem_space.start = PCI_MSTR_MEM_BUS;
+	hose->mem_space.end = PCI_MSTR_MEMIO_BUS + PCI_MSTR_MEMIO_SIZE - 1U;
+	hose->io_base_virt = (void *)PCI_MSTR_IO_LOCAL;
+	isa_io_base = PCI_MSTR_IO_LOCAL;
+	
+	pci_init_resource(&hose->io_resource,
+			  PCI_MSTR_IO_BUS,
+			  PCI_MSTR_IO_BUS + PCI_MSTR_IO_SIZE - 1U,
+			  IORESOURCE_IO,
+			  "PCI host bridge");
+
+	pci_init_resource(&hose->mem_resources[0],
+			  PCI_MSTR_MEMIO_BUS,
+			  PCI_MSTR_MEMIO_BUS + PCI_MSTR_MEMIO_SIZE - 1U,
+			  IORESOURCE_MEM,
+			  "PCI host bridge");
+
+	pci_init_resource(&hose->mem_resources[1],
+	                  PCI_MSTR_MEM_BUS,
+	                  PCI_MSTR_MEM_BUS + PCI_MSTR_MEM_SIZE - 1U,
+	                  IORESOURCE_MEM | IORESOURCE_PREFETCH,
+	                  "PCI host bridge");
+
+	pci_dram_offset = PCI_SLV_MEM_LOCAL;
+
+	ppc_md.pci_exclude_device = pq2ads_exclude_device;
+	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+
+	ppc_md.pcibios_fixup = NULL;
+	ppc_md.pcibios_fixup_bus = NULL;
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = pq2ads_map_irq;
+
+	return;
+}
diff -Nru a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
--- a/include/asm-ppc/mpc8260.h	2005-02-18 17:14:12 +03:00
+++ b/include/asm-ppc/mpc8260.h	2005-02-18 17:14:12 +03:00
@@ -24,12 +24,14 @@
 #include <platforms/pq2ads.h>
 #endif
 
+#ifndef CONFIG_PCI
 /* I don't yet have the ISA or PCI stuff done....no 8260 with
  * such thing.....
  */
 #define _IO_BASE        0
 #define _ISA_MEM_BASE   0
 #define PCI_DRAM_OFFSET 0
+#endif
 
 #ifndef __ASSEMBLY__
 /* The "residual" data board information structure the boot loader

--------------040005020007040707020607--
