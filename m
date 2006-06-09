Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 88F1567B19
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 19:25:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k59AgAdQ005962
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jun 2006 04:42:10 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k599Piik006373
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jun 2006 04:25:46 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306907E1B@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexandre Bounine
	<Alexandre.Bounine@tundra.com>
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
Date: Fri, 9 Jun 2006 17:25:41 +0800 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> On Tue, 2006-06-06 at 10:45 -0400, Alexandre Bounine wrote:
> 
> > We have a level-signalled irq from the cascaded PCI interrupt 
> > controller. If I do EOI at this time, level request will not have 
> > chance to be cleared (unless all PCI interrupts have an 
> SA_INTERRUPT flag) and result in recurring interrupts.
> 
> Hrm... Ok, when the cascade is a 8259 or an MPIC, we don't 
> have that problem despite the output also being level... I 
> think that's because the cascade handler itself will mask the 
> cascade interrupt (on MPIC, reading the irq does an ack which 
> will mask that priority level). If your cascaded controller 
> doesn't act this way, you may need something a bit different 
> in your cascade handler rather than changing mpic.
> 
> However, I wouldn't bother too much. As I said, this is all 
> changing a lot at the moment as I'm porting powerpc to Ingo 
> Molnar and Thomas Gleixner's new "genirq" layer. Cascade 
> handling will be different and taken out of MPIC, so you'll 
> be able to implement it the way your want (with much greater 
> control on what happens) without changing the MPIC driver.
> 
> I'll have patches posted on the list in a few days hopefully.
> 
> > I chose to have an individual flag instead of checking model ID to 
> > avoid multiple checks within ISR (in case if we have more 
> that one mpic version requiring this option). I also expect 
> that it may be
> > useful for any external level-signalling cascades connected 
> to MPIC.      
> 
> As I said above, I think it can just go away with the port to genirq.
> 
> > Motivation is the same as above - I just do not want to 
> have multiple 
> > ID checks here. I agree that it is driven by mpic type (model ID) 
> > only. I can remove this one if you do not expect any new 
> "broken" MPICs on horizon.
> 
> Well, I do expect broken ones but not with that specific issue :)
> 
> Cheers,
> Ben.
> 
update mpic support for tsi108 .
Any comment?

diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index db5dc10..efee7da 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -43,7 +43,16 @@ #include <asm/pci-bridge.h>  #include <asm/reg.h>  #include <mm/mmu_decl.h>  #include "mpc7448_hpc2.h"
-#include <asm/tsi108_pic.h>
+#include <asm/tsi108_irq.h>
+#include <asm/mpic.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(fmt); } while(0) #else #define 
+DBG(fmt...) do { } while(0) #endif
 
 #ifndef CONFIG_PCI
 isa_io_base = MPC7448_HPC2_ISA_IO_BASE; @@ -53,20 +62,8 @@ #endif
 
 extern int add_bridge(struct device_node *dev);  extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
-
-#ifdef TSI108_ETH
-hw_info hw_info_table[TSI108_ETH_MAX_PORTS + 1] = {
-	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
-	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
-	 TSI108_PHY0_ADDR, IRQ_TSI108_GIGE0},
-
-	{TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET + 0x400,
-	 TSI108_CSR_ADDR_PHYS + TSI108_ETH_OFFSET,
-	 TSI108_PHY1_ADDR, IRQ_TSI108_GIGE1},
-
-	{TBL_END, TBL_END, TBL_END, TBL_END}
-};
-#endif
+extern void tsi108_pci_int_init(void);
+extern int tsi108_irq_cascade(struct pt_regs *regs, void *unused);
 
 /*
  * Define all of the IRQ senses and polarities.  Taken from the @@ -76,10 +73,32 @@ #endif
  */
 
 static u_char mpc7448_hpc2_pic_initsenses[] __initdata = {
+	/* External on-board sources */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[0] XINT0 from FPGA */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[1] XINT1 from FPGA */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[2] PHY_INT from both GIGE */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[3] RESERVED */
+	/* Internal Tsi108/109 interrupt sources */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA0 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA1 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA2 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA3 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* UART0 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* UART1 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* I2C */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* GPIO */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* GIGE0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* GIGE1 */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* HLP */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* SDC */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Processor IF */
+	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* PCI/X block */
 };
 
 /*
@@ -196,18 +215,43 @@ #endif
  */
 static void __init mpc7448_hpc2_init_IRQ(void)  {
+	struct mpic *mpic;
+	phys_addr_t mpic_paddr = 0;
+	struct device_node *tsi_pic;
+
+	tsi_pic = of_find_node_by_type(NULL, "open-pic");
+	if (tsi_pic) {
+		unsigned int size;
+		void *prop = get_property(tsi_pic, "reg", &size);
+		mpic_paddr = of_translate_address(tsi_pic, prop);
+	}
 
-	tsi108_pic_init(mpc7448_hpc2_pic_initsenses);
+	if (mpic_paddr == 0) {
+		printk("%s: No tsi108 PIC found !\n", __FUNCTION__);
+		return;
+	}
 
-	/* Configure MPIC outputs to CPU0 */
-	tsi108_pic_set_output(0, IRQ_SENSE_EDGE, IRQ_POLARITY_NEGATIVE);
-}
+	DBG("%s: tsi108pic phys_addr = 0x%x\n", __FUNCTION__,
+	    (u32) mpic_paddr);
 
