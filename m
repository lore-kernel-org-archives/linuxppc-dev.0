Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id D7A7E68813
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2005 02:41:21 +1100 (EST)
Message-ID: <438B238F.9070804@ru.mvista.com>
Date: Mon, 28 Nov 2005 18:34:39 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-devel list <linuxppc-dev@ozlabs.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: Added setbitsXX/clrbitsXX macro for
 read-modify-write operations
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds setbitsXX/clrbitsXX macro for read-modify-write operations
and converts the 8xx core and drivers to use it.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


---

  arch/ppc/8xx_io/commproc.c   |    6 +++---
  arch/ppc/syslib/m8xx_setup.c |   12 +++++-------
  arch/ppc/syslib/m8xx_wdt.c   |    3 +--
  include/asm-ppc/io.h         |    7 +++++++
  4 files changed, 16 insertions(+), 12 deletions(-)

applies-to: d2cd86c706af9e6ad47e2dda6b24df0d93f6f98f
055cb7782e10f214243c31522229173660cb24bc
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 579cd40..5cecb6e 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -73,7 +73,7 @@ cpm_mask_irq(unsigned int irq)
  {
  	int cpm_vec = irq - CPM_IRQ_OFFSET;

-	out_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr, in_be32(&((immap_t 
*)IMAP_ADDR)->im_cpic.cpic_cimr) & ~(1 << cpm_vec));
+	clrbits32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr,(1 << cpm_vec));
  }

  static void
@@ -81,7 +81,7 @@ cpm_unmask_irq(unsigned int irq)
  {
  	int cpm_vec = irq - CPM_IRQ_OFFSET;

-	out_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr, in_be32(&((immap_t 
*)IMAP_ADDR)->im_cpic.cpic_cimr) | (1 << cpm_vec));
+	setbits32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr,(1 << cpm_vec));
  }

  static void
@@ -198,7 +198,7 @@ cpm_interrupt_init(void)
  	if (setup_irq(CPM_IRQ_OFFSET + CPMVEC_ERROR, &cpm_error_irqaction))
  		panic("Could not allocate CPM error IRQ!");

-	out_be32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr, in_be32(&((immap_t 
*)IMAP_ADDR)->im_cpic.cpic_cicr) | CICR_IEN);
+	setbits32(&((immap_t *)IMAP_ADDR)->im_cpic.cpic_cicr, CICR_IEN);
  }

  /*
diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index 1cc3abe..ad7db45 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -149,8 +149,7 @@ void __init m8xx_calibrate_decr(void)
  	out_be32(&((immap_t *)IMAP_ADDR)->im_clkrstk.cark_sccrk, KAPWR_KEY);

  	/* Force all 8xx processors to use divide by 16 processor clock. */
-	out_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_sccr,
-		in_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_sccr)|0x02000000);
+	setbits32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_sccr, 0x02000000);
  	/* Processor frequency is MHz.
  	 * The value 'fp' is the number of decrementer ticks per second.
  	 */
@@ -184,10 +183,9 @@ void __init m8xx_calibrate_decr(void)
  	out_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk, KAPWR_KEY);

  	/* Disable the RTC one second and alarm interrupts. */
-	out_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, in_be16(&((immap_t 
*)IMAP_ADDR)->im_sit.sit_rtcsc) & ~(RTCSC_SIE | RTCSC_ALE));
+	clrbits16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, (RTCSC_SIE | RTCSC_ALE));
  	/* Enable the RTC */
-	out_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, in_be16(&((immap_t 
*)IMAP_ADDR)->im_sit.sit_rtcsc) | (RTCSC_RTF | RTCSC_RTE));
-
+	setbits16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, (RTCSC_RTF | RTCSC_RTE));
  	/* Enabling the decrementer also enables the timebase interrupts
  	 * (or from the other point of view, to get decrementer interrupts
  	 * we have to enable the timebase).  The decrementer interrupt
@@ -232,8 +230,8 @@ m8xx_restart(char *cmd)
  	__volatile__ unsigned char dummy;

  	local_irq_disable();
-	out_be32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr, in_be32(&((immap_t 
*)IMAP_ADDR)->im_clkrst.car_plprcr) | 0x00000080);

+	setbits32(&((immap_t *)IMAP_ADDR)->im_clkrst.car_plprcr, 0x00000080);
  	/* Clear the ME bit in MSR to cause checkstop on machine check
  	*/
  	mtmsr(mfmsr() & ~0x1000);
@@ -303,8 +301,8 @@ m8xx_init_IRQ(void)
  	i8259_init(0);

  	/* The i8259 cascade interrupt must be level sensitive. */
-	out_be32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel, in_be32(&((immap_t 
*)IMAP_ADDR)->im_siu_conf.sc_siel & ~(0x80000000 >> ISA_BRIDGE_INT)));

+	clrbits32(&((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel, (0x80000000 >> ISA_BRIDGE_INT));
  	if (setup_irq(ISA_BRIDGE_INT, &mbx_i8259_irqaction))
  		enable_irq(ISA_BRIDGE_INT);
  #endif	/* CONFIG_PCI */
diff --git a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
index a21632d..57f8b9f 100644
--- a/arch/ppc/syslib/m8xx_wdt.c
+++ b/arch/ppc/syslib/m8xx_wdt.c
@@ -40,8 +40,7 @@ static irqreturn_t m8xx_wdt_interrupt(in

  	m8xx_wdt_reset();

-	out_be16(&imap->im_sit.sit_piscr, in_be16(&imap->im_sit.sit_piscr) | PISCR_PS);	/* clear 
irq */
-
+	setbits16(&imap->im_sit.sit_piscr, PISCR_PS);
  	return IRQ_HANDLED;
  }

diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 2bfdf9c..0ff4395 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -556,4 +556,11 @@ extern void pci_iounmap(struct pci_dev *
   */
  #define xlate_dev_kmem_ptr(p)	p

+/* access ports */
+#define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
+#define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16((_addr), in_be16(_addr) |  (_v))
+#define clrbits16(_addr, _v) out_be16((_addr), in_be16(_addr) & ~(_v))
+
  #endif /* __KERNEL__ */
---
Sincerely,
Vitaly
