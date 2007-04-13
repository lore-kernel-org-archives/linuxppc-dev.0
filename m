Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C0AB6DDE36
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 08:14:47 +1000 (EST)
Date: Fri, 13 Apr 2007 15:16:57 -0700
From: Dave Jiang <djiang@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
Message-ID: <20070413221657.GA23624@blade.az.mvista.com>
References: <20070413173524.GA17890@blade.az.mvista.com>
	<461FCB6F.7010504@ru.mvista.com>
	<20070413200659.GA21588@blade.az.mvista.com>
	<B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Have the booke watchdog dump some useful information when triggered.
Hopefully that'll give the user some hint of what happened rather than just a
mysterious reboot.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

 arch/powerpc/kernel/traps.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f786222..e4d6186 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1108,9 +1108,39 @@ void unrecoverable_exception(struct pt_regs *regs)
  */
 void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
 {
+	unsigned long flags;
+
 	/* Generic WatchdogHandler, implement your own */
 	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
-	return;
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
 }
 
 void WatchdogException(struct pt_regs *regs)
