Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D910968162
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Sep 2005 10:13:10 +1000 (EST)
Date: Wed, 7 Sep 2005 20:03:24 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20050907230324.GC7513@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] add big endian version of ld_/st_ IO access macros and
	convert main 8xx code to use it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

The following patch adds big endian version of ld_/st_ macros 
and converts core 8xx code to use them.

Other than making IO accesses explicit (which is a plus for
readability), a common set of macros provides a unified place for the
volatile flag to constraint compiler code reordering.

There are several unlucky places at the moment which lack the 
volatile flag.


diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -73,7 +73,7 @@ cpm_mask_irq(unsigned int irq)
 {
 	int cpm_vec = irq - CPM_IRQ_OFFSET;
 
-	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr &= ~(1 << cpm_vec);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr, ld_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr) & ~(1 << cpm_vec));
 }
 
 static void
@@ -81,7 +81,7 @@ cpm_unmask_irq(unsigned int irq)
 {
 	int cpm_vec = irq - CPM_IRQ_OFFSET;
 
-	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr |= (1 << cpm_vec);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr, ld_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr) | (1 << cpm_vec));
 }
 
 static void
@@ -95,7 +95,7 @@ cpm_eoi(unsigned int irq)
 {
 	int cpm_vec = irq - CPM_IRQ_OFFSET;
 
-	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr = (1 << cpm_vec);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr, (1 << cpm_vec));
 }
 
 struct hw_interrupt_type cpm_pic = {
@@ -133,7 +133,7 @@ m8xx_cpm_reset(void)
 	 * manual recommends it.
 	 * Bit 25, FAM can also be set to use FEC aggressive mode (860T).
 	 */
-	imp->im_siu_conf.sc_sdcr = 1;
+	st_be32(&imp->im_siu_conf.sc_sdcr, 1);
 
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
@@ -178,10 +178,10 @@ cpm_interrupt_init(void)
 
 	/* Initialize the CPM interrupt controller.
 	*/
-	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr =
+	st_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr,
 	    (CICR_SCD_SCC4 | CICR_SCC_SCC3 | CICR_SCB_SCC2 | CICR_SCA_SCC1) |
-		((CPM_INTERRUPT/2) << 13) | CICR_HP_MASK;
-	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr = 0;
+		((CPM_INTERRUPT/2) << 13) | CICR_HP_MASK);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr, 0);
 
         /* install the CPM interrupt controller routines for the CPM
          * interrupt vectors
@@ -198,7 +198,7 @@ cpm_interrupt_init(void)
 	if (setup_irq(CPM_IRQ_OFFSET + CPMVEC_ERROR, &cpm_error_irqaction))
 		panic("Could not allocate CPM error IRQ!");
 
-	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr |= CICR_IEN;
+	st_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr, ld_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr) | CICR_IEN);
 }
 
 /*
@@ -212,8 +212,8 @@ cpm_get_irq(struct pt_regs *regs)
 	/* Get the vector by setting the ACK bit and then reading
 	 * the register.
 	 */
-	((volatile immap_t *)IMAP_ADDR)->im_cpic.cpic_civr = 1;
-	cpm_vec = ((volatile immap_t *)IMAP_ADDR)->im_cpic.cpic_civr;
+	st_be16(&((volatile immap_t *)IMAP_ADDR)->im_cpic.cpic_civr, 1);
+	cpm_vec = ld_be16(&((volatile immap_t *)IMAP_ADDR)->im_cpic.cpic_civr);
 	cpm_vec >>= 11;
 
 	return cpm_vec;
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -144,12 +144,12 @@ void __init m8xx_calibrate_decr(void)
 	int freq, fp, divisor;
 
 	/* Unlock the SCCR. */