-static void __init mpc7448_hpc2_map_io(void) -{
-	/* Tsi108 CSR mapping */
-	io_block_mapping(TSI108_CSR_ADDR_VIRT, TSI108_CSR_ADDR_PHYS,
-			 0x100000, _PAGE_IO);
+	mpic = mpic_alloc(mpic_paddr,
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_SPV_EOI | MPIC_MOD_ID(MPIC_ID_TSI108),
+			0, /* num_sources used */
+			TSI108_IRQ_BASE,
+			0, /* num_sources used */
+			NR_IRQS - 4 /* XXXX */,
+			mpc7448_hpc2_pic_initsenses,
+			sizeof(mpc7448_hpc2_pic_initsenses), "Tsi108_PIC");
+
+	BUG_ON(mpic == NULL); /* XXXX */
+
+	mpic_init(mpic);
+	mpic_setup_cascade(IRQ_TSI108_PCI, tsi108_irq_cascade, mpic);
+	tsi108_pci_int_init();
+
+	/* Configure MPIC outputs to CPU0 */
+	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
 }
 
 void mpc7448_hpc2_show_cpuinfo(struct seq_file *m) @@ -269,10 +313,9 @@ define_machine(mpc7448_hpc2){
 	.setup_arch 		= mpc7448_hpc2_setup_arch,
 	.init_IRQ 		= mpc7448_hpc2_init_IRQ,
 	.show_cpuinfo 		= mpc7448_hpc2_show_cpuinfo,
-	.get_irq 		= tsi108_pic_get_irq,
+	.get_irq 		= mpic_get_irq,
 	.restart 		= mpc7448_hpc2_restart,
 	.calibrate_decr 	= generic_calibrate_decr,
-	.setup_io_mappings 	= mpc7448_hpc2_map_io,
 	.machine_check_exception= mpc7448_machine_check_exception,
 	.progress 		= udbg_progress,
 };
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile index 8c0afb7..048e1f6 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
-obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_common.o tsi108_pic.o
+obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_common.o tsi108_pci_int.o
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c index 7dcdfcb..fc21e47 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -55,6 +55,78 @@ #define distribute_irqs	(0)
 #endif
 #endif
 
