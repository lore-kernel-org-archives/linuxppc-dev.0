Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc: Rework set_dabr so it can take a DABRX value as
 well
Date: Fri,  7 Sep 2012 17:24:56 +1000
Message-Id: <1347002698-7341-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1347002698-7341-1-git-send-email-mikey@neuling.org>
References: <1347002698-7341-1-git-send-email-mikey@neuling.org>
In-Reply-To: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
References: <alpine.DEB.2.00.1209070716110.22556@bushbaby.sonytel.be>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rework set_dabr to take a DABRX value as well.

Both the pseries and PS3 hypervisors do some checks on the DABRX
values that are passed in the hcall.  This patch stops bogus values
from being passed to hypervisor.  Also, in the case where we are
clearing the breakpoint, where DABR and DABRX are zero, we modify the
DABRX value to make it valid so that the hcall won't fail.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/debug.h         |    2 +-
 arch/powerpc/include/asm/hw_breakpoint.h |    2 +-
 arch/powerpc/include/asm/machdep.h       |    3 ++-
 arch/powerpc/include/asm/processor.h     |    1 +
 arch/powerpc/include/asm/reg.h           |    3 +++
 arch/powerpc/kernel/hw_breakpoint.c      |   12 ++++++------
 arch/powerpc/kernel/process.c            |   14 +++++++-------
 arch/powerpc/kernel/ptrace.c             |    3 +++
 arch/powerpc/kernel/signal.c             |    2 +-
 arch/powerpc/platforms/cell/beat.c       |    4 ++--
 arch/powerpc/platforms/cell/beat.h       |    2 +-
 arch/powerpc/platforms/ps3/setup.c       |   10 +++++++---
 arch/powerpc/platforms/pseries/setup.c   |   14 +++++++++-----
 arch/powerpc/xmon/xmon.c                 |    4 ++--
 14 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 716d2f0..32de257 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -44,7 +44,7 @@ static inline int debugger_dabr_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
-extern int set_dabr(unsigned long dabr);
+extern int set_dabr(unsigned long dabr, unsigned long dabrx);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int signal_code, int brkpt);
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 39b323e..c6f48eb 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -61,7 +61,7 @@ extern void ptrace_triggered(struct perf_event *bp,
 			struct perf_sample_data *data, struct pt_regs *regs);
 static inline void hw_breakpoint_disable(void)
 {
-	set_dabr(0);
+	set_dabr(0, 0);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 42ce570..236b477 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -180,7 +180,8 @@ struct machdep_calls {
 	void		(*enable_pmcs)(void);
 
 	/* Set DABR for this platform, leave empty for default implemenation */
-	int		(*set_dabr)(unsigned long dabr);
+	int		(*set_dabr)(unsigned long dabr,
+				    unsigned long dabrx);
 
 #ifdef CONFIG_PPC32	/* XXX for now */
 	/* A general init function, called by ppc_init in init/main.c.
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 54b73a2..17b58e5 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -219,6 +219,7 @@ struct thread_struct {
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
+	unsigned long	dabrx;		/*      ... extension  */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
 	vector128	vr[32] __attribute__((aligned(16)));
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 6386086..334be34 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -208,6 +208,9 @@
 #define SPRN_DABRX	0x3F7	/* Data Address Breakpoint Register Extension */
 #define   DABRX_USER	(1UL << 0)
 #define   DABRX_KERNEL	(1UL << 1)
+#define   DABRX_HYP	(1UL << 2)
+#define   DABRX_BTI	(1UL << 3)
+#define   DABRX_ALL     (DABRX_BTI | DABRX_HYP | DABRX_KERNEL | DABRX_USER)
 #define SPRN_DAR	0x013	/* Data Address Register */
 #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
 #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 6767445..6891d79 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -73,7 +73,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	 * If so, DABR will be populated in single_step_dabr_instruction().
 	 */
 	if (current->thread.last_hit_ubp != bp)
-		set_dabr(info->address | info->type | DABR_TRANSLATION);
+		set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
 
 	return 0;
 }
@@ -97,7 +97,7 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 	}
 
 	*slot = NULL;
