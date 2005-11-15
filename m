Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB7DD68748
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 06:33:40 +1100 (EST)
Date: Tue, 15 Nov 2005 12:21:47 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Florian Schirmer <jolt@tuxbox.org>
Message-ID: <20051115142147.GD32373@logos.cnet>
References: <20051114143821.GA28852@logos.cnet> <43798327.70305@tuxbox.org>
	<20051115054216.GB29963@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051115054216.GB29963@logos.cnet>
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

On Tue, Nov 15, 2005 at 03:42:16AM -0200, Marcelo Tosatti wrote:
> Hi Florian!
> 
> On Tue, Nov 15, 2005 at 07:41:43AM +0100, Florian Schirmer wrote:
> > Hi,
> > 
> > >Note: From my reading of the documentation, even if the SWRI bit is
> > >unset (interrupt select mode), an NMI at IRQ0 should cause the system to
> > >jump to exception vector 0x100, resetting the system.
> > >
> > >So I'm wondering if the interrupt mode ever worked?
> > 
> > Never tried the interrupt mode. IMHO doesn't make much sense for a 
> > watchdog. Why don't you simply set SWRI?
> 
> The SYPCR register can be set only _once_ at machine startup and the
> bootloader in question does not have an option to change the mode. Many
> bootloaders probably dont.
> 
> > >+static void m8xx_wdt_timer_func(unsigned long data)
> > >+{
> > >+	m8xx_wdt_reset();
> > >+	m8xx_wdt_timer.expires = jiffies + 25;
> > >+	add_timer(&m8xx_wdt_timer);
> > >+}
> > >+
> > >+void m8xx_wdt_install_timer(volatile immap_t *imap)
> > >+{
> > >+	m8xx_wdt_timer.expires = jiffies + 25;
> > >+	add_timer(&m8xx_wdt_timer);
> > >+}
> > 
> > m8xx_wdt_install_timer doesn't need imap and you could call it from 
> > m8xx_wdt_timer_func to re-engange the timer resulting in less duplicated 
> > code. Just a cosmetic thing though.
> 
> Indeed. Will update the patch and resend you for review.

Florian,

Updated patch addresses code duplication issue you mentioned and also 
adds an error message in case timer interrupt frequency is higher
than the watchdog frequency.

Can I add your Signed-off-by in case you're OK with it?


diff --git a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
index a21632d..d73f8db 100644
--- a/arch/ppc/syslib/m8xx_wdt.c
+++ b/arch/ppc/syslib/m8xx_wdt.c
@@ -45,35 +45,18 @@ static irqreturn_t m8xx_wdt_interrupt(in
 	return IRQ_HANDLED;
 }
 
-void __init m8xx_wdt_handler_install(bd_t * binfo)
+#define SYPCR_SWP 0x1
+#define SYPCR_SWRI 0x2
+#define SYPCR_SWE 0x4
+
+/* software watchdog reset/interrupt select */
+int m8xx_wdt_keepalive_mode = 0;
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
@@ -98,6 +81,65 @@ void __init m8xx_wdt_handler_install(bd_
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
+	m8xx_wdt_keepalive_mode = sypcr & SYPCR_SWRI;
+	if (m8xx_wdt_keepalive_mode) {
+		if (wdt_timeout < (binfo->bi_intfreq/HZ))
+			printk(KERN_ERR "m8xx_wdt: timeout too short for ktimer!\n");
+		m8xx_wdt_install_timer();
+	} else
+		m8xx_wdt_install_irq(imap, binfo);
+
 	wdt_timeout /= binfo->bi_intfreq;
 }
 
diff --git a/arch/ppc/syslib/m8xx_wdt.h b/arch/ppc/syslib/m8xx_wdt.h
index 0d81a9f..c9ee9d7 100644
--- a/arch/ppc/syslib/m8xx_wdt.h
+++ b/arch/ppc/syslib/m8xx_wdt.h
@@ -9,8 +9,12 @@
 #ifndef _PPC_SYSLIB_M8XX_WDT_H
 #define _PPC_SYSLIB_M8XX_WDT_H
 
+extern int m8xx_wdt_keepalive_mode;
+
 extern void m8xx_wdt_handler_install(bd_t * binfo);
 extern int m8xx_wdt_get_timeout(void);
 extern void m8xx_wdt_reset(void);
+extern void m8xx_wdt_install_timer(void);
+extern void m8xx_wdt_stop_timer(void);
 
 #endif				/* _PPC_SYSLIB_M8XX_WDT_H */
diff --git a/drivers/char/watchdog/mpc8xx_wdt.c b/drivers/char/watchdog/mpc8xx_wdt.c
index 56d62ba..8ffa744 100644
--- a/drivers/char/watchdog/mpc8xx_wdt.c
+++ b/drivers/char/watchdog/mpc8xx_wdt.c
@@ -27,7 +27,10 @@ static void mpc8xx_wdt_handler_disable(v
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
-	imap->im_sit.sit_piscr &= ~(PISCR_PIE | PISCR_PTE);
+	if (m8xx_wdt_keepalive_mode)
+		m8xx_wdt_stop_timer();
+	else
+		imap->im_sit.sit_piscr &= ~(PISCR_PIE | PISCR_PTE);
 
 	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler deactivated\n");
 }
@@ -36,7 +39,10 @@ static void mpc8xx_wdt_handler_enable(vo
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
-	imap->im_sit.sit_piscr |= PISCR_PIE | PISCR_PTE;
+	if (m8xx_wdt_keepalive_mode)
+		m8xx_wdt_install_timer();
+	else
+		imap->im_sit.sit_piscr |= PISCR_PIE | PISCR_PTE;
 
 	printk(KERN_NOTICE "mpc8xx_wdt: keep-alive handler activated\n");
 }