-	((volatile immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk = KAPWR_KEY;
+	st_be32(&((immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk, ~KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk, KAPWR_KEY);
 
 	/* Force all 8xx processors to use divide by 16 processor clock. */
-	((volatile immap_t *)IMAP_ADDR)->im_clkrst.car_sccr |= 0x02000000;
-
+	st_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_sccr, 
+		ld_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_sccr)|0x02000000);
 	/* Processor frequency is MHz.
 	 * The value 'fp' is the number of decrementer ticks per second.
 	 */
@@ -175,28 +175,24 @@ void __init m8xx_calibrate_decr(void)
 	 * we guarantee the registers are locked, then we unlock them
 	 * for our use.
 	 */
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk    = ~KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk =  KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck =  KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk    =  KAPWR_KEY;
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk, ~KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck, ~KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk, ~KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_tbscrk, KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck, KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk, KAPWR_KEY);
 
 	/* Disable the RTC one second and alarm interrupts. */
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc &=
-						~(RTCSC_SIE | RTCSC_ALE);
+	st_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, ld_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc) & ~(RTCSC_SIE | RTCSC_ALE));
 	/* Enable the RTC */
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc |=
-						(RTCSC_RTF | RTCSC_RTE);
+	st_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, ld_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc) | (RTCSC_RTF | RTCSC_RTE));
 
 	/* Enabling the decrementer also enables the timebase interrupts
 	 * (or from the other point of view, to get decrementer interrupts
 	 * we have to enable the timebase).  The decrementer interrupt
 	 * is wired into the vector table, nothing to do here for that.
 	 */
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_tbscr =
-				((mk_int_int_mask(DEC_INTERRUPT) << 8) |
-					 (TBSCR_TBF | TBSCR_TBE));
+	st_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_tbscr, (mk_int_int_mask(DEC_INTERRUPT) << 8) | (TBSCR_TBF | TBSCR_TBE));
 
 	if (setup_irq(DEC_INTERRUPT, &tbint_irqaction))
 		panic("Could not allocate timer IRQ!");
@@ -216,9 +212,9 @@ void __init m8xx_calibrate_decr(void)
 static int
 m8xx_set_rtc_time(unsigned long time)
 {
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = KAPWR_KEY;
-	((volatile immap_t *)IMAP_ADDR)->im_sit.sit_rtc = time;
-	((volatile immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck = ~KAPWR_KEY;
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck, KAPWR_KEY);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtc, time);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_rtck, ~KAPWR_KEY);
 	return(0);
 }
 
@@ -226,7 +222,7 @@ static unsigned long
 m8xx_get_rtc_time(void)
 {
 	/* Get time from the RTC. */
-	return((unsigned long)(((immap_t *)IMAP_ADDR)->im_sit.sit_rtc));
+	return (unsigned long) ld_be32(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtc);
 }
 
 static void
@@ -235,13 +231,13 @@ m8xx_restart(char *cmd)
 	__volatile__ unsigned char dummy;
 
 	local_irq_disable();
-	((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr |= 0x00000080;
+	st_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr, ld_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr) | 0x00000080);
 
 	/* Clear the ME bit in MSR to cause checkstop on machine check
 	*/
 	mtmsr(mfmsr() & ~0x1000);
 
-	dummy = ((immap_t *)IMAP_ADDR)->im_clkrst.res[0];
+	dummy = ld_be8(&((immap_t *)IMAP_ADDR)->im_clkrst.res[0]);
 	printk("Restart failed\n");
 	while(1);
 }
@@ -306,8 +302,7 @@ m8xx_init_IRQ(void)
 	i8259_init(0);
 
 	/* The i8259 cascade interrupt must be level sensitive. */
-	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel &=
-		~(0x80000000 >> ISA_BRIDGE_INT);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel, ld_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel & ~(0x80000000 >> ISA_BRIDGE_INT)));
 
 	if (setup_irq(ISA_BRIDGE_INT, &mbx_i8259_irqaction))
 		enable_irq(ISA_BRIDGE_INT);
diff --git a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
--- a/arch/ppc/syslib/m8xx_wdt.c
+++ b/arch/ppc/syslib/m8xx_wdt.c
@@ -29,8 +29,8 @@ void m8xx_wdt_reset(void)
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
-	imap->im_siu_conf.sc_swsr = 0x556c;	/* write magic1 */
-	imap->im_siu_conf.sc_swsr = 0xaa39;	/* write magic2 */
+	st_be16(imap->im_siu_conf.sc_swsr, 0x556c);	/* write magic1 */
+	st_be16(imap->im_siu_conf.sc_swsr, 0xaa39);	/* write magic2 */
 }
 
 static irqreturn_t m8xx_wdt_interrupt(int irq, void *dev, struct pt_regs *regs)
@@ -39,7 +39,7 @@ static irqreturn_t m8xx_wdt_interrupt(in
 
 	m8xx_wdt_reset();
 
-	imap->im_sit.sit_piscr |= PISCR_PS;	/* clear irq */
+	st_be16(imap->im_sit.sit_piscr, ld_be16(imap->im_sit.sit_piscr | PISCR_PS));	/* clear irq */
 
 	return IRQ_HANDLED;
 }