+static struct mpic_info mpic_infos[] = {
+	[0] = {	/* Original OpenPIC compatible MPIC */
+	.greg_base	= MPIC_GREG_BASE,
+	.greg_frr0	= MPIC_GREG_FEATURE_0,
+	.greg_config0	= MPIC_GREG_GLOBAL_CONF_0,
+	.greg_vendor_id	= MPIC_GREG_VENDOR_ID,
+	.greg_ipi_vp0	= MPIC_GREG_IPI_VECTOR_PRI_0,
+	.greg_ipi_stride	= MPIC_GREG_IPI_STRIDE,
+	.greg_spurious	= MPIC_GREG_SPURIOUS,
+	.greg_tfrr	= MPIC_GREG_TIMER_FREQ,
+
+	.timer_base	= MPIC_TIMER_BASE,
+	.timer_stride	= MPIC_TIMER_STRIDE,
+	.timer_ccr	= MPIC_TIMER_CURRENT_CNT,
+	.timer_bcr	= MPIC_TIMER_BASE_CNT,
+	.timer_vpr	= MPIC_TIMER_VECTOR_PRI,
+	.timer_dest	= MPIC_TIMER_DESTINATION,
+
+	.cpu_base	= MPIC_CPU_BASE,
+	.cpu_stride	= MPIC_CPU_STRIDE,
+	.cpu_ipi_disp0	= MPIC_CPU_IPI_DISPATCH_0,
+	.cpu_ipi_disp_stride	= MPIC_CPU_IPI_DISPATCH_STRIDE,
+	.cpu_task_pri	= MPIC_CPU_CURRENT_TASK_PRI,
+	.cpu_whoami	= MPIC_CPU_WHOAMI,
+	.cpu_intack	= MPIC_CPU_INTACK,
+	.cpu_eoi	= MPIC_CPU_EOI,
+
+	.irq_base	= MPIC_IRQ_BASE,
+	.irq_stride	= MPIC_IRQ_STRIDE,
+	.irq_vpr	= MPIC_IRQ_VECTOR_PRI,
+	.irq_vpr_vector	= MPIC_VECPRI_VECTOR_MASK,
+	.irq_vpr_polpos	= MPIC_VECPRI_POLARITY_POSITIVE,
+	.irq_vpr_senlvl	= MPIC_VECPRI_SENSE_LEVEL,
+	.irq_dest	= MPIC_IRQ_DESTINATION,
+	},
+
+	[1] = {	/* Tsi108/109 PIC */
+	.greg_base	= TSI108_GREG_BASE,
+	.greg_frr0	= TSI108_GREG_FEATURE_0,
+	.greg_config0	= TSI108_GREG_GLOBAL_CONF_0,
+	.greg_vendor_id	= TSI108_GREG_VENDOR_ID,
+	.greg_ipi_vp0	= TSI108_GREG_IPI_VECTOR_PRI_0,
+	.greg_ipi_stride	= TSI108_GREG_IPI_STRIDE,
+	.greg_spurious	= TSI108_GREG_SPURIOUS,
+	.greg_tfrr	= TSI108_GREG_TIMER_FREQ,
+
+	.timer_base	= TSI108_TIMER_BASE,
+	.timer_stride	= TSI108_TIMER_STRIDE,
+	.timer_ccr	= TSI108_TIMER_CURRENT_CNT,
+	.timer_bcr	= TSI108_TIMER_BASE_CNT,
+	.timer_vpr	= TSI108_TIMER_VECTOR_PRI,
+	.timer_dest	= TSI108_TIMER_DESTINATION,
+
+	.cpu_base	= TSI108_CPU_BASE,
+	.cpu_stride	= TSI108_CPU_STRIDE,
+	.cpu_ipi_disp0	= TSI108_CPU_IPI_DISPATCH_0,
+	.cpu_ipi_disp_stride	= TSI108_CPU_IPI_DISPATCH_STRIDE,
+	.cpu_task_pri	= TSI108_CPU_CURRENT_TASK_PRI,
+	.cpu_whoami	= 0xFFFFFFFF,
+	.cpu_intack	= TSI108_CPU_INTACK,
+	.cpu_eoi	= TSI108_CPU_EOI,
+
+	.irq_base	= TSI108_IRQ_REG_BASE,
+	.irq_stride	= TSI108_IRQ_STRIDE,
+	.irq_vpr	= TSI108_IRQ_VECTOR_PRI,
+	.irq_vpr_vector = TSI108_VECPRI_VECTOR_MASK,
+	.irq_vpr_polpos = TSI108_VECPRI_POLARITY_POSITIVE,
+	.irq_vpr_senlvl = TSI108_VECPRI_SENSE_LEVEL,
+	.irq_dest	= TSI108_IRQ_DESTINATION,
+	},
+};
+
 /*
  * Register accessor functions
  */
@@ -81,7 +153,8 @@ static inline void _mpic_write(unsigned  static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)  {
 	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
 
 	if (mpic->flags & MPIC_BROKEN_IPI)
 		be = !be;
@@ -90,7 +163,8 @@ static inline u32 _mpic_ipi_read(struct 
 
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)  {
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, value);  } @@ -121,7 +195,7 @@ static inline u32 _mpic_irq_read(struct 
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-			  reg + (idx * MPIC_IRQ_STRIDE));
+			  reg + (idx * mpic->hw_set->irq_stride));
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no, @@ -131,7 +205,7 @@ static inline void _mpic_irq_write(struc
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-		    reg + (idx * MPIC_IRQ_STRIDE), value);
+		    reg + (idx * mpic->hw_set->irq_stride), value);
 }
 
 #define mpic_read(b,r)		_mpic_read(mpic->flags & MPIC_BIG_ENDIAN,(b),(r))
@@ -157,8 +231,8 @@ static void __init mpic_test_broken_ipi(  {
 	u32 r;
 
-	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0, MPIC_VECPRI_MASK);
-	r = mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_ipi_vp0, MPIC_VECPRI_MASK);
+	r = mpic_read(mpic->gregs, mpic->hw_set->greg_ipi_vp0);
 
 	if (r == le32_to_cpu(MPIC_VECPRI_MASK)) {
 		printk(KERN_INFO "mpic: Detected reversed IPI registers\n"); @@ -392,8 +466,8 @@ static inline struct mpic * mpic_from_ir
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)  {
-	mpic_cpu_write(MPIC_CPU_EOI, 0);
-	(void)mpic_cpu_read(MPIC_CPU_WHOAMI);
+	mpic_cpu_write(mpic->hw_set->cpu_eoi, 0);
+	(void)mpic_cpu_read(mpic->hw_set->cpu_task_pri);
 }
 
 #ifdef CONFIG_SMP
