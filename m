Return-Path: <tglx@linutronix.de>
Received: from debian.tglx.de (unknown [213.239.205.147])
	by ozlabs.org (Postfix) with ESMTP id 71DD72BE83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Dec 2004 11:56:52 +1100 (EST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <2A28D57A-4E27-11D9-B992-000393DBC2E8@freescale.com>
References: <20041213230348.1.patchmail@tglx>
	<2A28D57A-4E27-11D9-B992-000393DBC2E8@freescale.com>
Content-Type: multipart/mixed; boundary="=-Ptr5YM0wAozHTMQ3ijJA"
Date: Wed, 15 Dec 2004 01:37:42 +0100
Message-Id: <1103071062.3406.103.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Fix __res data type (PPC 85xx) 2nd version
Reply-To: tglx@linutronix.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-Ptr5YM0wAozHTMQ3ijJA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Kumar,

On Tue, 2004-12-14 at 17:23 -0600, Kumar Gala wrote:
> Thomas,
> 
> This generally looks good, I would like to apply the patch and do some 
> testing.  In the future please CC: linuxppc-embedded@ozlabs.org (this 
> will allow us to manage the patches @ http://ozlabs.org/ppc32-patches/)

The attached patch contains the previous one and the resulting changes
for syslib/ppc85xx_setup.c. It's a correct -p1 patch now.

Thanks,

tglx



--=-Ptr5YM0wAozHTMQ3ijJA
Content-Disposition: attachment; filename=res-2.diff
Content-Type: text/x-patch; name=res-2.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: 2.6.10-rc3/include/asm-ppc/mpc85xx.h
===================================================================
--- 2.6.10-rc3/include/asm-ppc/mpc85xx.h	(revision 8)
+++ 2.6.10-rc3/include/asm-ppc/mpc85xx.h	(working copy)
@@ -47,7 +47,7 @@
  * The "residual" board information structure the boot loader passes
  * into the kernel.
  */
-extern unsigned char __res[];
+extern bd_t __res;
 
 /* Internal IRQs on MPC85xx OpenPIC */
 /* Not all of these exist on all MPC85xx implementations */
Index: 2.6.10-rc3/arch/ppc/platforms/85xx/sbc85xx.c
===================================================================
--- 2.6.10-rc3/arch/ppc/platforms/85xx/sbc85xx.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/platforms/85xx/sbc85xx.c	(working copy)
@@ -48,7 +48,7 @@
 
 #include <platforms/85xx/sbc85xx.h>
 
-unsigned char __res[sizeof (bd_t)];
+bd_t __res;
 
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
@@ -120,11 +120,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = __res.bi_intfreq;
 
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
@@ -159,10 +158,9 @@
 void __init
 sbc8560_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	    __res.bi_immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = sbc8560_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (sbc8560_openpic_initsenses);
Index: 2.6.10-rc3/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
===================================================================
--- 2.6.10-rc3/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	(working copy)
@@ -56,7 +56,7 @@
 
 extern unsigned long total_memory;	/* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
+bd_t __res;
 
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
 
@@ -120,11 +120,10 @@
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
-	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 
 	/* get the core frequency */
-	freq = binfo->bi_intfreq;
+	freq = __res.bi_intfreq;
 
 	pvid = mfspr(PVR);
 	svid = mfspr(SVR);
@@ -159,10 +158,9 @@
 void __init
 mpc85xx_ads_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
 	/* Determine the Physical Address of the OpenPIC regs */
 	phys_addr_t OpenPIC_PAddr =
-	    binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	    __res.bi_immr_base + MPC85xx_OPENPIC_OFFSET;
 	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
 	OpenPIC_InitSenses = mpc85xx_ads_openpic_initsenses;
 	OpenPIC_NumInitSenses = sizeof (mpc85xx_ads_openpic_initsenses);
Index: 2.6.10-rc3/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
===================================================================
--- 2.6.10-rc3/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	(working copy)
@@ -64,7 +64,7 @@
 
 extern unsigned long total_memory;      /* in mm/init */
 
-unsigned char __res[sizeof (bd_t)];
+bd_t __res;
 
 static int cds_pci_slot = 2;
 static volatile u8 * cadmus;
@@ -161,11 +161,10 @@
 {
         uint pvid, svid, phid1;
         uint memsize = total_memory;
-        bd_t *binfo = (bd_t *) __res;
         unsigned int freq;
 
         /* get the core frequency */
-        freq = binfo->bi_intfreq;
+        freq = __res.bi_intfreq;
 
         pvid = mfspr(PVR);
         svid = mfspr(SVR);
@@ -204,7 +203,7 @@
 void __init
 mpc85xx_cds_init_IRQ(void)
 {
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 #ifdef CONFIG_CPM2
 	volatile cpm2_map_t *immap = cpm2_immr;
 	int i;
@@ -337,7 +336,7 @@
 {
         struct ocp_def *def;
         struct ocp_gfar_data *einfo;
-        bd_t *binfo = (bd_t *) __res;
+        bd_t *binfo = &__res;
         unsigned int freq;
 
         /* get the core frequency */
@@ -411,13 +410,13 @@
          * residual data area.
          */
         if (r3) {
-                memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+                memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
                        sizeof (bd_t));
 
         }
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
-		bd_t *binfo = (bd_t *) __res;
+		bd_t *binfo = &__res;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
Index: 2.6.10-rc3/arch/ppc/platforms/85xx/mpc8540_ads.c
===================================================================
--- 2.6.10-rc3/arch/ppc/platforms/85xx/mpc8540_ads.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/platforms/85xx/mpc8540_ads.c	(working copy)
@@ -102,7 +102,7 @@
 {
 	struct ocp_def *def;
 	struct ocp_gfar_data *einfo;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	unsigned int freq;
 
 	/* get the core frequency */
@@ -175,12 +175,12 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
 		       sizeof (bd_t));
 	}
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
-		bd_t *binfo = (bd_t *) __res;
+		bd_t *binfo = &__res;
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
Index: 2.6.10-rc3/arch/ppc/platforms/85xx/mpc8560_ads.c
===================================================================
--- 2.6.10-rc3/arch/ppc/platforms/85xx/mpc8560_ads.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/platforms/85xx/mpc8560_ads.c	(working copy)
@@ -97,7 +97,7 @@
 {
 	struct ocp_def *def;
 	struct ocp_gfar_data *einfo;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	unsigned int freq;
 
 	cpm2_reset();
@@ -200,7 +200,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
 		       sizeof (bd_t));
 
 	}
Index: 2.6.10-rc3/arch/ppc/platforms/85xx/sbc8560.c
===================================================================
--- 2.6.10-rc3/arch/ppc/platforms/85xx/sbc8560.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/platforms/85xx/sbc8560.c	(working copy)
@@ -127,7 +127,7 @@
 {
 	struct ocp_def *def;
 	struct ocp_gfar_data *einfo;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	unsigned int freq;
 
 	/* get the core frequency */
@@ -193,7 +193,7 @@
 	 * residual data area.
 	 */
 	if (r3) {
-		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+		memcpy((void *) &__res, (void *) (r3 + KERNELBASE),
 		       sizeof (bd_t));
 	}
 
Index: 2.6.10-rc3/arch/ppc/syslib/ppc85xx_setup.c
===================================================================
--- 2.6.10-rc3/arch/ppc/syslib/ppc85xx_setup.c	(revision 11)
+++ 2.6.10-rc3/arch/ppc/syslib/ppc85xx_setup.c	(working copy)
@@ -36,22 +36,17 @@
 unsigned long __init
 mpc85xx_find_end_of_memory(void)
 {
-        bd_t *binfo;
-
-        binfo = (bd_t *) __res;
-
-        return binfo->bi_memsize;
+        return __res.bi_memsize;
 }
 
 /* The decrementer counts at the system (internal) clock freq divided by 8 */
 void __init
 mpc85xx_calibrate_decr(void)
 {
-        bd_t *binfo = (bd_t *) __res;
         unsigned int freq, divisor;
 
         /* get the core frequency */
-        freq = binfo->bi_busfreq;
+        freq = __res.bi_busfreq;
 
         /* The timebase is updated every 8 bus clocks, HID0[SEL_TBCLK] = 0 */
         divisor = 8;
@@ -74,7 +69,7 @@
 mpc85xx_early_serial_map(void)
 {
 	struct uart_port serial_req;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 	phys_addr_t duart_paddr = binfo->bi_immr_base + MPC85xx_UART0_OFFSET;
 
 	/* Setup serial port access */
@@ -138,7 +133,7 @@
 	volatile struct ccsr_pci *pci;
 	volatile struct ccsr_guts *guts;
 	unsigned short temps;
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 
 	pci = ioremap(binfo->bi_immr_base + MPC85xx_PCI1_OFFSET,
 		    MPC85xx_PCI1_SIZE);
@@ -250,7 +245,7 @@
 #ifdef CONFIG_85xx_PCI2
 	struct pci_controller *hose_b;
 #endif
-	bd_t *binfo = (bd_t *) __res;
+	bd_t *binfo = &__res;
 
 	hose_a = pcibios_alloc_controller();
 

--=-Ptr5YM0wAozHTMQ3ijJA--
