Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (unknown [192.88.158.102])
	by ozlabs.org (Postfix) with ESMTP id 5052067B64
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Jun 2006 19:44:12 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k56A4dl5025827
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 03:04:39 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k569htNN005135
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 04:43:57 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673067CD108@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Alexandre Bounine <Alexandre.Bounine@tundra.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: [PATCH/2.6.17-rc4 4/10]Powerpc:  Add tsi108 pic support
Date: Tue, 6 Jun 2006 17:43:49 +0800 
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

> The items 1 and 2 not needed. I moved them from the 
> tsi108_pic.c but really they have been leftovers from the old 
> code there. Originally code ppc/syslib/open_pic.c was used as 
> a template, which was good fit for the blocking output mode 
> of the tsi108 PIC (plus some extra tweaks). In that mode EOI 
> has to be signaled to PIC to deactivate interrupt line to the 
> CPU before it re-enables local interrupts. This is why we 
> have got ack routine. We changed mode later and removed most 
> of workarounds except these two.
> 
> I removed code for 1 and 2 and will send a patch to Roy after 
> retesting (probably this weekend with some other stuff).
> 
> Alex.
>               
> 
> On Thu, 2006-06-01 at 16:45 -0400, Alexandre Bounine wrote:
> > All differences in the Tsi108/109 PIC code from the 
> standard MPIC are caused by the HW behavior. The Tsi108/109 
> PIC looks like standard OpenPIC but, in fact, is different in 
> registers mapping and behavior. Its logic is close but not 
> exactly as MPIC.  
> > 
> > Here are replies on comments to the code:
> > 
> > 1.Why do you have to check if its a LEVEL irq?
> > 
> > Check for LEVEL irqs is required in the ack/end pair to 
> enable nested 
> > interrupt servicing and does not hang when core (local) 
> interrupts are 
> > re-enabled in the ISR. Otherwise we have to use 
> SA_INTERRUPT flag for all level signaled interrupts.
> 
> Can you be more precise about what exactly happens and why ? 
> Unless you EOI handling is broken of course, there should be 
> no need to do anything other than a single eoi in end(), period.
> 
> > 2. if the PIC works like other openpic's you dont need an 'ack' we 
> > handle it via 'end'
> > 
> > Tsi108/109 needs it.
> 
> What for ? Please, give the low level details.
> 
> > 3. why the changes to where we do mpic_eoi for TSI108?
> > The Tsi108 PIC requires EOI for spurious interrupt (as all 
> other interrupt sources).
> 
> Ok, that is acceptable.
> 
> > The do_IRQ() does not call end routine for spurious interrupts.  
> > 
> > The MPIC code patch for Tsi108/109 demonstrates HW 
> differences and why we originally considered having separate 
> code for Tsi108 pic.
> 
> Please tell me more about the HW differences :)
> 
> Ben.


Update Tsi108 implementation of MPIC.
Any comment? 

Integrate Tundra Semiconductor tsi108 host bridge interrupt controller 
to mpic arch.

Signed-off-by: Alexandre Bounine <alexandreb@tundra.com>
Signed-off-by: Roy Zang		<tie-fei.zang@freescale.com>

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7e4d38e..d8a9add 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -408,7 +408,8 @@ config U3_DART
 	default n
 
 config MPIC
-	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP
+	depends on PPC_PSERIES || PPC_PMAC || PPC_MAPLE || PPC_CHRP \
+			       || MPC7448HPC2
 	bool
 	default y
 
diff --git a/arch/powerpc/configs/mpc7448_hpc2_defconfig b/arch/powerpc/configs/mpc7448_hpc2_defconfig
index 28c7c8b..15a50f4 100644
--- a/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ b/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.17-rc4
-# Tue May 23 11:29:48 2006
+# Sat May 27 18:45:55 2006
 #
 # CONFIG_PPC64 is not set
 CONFIG_PPC32=y