@@ -419,8 +493,8 @@ static void mpic_enable_irq(unsigned int
 
 	DBG("%p: %s: enable_irq: %d (src %d)\n", mpic, mpic->name, irq, src);
 
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) &
+	mpic_irq_write(src, mpic->hw_set->irq_vpr,
+		       mpic_irq_read(src, mpic->hw_set->irq_vpr) &
 		       ~MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */ @@ -429,7 +503,7 @@ static void mpic_enable_irq(unsigned int
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK);	
+	} while(mpic_irq_read(src, mpic->hw_set->irq_vpr) & MPIC_VECPRI_MASK);	
 
 #ifdef CONFIG_MPIC_BROKEN_U3
 	if (mpic->flags & MPIC_BROKEN_U3) {
@@ -466,8 +540,8 @@ static void mpic_disable_irq(unsigned in
 
 	DBG("%s: disable_irq: %d (src %d)\n", mpic->name, irq, src);
 
-	mpic_irq_write(src, MPIC_IRQ_VECTOR_PRI,
-		       mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) |
+	mpic_irq_write(src, mpic->hw_set->irq_vpr,
+		       mpic_irq_read(src, mpic->hw_set->irq_vpr) |
 		       MPIC_VECPRI_MASK);
 
 	/* make sure mask gets to controller before we return to user */ @@ -476,7 +550,7 @@ static void mpic_disable_irq(unsigned in
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
+	} while(!(mpic_irq_read(src, mpic->hw_set->irq_vpr) & 
+MPIC_VECPRI_MASK));
 }
 
 static void mpic_shutdown_irq(unsigned int irq) @@ -557,7 +631,7 @@ static void mpic_set_affinity(unsigned i
 
 	cpus_and(tmp, cpumask, cpu_online_map);
 
-	mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_DESTINATION,
+	mpic_irq_write(irq - mpic->irq_offset, mpic->hw_set->irq_dest,
 		       mpic_physmask(cpus_addr(tmp)[0]));	
 }
 
@@ -613,18 +687,20 @@ #endif /* CONFIG_SMP */
 	mpic->num_sources = 0; /* so far */
 	mpic->senses = senses;
 	mpic->senses_count = senses_count;
+	mpic->hw_set = &mpic_infos[MPIC_GET_MOD_ID(flags)];
 
 	/* Map the global registers */
-	mpic->gregs = ioremap(phys_addr + MPIC_GREG_BASE, 0x1000);
-	mpic->tmregs = mpic->gregs + ((MPIC_TIMER_BASE - MPIC_GREG_BASE) >> 2);
+	mpic->gregs = ioremap(phys_addr + mpic->hw_set->greg_base, 0x1000);
+	mpic->tmregs = mpic->gregs +
+		       ((mpic->hw_set->timer_base - mpic->hw_set->greg_base) >> 2);
 	BUG_ON(mpic->gregs == NULL);
 
 	/* Reset */
 	if (flags & MPIC_WANTS_RESET) {
-		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-			   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		mpic_write(mpic->gregs, mpic->hw_set->greg_config0,
+			   mpic_read(mpic->gregs, mpic->hw_set->greg_config0)
 			   | MPIC_GREG_GCONF_RESET);
-		while( mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
+		while( mpic_read(mpic->gregs, mpic->hw_set->greg_config0)
 		       & MPIC_GREG_GCONF_RESET)
 			mb();
 	}
@@ -633,7 +709,7 @@ #endif /* CONFIG_SMP */
 	 * MPICs, num sources as well. On ISU MPICs, sources are counted
 	 * as ISUs are added
 	 */
-	reg = mpic_read(mpic->gregs, MPIC_GREG_FEATURE_0);
+	reg = mpic_read(mpic->gregs, mpic->hw_set->greg_frr0);
 	mpic->num_cpus = ((reg & MPIC_GREG_FEATURE_LAST_CPU_MASK)
 			  >> MPIC_GREG_FEATURE_LAST_CPU_SHIFT) + 1;
 	if (isu_size == 0)
@@ -642,16 +718,16 @@ #endif /* CONFIG_SMP */
 
 	/* Map the per-CPU registers */
 	for (i = 0; i < mpic->num_cpus; i++) {
-		mpic->cpuregs[i] = ioremap(phys_addr + MPIC_CPU_BASE +
-					   i * MPIC_CPU_STRIDE, 0x1000);
+		mpic->cpuregs[i] = ioremap(phys_addr + mpic->hw_set->cpu_base +
+					   i * mpic->hw_set->cpu_stride, 0x1000);
 		BUG_ON(mpic->cpuregs[i] == NULL);
 	}
 
 	/* Initialize main ISU if none provided */
 	if (mpic->isu_size == 0) {
 		mpic->isu_size = mpic->num_sources;
-		mpic->isus[0] = ioremap(phys_addr + MPIC_IRQ_BASE,
-					MPIC_IRQ_STRIDE * mpic->isu_size);
+		mpic->isus[0] = ioremap(phys_addr + mpic->hw_set->irq_base,
+					mpic->hw_set->irq_stride * mpic->isu_size);
 		BUG_ON(mpic->isus[0] == NULL);
 	}
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1); @@ -693,7 +769,8 @@ void __init mpic_assign_isu(struct mpic 
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic->isus[isu_num] = ioremap(phys_addr, MPIC_IRQ_STRIDE * mpic->isu_size);
+	mpic->isus[isu_num] = ioremap(phys_addr,
+				      mpic->hw_set->irq_stride * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;  } @@ -729,14 +806,15 @@ void __init mpic_init(struct mpic *mpic)
 	printk(KERN_INFO "mpic: Initializing for %d sources\n", mpic->num_sources);
 
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0xf);
 
 	/* Initialize timers: just disable them all */
 	for (i = 0; i < 4; i++) {
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_DESTINATION, 0);
+			   i * mpic->hw_set->timer_stride +
+			   mpic->hw_set->timer_dest, 0);
 		mpic_write(mpic->tmregs,
-			   i * MPIC_TIMER_STRIDE + MPIC_TIMER_VECTOR_PRI,
+			   i * mpic->hw_set->timer_stride + mpic->hw_set->timer_vpr,
 			   MPIC_VECPRI_MASK |
 			   (MPIC_VEC_TIMER_0 + i));
 	}