@@ -51,7 +51,7 @@ void __init m8xx_wdt_handler_install(bd_
 	u32 sypcr;
 	u32 pitrtclk;
 
-	sypcr = imap->im_siu_conf.sc_sypcr;
+	sypcr = ld_be32(imap->im_siu_conf.sc_sypcr);
 
 	if (!(sypcr & 0x04)) {
 		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
@@ -87,9 +87,9 @@ void __init m8xx_wdt_handler_install(bd_
 	else
 		pitc = pitrtclk * wdt_timeout / binfo->bi_intfreq / 2;
 
-	imap->im_sit.sit_pitc = pitc << 16;
-	imap->im_sit.sit_piscr =
-	    (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE;
+	st_be32(imap->im_sit.sit_pitc, pitc << 16);
+
+	st_be16(imap->im_sit.sit_piscr, (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE);
 
 	if (setup_irq(PIT_INTERRUPT, &m8xx_wdt_irqaction))
 		panic("m8xx_wdt: error setting up the watchdog irq!");
diff --git a/arch/ppc/syslib/ppc8xx_pic.c b/arch/ppc/syslib/ppc8xx_pic.c
--- a/arch/ppc/syslib/ppc8xx_pic.c
+++ b/arch/ppc/syslib/ppc8xx_pic.c
@@ -29,8 +29,7 @@ static void m8xx_mask_irq(unsigned int i
 	word = irq_nr >> 5;
 
 	ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
-	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask =
-						ppc_cached_irq_mask[word];
+	st_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, ppc_cached_irq_mask[word]);
 }
 
 static void m8xx_unmask_irq(unsigned int irq_nr)
@@ -41,8 +40,7 @@ static void m8xx_unmask_irq(unsigned int
 	word = irq_nr >> 5;
 
 	ppc_cached_irq_mask[word] |= (1 << (31-bit));
-	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask =
-						ppc_cached_irq_mask[word];
+	st_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, ppc_cached_irq_mask[word]);
 }
 
 static void m8xx_end_irq(unsigned int irq_nr)
@@ -55,8 +53,7 @@ static void m8xx_end_irq(unsigned int ir
 		word = irq_nr >> 5;
 
 		ppc_cached_irq_mask[word] |= (1 << (31-bit));
-		((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask =
-			ppc_cached_irq_mask[word];
+		st_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, ppc_cached_irq_mask[word]);
 	}
 }
 
@@ -69,9 +66,8 @@ static void m8xx_mask_and_ack(unsigned i
 	word = irq_nr >> 5;
 
 	ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
-	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask =
-						ppc_cached_irq_mask[word];
-	((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sipend = 1 << (31-bit);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask, ppc_cached_irq_mask[word]);
+	st_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sipend, 1 << (31-bit));
 }
 
 struct hw_interrupt_type ppc8xx_pic = {
@@ -93,7 +89,7 @@ m8xx_get_irq(struct pt_regs *regs)
 	/* For MPC8xx, read the SIVEC register and shift the bits down
 	 * to get the irq number.
 	 */
-	irq = ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sivec >> 26;
+	irq = ld_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sivec) >> 26;
 
 	/*
 	 * When we read the sivec without an interrupt to process, we will
diff --git a/include/asm-ppc/byteorder.h b/include/asm-ppc/byteorder.h
--- a/include/asm-ppc/byteorder.h
+++ b/include/asm-ppc/byteorder.h
@@ -7,6 +7,48 @@
 #ifdef __GNUC__
 #ifdef __KERNEL__
 
+/* big endian */
+extern __inline__ unsigned ld_be8(const volatile unsigned char *addr)
+{
+	unsigned val;
+
+	__asm__ __volatile__ ("lbz %0,0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+extern __inline__ void st_be8(volatile unsigned char *addr, const unsigned val)
+{
+	__asm__ __volatile__ ("stb %1,0(%2)" : "=m" (*addr) : "r" (val), "r" (addr));
+}
+
+extern __inline__ unsigned ld_be16(const volatile unsigned short *addr)
+{
+	unsigned val;
+
+	__asm__ __volatile__ ("lhz %0,0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+extern __inline__ void st_be16(volatile unsigned short *addr, const unsigned val)
+{
+	__asm__ __volatile__ ("sth %1,0(%2)" : "=m" (*addr) : "r" (val), "r" (addr));
+}
+
+extern __inline__ unsigned ld_be32(const volatile unsigned *addr)
+{
+	unsigned val;
+
+	__asm__ __volatile__ ("lwz %0,0(%1)" : "=r" (val) : "r" (addr));
+	return val;
+}
+
+extern __inline__ void st_be32(volatile unsigned *addr, const unsigned val)
+{
+	__asm__ __volatile__ ("stw %1,0(%2)" : "=m" (*addr) : "r" (val), "r" (addr));
+}
+
+/* little endian (reversed) */
+
 extern __inline__ unsigned ld_le16(const volatile unsigned short *addr)
 {
 	unsigned val;
