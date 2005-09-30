Return-Path: <sfr@canb.auug.org.au>
Date: Fri, 30 Sep 2005 23:49:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Message-Id: <20050930234959.52c939ef.sfr@canb.auug.org.au>
In-Reply-To: <20050930233602.138b6e27.sfr@canb.auug.org.au>
References: <20050930233602.138b6e27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/9] powerpc: merge asm-offsets.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I needed more merged to make iSeries build.  I also rearranged it into a
bit more logical arrangement where the referneces to each structure are
all together.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/kernel/asm-offsets.c |  220 ++++++++++++++++++++-----------------
 1 files changed, 117 insertions(+), 103 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

d1dead5c5f016ebadb4b87c2c9fa13dfc2c99bf0
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -20,17 +20,20 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/suspend.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#ifdef CONFIG_PPC64
 #include <linux/time.h>
 #include <linux/hardirq.h>
+#else
+#include <linux/ptrace.h>
+#include <linux/suspend.h>
+#endif
+
 #include <asm/io.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
-
 #include <asm/cputable.h>
 #include <asm/thread_info.h>
 #ifdef CONFIG_PPC64
@@ -50,63 +53,117 @@
 
 int main(void)
 {
-	/* thread struct on stack */
-	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
-	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
-#ifdef CONFIG_PPC32
-	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
-#endif
+	DEFINE(THREAD, offsetof(struct task_struct, thread));
+	DEFINE(MM, offsetof(struct task_struct, mm));
 #ifdef CONFIG_PPC64
-	DEFINE(TI_SC_NOERR, offsetof(struct thread_info, syscall_noerror));
 	DEFINE(THREAD_SHIFT, THREAD_SHIFT);
-#endif
 	DEFINE(THREAD_SIZE, THREAD_SIZE);
-
-	/* task_struct->thread */
-	DEFINE(THREAD, offsetof(struct task_struct, thread));
+	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
+#else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, thread_info));
-	DEFINE(MM, offsetof(struct task_struct, mm));
 	DEFINE(PTRACE, offsetof(struct task_struct, ptrace));
+#endif /* CONFIG_PPC64 */
+
 	DEFINE(KSP, offsetof(struct thread_struct, ksp));
-	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
-	DEFINE(LAST_SYSCALL, offsetof(struct thread_struct, last_syscall));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
 	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
-	DEFINE(PT_PTRACED, PT_PTRACED);
-#endif
-#ifdef CONFIG_PPC64
-	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
-#endif
-
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VR0, offsetof(struct thread_struct, vr[0]));
 	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
 	DEFINE(THREAD_VSCR, offsetof(struct thread_struct, vscr));
 	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
+#else /* CONFIG_PPC64 */
+	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
+	DEFINE(LAST_SYSCALL, offsetof(struct thread_struct, last_syscall));
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, dbcr0));
+	DEFINE(PT_PTRACED, PT_PTRACED);
+#endif
 #ifdef CONFIG_SPE
 	DEFINE(THREAD_EVR0, offsetof(struct thread_struct, evr[0]));
 	DEFINE(THREAD_ACC, offsetof(struct thread_struct, acc));
 	DEFINE(THREAD_SPEFSCR, offsetof(struct thread_struct, spefscr));
 	DEFINE(THREAD_USED_SPE, offsetof(struct thread_struct, used_spe));
 #endif /* CONFIG_SPE */