@@ -110,6 +110,7 @@ # CONFIG_PPC_MULTIPLATFORM is not set
 # CONFIG_PPC_ISERIES is not set
 CONFIG_EMBEDDED6xx=y
 # CONFIG_APUS is not set
+CONFIG_MPIC=y
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
 # CONFIG_PPC_MPC106 is not set
@@ -899,6 +900,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_DEBUG_FS is not set
 # CONFIG_UNWIND_INFO is not set
 # CONFIG_BOOTX_TEXT is not set
+# CONFIG_SERIAL_TEXT_DEBUG is not set
 # CONFIG_PPC_EARLY_DEBUG_LPAR is not set
 # CONFIG_PPC_EARLY_DEBUG_G5 is not set
 # CONFIG_PPC_EARLY_DEBUG_RTAS is not set
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index e125ec6..2b78196 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -79,6 +79,7 @@ config MPC7448HPC2
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
+	select MPIC
 	help
 	  Select MPC7448HPC2 if configuring for Freescale MPC7448HPC2 (Taiga)
 	  platform
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index db5dc10..458f70d 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -43,7 +43,16 @@ #include <asm/pci-bridge.h>
 #include <asm/reg.h>
 #include <mm/mmu_decl.h>
 #include "mpc7448_hpc2.h"
-#include <asm/tsi108_pic.h>
+#include <asm/tsi108_irq.h>
+#include <asm/mpic.h>
+
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(fmt); } while(0)
+#else
+#define DBG(fmt...) do { } while(0)
+#endif
 
 #ifndef CONFIG_PCI
 isa_io_base = MPC7448_HPC2_ISA_IO_BASE;
@@ -53,20 +62,8 @@ #endif
 
 extern int add_bridge(struct device_node *dev);
 extern void _nmask_and_or_msr(unsigned long nmask, unsigned long or_val);
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
  * Define all of the IRQ senses and polarities.  Taken from the