@@ -780,14 +858,14 @@ #endif /* CONFIG_MPIC_BROKEN_U3 */
 		/* do senses munging */
 		if (mpic->senses && i < mpic->senses_count) {
 			if (mpic->senses[i] & IRQ_SENSE_LEVEL)
-				vecpri |= MPIC_VECPRI_SENSE_LEVEL;
+				vecpri |= mpic->hw_set->irq_vpr_senlvl;
 			if (mpic->senses[i] & IRQ_POLARITY_POSITIVE)
-				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+				vecpri |= mpic->hw_set->irq_vpr_polpos;
 		} else
-			vecpri |= MPIC_VECPRI_SENSE_LEVEL;
+			vecpri |= mpic->hw_set->irq_vpr_senlvl;
 
 		/* remember if it was a level interrupts */
-		level = (vecpri & MPIC_VECPRI_SENSE_LEVEL);
+		level = (vecpri & mpic->hw_set->irq_vpr_senlvl);
 
 		/* deal with broken U3 */
 		if (mpic->flags & MPIC_BROKEN_U3) {
@@ -795,7 +873,7 @@ #ifdef CONFIG_MPIC_BROKEN_U3
 			if (mpic_is_ht_interrupt(mpic, i)) {
 				vecpri &= ~(MPIC_VECPRI_SENSE_MASK |
 					    MPIC_VECPRI_POLARITY_MASK);
-				vecpri |= MPIC_VECPRI_POLARITY_POSITIVE;
+				vecpri |= mpic->hw_set->irq_vpr_polpos;
 			}
 #else
 			printk(KERN_ERR "mpic: BROKEN_U3 set, but CONFIG doesn't match\n"); @@ -806,8 +884,8 @@ #endif
 		    (level != 0));
 
 		/* init hw */
-		mpic_irq_write(i, MPIC_IRQ_VECTOR_PRI, vecpri);
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
+		mpic_irq_write(i, mpic->hw_set->irq_vpr, vecpri);
+		mpic_irq_write(i, mpic->hw_set->irq_dest,
 			       1 << hard_smp_processor_id());
 
 		/* init linux descriptors */
@@ -818,15 +896,16 @@ #endif
 	}
 	
 	/* Init spurrious vector */
-	mpic_write(mpic->gregs, MPIC_GREG_SPURIOUS, MPIC_VEC_SPURRIOUS);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_spurious, 
+MPIC_VEC_SPURRIOUS);
 
-	/* Disable 8259 passthrough */
-	mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0,
-		   mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_0)
-		   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
+	/* Disable 8259 passthrough, if supported */
+	if (MPIC_GET_MOD_ID(mpic->flags) != MPIC_ID_TSI108)
+		mpic_write(mpic->gregs, mpic->hw_set->greg_config0,
+			   mpic_read(mpic->gregs, mpic->hw_set->greg_config0)
+			   | MPIC_GREG_GCONF_8259_PTHROU_DIS);
 
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0);
 }
 
 
@@ -845,9 +924,9 @@ void mpic_irq_set_priority(unsigned int 
 		mpic_ipi_write(irq - mpic->ipi_offset,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	} else {
-		reg = mpic_irq_read(irq - mpic->irq_offset,MPIC_IRQ_VECTOR_PRI)
+		reg = mpic_irq_read(irq - mpic->irq_offset,mpic->hw_set->irq_vpr)
 			& ~MPIC_VECPRI_PRIORITY_MASK;
-		mpic_irq_write(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI,
+		mpic_irq_write(irq - mpic->irq_offset, mpic->hw_set->irq_vpr,
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
 	}
 	spin_unlock_irqrestore(&mpic_lock, flags); @@ -864,7 +943,7 @@ unsigned int mpic_irq_get_priority(unsig
 	if (is_ipi)
 		reg = mpic_ipi_read(irq - mpic->ipi_offset);
 	else
-		reg = mpic_irq_read(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI);
+		reg = mpic_irq_read(irq - mpic->irq_offset, mpic->hw_set->irq_vpr);
 	spin_unlock_irqrestore(&mpic_lock, flags);
 	return (reg & MPIC_VECPRI_PRIORITY_MASK) >> MPIC_VECPRI_PRIORITY_SHIFT;  } @@ -890,12 +969,12 @@ #ifdef CONFIG_SMP
  	 */
 	if (distribute_irqs) {
 	 	for (i = 0; i < mpic->num_sources ; i++)
-			mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-				mpic_irq_read(i, MPIC_IRQ_DESTINATION) | msk);
+			mpic_irq_write(i, mpic->hw_set->irq_dest,
+				mpic_irq_read(i, mpic->hw_set->irq_dest) | msk);
 	}
 
 	/* Set current processor priority to 0 */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);  #endif /* CONFIG_SMP */ @@ -905,7 +984,7 @@ int mpic_cpu_get_priority(void)  {
 	struct mpic *mpic = mpic_primary;
 
-	return mpic_cpu_read(MPIC_CPU_CURRENT_TASK_PRI);
+	return mpic_cpu_read(mpic->hw_set->cpu_task_pri);
 }
 
 void mpic_cpu_set_priority(int prio)