+#endif /* CONFIG_PPC64 */
+
+	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
+#ifdef CONFIG_PPC64
+	DEFINE(TI_SC_NOERR, offsetof(struct thread_info, syscall_noerror));
+#else
+	DEFINE(TI_TASK, offsetof(struct thread_info, task));
+	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
+	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
+	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
+#endif /* CONFIG_PPC64 */
+
+#ifdef CONFIG_PPC64
+	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
+	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
+	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
+	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
+	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
+	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
+	DEFINE(PLATFORM, offsetof(struct systemcfg, platform));
+
+	/* paca */
+	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
+	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
+	DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
+	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
+	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
+	DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
+	DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
+	DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
+	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_rr));
+	DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
+	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
+	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, proc_enabled));
+	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
+	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
+	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
+#ifdef CONFIG_HUGETLB_PAGE
+	DEFINE(PACALOWHTLBAREAS, offsetof(struct paca_struct, context.low_htlb_areas));
+	DEFINE(PACAHIGHHTLBAREAS, offsetof(struct paca_struct, context.high_htlb_areas));
+#endif /* CONFIG_HUGETLB_PAGE */
+	DEFINE(PACADEFAULTDECR, offsetof(struct paca_struct, default_decr));
+	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
+	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
+	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
+	DEFINE(PACA_EXDSI, offsetof(struct paca_struct, exdsi));
+	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
+	DEFINE(PACALPPACA, offsetof(struct paca_struct, lppaca));
+	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
+
+	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
+	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
+	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
+	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
+
+	/* RTAS */
+	DEFINE(RTASBASE, offsetof(struct rtas_t, base));
+	DEFINE(RTASENTRY, offsetof(struct rtas_t, entry));
+#endif /* CONFIG_PPC64 */
+
 	/* Interrupt register frame */
 	DEFINE(STACK_FRAME_OVERHEAD, STACK_FRAME_OVERHEAD);
 #ifndef CONFIG_PPC64
 	DEFINE(INT_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
-#else
+#else /* CONFIG_PPC64 */
 	DEFINE(SWITCH_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs));
-
 	/* 288 = # of volatile regs, int & fp, for leaf routines */
 	/* which do not stack a frame.  See the PPC64 ABI.       */
 	DEFINE(INT_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 288);
-#endif
-	/* in fact we only use gpr0 - gpr9 and gpr20 - gpr23 */
+	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
+	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
+	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
+#endif /* CONFIG_PPC64 */
 	DEFINE(GPR0, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[0]));
 	DEFINE(GPR1, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[1]));
 	DEFINE(GPR2, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[2]));
@@ -121,6 +178,7 @@ int main(void)
 	DEFINE(GPR11, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[11]));
 	DEFINE(GPR12, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[12]));
 	DEFINE(GPR13, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[13]));
+#ifndef CONFIG_PPC64
 	DEFINE(GPR14, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[14]));
 	DEFINE(GPR15, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[15]));
 	DEFINE(GPR16, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[16]));
@@ -139,6 +197,7 @@ int main(void)
 	DEFINE(GPR29, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[29]));
 	DEFINE(GPR30, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[30]));
 	DEFINE(GPR31, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, gpr[31]));
+#endif /* CONFIG_PPC64 */
 	/*
 	 * Note: these symbols include _ because they overlap with special
 	 * register names
@@ -148,23 +207,37 @@ int main(void)
 	DEFINE(_CTR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, ctr));
 	DEFINE(_LINK, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, link));
 	DEFINE(_CCR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, ccr));
-	DEFINE(_MQ, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, mq));
 	DEFINE(_XER, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, xer));
 	DEFINE(_DAR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dar));
 	DEFINE(_DSISR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dsisr));
-	/* The PowerPC 400-class & Book-E processors have neither the DAR nor the DSISR
-	 * SPRs. Hence, we overload them to hold the similar DEAR and ESR SPRs
-	 * for such processors.  For critical interrupts we use them to
-	 * hold SRR0 and SRR1.
+	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
+	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
+#ifndef CONFIG_PPC64
+	DEFINE(_MQ, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, mq));
+	/*
+	 * The PowerPC 400-class & Book-E processors have neither the DAR
+	 * nor the DSISR SPRs. Hence, we overload them to hold the similar
+	 * DEAR and ESR SPRs for such processors.  For critical interrupts
+	 * we use them to hold SRR0 and SRR1.
 	 */
 	DEFINE(_DEAR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dar));
 	DEFINE(_ESR, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, dsisr));
