Return-Path: <carjay@gmx.net>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.176]) by ozlabs.org (Postfix) with ESMTP id 31C8F67A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 17:50:13 +1100 (EST)
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CzU6e-0000kC-00
	for linuxppc-embedded@ozlabs.org; Fri, 11 Feb 2005 07:16:44 +0100
Received: from [80.133.47.118] (helo=[192.168.99.1])
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1) id 1CzU6d-0007B0-00
	for linuxppc-embedded@ozlabs.org; Fri, 11 Feb 2005 07:16:44 +0100
Message-ID: <420C4DCB.6030104@gmx.net>
Date: Fri, 11 Feb 2005 07:16:43 +0100
From: Carsten Juttner <carjay@gmx.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="------------070001000801060006010403"
Subject: Patch for 8xx watchdog handler for >=2.6.10
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
--------------070001000801060006010403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

our mpc 823 based embedded board (STB, dbox2) would hang with every 
kernel starting from 2.6.10-rc1_linuxppc. I tracked the problem down to 
the watchdog interrupt handler setup and the new generic interrupt 
handling routines (which caused an uninitialized pointer because kmalloc 
was used before the kmem_cache was initialized).

As said, this was only an issue if CONFIG_8xx_WDT was set.

I have attached a simple patch for the handler.

Regards,
Carsten Juttner


--------------070001000801060006010403
Content-Type: text/x-patch;
 name="m8xx_wdt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="m8xx_wdt.diff"

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
@@ -18,6 +19,14 @@
 
 static int wdt_timeout;
 
+static irqreturn_t m8xx_wdt_interrupt(int, void *, struct pt_regs *);
+static struct irqaction m8xx_wdt_irqaction = {
+    .handler = m8xx_wdt_interrupt,
+    .flags = 0,
+    .name = "watchdog",
+    .dev_id = NULL
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

--------------070001000801060006010403--