@@ -913,7 +992,7 @@ void mpic_cpu_set_priority(int prio)
 	struct mpic *mpic = mpic_primary;
 
 	prio &= MPIC_CPU_TASKPRI_MASK;
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, prio);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, prio);
 }
 
 /*
@@ -935,11 +1014,11 @@ void mpic_teardown_this_cpu(int secondar
 
 	/* let the mpic know we don't want intrs.  */
 	for (i = 0; i < mpic->num_sources ; i++)
-		mpic_irq_write(i, MPIC_IRQ_DESTINATION,
-			mpic_irq_read(i, MPIC_IRQ_DESTINATION) & ~msk);
+		mpic_irq_write(i, mpic->hw_set->irq_dest,
+			mpic_irq_read(i, mpic->hw_set->irq_dest) & ~msk);
 
 	/* Set current processor priority to max */
-	mpic_cpu_write(MPIC_CPU_CURRENT_TASK_PRI, 0xf);
+	mpic_cpu_write(mpic->hw_set->cpu_task_pri, 0xf);
 
 	spin_unlock_irqrestore(&mpic_lock, flags);  } @@ -955,7 +1034,8 @@ #ifdef DEBUG_IPI
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);  #endif
 
-	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+	mpic_cpu_write(mpic->hw_set->cpu_ipi_disp0 +
+		       ipi_no * mpic->hw_set->cpu_ipi_disp_stride,
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));  }
 
@@ -963,7 +1043,7 @@ int mpic_get_one_irq(struct mpic *mpic,  {
 	u32 irq;
 
-	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	irq = mpic_cpu_read(mpic->hw_set->cpu_intack) & 
+mpic->hw_set->irq_vpr_vector;
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);  #endif @@ -972,11 +1052,17 @@ #ifdef DEBUG_LOW
 		DBG("%s: cascading ...\n", mpic->name);  #endif
 		irq = mpic->cascade(regs, mpic->cascade_data);
+#ifdef DEBUG_LOW
+		DBG("%s: cascaded irq: %d\n", mpic->name, irq); #endif
 		mpic_eoi(mpic);
 		return irq;
 	}
-	if (unlikely(irq == MPIC_VEC_SPURRIOUS))
+	if (unlikely(irq == MPIC_VEC_SPURRIOUS)) {
+		if (mpic->flags & MPIC_SPV_EOI)
+			mpic_eoi(mpic);
 		return -1;
+	}
 	if (irq < MPIC_VEC_IPI_0) {
 #ifdef DEBUG_IRQ
 		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset); diff --git a/arch/powerpc/sysdev/tsi108_common.c b/arch/powerpc/sysdev/tsi108_common.c
index 3c55f99..03b5d8f 100644
--- a/arch/powerpc/sysdev/tsi108_common.c
+++ b/arch/powerpc/sysdev/tsi108_common.c
@@ -90,9 +90,13 @@ tsi108_direct_write_config(struct pci_bu  {
 	volatile unsigned char *cfg_addr;
 
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfunc))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
 	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
 							devfunc, offset) |
-				     (offset & 0x03));
+							(offset & 0x03));
 
 #ifdef TSI108_PCI_DEBUG
 	printk("PCI CFG write : ");
