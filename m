Return-Path: <qboosh@pld-linux.org>
Received: from cne142.neoplus.adsl.tpnet.pl (cms101.neoplus.adsl.tpnet.pl
	[83.31.146.101])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 64431679E7
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jun 2005 05:54:56 +1000 (EST)
Date: Tue, 14 Jun 2005 21:38:26 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-ID: <20050614193826.GE13702@fngna.oyu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2.6][PPC32] RESEND: don't recursively crash in die() on
	CHRP/PReP machines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch avoids recursive crash (leading to kernel stack overflow) in
die() on CHRP/PReP machines when CONFIG_PMAC_BACKLIGHT=y.
set_backlight_* functions are placed in pmac section, which is discarded
when _machine != _MACH_Pmac.

I already posted this patch to LKML few months ago:
http://www.ussg.iu.edu/hypermail/linux/kernel/0412.0/0300.html
and it has been applied to linux-2.4 tree, but still not 2.6.
(patch was made against 2.4.27, but still applies cleanly against
kernels up to 2.6.11.12)

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.4.27/arch/ppc/kernel/traps.c.orig	Wed Apr 14 15:05:27 2004
+++ linux-2.4.27/arch/ppc/kernel/traps.c	Mon Nov 29 19:05:28 2004
@@ -88,8 +88,10 @@
 	console_verbose();
 	spin_lock_irq(&die_lock);
 #ifdef CONFIG_PMAC_BACKLIGHT
-	set_backlight_enable(1);
-	set_backlight_level(BACKLIGHT_MAX);
+	if (_machine == _MACH_Pmac) {
+		set_backlight_enable(1);
+		set_backlight_level(BACKLIGHT_MAX);
+	}
 #endif
 	printk("Oops: %s, sig: %ld\n", str, err);
 	show_regs(fp);


-- 
Jakub Bogusz    http://qboosh.cs.net.pl/
