Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs,
	and VSRs in the MSR
In-reply-to: <1237164566.25062.114.camel@pasglop> 
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
	<FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
	<1237042739.8874.3.camel@localhost.localdomain>
	<1237164566.25062.114.camel@pasglop>
Date: Mon, 16 Mar 2009 17:43:02 +1100
Message-ID: <7609.1237185782@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > We can do some VMX testing on existing POWER6 machines.  The VSX
> > instruction set hasn't been fully implemented in GCC yet so we'll need
> > to wait a bit for that.  Does anyone have an idea for a good VMX/Altivec
> > benchmark?
> 
> Note that there are two aspects to the problem:
> 
>  - Lazy save/restore on SMP. This would avoid both the save and restore
> phases, thus is where the most potential gain is to be made. At the
> expense of some tricky IPI work when processes migrate between CPUs.
> 
> However, it will only be useful -if- a process using FP/VMX/VSX is
> "interrupted" by another process that isn't using them. For example, a
> kernel thread. So it's unclear whether that's worth it in practice, ie,
> does this happen that often ?
> 
>  - Always restoring the FP/VMX/VSX state on context switch "in" rather
> than taking a fault. This is reasonably simple, but at the potential
> expense of adding the save/restore overhead to applications that only
> seldomly use these facilities. (Some heuristics might help here).
> 
> However, the question here what do this buy us ?
> 
> IE, In the worst case scenario, which is HZ=1000, so every 1ms, the
> process would have the overhead of an interrupt to do the restore of the
> state. IE. The restore state itself doesn't count since it would be done
> either way (at context switch vs. in the unavailable interrupt), so all
> we win here is the overhead of the actual interrupt, which is
> implemented as a fast interrupt in assembly. So we have what here ? 1000
> cycles to be pessimistic ? On a 1Ghz CPU, that is 1/1000 of the time
> slice, and both of these are rather pessimistic numbers.
> 
> So that leaves us with the possible case of 2 tasks using the facility
> and running a fraction of the timeslice each, for example because they
> are ping-ponging with each other.
> 
> Is that something that happens in practice to make it noticeable ?

I hacked up the below to put stats in /proc/self/sched.