@@ -172,6 +176,10 @@ tsi108_direct_read_config(struct pci_bus
 	volatile unsigned char *cfg_addr;
 	u32 temp;
 
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
 	cfg_addr = (unsigned char *)(tsi_mk_config_addr(bus->number,
 							devfn,
 							offset) | (offset &
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h index 6b9e781..72131a4 100644
--- a/include/asm-powerpc/mpic.h
+++ b/include/asm-powerpc/mpic.h
@@ -37,6 +37,7 @@ #define MPIC_GREG_IPI_VECTOR_PRI_0	0x000
 #define MPIC_GREG_IPI_VECTOR_PRI_1	0x000b0
 #define MPIC_GREG_IPI_VECTOR_PRI_2	0x000c0
 #define MPIC_GREG_IPI_VECTOR_PRI_3	0x000d0
+#define MPIC_GREG_IPI_STRIDE		0x10
 #define MPIC_GREG_SPURIOUS		0x000e0
 #define MPIC_GREG_TIMER_FREQ		0x000f0
 
@@ -64,6 +65,7 @@ #define MPIC_CPU_IPI_DISPATCH_0		0x00040
 #define MPIC_CPU_IPI_DISPATCH_1		0x00050
 #define MPIC_CPU_IPI_DISPATCH_2		0x00060
 #define MPIC_CPU_IPI_DISPATCH_3		0x00070
+#define MPIC_CPU_IPI_DISPATCH_STRIDE	0x00010
 #define MPIC_CPU_CURRENT_TASK_PRI	0x00080
 #define 	MPIC_CPU_TASKPRI_MASK			0x0000000f
 #define MPIC_CPU_WHOAMI			0x00090
@@ -91,6 +93,55 @@ #define 	MPIC_VECPRI_SENSE_EDGE			0x0000
 #define 	MPIC_VECPRI_SENSE_MASK			0x00400000
 #define MPIC_IRQ_DESTINATION		0x00010
 
+/**********************************************************************
+********
+ * Tsi108 implementation of MPIC has many differences form the original 
+one  */
+
+/*
+ * Global registers
+ */
+
+#define TSI108_GREG_BASE		0x00000
+#define TSI108_GREG_FEATURE_0		0x00000
+#define TSI108_GREG_GLOBAL_CONF_0	0x00004
+#define TSI108_GREG_VENDOR_ID		0x0000c
+#define TSI108_GREG_IPI_VECTOR_PRI_0	0x00204		/* Doorbell 0 */
+#define TSI108_GREG_IPI_STRIDE		0x0c
+#define TSI108_GREG_SPURIOUS		0x00010
+#define TSI108_GREG_TIMER_FREQ		0x00014
+
+/*
+ * Timer registers
+ */
+#define TSI108_TIMER_BASE		0x0030
+#define TSI108_TIMER_STRIDE		0x10
+#define TSI108_TIMER_CURRENT_CNT	0x00000
+#define TSI108_TIMER_BASE_CNT		0x00004
+#define TSI108_TIMER_VECTOR_PRI		0x00008
+#define TSI108_TIMER_DESTINATION	0x0000c
+
+/*
+ * Per-Processor registers
+ */
+#define TSI108_CPU_BASE			0x00300
+#define TSI108_CPU_STRIDE		0x00040
+#define TSI108_CPU_IPI_DISPATCH_0	0x00200
+#define TSI108_CPU_IPI_DISPATCH_STRIDE	0x00000
+#define TSI108_CPU_CURRENT_TASK_PRI	0x00000
+#define TSI108_CPU_INTACK		0x00004
+#define TSI108_CPU_EOI			0x00008
+
+/*
+ * Per-source registers
+ */
+#define TSI108_IRQ_REG_BASE		0x00100
+#define TSI108_IRQ_STRIDE		0x00008
+#define TSI108_IRQ_VECTOR_PRI		0x00000
+#define 	TSI108_VECPRI_VECTOR_MASK		0x000000ff
+#define 	TSI108_VECPRI_POLARITY_POSITIVE		0x01000000
+#define 	TSI108_VECPRI_SENSE_LEVEL		0x02000000
+#define TSI108_IRQ_DESTINATION		0x00004
+
 #define MPIC_MAX_IRQ_SOURCES	2048
 #define MPIC_MAX_CPUS		32
 #define MPIC_MAX_ISU		32
@@ -124,6 +175,40 @@ struct mpic_irq_fixup  };  #endif /* CONFIG_MPIC_BROKEN_U3 */
 
+struct mpic_info {
+	u32	greg_base;	/* offset of global registers from MPIC base */
+	u32	greg_frr0;	/* FRR0 offset from base */
+	u32	greg_config0;	/* Global Config register offset from base */
+	u32	greg_vendor_id;	/* VID register offset from base */
+	u32	greg_ipi_vp0;	/* IPI Vector/Priority Registers */
+	u32	greg_ipi_stride; /* IPI Vector/Priority Registers spacing */
+	u32	greg_spurious;	/* Spurious Vector Register */
+	u32	greg_tfrr;	/* Global Timer Frequency Reporting Register */
+
+	u32	timer_base;	/* Global Timer Registers base */
+	u32	timer_stride;	/* Global Timer Registers spacing */
+	u32	timer_ccr;	/* Global Timer Current Count Register */
+	u32	timer_bcr;	/* Global Timer Base Count Register */
+	u32	timer_vpr;	/* Global Timer Vector/Priority Register */
+	u32	timer_dest;	/* Global Timer Destination Register */
+
+	u32	cpu_base;	/* Global Timer Destination Register */
+	u32	cpu_stride;	/* Global Timer Destination Register */
+	u32	cpu_ipi_disp0;	/* IPI 0 Dispatch Command Register */
+	u32	cpu_ipi_disp_stride;	/* IPI Dispatch spacing */
+	u32	cpu_task_pri;	/* Processor Current Task Priority Register */
+	u32	cpu_whoami;	/* Who Am I Register */
+	u32	cpu_intack;	/* Interrupt Acknowledge Register */
+	u32	cpu_eoi;	/* End of Interrupt Register */
+
+	u32	irq_base;	/* Interrupt registers base */
+	u32	irq_stride;	/* Interrupt registers spacing */
+	u32	irq_vpr;	/* Interrupt Vector/Priority Register */
+	u32	irq_vpr_vector;	/* Interrupt Vector Mask */
+	u32	irq_vpr_polpos;	/* Interrupt Positive Polarity bit */
+	u32	irq_vpr_senlvl;	/* Interrupt Level Sense bit */
+	u32	irq_dest;	/* Interrupt Destination Register */
+};
 
 /* The instance data of a given MPIC */  struct mpic @@ -168,6 +253,8 @@ #endif
 	volatile u32 __iomem	*tmregs;
 	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
 	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+	/* Pointer to HW info structure */
+	struct mpic_info	*hw_set;
 
 	/* link */
 	struct mpic		*next;
@@ -186,6 +273,14 @@ #define MPIC_BROKEN_U3			0x00000004
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* Spurious vector requires EOI */
+#define MPIC_SPV_EOI			0x00000020
+/* MPIC HW modification ID */
+#define MPIC_MOD_ID_MASK		0x00000f00
+#define MPIC_MOD_ID(val)		(((val) << 8) & MPIC_MOD_ID_MASK)
+#define MPIC_GET_MOD_ID(flags)		(((flags) & MPIC_MOD_ID_MASK) >> 8)
+#define		MPIC_ID_MPIC		0	/* Original MPIC */
+#define		MPIC_ID_TSI108		1	/* Tsi108/109 PIC */
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is diff --git a/include/asm-powerpc/tsi108.h b/include/asm-powerpc/tsi108.h index ed9ec36..850c56d 100644
--- a/include/asm-powerpc/tsi108.h
+++ b/include/asm-powerpc/tsi108.h
@@ -55,6 +55,7 @@ #define TSI108_PCI_IRP_ENABLE	(0x188)
 #define TSI108_PCI_IRP_INTAD	(0x18C)
 
 #define TSI108_PCI_IRP_STAT_P_INT	(0x00400000)
+#define TSI108_PCI_IRP_ENABLE_P_INT	(0x00400000)
 
 #define TSI108_CG_PWRUP_STATUS	(0x234)
diff --git a/arch/powerpc/sysdev/tsi108_pci_int.c b/arch/powerpc/sysdev/tsi108_pci_int.c
index e69de29..c1ca187 100644
--- a/arch/powerpc/sysdev/tsi108_pci_int.c
+++ b/arch/powerpc/sysdev/tsi108_pci_int.c
@@ -0,0 +1,232 @@
+/*
+ * (C) Copyright 2005 Tundra Semiconductor Corp.
+ * Alex Bounine, <alexandreb@tundra.com).
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+/*
+ * Tsi108 PCI Interrupt Handling (cascaded to MPIC)  */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/sysdev.h>
+#include <asm/ptrace.h>
+#include <asm/signal.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <asm/sections.h>
+#include <asm/hardirq.h>
+#include <asm/machdep.h>
+
+#include <asm/tsi108.h>
+#include <asm/tsi108_irq.h>
+
+#undef DEBUG
+#undef DBG_TSI108_INTERRUPT
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(fmt); } while(0) #else #define 
+DBG(fmt...) do { } while(0) #endif
+
+extern u32 get_vir_csrbase(void);
+extern u32 tsi108_read_reg(u32 reg_offset); extern void 
+tsi108_write_reg(u32 reg_offset, u32 val);
+
+/*
+ * Low level utility functions
+ */
+
+static void tsi108_pci_int_mask(u_int irq) {
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
+static void tsi108_pci_int_unmask(u_int irq) {
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
+#ifdef DBG_TSI108_INTERRUPT
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
+#endif	/* DBG_TSI108_INTERRUPT */
+
+	return irq;
+}
+
+
+/*
+ * Linux descriptor level callbacks
+ */
+
+static void tsi108_pci_irq_enable(u_int irq) {
+	tsi108_pci_int_unmask(irq);
+}
+
+static void tsi108_pci_irq_disable(u_int irq) {
+	tsi108_pci_int_mask(irq);
+}
+
+static void tsi108_pci_irq_ack(u_int irq) {
+	tsi108_pci_int_mask(irq);
+}
+
+static void tsi108_pci_irq_end(u_int irq) {
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
+ * The INTA# - INTD# interrupts on the PCI bus are reported by the PCI 
+block
+ * to the MPIC using single interrupt source (IRQ_TSI108_PCI). 
+Therefore the
+ * PCI block has to be treated as a cascaded interrupt controller 
+connected
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
+int tsi108_irq_cascade(struct pt_regs *regs, void *unused) {
+	return get_pci_source();
+}