-	set_dabr(0);
+	set_dabr(0, 0);
 }
 
 /*
@@ -197,7 +197,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 
 	info = counter_arch_bp(tsk->thread.last_hit_ubp);
 	regs->msr &= ~MSR_SE;
-	set_dabr(info->address | info->type | DABR_TRANSLATION);
+	set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
 	tsk->thread.last_hit_ubp = NULL;
 }
 
@@ -215,7 +215,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	unsigned long dar = regs->dar;
 
 	/* Disable breakpoints during exception handling */
-	set_dabr(0);
+	set_dabr(0, 0);
 
 	/*
 	 * The counter may be concurrently released but that can only
@@ -281,7 +281,7 @@ int __kprobes hw_breakpoint_handler(struct die_args *args)
 	if (!info->extraneous_interrupt)
 		perf_bp_event(bp, regs);
 
-	set_dabr(info->address | info->type | DABR_TRANSLATION);
+	set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
 out:
 	rcu_read_unlock();
 	return rc;
@@ -313,7 +313,7 @@ int __kprobes single_step_dabr_instruction(struct die_args *args)
 	if (!info->extraneous_interrupt)
 		perf_bp_event(bp, regs);
 
-	set_dabr(info->address | info->type | DABR_TRANSLATION);
+	set_dabr(info->address | info->type | DABR_TRANSLATION, DABRX_ALL);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1a1f2dd..53c32a9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -283,7 +283,7 @@ void do_dabr(struct pt_regs *regs, unsigned long address,
 		return;
 
 	/* Clear the DABR */
-	set_dabr(0);
+	set_dabr(0, 0);
 
 	/* Deliver the signal to userspace */
 	info.si_signo = SIGTRAP;
@@ -364,18 +364,19 @@ static void set_debug_reg_defaults(struct thread_struct *thread)
 {
 	if (thread->dabr) {
 		thread->dabr = 0;
-		set_dabr(0);
+		thread->dabrx = 0;
+		set_dabr(0, 0);
 	}
 }
 #endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
-int set_dabr(unsigned long dabr)
+int set_dabr(unsigned long dabr, unsigned long dabrx)
 {
 	__get_cpu_var(current_dabr) = dabr;
 
 	if (ppc_md.set_dabr)
-		return ppc_md.set_dabr(dabr);
+		return ppc_md.set_dabr(dabr, dabrx);
 
 	/* XXX should we have a CPU_FTR_HAS_DABR ? */
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
@@ -385,9 +386,8 @@ int set_dabr(unsigned long dabr)
 #endif
 #elif defined(CONFIG_PPC_BOOK3S)
 	mtspr(SPRN_DABR, dabr);
+	mtspr(SPRN_DABRX, dabrx);
 #endif
-
-
 	return 0;
 }
 
@@ -480,7 +480,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
  */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
-		set_dabr(new->thread.dabr);
+		set_dabr(new->thread.dabr, new->thread.dabrx);
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index c10fc28..79d8e56 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -960,6 +960,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		thread->ptrace_bps[0] = bp;
 		ptrace_put_breakpoints(task);
 		thread->dabr = data;
+		thread->dabrx = DABRX_ALL;
 		return 0;
 	}
 
@@ -983,6 +984,7 @@ int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 
 	/* Move contents to the DABR register */
 	task->thread.dabr = data;
+	task->thread.dabrx = DABRX_ALL;
 #else /* CONFIG_PPC_ADV_DEBUG_REGS */
 	/* As described above, it was assumed 3 bits were passed with the data
 	 *  address, but we will assume only the mode bits will be passed
@@ -1397,6 +1399,7 @@ static long ppc_set_hwdebug(struct task_struct *child,
 		dabr |= DABR_DATA_WRITE;
 
 	child->thread.dabr = dabr;
+	child->thread.dabrx = DABRX_ALL;
 
 	return 1;
 #endif /* !CONFIG_PPC_ADV_DEBUG_DVCS */
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 5c023c9..b936b45 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -130,7 +130,7 @@ static int do_signal(struct pt_regs *regs)
 	 * triggered inside the kernel.
 	 */
 	if (current->thread.dabr)
-		set_dabr(current->thread.dabr);
+		set_dabr(current->thread.dabr, current->thread.dabrx);
 #endif
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(current, regs);
diff --git a/arch/powerpc/platforms/cell/beat.c b/arch/powerpc/platforms/cell/beat.c
index 852592b..affcf56 100644
--- a/arch/powerpc/platforms/cell/beat.c
+++ b/arch/powerpc/platforms/cell/beat.c
@@ -136,9 +136,9 @@ ssize_t beat_nvram_get_size(void)
 	return BEAT_NVRAM_SIZE;
 }
 
