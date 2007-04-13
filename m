Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id B45C9DDE43
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 06:04:48 +1000 (EST)
Date: Fri, 13 Apr 2007 13:06:59 -0700
From: Dave Jiang <djiang@mvista.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
Message-ID: <20070413200659.GA21588@blade.az.mvista.com>
References: <20070413173524.GA17890@blade.az.mvista.com>
	<461FCB6F.7010504@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <461FCB6F.7010504@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have the booke watchdog dump some useful information when triggered. Hopefully
that'll give the user some hint of what happened rather than just a mysterious
reboot.

--

 Ok here's try 2. Modified the watchdog driver instead per Sergei's suggestion.

 drivers/char/watchdog/booke_wdt.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index 0e23f29..90e5301 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -23,6 +23,7 @@
 #include <asm/reg_booke.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
+#include <asm/machdep.h>
 
 /* If the kernel parameter wdt_enable=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
@@ -47,6 +48,42 @@ u32 booke_wdt_period = WDT_PERIOD_DEFAULT;
 #define WDTP(x)		(TCR_WP(x))
 #endif
 
+void WatchdogHandler(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	mtspr(SPRN_TCR, mfspr(SPRN_TCR) & ~TCR_WIE);
+	oops_enter();
+
+	console_verbose();
+	bust_spinlocks(1);
+	local_save_flags(flags);
+
+#ifdef CONFIG_PREEMPT
+	printk("PREEMPT ");
+#endif
+#ifdef CONFIG_SMP
+	printk("SMP NR_CPUS=%d ", NR_CPUS);
+#endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	printk("DEBUG_PAGEALLOC ");
+#endif
+#ifdef CONFIG_NUMA
+	printk("NUMA ");
+#endif
+	printk("%s\n", ppc_md.name ? ppc_md.name : "");
+
+	print_modules();
+	show_regs(regs);
+
+	bust_spinlocks(0);
+
+	printk(KERN_EMERG "Waiting for hardware watchdog reset...\n");
+	/* spin until hardware reset */
+	while(1)
+		cpu_relax();
+}
+
 /*
  * booke_wdt_ping:
  */
