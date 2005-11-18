Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AD18B6872B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 07:56:58 +1100 (EST)
Date: Fri, 18 Nov 2005 13:36:57 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Florian Schirmer <jolt@tuxbox.org>, Dan Malek <dan@embeddededge.com>
Message-ID: <20051118153657.GA13943@logos.cnet>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
	<20051115054216.GB29963@logos.cnet>
	<20051115142147.GD32373@logos.cnet> <437B1C53.1060004@tuxbox.org>
	<20051116083609.GC4441@logos.cnet> <437C499C.6090002@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437C499C.6090002@tuxbox.org>
Cc: obi@saftware.de, carjay@gmx.de,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] m8xx_wdt: software watchdog reset/interrupt select
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2005 at 10:13:00AM +0100, Florian Schirmer wrote:
> Hi,
> 
> okay here is what the current driver does:
> 
> During startup it installs a timer irq (PIT) handler and sets the 
> frequency to half of the watchdog timeout. As soon as this timer irq 
> triggers we reset the watchdog inside the irq handler.
> 
> If a userspace handler takes over the watchdog we deinstall the timer 
> irq handler and let the userspace daemon handle the watchdog resets.
> 
> Please not that we're talking about the timer irq, not the watchdog 
> interrupt.
> 
> I don't see why it should make a difference wether the watchdog 
> generates a IRQ0/HRESET or a system reset directly since it should never 
> trigger anyway.
> 
> All the patch does is to use a kernel timer instead of the hardware 
> timer. So i'm little confused.

Florian,

After your message I decided to check if the PIT is working, guess what: it isnt.

Our board uses an external RTC (the internal RTC/PIT HW seem to be
nonexistant/nonfunctional).

I've changed the m8xx_wdt code to deal with that situation by checking
the RTC enable bit of RTCSC as follows:

m8xx_has_internal_rtc = in_be16(&imap->im_sit.sit_rtcsc) & RTCSC_RTE;

Problem with it is that the kernel sets the RTCSC_RTE bit
unconditionally in m8xx_calibrate_decr(), so you can't really know its
original value. The following patch changes m8xx_calibrate_decr()'s
RTC initialization to a weak function which can be overriden by board
specific code.

Dan, can you think of any nicer to avoid m8xx_calibrate_decr() from 
overwriting RTCSC?

diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
index 1cc3abe..688616d 100644
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -135,6 +135,16 @@ static struct irqaction tbint_irqaction 
 	.name = "tbint",
 };
 
+/* per-board overridable init_internal_rtc() function. */
+void __init __attribute__ ((weak))
+init_internal_rtc(void)
+{
+	/* Disable the RTC one second and alarm interrupts. */
+	out_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, in_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc) & ~(RTCSC_SIE | RTCSC_ALE));
+	/* Enable the RTC */
+	out_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, in_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc) | (RTCSC_RTF | RTCSC_RTE));
+}
+
 /* The decrementer counts at the system (internal) clock frequency divided by
  * sixteen, or external oscillator divided by four.  We force the processor
  * to use system clock divided by sixteen.
@@ -183,10 +193,7 @@ void __init m8xx_calibrate_decr(void)
 	out_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_rtcsck, KAPWR_KEY);
 	out_be32(&((immap_t *)IMAP_ADDR)->im_sitk.sitk_tbk, KAPWR_KEY);
 
-	/* Disable the RTC one second and alarm interrupts. */
-	out_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, in_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc) & ~(RTCSC_SIE | RTCSC_ALE));
-	/* Enable the RTC */
-	out_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc, in_be16(&((immap_t *)IMAP_ADDR)->im_sit.sit_rtcsc) | (RTCSC_RTF | RTCSC_RTE));
+	init_internal_rtc();
 
 	/* Enabling the decrementer also enables the timebase interrupts
 	 * (or from the other point of view, to get decrementer interrupts
diff --git a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
index a21632d..df6c955 100644
--- a/arch/ppc/syslib/m8xx_wdt.c
+++ b/arch/ppc/syslib/m8xx_wdt.c
@@ -19,6 +19,7 @@
 #include <syslib/m8xx_wdt.h>
 
 static int wdt_timeout;
+int m8xx_has_internal_rtc = 0;
 
 static irqreturn_t m8xx_wdt_interrupt(int, void *, struct pt_regs *);
 static struct irqaction m8xx_wdt_irqaction = {
@@ -45,35 +46,15 @@ static irqreturn_t m8xx_wdt_interrupt(in
 	return IRQ_HANDLED;
 }
 
-void __init m8xx_wdt_handler_install(bd_t * binfo)
+#define SYPCR_SWP 0x1
+#define SYPCR_SWE 0x4
+
+
+void __init m8xx_wdt_install_irq(volatile immap_t *imap, bd_t *binfo)
 {
-	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 	u32 pitc;
-	u32 sypcr;
 	u32 pitrtclk;
 
-	sypcr = in_be32(&imap->im_siu_conf.sc_sypcr);
-
-	if (!(sypcr & 0x04)) {
-		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
-		       sypcr);
-		return;
-	}
-
-	m8xx_wdt_reset();
-
-	printk(KERN_NOTICE
-	       "m8xx_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
-	       (sypcr >> 16), sypcr & 0x01);
-
-	wdt_timeout = (sypcr >> 16) & 0xFFFF;
-
-	if (!wdt_timeout)
-		wdt_timeout = 0xFFFF;
-
-	if (sypcr & 0x01)
-		wdt_timeout *= 2048;
-
 	/*
 	 * Fire trigger if half of the wdt ticked down 
 	 */