-int beat_set_xdabr(unsigned long dabr)
+int beat_set_xdabr(unsigned long dabr, unsigned long dabrx)
 {
-	if (beat_set_dabr(dabr, DABRX_KERNEL | DABRX_USER))
+	if (beat_set_dabr(dabr, dabrx))
 		return -1;
 	return 0;
 }
diff --git a/arch/powerpc/platforms/cell/beat.h b/arch/powerpc/platforms/cell/beat.h
index 32c8efc..bfcb8e3 100644
--- a/arch/powerpc/platforms/cell/beat.h
+++ b/arch/powerpc/platforms/cell/beat.h
@@ -32,7 +32,7 @@ void beat_get_rtc_time(struct rtc_time *);
 ssize_t beat_nvram_get_size(void);
 ssize_t beat_nvram_read(char *, size_t, loff_t *);
 ssize_t beat_nvram_write(char *, size_t, loff_t *);
-int beat_set_xdabr(unsigned long);
+int beat_set_xdabr(unsigned long, unsigned long);
 void beat_power_save(void);
 void beat_kexec_cpu_down(int, int);
 
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 2d664c5..3f509f8 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -184,11 +184,15 @@ early_param("ps3flash", early_parse_ps3flash);
 #define prealloc_ps3flash_bounce_buffer()	do { } while (0)
 #endif
 
-static int ps3_set_dabr(unsigned long dabr)
+static int ps3_set_dabr(unsigned long dabr, unsigned long dabrx)
 {
-	enum {DABR_USER = 1, DABR_KERNEL = 2,};
+	/* Have to set at least one bit in the DABRX */
+	if (dabrx == 0 && dabr == 0)
+		dabrx = DABRX_USER;
+	/* hypervisor only allows us to set BTI, Kernel and user */
+	dabrx &= DABRX_BTI | DABRX_KERNEL | DABRX_USER;
 
-	return lv1_set_dabr(dabr, DABR_KERNEL | DABR_USER) ? -1 : 0;
+	return lv1_set_dabr(dabr, dabrx) ? -1 : 0;
 }
 
 static void __init ps3_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 36b7744..b90deaf 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -416,16 +416,20 @@ static int __init pSeries_init_panel(void)
 }
 machine_arch_initcall(pseries, pSeries_init_panel);
 
-static int pseries_set_dabr(unsigned long dabr)
+static int pseries_set_dabr(unsigned long dabr, unsigned long dabrx)
 {
 	return plpar_hcall_norets(H_SET_DABR, dabr);
 }
 
-static int pseries_set_xdabr(unsigned long dabr)
+static int pseries_set_xdabr(unsigned long dabr, unsigned long dabrx)
 {
-	/* We want to catch accesses from kernel and userspace */
-	return plpar_hcall_norets(H_SET_XDABR, dabr,
-			H_DABRX_KERNEL | H_DABRX_USER);
+	/* Have to set at least one bit in the DABRX according to PAPR */
+	if (dabrx == 0 && dabr == 0)
+		dabrx = DABRX_USER;
+	/* PAPR says we can only set kernel and user bits */
+	dabrx &= H_DABRX_KERNEL | H_DABRX_USER;
+
+	return plpar_hcall_norets(H_SET_XDABR, dabr, dabrx);
 }
 
 #define CMO_CHARACTERISTICS_TOKEN 44
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9b49c65..987f441 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -740,7 +740,7 @@ static void insert_bpts(void)
 static void insert_cpu_bpts(void)
 {
 	if (dabr.enabled)
-		set_dabr(dabr.address | (dabr.enabled & 7));
+		set_dabr(dabr.address | (dabr.enabled & 7), DABRX_ALL);
 	if (iabr && cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, iabr->address
 			 | (iabr->enabled & (BP_IABR|BP_IABR_TE)));
@@ -768,7 +768,7 @@ static void remove_bpts(void)
 
 static void remove_cpu_bpts(void)
 {
-	set_dabr(0);
+	set_dabr(0, 0);
 	if (cpu_has_feature(CPU_FTR_IABR))
 		mtspr(SPRN_IABR, 0);
 }
-- 
1.7.9.5
