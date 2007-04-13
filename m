Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id E2DDDDDE3A
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 03:45:45 +1000 (EST)
Date: Fri, 13 Apr 2007 10:47:13 -0700
From: Dave Jiang <djiang@mvista.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org,
	galak@kernel.crashing.org
Subject: Re: oops, forgot to sign off
Message-ID: <20070413174713.GA18110@blade.az.mvista.com>
References: <20070413173524.GA17890@blade.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070413173524.GA17890@blade.az.mvista.com>
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

Signed-off-by: Dave Jiang <djiang@mvista.com>

--

 arch/powerpc/kernel/traps.c |   35 ++++++++++++++++++++++++++++++++++-
 1 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index f786222..1af83b7 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1108,9 +1108,42 @@ void unrecoverable_exception(struct pt_regs *regs)
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
+	printk(KERN_ERR "PowerPC Book-E Watchdog detected LOCKUP\n");
+	printk(KERN_ERR "Watchdog exception at PC=%lx MSR=%lx\n",
+			regs->nip, regs->msr);
+#ifdef CONFIG_PREEMPT
+	printk(KERN_ERR "PREEMPT ");
+#endif
+#ifdef CONFIG_SMP
+	printk(KERN_ERR "SMP NR_CPUS=%d ", NR_CPUS);
+#endif
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	printk(KERN_ERR "DEBUG_PAGEALLOC ");
+#endif
+#ifdef CONFIG_NUMA
+	printk(KERN_ERR "NUMA ");
+#endif
+	printk(KERN_ERR "%s\n", ppc_md.name ? ppc_md.name : "");
+
+	print_modules();
+	show_regs(regs);
+
+	bust_spinlocks(0);
+
+	printk(KERN_ERR "Wating for hardware watchdog reset...\n");
+	/* spin until hardware reset */
+	while(1)
+		cpu_relax();
 }
 
 void WatchdogException(struct pt_regs *regs)