@@ -76,10 +73,32 @@ #endif
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
@@ -196,18 +215,44 @@ #endif
  */
 static void __init mpc7448_hpc2_init_IRQ(void)
 {
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
 
-static void __init mpc7448_hpc2_map_io(void)
-{
-	/* Tsi108 CSR mapping */
-	io_block_mapping(TSI108_CSR_ADDR_VIRT, TSI108_CSR_ADDR_PHYS,
-			 0x100000, _PAGE_IO);
+	mpic = mpic_alloc(mpic_paddr,
+			MPIC_PRIMARY | MPIC_BIG_ENDIAN | MPIC_WANTS_RESET |
+			MPIC_SPV_EOI | MPIC_CASC_NOEOI | 
+			MPIC_MOD_ID(MPIC_ID_TSI108),
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
 
 void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
@@ -269,10 +314,9 @@ define_machine(mpc7448_hpc2){
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
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 8c0afb7..048e1f6 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -8,4 +8,4 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
-obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_common.o tsi108_pic.o
+obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_common.o tsi108_pci_int.o
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7dcdfcb..09cb0eb 100644
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
@@ -81,7 +153,8 @@ static inline void _mpic_write(unsigned 
 static inline u32 _mpic_ipi_read(struct mpic *mpic, unsigned int ipi)
 {
 	unsigned int be = (mpic->flags & MPIC_BIG_ENDIAN) != 0;
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
 
 	if (mpic->flags & MPIC_BROKEN_IPI)
 		be = !be;
@@ -90,7 +163,8 @@ static inline u32 _mpic_ipi_read(struct 
 
 static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 value)
 {
-	unsigned int offset = MPIC_GREG_IPI_VECTOR_PRI_0 + (ipi * 0x10);
+	unsigned int offset = mpic->hw_set->greg_ipi_vp0 +
+			      (ipi * mpic->hw_set->greg_ipi_stride);
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->gregs, offset, value);
 }
@@ -121,7 +195,7 @@ static inline u32 _mpic_irq_read(struct 
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	return _mpic_read(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-			  reg + (idx * MPIC_IRQ_STRIDE));
+			  reg + (idx * mpic->hw_set->irq_stride));
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -131,7 +205,7 @@ static inline void _mpic_irq_write(struc
 	unsigned int	idx = src_no & mpic->isu_mask;
 
 	_mpic_write(mpic->flags & MPIC_BIG_ENDIAN, mpic->isus[isu],
-		    reg + (idx * MPIC_IRQ_STRIDE), value);
+		    reg + (idx * mpic->hw_set->irq_stride), value);
 }
 
 #define mpic_read(b,r)		_mpic_read(mpic->flags & MPIC_BIG_ENDIAN,(b),(r))
@@ -157,8 +231,8 @@ static void __init mpic_test_broken_ipi(
 {
 	u32 r;
 
-	mpic_write(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0, MPIC_VECPRI_MASK);
-	r = mpic_read(mpic->gregs, MPIC_GREG_IPI_VECTOR_PRI_0);
+	mpic_write(mpic->gregs, mpic->hw_set->greg_ipi_vp0, MPIC_VECPRI_MASK);
+	r = mpic_read(mpic->gregs, mpic->hw_set->greg_ipi_vp0);
 
 	if (r == le32_to_cpu(MPIC_VECPRI_MASK)) {
 		printk(KERN_INFO "mpic: Detected reversed IPI registers\n");
@@ -392,8 +466,8 @@ static inline struct mpic * mpic_from_ir
 /* Send an EOI */
 static inline void mpic_eoi(struct mpic *mpic)
 {
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
 
 	/* make sure mask gets to controller before we return to user */
@@ -429,7 +503,7 @@ static void mpic_enable_irq(unsigned int
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
 
 	/* make sure mask gets to controller before we return to user */
@@ -476,7 +550,7 @@ static void mpic_disable_irq(unsigned in
 			printk(KERN_ERR "mpic_enable_irq timeout\n");
 			break;
 		}
-	} while(!(mpic_irq_read(src, MPIC_IRQ_VECTOR_PRI) & MPIC_VECPRI_MASK));
+	} while(!(mpic_irq_read(src, mpic->hw_set->irq_vpr) & MPIC_VECPRI_MASK));
 }
 
 static void mpic_shutdown_irq(unsigned int irq)
@@ -557,7 +631,7 @@ static void mpic_set_affinity(unsigned i
 
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
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
@@ -693,7 +769,8 @@ void __init mpic_assign_isu(struct mpic 
 
 	BUG_ON(isu_num >= MPIC_MAX_ISU);
 
-	mpic->isus[isu_num] = ioremap(phys_addr, MPIC_IRQ_STRIDE * mpic->isu_size);
+	mpic->isus[isu_num] = ioremap(phys_addr,
+				      mpic->hw_set->irq_stride * mpic->isu_size);
 	if ((isu_first + mpic->isu_size) > mpic->num_sources)
 		mpic->num_sources = isu_first + mpic->isu_size;
 }
@@ -729,14 +806,15 @@ void __init mpic_init(struct mpic *mpic)
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
 			printk(KERN_ERR "mpic: BROKEN_U3 set, but CONFIG doesn't match\n");
@@ -806,8 +884,8 @@ #endif
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
+	mpic_write(mpic->gregs, mpic->hw_set->greg_spurious, MPIC_VEC_SPURRIOUS);
 
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
 	spin_unlock_irqrestore(&mpic_lock, flags);
@@ -864,7 +943,7 @@ unsigned int mpic_irq_get_priority(unsig
 	if (is_ipi)
 		reg = mpic_ipi_read(irq - mpic->ipi_offset);
 	else
-		reg = mpic_irq_read(irq - mpic->irq_offset, MPIC_IRQ_VECTOR_PRI);
+		reg = mpic_irq_read(irq - mpic->irq_offset, mpic->hw_set->irq_vpr);
 	spin_unlock_irqrestore(&mpic_lock, flags);
 	return (reg & MPIC_VECPRI_PRIORITY_MASK) >> MPIC_VECPRI_PRIORITY_SHIFT;
 }
@@ -890,12 +969,12 @@ #ifdef CONFIG_SMP
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
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 #endif /* CONFIG_SMP */
@@ -905,7 +984,7 @@ int mpic_cpu_get_priority(void)
 {
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
 
 	spin_unlock_irqrestore(&mpic_lock, flags);
 }
@@ -955,7 +1034,8 @@ #ifdef DEBUG_IPI
 	DBG("%s: send_ipi(ipi_no: %d)\n", mpic->name, ipi_no);
 #endif
 
-	mpic_cpu_write(MPIC_CPU_IPI_DISPATCH_0 + ipi_no * 0x10,
+	mpic_cpu_write(mpic->hw_set->cpu_ipi_disp0 +
+		       ipi_no * mpic->hw_set->cpu_ipi_disp_stride,
 		       mpic_physmask(cpu_mask & cpus_addr(cpu_online_map)[0]));
 }
 
@@ -963,7 +1043,7 @@ int mpic_get_one_irq(struct mpic *mpic, 
 {
 	u32 irq;
 
-	irq = mpic_cpu_read(MPIC_CPU_INTACK) & MPIC_VECPRI_VECTOR_MASK;
+	irq = mpic_cpu_read(mpic->hw_set->cpu_intack) & mpic->hw_set->irq_vpr_vector;
 #ifdef DEBUG_LOW
 	DBG("%s: get_one_irq(): %d\n", mpic->name, irq);
 #endif
@@ -972,11 +1052,18 @@ #ifdef DEBUG_LOW
 		DBG("%s: cascading ...\n", mpic->name);
 #endif
 		irq = mpic->cascade(regs, mpic->cascade_data);
-		mpic_eoi(mpic);
+#ifdef DEBUG_LOW
+		DBG("%s: cascaded irq: %d\n", mpic->name, irq);
+#endif
+		if (!(mpic->flags & MPIC_CASC_NOEOI))
+			mpic_eoi(mpic);
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
 		DBG("%s: irq %d\n", mpic->name, irq + mpic->irq_offset);
diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
index 6b9e781..6fa3427 100644
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
 
+/******************************************************************************
+ * Tsi108 implementation of MPIC has many differences form the original one
+ */
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
@@ -124,6 +175,40 @@ struct mpic_irq_fixup
 };
 #endif /* CONFIG_MPIC_BROKEN_U3 */
 
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
 
 /* The instance data of a given MPIC */
 struct mpic
@@ -168,6 +253,8 @@ #endif
 	volatile u32 __iomem	*tmregs;
 	volatile u32 __iomem	*cpuregs[MPIC_MAX_CPUS];
 	volatile u32 __iomem	*isus[MPIC_MAX_ISU];
+	/* Pointer to HW info structure */
+	struct mpic_info	*hw_set;
 
 	/* link */
 	struct mpic		*next;
@@ -186,6 +273,16 @@ #define MPIC_BROKEN_U3			0x00000004
 #define MPIC_BROKEN_IPI			0x00000008
 /* MPIC wants a reset */
 #define MPIC_WANTS_RESET		0x00000010
+/* Spurious vector requires EOI */
+#define MPIC_SPV_EOI			0x00000020
+/* No EOI for cascaded interrupt */
+#define MPIC_CASC_NOEOI			0x00000040
+/* MPIC HW modification ID */
+#define MPIC_MOD_ID_MASK		0x00000f00
+#define MPIC_MOD_ID(val)		(((val) << 8) & MPIC_MOD_ID_MASK)
+#define MPIC_GET_MOD_ID(flags)		(((flags) & MPIC_MOD_ID_MASK) >> 8)
+#define		MPIC_ID_MPIC		0	/* Original MPIC */
+#define		MPIC_ID_TSI108		1	/* Tsi108/109 PIC */
 
 /* Allocate the controller structure and setup the linux irq descs
  * for the range if interrupts passed in. No HW initialization is