-	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
-	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
+#else /* CONFIG_PPC64 */
+	DEFINE(_TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
+	DEFINE(SOFTE, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, softe));
+
+	/* These _only_ to be used with {PROM,RTAS}_FRAME_SIZE!!! */
+	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs));
+	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
+#endif /* CONFIG_PPC64 */
+
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
+
+#ifndef CONFIG_PPC64
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
+#endif /* ! CONFIG_PPC64 */
 
 	/* About the CPU features table */
 	DEFINE(CPU_SPEC_ENTRY_SIZE, sizeof(struct cpu_spec));
@@ -173,66 +246,13 @@ int main(void)
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
-#ifdef CONFIG_PPC64
-	DEFINE(MM, offsetof(struct task_struct, mm));
-	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
-
-	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
-	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
-	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
-	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
-	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
-	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
-	DEFINE(PLATFORM, offsetof(struct systemcfg, platform));
-
-	/* paca */
-        DEFINE(PACA_SIZE, sizeof(struct paca_struct));
-        DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
-        DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
-        DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
-	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
-        DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
-        DEFINE(PACASTABREAL, offsetof(struct paca_struct, stab_real));
-        DEFINE(PACASTABVIRT, offsetof(struct paca_struct, stab_addr));
-	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_rr));
-        DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
-	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
-	DEFINE(PACAPROCENABLED, offsetof(struct paca_struct, proc_enabled));
-	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
-	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
-	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
-#ifdef CONFIG_HUGETLB_PAGE
-	DEFINE(PACALOWHTLBAREAS, offsetof(struct paca_struct, context.low_htlb_areas));
-	DEFINE(PACAHIGHHTLBAREAS, offsetof(struct paca_struct, context.high_htlb_areas));
-#endif /* CONFIG_HUGETLB_PAGE */
-	DEFINE(PACADEFAULTDECR, offsetof(struct paca_struct, default_decr));
-        DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
-        DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
-        DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
-        DEFINE(PACA_EXDSI, offsetof(struct paca_struct, exdsi));
-        DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
-	DEFINE(PACALPPACA, offsetof(struct paca_struct, lppaca));
-	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
-	DEFINE(LPPACASRR0, offsetof(struct lppaca, saved_srr0));
-	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
-	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
-	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
-
-	/* RTAS */
-	DEFINE(RTASBASE, offsetof(struct rtas_t, base));
-	DEFINE(RTASENTRY, offsetof(struct rtas_t, entry));
-
-	DEFINE(_TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
-	DEFINE(SOFTE, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, softe));
-
-	/* Create extra stack space for SRR0 and SRR1 when calling prom/rtas. */
-	DEFINE(PROM_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-	DEFINE(RTAS_FRAME_SIZE, STACK_FRAME_OVERHEAD + sizeof(struct pt_regs) + 16);
-
-	/* These _only_ to be used with {PROM,RTAS}_FRAME_SIZE!!! */
-	DEFINE(_SRR0, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs));
-	DEFINE(_SRR1, STACK_FRAME_OVERHEAD+sizeof(struct pt_regs)+8);
+#ifndef CONFIG_PPC64
+	DEFINE(pbe_address, offsetof(struct pbe, address));
+	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
+	DEFINE(pbe_next, offsetof(struct pbe, next));
 
+	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
+#else /* CONFIG_PPC64 */
 	/* systemcfg offsets for use by vdso */
 	DEFINE(CFG_TB_ORIG_STAMP, offsetof(struct systemcfg, tb_orig_stamp));
 	DEFINE(CFG_TB_TICKS_PER_SEC, offsetof(struct systemcfg, tb_ticks_per_sec));
@@ -251,12 +271,6 @@ int main(void)
 	DEFINE(TVAL32_TV_USEC, offsetof(struct compat_timeval, tv_usec));
 	DEFINE(TZONE_TZ_MINWEST, offsetof(struct timezone, tz_minuteswest));
 	DEFINE(TZONE_TZ_DSTTIME, offsetof(struct timezone, tz_dsttime));
-#endif
-
-	DEFINE(pbe_address, offsetof(struct pbe, address));
-	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
-	DEFINE(pbe_next, offsetof(struct pbe, next));
-
-	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
+#endif /* CONFIG_PPC64 */
 	return 0;
 }