@@ -98,6 +79,67 @@ void __init m8xx_wdt_handler_install(bd_
 	printk(KERN_NOTICE
 	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n", pitc);
 
+}
+
+static void m8xx_wdt_timer_func(unsigned long data);
+
+static struct timer_list m8xx_wdt_timer =
+	TIMER_INITIALIZER(m8xx_wdt_timer_func, 0, 0);
+
+void m8xx_wdt_stop_timer(void)
+{
+	del_timer(&m8xx_wdt_timer);
+}
+
+void m8xx_wdt_install_timer(void)
+{
+	m8xx_wdt_timer.expires = jiffies + (HZ/2);
+	add_timer(&m8xx_wdt_timer);
+}
+
+static void m8xx_wdt_timer_func(unsigned long data)
+{
+	m8xx_wdt_reset();
+	m8xx_wdt_install_timer();
+}
+
+void __init m8xx_wdt_handler_install(bd_t * binfo)
+{
+	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
+	u32 sypcr;
+
+	sypcr = in_be32(&imap->im_siu_conf.sc_sypcr);
+
+	if (!(sypcr & SYPCR_SWE)) {
+		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
+		       sypcr);
+		return;
+	}
+
+	m8xx_wdt_reset();
+
+	printk(KERN_NOTICE
+	       "m8xx_wdt: active wdt found (SWTC: 0x%04X, SWP: 0x%01X)\n",
+	       (sypcr >> 16), sypcr & SYPCR_SWP);
+
+	wdt_timeout = (sypcr >> 16) & 0xFFFF;
+
+	if (!wdt_timeout)
+		wdt_timeout = 0xFFFF;
+
+	if (sypcr & SYPCR_SWP)
+		wdt_timeout *= 2048;
+
+	m8xx_has_internal_rtc = in_be16(&imap->im_sit.sit_rtcsc) & RTCSC_RTE;
+
+	/* if the internal RTC is off use a kernel timer */
+	if (!m8xx_has_internal_rtc) {
+		if (wdt_timeout < (binfo->bi_intfreq/HZ))
+			printk(KERN_ERR "m8xx_wdt: timeout too short for ktimer!\n");
+		m8xx_wdt_install_timer();
+	} else
+		m8xx_wdt_install_irq(imap, binfo);
+
 	wdt_timeout /= binfo->bi_intfreq;
 }
 
diff --git a/arch/ppc/syslib/m8xx_wdt.h b/arch/ppc/syslib/m8xx_wdt.h
index 0d81a9f..e75835f 100644
--- a/arch/ppc/syslib/m8xx_wdt.h
+++ b/arch/ppc/syslib/m8xx_wdt.h
@@ -9,8 +9,12 @@
 #ifndef _PPC_SYSLIB_M8XX_WDT_H
 #define _PPC_SYSLIB_M8XX_WDT_H
 
+extern int m8xx_has_internal_rtc;
+
 extern void m8xx_wdt_handler_install(bd_t * binfo);
 extern int m8xx_wdt_get_timeout(void);
 extern void m8xx_wdt_reset(void);
+extern void m8xx_wdt_install_timer(void);
+extern void m8xx_wdt_stop_timer(void);
 
 #endif				/* _PPC_SYSLIB_M8XX_WDT_H */
diff --git a/drivers/char/watchdog/mpc8xx_wdt.c b/drivers/char/watchdog/mpc8xx_wdt.c
index 56d62ba..ac6fbac 100644
--- a/drivers/char/watchdog/mpc8xx_wdt.c
+++ b/drivers/char/watchdog/mpc8xx_wdt.c
@@ -27,7 +27,10 @@ static void mpc8xx_wdt_handler_disable(v
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
-	imap->im_sit.sit_piscr &= ~(PISCR_PIE | PISCR_PTE);
+	if (!m8xx_has_internal_rtc)
+		m8xx_wdt_stop_timer();
+	else
+		out_be32(imap->im_sit.sit_piscr, in_be32(&imap->im_sit.sit_piscr) & ~(PISCR_PIE | PISCR_PTE));
 
 	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler deactivated\n");
 }
@@ -36,7 +39,10 @@ static void mpc8xx_wdt_handler_enable(vo
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
-	imap->im_sit.sit_piscr |= PISCR_PIE | PISCR_PTE;
+	if (!m8xx_has_internal_rtc)
+		m8xx_wdt_install_timer();
+	else
+		out_be32(&imap->im_sit.sit_piscr, in_be32(&imap->im_sit.sit_piscr) | PISCR_PIE | PISCR_PTE);
 
 	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler activated\n");
 }
@@ -68,9 +74,6 @@ static int mpc8xx_wdt_release(struct ino
 static ssize_t mpc8xx_wdt_write(struct file *file, const char *data, size_t len,
 				loff_t * ppos)
 {
-	if (ppos != &file->f_pos)
-		return -ESPIPE;
-
 	if (len)
 		m8xx_wdt_reset();
 