A quick grep through /proc on a rhel5.2 machine (egrep
'(fp_count|switch_count)' /proc/*/sched) shows a few apps use fp a few
dozen times but then stop.  This is only init apps like hald, so need to
check some real world apps too.

Ryan: let me know if this allows you to collect some useful stats.  

Subject: [PATCH] powerpc: add context switch, fpr & vr stats to /proc/self/sched.

Add a counter for every task switch, fp and vr exception to
/proc/self/sched.

[root@p5-20-p6-e0 ~]# cat /proc/3422/sched |tail -3
switch_count                       :                  559
fp_count                           :                  317
vr_count                           :                    0
[root@p5-20-p6-e0 ~]# 

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/processor.h |    3 +++
 arch/powerpc/kernel/asm-offsets.c    |    3 +++
 arch/powerpc/kernel/fpu.S            |    3 +++
 arch/powerpc/kernel/process.c        |    3 +++
 arch/powerpc/kernel/setup-common.c   |   10 ++++++++++
 include/linux/seq_file.h             |   12 ++++++++++++
 kernel/sched_debug.c                 |   16 ++++------------
 7 files changed, 38 insertions(+), 12 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/processor.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/processor.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/processor.h
@@ -174,11 +174,13 @@ struct thread_struct {
 	} fpscr;
 	int		fpexc_mode;	/* floating-point exception mode */
 	unsigned int	align_ctl;	/* alignment handling control */
+	unsigned long	fp_count;	/* FP restore count */
 #ifdef CONFIG_PPC64
 	unsigned long	start_tb;	/* Start purr when proc switched in */
 	unsigned long	accum_tb;	/* Total accumilated purr for process */
 #endif
 	unsigned long	dabr;		/* Data address breakpoint register */
+	unsigned long	switch_count;	/* switch count */
 #ifdef CONFIG_ALTIVEC
 	/* Complete AltiVec register set */
 	vector128	vr[32] __attribute__((aligned(16)));
@@ -186,6 +188,7 @@ struct thread_struct {
 	vector128	vscr __attribute__((aligned(16)));
 	unsigned long	vrsave;
 	int		used_vr;	/* set if process has used altivec */
+	unsigned long	vr_count;	/* VSX restore count */
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	/* VSR status */
Index: linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
@@ -74,14 +74,17 @@ int main(void)
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
 	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
+	DEFINE(THREAD_SWITCHCOUNT, offsetof(struct thread_struct, switch_count));
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
+	DEFINE(THREAD_FPCOUNT, offsetof(struct thread_struct, fp_count));
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VR0, offsetof(struct thread_struct, vr[0]));
 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
 	DEFINE(THREAD_VSCR, offsetof(struct thread_struct, vscr));
 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
+	DEFINE(THREAD_VRCOUNT, offsetof(struct thread_struct, vr_count));
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
 	DEFINE(THREAD_VSR0, offsetof(struct thread_struct, fpr));
Index: linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/fpu.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/fpu.S
@@ -102,6 +102,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	ori	r12,r12,MSR_FP
 	or	r12,r12,r4
 	std	r12,_MSR(r1)
+	ld	r4,THREAD_FPCOUNT(r5)
+	addi	r4, r4, 1
+	std	r4,THREAD_FPCOUNT(r5)
 #endif
 	lfd	fr0,THREAD_FPSCR(r5)
 	MTFSF_L(fr0)
Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -744,17 +744,20 @@ void start_thread(struct pt_regs *regs, 
 #endif
 
 	discard_lazy_cpu_state();
+	current->thread.switch_count = 0;
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
 #endif
 	memset(current->thread.fpr, 0, sizeof(current->thread.fpr));
 	current->thread.fpscr.val = 0;
+	current->thread.fp_count = 0;
 #ifdef CONFIG_ALTIVEC
 	memset(current->thread.vr, 0, sizeof(current->thread.vr));
 	memset(&current->thread.vscr, 0, sizeof(current->thread.vscr));
 	current->thread.vscr.u[3] = 0x00010000; /* Java mode disabled */
 	current->thread.vrsave = 0;
 	current->thread.used_vr = 0;
+	current->thread.vr_count = 0;
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_SPE
 	memset(current->thread.evr, 0, sizeof(current->thread.evr));
Index: linux-2.6-ozlabs/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/setup-common.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/setup-common.c
@@ -669,3 +669,13 @@ static int powerpc_debugfs_init(void)
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
+
+void arch_proc_sched_show_task(struct task_struct *p, struct seq_file *m) {
+	SEQ_printf(m, "%-35s:%21Ld\n",
+		   "switch_count", (long long)p->thread.switch_count);
+	SEQ_printf(m, "%-35s:%21Ld\n",
+		   "fp_count", (long long)p->thread.fp_count);
+	SEQ_printf(m, "%-35s:%21Ld\n",
+		   "vr_count", (long long)p->thread.vr_count);
+}
+
Index: linux-2.6-ozlabs/include/linux/seq_file.h
===================================================================
--- linux-2.6-ozlabs.orig/include/linux/seq_file.h
+++ linux-2.6-ozlabs/include/linux/seq_file.h
@@ -95,4 +95,16 @@ extern struct list_head *seq_list_start_
 extern struct list_head *seq_list_next(void *v, struct list_head *head,
 		loff_t *ppos);
 
+/*
+ * This allows printing both to /proc/sched_debug and
+ * to the console
+ */
+#define SEQ_printf(m, x...)			\
+ do {						\
+	if (m)					\
+		seq_printf(m, x);		\
+	else					\
+		printk(x);			\
+ } while (0)
+
 #endif
Index: linux-2.6-ozlabs/kernel/sched_debug.c
===================================================================
--- linux-2.6-ozlabs.orig/kernel/sched_debug.c
+++ linux-2.6-ozlabs/kernel/sched_debug.c
@@ -17,18 +17,6 @@
 #include <linux/utsname.h>
 
 /*
- * This allows printing both to /proc/sched_debug and
- * to the console
- */
-#define SEQ_printf(m, x...)			\
- do {						\
-	if (m)					\
-		seq_printf(m, x);		\
-	else					\
-		printk(x);			\
- } while (0)
-
-/*
  * Ease the printing of nsec fields:
  */
 static long long nsec_high(unsigned long long nsec)
@@ -370,6 +358,9 @@ static int __init init_sched_debug_procf
 
 __initcall(init_sched_debug_procfs);
 
+void __attribute__ ((weak))
+arch_proc_sched_show_task(struct task_struct *p, struct seq_file *m) {}
+
 void proc_sched_show_task(struct task_struct *p, struct seq_file *m)
 {
 	unsigned long nr_switches;
@@ -473,6 +464,7 @@ void proc_sched_show_task(struct task_st
 		SEQ_printf(m, "%-35s:%21Ld\n",
 			   "clock-delta", (long long)(t1-t0));
 	}
+	arch_proc_sched_show_task(p, m);
 }
 
 void proc_sched_set_task(struct task_struct *p)
