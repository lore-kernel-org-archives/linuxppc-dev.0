Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CA216869D
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Nov 2005 06:59:04 +1100 (EST)
Date: Sat, 5 Nov 2005 13:01:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051105150116.GA6577@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: fix m8xx_wdt acessor macro update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Paul,

The following patch against m8xx_wdt.c adds <asm/io.h> (required for
out,in_be32/16) and fixes syntatic problems introduced with the IO
accessor macro update.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

--- ../git/linux-2.6/arch/ppc/syslib/m8xx_wdt.c	2005-11-01 07:58:12.000000000 -0600
+++ linux-2.6-git-wednov02/arch/ppc/syslib/m8xx_wdt.c	2005-11-05 13:14:53.545580928 -0600
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <asm/io.h>
 #include <asm/8xx_immap.h>
 #include <syslib/m8xx_wdt.h>
 
@@ -29,8 +30,8 @@
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
 
-	out_be16(imap->im_siu_conf.sc_swsr, 0x556c);	/* write magic1 */
-	out_be16(imap->im_siu_conf.sc_swsr, 0xaa39);	/* write magic2 */
+	out_be16(&imap->im_siu_conf.sc_swsr, 0x556c);	/* write magic1 */
+	out_be16(&imap->im_siu_conf.sc_swsr, 0xaa39);	/* write magic2 */
 }
 
 static irqreturn_t m8xx_wdt_interrupt(int irq, void *dev, struct pt_regs *regs)
@@ -39,7 +40,7 @@
 
 	m8xx_wdt_reset();
 
-	out_be16(imap->im_sit.sit_piscr, in_be16(imap->im_sit.sit_piscr | PISCR_PS));	/* clear irq */
+	out_be16(&imap->im_sit.sit_piscr, in_be16(&imap->im_sit.sit_piscr) | PISCR_PS);	/* clear irq */
 
 	return IRQ_HANDLED;
 }
@@ -51,7 +52,7 @@
 	u32 sypcr;
 	u32 pitrtclk;
 
-	sypcr = in_be32(imap->im_siu_conf.sc_sypcr);
+	sypcr = in_be32(&imap->im_siu_conf.sc_sypcr);
 
 	if (!(sypcr & 0x04)) {
 		printk(KERN_NOTICE "m8xx_wdt: wdt disabled (SYPCR: 0x%08X)\n",
@@ -87,9 +88,9 @@
 	else
 		pitc = pitrtclk * wdt_timeout / binfo->bi_intfreq / 2;
 
-	out_be32(imap->im_sit.sit_pitc, pitc << 16);
+	out_be32(&imap->im_sit.sit_pitc, pitc << 16);
 
-	out_be16(imap->im_sit.sit_piscr, (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE);
+	out_be16(&imap->im_sit.sit_piscr, (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE);
 
 	if (setup_irq(PIT_INTERRUPT, &m8xx_wdt_irqaction))
 		panic("m8xx_wdt: error setting up the watchdog irq!");
