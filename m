Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id B73FD67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 04:37:53 +1000 (EST)
Date: Wed, 6 Apr 2005 11:37:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-embedded@ozlabs.org
Message-ID: <20050406183750.GD3396@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carsten Juttner <carjay@gmx.net>
Subject: [PATCH 2.6.12-rc1] ppc32: Fix mpc8xx watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The CONFIG_8xx_WDT option got broken in the generic hardirq update as
ppc32 had its own different request_irq that worked when other arches
used setup_irq.  This is the trivial fix for the problem.

From: Carsten Juttner <carjay@gmx.net>
Signed-off-by: Tom Rini <trini@kernel.crashing.org>

diff -Nru a/arch/ppc/syslib/m8xx_wdt.c b/arch/ppc/syslib/m8xx_wdt.c
--- a/arch/ppc/syslib/m8xx_wdt.c	2005-02-11 07:08:20 +01:00
+++ b/arch/ppc/syslib/m8xx_wdt.c	2005-02-11 07:08:20 +01:00
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <asm/8xx_immap.h>
@@ -18,6 +19,12 @@
 
 static int wdt_timeout;
 
+static irqreturn_t m8xx_wdt_interrupt(int, void *, struct pt_regs *);
+static struct irqaction m8xx_wdt_irqaction = {
+	.handler = m8xx_wdt_interrupt,
+	.name = "watchdog",
+};
+
 void m8xx_wdt_reset(void)
 {
 	volatile immap_t *imap = (volatile immap_t *)IMAP_ADDR;
@@ -84,8 +93,8 @@
 	imap->im_sit.sit_piscr =
 	    (mk_int_int_mask(PIT_INTERRUPT) << 8) | PISCR_PIE | PISCR_PTE;
 
-	if (request_irq(PIT_INTERRUPT, m8xx_wdt_interrupt, 0, "watchdog", NULL))
-		panic("m8xx_wdt: could not allocate watchdog irq!");
+	if (setup_irq(PIT_INTERRUPT, &m8xx_wdt_irqaction))
+		panic("m8xx_wdt: error setting up the watchdog irq!");
 
 	printk(KERN_NOTICE
 	       "m8xx_wdt: keep-alive trigger installed (PITC: 0x%04X)\n", pitc);

-- 
Tom Rini
http://gate.crashing.org/~trini/
