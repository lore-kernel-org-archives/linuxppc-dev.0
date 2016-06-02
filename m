Return-Path: <rashmicy@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKvQm0RPWzDqXb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 14:30:08 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id b124so6443143pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jun 2016 21:30:07 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/asm: Use OFFSET macro in asm-offsets.c
Date: Thu,  2 Jun 2016 14:29:46 +1000
Message-Id: <1464841788-17465-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A lot of entries in asm-offests.c look like this:
DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));

But there is a common macro, OFFSET, which makes this cleaner:
OFFSET(TI_flags, thread_info, flags), so use this.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c | 685 ++++++++++++++++++--------------------
 1 file changed, 333 insertions(+), 352 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f351f7325f20..345a351909c5 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -70,188 +70,180 @@
 
 int main(void)
 {
-	DEFINE(THREAD, offsetof(struct task_struct, thread));
-	DEFINE(MM, offsetof(struct task_struct, mm));
-	DEFINE(MMCONTEXTID, offsetof(struct mm_struct, context.id));
+	OFFSET(THREAD, task_struct, thread);
+	OFFSET(MM, task_struct, mm);
+	OFFSET(MMCONTEXTID, mm_struct, context.id);
 #ifdef CONFIG_PPC64
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
-	DEFINE(TASKTHREADPPR, offsetof(struct task_struct, thread.ppr));
+	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
-	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
+	OFFSET(THREAD_INFO, task_struct, stack);
 	DEFINE(THREAD_INFO_GAP, _ALIGN_UP(sizeof(struct thread_info), 16));
-	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
+	OFFSET(KSP_LIMIT, thread_struct, ksp_limit);
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_LIVEPATCH
-	DEFINE(TI_livepatch_sp, offsetof(struct thread_info, livepatch_sp));
+	OFFSET(TI_livepatch_sp, thread_info, livepatch_sp);
 #endif
 
-	DEFINE(KSP, offsetof(struct thread_struct, ksp));
-	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
+	OFFSET(KSP, thread_struct, ksp);
+	OFFSET(PT_REGS, thread_struct, regs);
 #ifdef CONFIG_BOOKE
-	DEFINE(THREAD_NORMSAVES, offsetof(struct thread_struct, normsave[0]));
+	OFFSET(THREAD_NORMSAVES, thread_struct, normsave[0]);
 #endif
-	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
-	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fp_state));
-	DEFINE(THREAD_FPSAVEAREA, offsetof(struct thread_struct, fp_save_area));
-	DEFINE(FPSTATE_FPSCR, offsetof(struct thread_fp_state, fpscr));
-	DEFINE(THREAD_LOAD_FP, offsetof(struct thread_struct, load_fp));
+	OFFSET(THREAD_FPEXC_MODE, thread_struct, fpexc_mode);
+	OFFSET(THREAD_FPSTATE, thread_struct, fp_state);
+	OFFSET(THREAD_FPSAVEAREA, thread_struct, fp_save_area);
+	OFFSET(FPSTATE_FPSCR, thread_fp_state, fpscr);
+	OFFSET(THREAD_LOAD_FP, thread_struct, load_fp);
 #ifdef CONFIG_ALTIVEC
-	DEFINE(THREAD_VRSTATE, offsetof(struct thread_struct, vr_state));
-	DEFINE(THREAD_VRSAVEAREA, offsetof(struct thread_struct, vr_save_area));
-	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
-	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
-	DEFINE(VRSTATE_VSCR, offsetof(struct thread_vr_state, vscr));
-	DEFINE(THREAD_LOAD_VEC, offsetof(struct thread_struct, load_vec));
+	OFFSET(THREAD_VRSTATE, thread_struct, vr_state);
+	OFFSET(THREAD_VRSAVEAREA, thread_struct, vr_save_area);
+	OFFSET(THREAD_VRSAVE, thread_struct, vrsave);
+	OFFSET(THREAD_USED_VR, thread_struct, used_vr);
+	OFFSET(VRSTATE_VSCR, thread_vr_state, vscr);
+	OFFSET(THREAD_LOAD_VEC, thread_struct, load_vec);
 #endif /* CONFIG_ALTIVEC */
 #ifdef CONFIG_VSX
-	DEFINE(THREAD_USED_VSR, offsetof(struct thread_struct, used_vsr));
+	OFFSET(THREAD_USED_VSR, thread_struct, used_vsr);
 #endif /* CONFIG_VSX */
 #ifdef CONFIG_PPC64
-	DEFINE(KSP_VSID, offsetof(struct thread_struct, ksp_vsid));
+	OFFSET(KSP_VSID, thread_struct, ksp_vsid);
 #else /* CONFIG_PPC64 */
-	DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
+	OFFSET(PGDIR, thread_struct, pgdir);
 #ifdef CONFIG_SPE
-	DEFINE(THREAD_EVR0, offsetof(struct thread_struct, evr[0]));
-	DEFINE(THREAD_ACC, offsetof(struct thread_struct, acc));
-	DEFINE(THREAD_SPEFSCR, offsetof(struct thread_struct, spefscr));
-	DEFINE(THREAD_USED_SPE, offsetof(struct thread_struct, used_spe));
+	OFFSET(THREAD_EVR0, thread_struct, evr[0]);
+	OFFSET(THREAD_ACC, thread_struct, acc);
+	OFFSET(THREAD_SPEFSCR, thread_struct, spefscr);
+	OFFSET(THREAD_USED_SPE, thread_struct, used_spe);
 #endif /* CONFIG_SPE */
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-	DEFINE(THREAD_DBCR0, offsetof(struct thread_struct, debug.dbcr0));
+	OFFSET(THREAD_DBCR0, thread_struct, debug.dbcr0);
 #endif
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
-	DEFINE(THREAD_KVM_SVCPU, offsetof(struct thread_struct, kvm_shadow_vcpu));
+	OFFSET(THREAD_KVM_SVCPU, thread_struct, kvm_shadow_vcpu);
 #endif
 #if defined(CONFIG_KVM) && defined(CONFIG_BOOKE)
-	DEFINE(THREAD_KVM_VCPU, offsetof(struct thread_struct, kvm_vcpu));
+	OFFSET(THREAD_KVM_VCPU, thread_struct, kvm_vcpu);
 #endif
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	DEFINE(PACATMSCRATCH, offsetof(struct paca_struct, tm_scratch));
-	DEFINE(THREAD_TM_TFHAR, offsetof(struct thread_struct, tm_tfhar));
-	DEFINE(THREAD_TM_TEXASR, offsetof(struct thread_struct, tm_texasr));
-	DEFINE(THREAD_TM_TFIAR, offsetof(struct thread_struct, tm_tfiar));
-	DEFINE(THREAD_TM_TAR, offsetof(struct thread_struct, tm_tar));
-	DEFINE(THREAD_TM_PPR, offsetof(struct thread_struct, tm_ppr));
-	DEFINE(THREAD_TM_DSCR, offsetof(struct thread_struct, tm_dscr));
-	DEFINE(PT_CKPT_REGS, offsetof(struct thread_struct, ckpt_regs));
-	DEFINE(THREAD_TRANSACT_VRSTATE, offsetof(struct thread_struct,
-						 transact_vr));
-	DEFINE(THREAD_TRANSACT_VRSAVE, offsetof(struct thread_struct,
-					    transact_vrsave));
-	DEFINE(THREAD_TRANSACT_FPSTATE, offsetof(struct thread_struct,
-						 transact_fp));
+	OFFSET(PACATMSCRATCH, paca_struct, tm_scratch);
+	OFFSET(THREAD_TM_TFHAR, thread_struct, tm_tfhar);
+	OFFSET(THREAD_TM_TEXASR, thread_struct, tm_texasr);
+	OFFSET(THREAD_TM_TFIAR, thread_struct, tm_tfiar);
+	OFFSET(THREAD_TM_TAR, thread_struct, tm_tar);
+	OFFSET(THREAD_TM_PPR, thread_struct, tm_ppr);
+	OFFSET(THREAD_TM_DSCR, thread_struct, tm_dscr);
+	OFFSET(PT_CKPT_REGS, thread_struct, ckpt_regs);
+	OFFSET(THREAD_TRANSACT_VRSTATE, thread_struct, transact_vr);
+	OFFSET(THREAD_TRANSACT_VRSAVE, thread_struct, transact_vrsave);
+	OFFSET(THREAD_TRANSACT_FPSTATE, thread_struct, transact_fp);
 	/* Local pt_regs on stack for Transactional Memory funcs. */
 	DEFINE(TM_FRAME_SIZE, STACK_FRAME_OVERHEAD +
 	       sizeof(struct pt_regs) + 16);
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
-	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
-	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
-	DEFINE(TI_TASK, offsetof(struct thread_info, task));
-	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
+	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_LOCAL_FLAGS, thread_info, local_flags);
+	OFFSET(TI_PREEMPT, thread_info, preempt_count);
+	OFFSET(TI_TASK, thread_info, task);
+	OFFSET(TI_CPU, thread_info, cpu);
 
 #ifdef CONFIG_PPC64
-	DEFINE(DCACHEL1LINESIZE, offsetof(struct ppc64_caches, dline_size));
-	DEFINE(DCACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_dline_size));
-	DEFINE(DCACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, dlines_per_page));
-	DEFINE(ICACHEL1LINESIZE, offsetof(struct ppc64_caches, iline_size));
-	DEFINE(ICACHEL1LOGLINESIZE, offsetof(struct ppc64_caches, log_iline_size));
-	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
+	OFFSET(DCACHEL1LINESIZE, ppc64_caches, dline_size);
+	OFFSET(DCACHEL1LOGLINESIZE, ppc64_caches, log_dline_size);
+	OFFSET(DCACHEL1LINESPERPAGE, ppc64_caches, dlines_per_page);
+	OFFSET(ICACHEL1LINESIZE, ppc64_caches, iline_size);
+	OFFSET(ICACHEL1LOGLINESIZE, ppc64_caches, log_iline_size);
+	OFFSET(ICACHEL1LINESPERPAGE, ppc64_caches, ilines_per_page);
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
-	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
-	DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
-	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
-	DEFINE(PACACURRENT, offsetof(struct paca_struct, __current));
-	DEFINE(PACASAVEDMSR, offsetof(struct paca_struct, saved_msr));
-	DEFINE(PACASTABRR, offsetof(struct paca_struct, stab_rr));
-	DEFINE(PACAR1, offsetof(struct paca_struct, saved_r1));
-	DEFINE(PACATOC, offsetof(struct paca_struct, kernel_toc));
-	DEFINE(PACAKBASE, offsetof(struct paca_struct, kernelbase));
-	DEFINE(PACAKMSR, offsetof(struct paca_struct, kernel_msr));
-	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
-	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
+	OFFSET(PACAPACAINDEX, paca_struct, paca_index);
+	OFFSET(PACAPROCSTART, paca_struct, cpu_start);
+	OFFSET(PACAKSAVE, paca_struct, kstack);
+	OFFSET(PACACURRENT, paca_struct, __current);
+	OFFSET(PACASAVEDMSR, paca_struct, saved_msr);
+	OFFSET(PACASTABRR, paca_struct, stab_rr);
+	OFFSET(PACAR1, paca_struct, saved_r1);
+	OFFSET(PACATOC, paca_struct, kernel_toc);
+	OFFSET(PACAKBASE, paca_struct, kernelbase);
+	OFFSET(PACAKMSR, paca_struct, kernel_msr);
+	OFFSET(PACASOFTIRQEN, paca_struct, soft_enabled);
+	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 #ifdef CONFIG_PPC_BOOK3S
-	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, mm_ctx_id));
+	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
 #ifdef CONFIG_PPC_MM_SLICES
-	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
-					    mm_ctx_low_slices_psize));
-	DEFINE(PACAHIGHSLICEPSIZE, offsetof(struct paca_struct,
-					    mm_ctx_high_slices_psize));
+	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
+	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E
-	DEFINE(PACAPGD, offsetof(struct paca_struct, pgd));
-	DEFINE(PACA_KERNELPGD, offsetof(struct paca_struct, kernel_pgd));
-	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
-	DEFINE(PACA_EXTLB, offsetof(struct paca_struct, extlb));
-	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
-	DEFINE(PACA_EXCRIT, offsetof(struct paca_struct, excrit));
-	DEFINE(PACA_EXDBG, offsetof(struct paca_struct, exdbg));
-	DEFINE(PACA_MC_STACK, offsetof(struct paca_struct, mc_kstack));
-	DEFINE(PACA_CRIT_STACK, offsetof(struct paca_struct, crit_kstack));
-	DEFINE(PACA_DBG_STACK, offsetof(struct paca_struct, dbg_kstack));
-	DEFINE(PACA_TCD_PTR, offsetof(struct paca_struct, tcd_ptr));
-
-	DEFINE(TCD_ESEL_NEXT,
-		offsetof(struct tlb_core_data, esel_next));
-	DEFINE(TCD_ESEL_MAX,
-		offsetof(struct tlb_core_data, esel_max));
-	DEFINE(TCD_ESEL_FIRST,
-		offsetof(struct tlb_core_data, esel_first));
+	OFFSET(PACAPGD, paca_struct, pgd);
+	OFFSET(PACA_KERNELPGD, paca_struct, kernel_pgd);
+	OFFSET(PACA_EXGEN, paca_struct, exgen);
+	OFFSET(PACA_EXTLB, paca_struct, extlb);
+	OFFSET(PACA_EXMC, paca_struct, exmc);
+	OFFSET(PACA_EXCRIT, paca_struct, excrit);
+	OFFSET(PACA_EXDBG, paca_struct, exdbg);
+	OFFSET(PACA_MC_STACK, paca_struct, mc_kstack);
+	OFFSET(PACA_CRIT_STACK, paca_struct, crit_kstack);
+	OFFSET(PACA_DBG_STACK, paca_struct, dbg_kstack);
+	OFFSET(PACA_TCD_PTR, paca_struct, tcd_ptr);
+
+	OFFSET(TCD_ESEL_NEXT, tlb_core_data, esel_next);
+	OFFSET(TCD_ESEL_MAX, tlb_core_data, esel_max);
+	OFFSET(TCD_ESEL_FIRST, tlb_core_data, esel_first);
 #endif /* CONFIG_PPC_BOOK3E */
 
 #ifdef CONFIG_PPC_STD_MMU_64
-	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
-	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
-	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
+	OFFSET(PACASLBCACHE, paca_struct, slb_cache);
+	OFFSET(PACASLBCACHEPTR, paca_struct, slb_cache_ptr);
+	OFFSET(PACAVMALLOCSLLP, paca_struct, vmalloc_sllp);
 #ifdef CONFIG_PPC_MM_SLICES
-	DEFINE(MMUPSIZESLLP, offsetof(struct mmu_psize_def, sllp));
+	OFFSET(MMUPSIZESLLP, mmu_psize_def, sllp);
 #else
-	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, mm_ctx_sllp));
+	OFFSET(PACACONTEXTSLLP, paca_struct, mm_ctx_sllp);
 #endif /* CONFIG_PPC_MM_SLICES */
-	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
-	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
-	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
-	DEFINE(PACALPPACAPTR, offsetof(struct paca_struct, lppaca_ptr));
-	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
-	DEFINE(SLBSHADOW_STACKVSID,
-	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].vsid));
-	DEFINE(SLBSHADOW_STACKESID,
-	       offsetof(struct slb_shadow, save_area[SLB_NUM_BOLTED - 1].esid));
-	DEFINE(SLBSHADOW_SAVEAREA, offsetof(struct slb_shadow, save_area));
-	DEFINE(LPPACA_PMCINUSE, offsetof(struct lppaca, pmcregs_in_use));
-	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
-	DEFINE(LPPACA_YIELDCOUNT, offsetof(struct lppaca, yield_count));
-	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
+	OFFSET(PACA_EXGEN, paca_struct, exgen);
+	OFFSET(PACA_EXMC, paca_struct, exmc);
+	OFFSET(PACA_EXSLB, paca_struct, exslb);
+	OFFSET(PACALPPACAPTR, paca_struct, lppaca_ptr);
+	OFFSET(PACA_SLBSHADOWPTR, paca_struct, slb_shadow_ptr);
+	OFFSET(SLBSHADOW_STACKVSID, slb_shadow, save_area[SLB_NUM_BOLTED -
+			1].vsid);
+	OFFSET(SLBSHADOW_STACKESID, slb_shadow, save_area[SLB_NUM_BOLTED -
+			1].esid);
+	OFFSET(SLBSHADOW_SAVEAREA, slb_shadow, save_area);
+	OFFSET(LPPACA_PMCINUSE, lppaca, pmcregs_in_use);
+	OFFSET(LPPACA_DTLIDX, lppaca, dtl_idx);
+	OFFSET(LPPACA_YIELDCOUNT, lppaca, yield_count);
+	OFFSET(PACA_DTL_RIDX, paca_struct, dtl_ridx);
 #endif /* CONFIG_PPC_STD_MMU_64 */
-	DEFINE(PACAEMERGSP, offsetof(struct paca_struct, emergency_sp));
+	OFFSET(PACAEMERGSP, paca_struct, emergency_sp);
 #ifdef CONFIG_PPC_BOOK3S_64
-	DEFINE(PACAMCEMERGSP, offsetof(struct paca_struct, mc_emergency_sp));
-	DEFINE(PACA_IN_MCE, offsetof(struct paca_struct, in_mce));
-#endif
-	DEFINE(PACAHWCPUID, offsetof(struct paca_struct, hw_cpu_id));
-	DEFINE(PACAKEXECSTATE, offsetof(struct paca_struct, kexec_state));
-	DEFINE(PACA_DSCR_DEFAULT, offsetof(struct paca_struct, dscr_default));
-	DEFINE(PACA_STARTTIME, offsetof(struct paca_struct, starttime));
-	DEFINE(PACA_STARTTIME_USER, offsetof(struct paca_struct, starttime_user));
-	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
-	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
-	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
-	DEFINE(PACA_NAPSTATELOST, offsetof(struct paca_struct, nap_state_lost));
-	DEFINE(PACA_SPRG_VDSO, offsetof(struct paca_struct, sprg_vdso));
+	OFFSET(PACAMCEMERGSP, paca_struct, mc_emergency_sp);
+	OFFSET(PACA_IN_MCE, paca_struct, in_mce);
+#endif
+	OFFSET(PACAHWCPUID, paca_struct, hw_cpu_id);
+	OFFSET(PACAKEXECSTATE, paca_struct, kexec_state);
+	OFFSET(PACA_DSCR_DEFAULT, paca_struct, dscr_default);
+	OFFSET(PACA_STARTTIME, paca_struct, starttime);
+	OFFSET(PACA_STARTTIME_USER, paca_struct, starttime_user);
+	OFFSET(PACA_USER_TIME, paca_struct, user_time);
+	OFFSET(PACA_SYSTEM_TIME, paca_struct, system_time);
+	OFFSET(PACA_TRAP_SAVE, paca_struct, trap_save);
+	OFFSET(PACA_NAPSTATELOST, paca_struct, nap_state_lost);
+	OFFSET(PACA_SPRG_VDSO, paca_struct, sprg_vdso);
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
-	DEFINE(RTASBASE, offsetof(struct rtas_t, base));
-	DEFINE(RTASENTRY, offsetof(struct rtas_t, entry));
+	OFFSET(RTASBASE, rtas_t, base);
+	OFFSET(RTASENTRY, rtas_t, entry);
 
 	/* Interrupt register frame */
 	DEFINE(INT_FRAME_SIZE, STACK_INT_FRAME_SIZE);
@@ -332,17 +324,17 @@ int main(void)
 #endif
 
 #ifndef CONFIG_PPC64
-	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
+	OFFSET(MM_PGD, mm_struct, pgd);
 #endif /* ! CONFIG_PPC64 */
 
 	/* About the CPU features table */
-	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
-	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
-	DEFINE(CPU_SPEC_RESTORE, offsetof(struct cpu_spec, cpu_restore));
+	OFFSET(CPU_SPEC_FEATURES, cpu_spec, cpu_features);
+	OFFSET(CPU_SPEC_SETUP, cpu_spec, cpu_setup);
+	OFFSET(CPU_SPEC_RESTORE, cpu_spec, cpu_restore);
 
-	DEFINE(pbe_address, offsetof(struct pbe, address));
-	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
-	DEFINE(pbe_next, offsetof(struct pbe, next));
+	OFFSET(pbe_address, pbe, address);
+	OFFSET(pbe_orig_address, pbe, orig_address);
+	OFFSET(pbe_next, pbe, next);
 
 #ifndef CONFIG_PPC64
 	DEFINE(TASK_SIZE, TASK_SIZE);
@@ -350,40 +342,40 @@ int main(void)
 #endif /* ! CONFIG_PPC64 */
 
 	/* datapage offsets for use by vdso */
-	DEFINE(CFG_TB_ORIG_STAMP, offsetof(struct vdso_data, tb_orig_stamp));
-	DEFINE(CFG_TB_TICKS_PER_SEC, offsetof(struct vdso_data, tb_ticks_per_sec));
-	DEFINE(CFG_TB_TO_XS, offsetof(struct vdso_data, tb_to_xs));
-	DEFINE(CFG_TB_UPDATE_COUNT, offsetof(struct vdso_data, tb_update_count));
-	DEFINE(CFG_TZ_MINUTEWEST, offsetof(struct vdso_data, tz_minuteswest));
-	DEFINE(CFG_TZ_DSTTIME, offsetof(struct vdso_data, tz_dsttime));
-	DEFINE(CFG_SYSCALL_MAP32, offsetof(struct vdso_data, syscall_map_32));
-	DEFINE(WTOM_CLOCK_SEC, offsetof(struct vdso_data, wtom_clock_sec));
-	DEFINE(WTOM_CLOCK_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
-	DEFINE(STAMP_XTIME, offsetof(struct vdso_data, stamp_xtime));
-	DEFINE(STAMP_SEC_FRAC, offsetof(struct vdso_data, stamp_sec_fraction));
-	DEFINE(CFG_ICACHE_BLOCKSZ, offsetof(struct vdso_data, icache_block_size));
-	DEFINE(CFG_DCACHE_BLOCKSZ, offsetof(struct vdso_data, dcache_block_size));
-	DEFINE(CFG_ICACHE_LOGBLOCKSZ, offsetof(struct vdso_data, icache_log_block_size));
-	DEFINE(CFG_DCACHE_LOGBLOCKSZ, offsetof(struct vdso_data, dcache_log_block_size));
+	OFFSET(CFG_TB_ORIG_STAMP, vdso_data, tb_orig_stamp);
+	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_data, tb_ticks_per_sec);
+	OFFSET(CFG_TB_TO_XS, vdso_data, tb_to_xs);
+	OFFSET(CFG_TB_UPDATE_COUNT, vdso_data, tb_update_count);
+	OFFSET(CFG_TZ_MINUTEWEST, vdso_data, tz_minuteswest);
+	OFFSET(CFG_TZ_DSTTIME, vdso_data, tz_dsttime);
+	OFFSET(CFG_SYSCALL_MAP32, vdso_data, syscall_map_32);
+	OFFSET(WTOM_CLOCK_SEC, vdso_data, wtom_clock_sec);
+	OFFSET(WTOM_CLOCK_NSEC, vdso_data, wtom_clock_nsec);
+	OFFSET(STAMP_XTIME, vdso_data, stamp_xtime);
+	OFFSET(STAMP_SEC_FRAC, vdso_data, stamp_sec_fraction);
+	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_data, icache_block_size);
+	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_data, dcache_block_size);
+	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_data, icache_log_block_size);
+	OFFSET(CFG_DCACHE_LOGBLOCKSZ, vdso_data, dcache_log_block_size);
 #ifdef CONFIG_PPC64
-	DEFINE(CFG_SYSCALL_MAP64, offsetof(struct vdso_data, syscall_map_64));
-	DEFINE(TVAL64_TV_SEC, offsetof(struct timeval, tv_sec));
-	DEFINE(TVAL64_TV_USEC, offsetof(struct timeval, tv_usec));
-	DEFINE(TVAL32_TV_SEC, offsetof(struct compat_timeval, tv_sec));
-	DEFINE(TVAL32_TV_USEC, offsetof(struct compat_timeval, tv_usec));
-	DEFINE(TSPC64_TV_SEC, offsetof(struct timespec, tv_sec));
-	DEFINE(TSPC64_TV_NSEC, offsetof(struct timespec, tv_nsec));
-	DEFINE(TSPC32_TV_SEC, offsetof(struct compat_timespec, tv_sec));
-	DEFINE(TSPC32_TV_NSEC, offsetof(struct compat_timespec, tv_nsec));
+	OFFSET(CFG_SYSCALL_MAP64, vdso_data, syscall_map_64);
+	OFFSET(TVAL64_TV_SEC, timeval, tv_sec);
+	OFFSET(TVAL64_TV_USEC, timeval, tv_usec);
+	OFFSET(TVAL32_TV_SEC, compat_timeval, tv_sec);
+	OFFSET(TVAL32_TV_USEC, compat_timeval, tv_usec);
+	OFFSET(TSPC64_TV_SEC, timespec, tv_sec);
+	OFFSET(TSPC64_TV_NSEC, timespec, tv_nsec);
+	OFFSET(TSPC32_TV_SEC, compat_timespec, tv_sec);
+	OFFSET(TSPC32_TV_NSEC, compat_timespec, tv_nsec);
 #else
-	DEFINE(TVAL32_TV_SEC, offsetof(struct timeval, tv_sec));
-	DEFINE(TVAL32_TV_USEC, offsetof(struct timeval, tv_usec));
-	DEFINE(TSPC32_TV_SEC, offsetof(struct timespec, tv_sec));
-	DEFINE(TSPC32_TV_NSEC, offsetof(struct timespec, tv_nsec));
+	OFFSET(TVAL32_TV_SEC, timeval, tv_sec);
+	OFFSET(TVAL32_TV_USEC, timeval, tv_usec);
+	OFFSET(TSPC32_TV_SEC, timespec, tv_sec);
+	OFFSET(TSPC32_TV_NSEC, timespec, tv_nsec);
 #endif
 	/* timeval/timezone offsets for use by vdso */
-	DEFINE(TZONE_TZ_MINWEST, offsetof(struct timezone, tz_minuteswest));
-	DEFINE(TZONE_TZ_DSTTIME, offsetof(struct timezone, tz_dsttime));
+	OFFSET(TZONE_TZ_MINWEST, timezone, tz_minuteswest);
+	OFFSET(TZONE_TZ_DSTTIME, timezone, tz_dsttime);
 
 	/* Other bits used by the vdso */
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
@@ -403,163 +395,163 @@ int main(void)
 	DEFINE(PTE_SIZE, sizeof(pte_t));
 
 #ifdef CONFIG_KVM
-	DEFINE(VCPU_HOST_STACK, offsetof(struct kvm_vcpu, arch.host_stack));
-	DEFINE(VCPU_HOST_PID, offsetof(struct kvm_vcpu, arch.host_pid));
-	DEFINE(VCPU_GUEST_PID, offsetof(struct kvm_vcpu, arch.pid));
-	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.gpr));
-	DEFINE(VCPU_VRSAVE, offsetof(struct kvm_vcpu, arch.vrsave));
-	DEFINE(VCPU_FPRS, offsetof(struct kvm_vcpu, arch.fp.fpr));
+	OFFSET(VCPU_HOST_STACK, kvm_vcpu, arch.host_stack);
+	OFFSET(VCPU_HOST_PID, kvm_vcpu, arch.host_pid);
+	OFFSET(VCPU_GUEST_PID, kvm_vcpu, arch.pid);
+	OFFSET(VCPU_GPRS, kvm_vcpu, arch.gpr);
+	OFFSET(VCPU_VRSAVE, kvm_vcpu, arch.vrsave);
+	OFFSET(VCPU_FPRS, kvm_vcpu, arch.fp.fpr);
 #ifdef CONFIG_ALTIVEC
-	DEFINE(VCPU_VRS, offsetof(struct kvm_vcpu, arch.vr.vr));
+	OFFSET(VCPU_VRS, kvm_vcpu, arch.vr.vr);
 #endif
-	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
-	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
-	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
+	OFFSET(VCPU_XER, kvm_vcpu, arch.xer);
+	OFFSET(VCPU_CTR, kvm_vcpu, arch.ctr);
+	OFFSET(VCPU_LR, kvm_vcpu, arch.lr);
 #ifdef CONFIG_PPC_BOOK3S
-	DEFINE(VCPU_TAR, offsetof(struct kvm_vcpu, arch.tar));
+	OFFSET(VCPU_TAR, kvm_vcpu, arch.tar);
 #endif
-	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
-	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
+	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
+	OFFSET(VCPU_PC, kvm_vcpu, arch.pc);
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	DEFINE(VCPU_MSR, offsetof(struct kvm_vcpu, arch.shregs.msr));
-	DEFINE(VCPU_SRR0, offsetof(struct kvm_vcpu, arch.shregs.srr0));
-	DEFINE(VCPU_SRR1, offsetof(struct kvm_vcpu, arch.shregs.srr1));
-	DEFINE(VCPU_SPRG0, offsetof(struct kvm_vcpu, arch.shregs.sprg0));
-	DEFINE(VCPU_SPRG1, offsetof(struct kvm_vcpu, arch.shregs.sprg1));
-	DEFINE(VCPU_SPRG2, offsetof(struct kvm_vcpu, arch.shregs.sprg2));
-	DEFINE(VCPU_SPRG3, offsetof(struct kvm_vcpu, arch.shregs.sprg3));
+	OFFSET(VCPU_MSR, kvm_vcpu, arch.shregs.msr);
+	OFFSET(VCPU_SRR0, kvm_vcpu, arch.shregs.srr0);
+	OFFSET(VCPU_SRR1, kvm_vcpu, arch.shregs.srr1);
+	OFFSET(VCPU_SPRG0, kvm_vcpu, arch.shregs.sprg0);
+	OFFSET(VCPU_SPRG1, kvm_vcpu, arch.shregs.sprg1);
+	OFFSET(VCPU_SPRG2, kvm_vcpu, arch.shregs.sprg2);
+	OFFSET(VCPU_SPRG3, kvm_vcpu, arch.shregs.sprg3);
 #endif
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
-	DEFINE(VCPU_TB_RMENTRY, offsetof(struct kvm_vcpu, arch.rm_entry));
-	DEFINE(VCPU_TB_RMINTR, offsetof(struct kvm_vcpu, arch.rm_intr));
-	DEFINE(VCPU_TB_RMEXIT, offsetof(struct kvm_vcpu, arch.rm_exit));
-	DEFINE(VCPU_TB_GUEST, offsetof(struct kvm_vcpu, arch.guest_time));
-	DEFINE(VCPU_TB_CEDE, offsetof(struct kvm_vcpu, arch.cede_time));
-	DEFINE(VCPU_CUR_ACTIVITY, offsetof(struct kvm_vcpu, arch.cur_activity));
-	DEFINE(VCPU_ACTIVITY_START, offsetof(struct kvm_vcpu, arch.cur_tb_start));
-	DEFINE(TAS_SEQCOUNT, offsetof(struct kvmhv_tb_accumulator, seqcount));
-	DEFINE(TAS_TOTAL, offsetof(struct kvmhv_tb_accumulator, tb_total));
-	DEFINE(TAS_MIN, offsetof(struct kvmhv_tb_accumulator, tb_min));
-	DEFINE(TAS_MAX, offsetof(struct kvmhv_tb_accumulator, tb_max));
-#endif
-	DEFINE(VCPU_SHARED_SPRG3, offsetof(struct kvm_vcpu_arch_shared, sprg3));
-	DEFINE(VCPU_SHARED_SPRG4, offsetof(struct kvm_vcpu_arch_shared, sprg4));
-	DEFINE(VCPU_SHARED_SPRG5, offsetof(struct kvm_vcpu_arch_shared, sprg5));
-	DEFINE(VCPU_SHARED_SPRG6, offsetof(struct kvm_vcpu_arch_shared, sprg6));
-	DEFINE(VCPU_SHARED_SPRG7, offsetof(struct kvm_vcpu_arch_shared, sprg7));
-	DEFINE(VCPU_SHADOW_PID, offsetof(struct kvm_vcpu, arch.shadow_pid));
-	DEFINE(VCPU_SHADOW_PID1, offsetof(struct kvm_vcpu, arch.shadow_pid1));
-	DEFINE(VCPU_SHARED, offsetof(struct kvm_vcpu, arch.shared));
-	DEFINE(VCPU_SHARED_MSR, offsetof(struct kvm_vcpu_arch_shared, msr));
-	DEFINE(VCPU_SHADOW_MSR, offsetof(struct kvm_vcpu, arch.shadow_msr));
+	OFFSET(VCPU_TB_RMENTRY, kvm_vcpu, arch.rm_entry);
+	OFFSET(VCPU_TB_RMINTR, kvm_vcpu, arch.rm_intr);
+	OFFSET(VCPU_TB_RMEXIT, kvm_vcpu, arch.rm_exit);
+	OFFSET(VCPU_TB_GUEST, kvm_vcpu, arch.guest_time);
+	OFFSET(VCPU_TB_CEDE, kvm_vcpu, arch.cede_time);
+	OFFSET(VCPU_CUR_ACTIVITY, kvm_vcpu, arch.cur_activity);
+	OFFSET(VCPU_ACTIVITY_START, kvm_vcpu, arch.cur_tb_start);
+	OFFSET(TAS_SEQCOUNT, kvmhv_tb_accumulator, seqcount);
+	OFFSET(TAS_TOTAL, kvmhv_tb_accumulator, tb_total);
+	OFFSET(TAS_MIN, kvmhv_tb_accumulator, tb_min);
+	OFFSET(TAS_MAX, kvmhv_tb_accumulator, tb_max);
+#endif
+	OFFSET(VCPU_SHARED_SPRG3, kvm_vcpu_arch_shared, sprg3);
+	OFFSET(VCPU_SHARED_SPRG4, kvm_vcpu_arch_shared, sprg4);
+	OFFSET(VCPU_SHARED_SPRG5, kvm_vcpu_arch_shared, sprg5);
+	OFFSET(VCPU_SHARED_SPRG6, kvm_vcpu_arch_shared, sprg6);
+	OFFSET(VCPU_SHARED_SPRG7, kvm_vcpu_arch_shared, sprg7);
+	OFFSET(VCPU_SHADOW_PID, kvm_vcpu, arch.shadow_pid);
+	OFFSET(VCPU_SHADOW_PID1, kvm_vcpu, arch.shadow_pid1);
+	OFFSET(VCPU_SHARED, kvm_vcpu, arch.shared);
+	OFFSET(VCPU_SHARED_MSR, kvm_vcpu_arch_shared, msr);
+	OFFSET(VCPU_SHADOW_MSR, kvm_vcpu, arch.shadow_msr);
 #if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_KVM_BOOK3S_PR_POSSIBLE)
-	DEFINE(VCPU_SHAREDBE, offsetof(struct kvm_vcpu, arch.shared_big_endian));
+	OFFSET(VCPU_SHAREDBE, kvm_vcpu, arch.shared_big_endian);
 #endif
 
-	DEFINE(VCPU_SHARED_MAS0, offsetof(struct kvm_vcpu_arch_shared, mas0));
-	DEFINE(VCPU_SHARED_MAS1, offsetof(struct kvm_vcpu_arch_shared, mas1));
-	DEFINE(VCPU_SHARED_MAS2, offsetof(struct kvm_vcpu_arch_shared, mas2));
-	DEFINE(VCPU_SHARED_MAS7_3, offsetof(struct kvm_vcpu_arch_shared, mas7_3));
-	DEFINE(VCPU_SHARED_MAS4, offsetof(struct kvm_vcpu_arch_shared, mas4));
-	DEFINE(VCPU_SHARED_MAS6, offsetof(struct kvm_vcpu_arch_shared, mas6));
+	OFFSET(VCPU_SHARED_MAS0, kvm_vcpu_arch_shared, mas0);
+	OFFSET(VCPU_SHARED_MAS1, kvm_vcpu_arch_shared, mas1);
+	OFFSET(VCPU_SHARED_MAS2, kvm_vcpu_arch_shared, mas2);
+	OFFSET(VCPU_SHARED_MAS7_3, kvm_vcpu_arch_shared, mas7_3);
+	OFFSET(VCPU_SHARED_MAS4, kvm_vcpu_arch_shared, mas4);
+	OFFSET(VCPU_SHARED_MAS6, kvm_vcpu_arch_shared, mas6);
 
-	DEFINE(VCPU_KVM, offsetof(struct kvm_vcpu, kvm));
-	DEFINE(KVM_LPID, offsetof(struct kvm, arch.lpid));
+	OFFSET(VCPU_KVM, kvm_vcpu, kvm);
+	OFFSET(KVM_LPID, kvm, arch.lpid);
 
 	/* book3s */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	DEFINE(KVM_SDR1, offsetof(struct kvm, arch.sdr1));
-	DEFINE(KVM_HOST_LPID, offsetof(struct kvm, arch.host_lpid));
-	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
-	DEFINE(KVM_HOST_SDR1, offsetof(struct kvm, arch.host_sdr1));
-	DEFINE(KVM_NEED_FLUSH, offsetof(struct kvm, arch.need_tlb_flush.bits));
-	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
-	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
-	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
-	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
-	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
-	DEFINE(VCPU_VPA_DIRTY, offsetof(struct kvm_vcpu, arch.vpa.dirty));
-	DEFINE(VCPU_HEIR, offsetof(struct kvm_vcpu, arch.emul_inst));
-	DEFINE(VCPU_CPU, offsetof(struct kvm_vcpu, cpu));
-	DEFINE(VCPU_THREAD_CPU, offsetof(struct kvm_vcpu, arch.thread_cpu));
+	OFFSET(KVM_SDR1, kvm, arch.sdr1);
+	OFFSET(KVM_HOST_LPID, kvm, arch.host_lpid);
+	OFFSET(KVM_HOST_LPCR, kvm, arch.host_lpcr);
+	OFFSET(KVM_HOST_SDR1, kvm, arch.host_sdr1);
+	OFFSET(KVM_NEED_FLUSH, kvm, arch.need_tlb_flush.bits);
+	OFFSET(KVM_ENABLED_HCALLS, kvm, arch.enabled_hcalls);
+	OFFSET(KVM_VRMA_SLB_V, kvm, arch.vrma_slb_v);
+	OFFSET(VCPU_DSISR, kvm_vcpu, arch.shregs.dsisr);
+	OFFSET(VCPU_DAR, kvm_vcpu, arch.shregs.dar);
+	OFFSET(VCPU_VPA, kvm_vcpu, arch.vpa.pinned_addr);
+	OFFSET(VCPU_VPA_DIRTY, kvm_vcpu, arch.vpa.dirty);
+	OFFSET(VCPU_HEIR, kvm_vcpu, arch.emul_inst);
+	OFFSET(VCPU_CPU, kvm_vcpu, cpu);
+	OFFSET(VCPU_THREAD_CPU, kvm_vcpu, arch.thread_cpu);
 #endif
 #ifdef CONFIG_PPC_BOOK3S
-	DEFINE(VCPU_PURR, offsetof(struct kvm_vcpu, arch.purr));
-	DEFINE(VCPU_SPURR, offsetof(struct kvm_vcpu, arch.spurr));
-	DEFINE(VCPU_IC, offsetof(struct kvm_vcpu, arch.ic));
-	DEFINE(VCPU_VTB, offsetof(struct kvm_vcpu, arch.vtb));
-	DEFINE(VCPU_DSCR, offsetof(struct kvm_vcpu, arch.dscr));
-	DEFINE(VCPU_AMR, offsetof(struct kvm_vcpu, arch.amr));
-	DEFINE(VCPU_UAMOR, offsetof(struct kvm_vcpu, arch.uamor));
-	DEFINE(VCPU_IAMR, offsetof(struct kvm_vcpu, arch.iamr));
-	DEFINE(VCPU_CTRL, offsetof(struct kvm_vcpu, arch.ctrl));
-	DEFINE(VCPU_DABR, offsetof(struct kvm_vcpu, arch.dabr));
-	DEFINE(VCPU_DABRX, offsetof(struct kvm_vcpu, arch.dabrx));
-	DEFINE(VCPU_DAWR, offsetof(struct kvm_vcpu, arch.dawr));
-	DEFINE(VCPU_DAWRX, offsetof(struct kvm_vcpu, arch.dawrx));
-	DEFINE(VCPU_CIABR, offsetof(struct kvm_vcpu, arch.ciabr));
-	DEFINE(VCPU_HFLAGS, offsetof(struct kvm_vcpu, arch.hflags));
-	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
-	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
-	DEFINE(VCPU_PENDING_EXC, offsetof(struct kvm_vcpu, arch.pending_exceptions));
-	DEFINE(VCPU_CEDED, offsetof(struct kvm_vcpu, arch.ceded));
-	DEFINE(VCPU_PRODDED, offsetof(struct kvm_vcpu, arch.prodded));
-	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
-	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
-	DEFINE(VCPU_SIAR, offsetof(struct kvm_vcpu, arch.siar));
-	DEFINE(VCPU_SDAR, offsetof(struct kvm_vcpu, arch.sdar));
-	DEFINE(VCPU_SIER, offsetof(struct kvm_vcpu, arch.sier));
-	DEFINE(VCPU_SLB, offsetof(struct kvm_vcpu, arch.slb));
-	DEFINE(VCPU_SLB_MAX, offsetof(struct kvm_vcpu, arch.slb_max));
-	DEFINE(VCPU_SLB_NR, offsetof(struct kvm_vcpu, arch.slb_nr));
-	DEFINE(VCPU_FAULT_DSISR, offsetof(struct kvm_vcpu, arch.fault_dsisr));
-	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, arch.fault_dar));
-	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));
-	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
-	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
-	DEFINE(VCPU_CFAR, offsetof(struct kvm_vcpu, arch.cfar));
-	DEFINE(VCPU_PPR, offsetof(struct kvm_vcpu, arch.ppr));
-	DEFINE(VCPU_FSCR, offsetof(struct kvm_vcpu, arch.fscr));
-	DEFINE(VCPU_PSPB, offsetof(struct kvm_vcpu, arch.pspb));
-	DEFINE(VCPU_EBBHR, offsetof(struct kvm_vcpu, arch.ebbhr));
-	DEFINE(VCPU_EBBRR, offsetof(struct kvm_vcpu, arch.ebbrr));
-	DEFINE(VCPU_BESCR, offsetof(struct kvm_vcpu, arch.bescr));
-	DEFINE(VCPU_CSIGR, offsetof(struct kvm_vcpu, arch.csigr));
-	DEFINE(VCPU_TACR, offsetof(struct kvm_vcpu, arch.tacr));
-	DEFINE(VCPU_TCSCR, offsetof(struct kvm_vcpu, arch.tcscr));
-	DEFINE(VCPU_ACOP, offsetof(struct kvm_vcpu, arch.acop));
-	DEFINE(VCPU_WORT, offsetof(struct kvm_vcpu, arch.wort));
-	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_map));
-	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
-	DEFINE(VCORE_NAPPING_THREADS, offsetof(struct kvmppc_vcore, napping_threads));
-	DEFINE(VCORE_KVM, offsetof(struct kvmppc_vcore, kvm));
-	DEFINE(VCORE_TB_OFFSET, offsetof(struct kvmppc_vcore, tb_offset));
-	DEFINE(VCORE_LPCR, offsetof(struct kvmppc_vcore, lpcr));
-	DEFINE(VCORE_PCR, offsetof(struct kvmppc_vcore, pcr));
-	DEFINE(VCORE_DPDES, offsetof(struct kvmppc_vcore, dpdes));
-	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
-	DEFINE(VCPU_SLB_V, offsetof(struct kvmppc_slb, origv));
+	OFFSET(VCPU_PURR, kvm_vcpu, arch.purr);
+	OFFSET(VCPU_SPURR, kvm_vcpu, arch.spurr);
+	OFFSET(VCPU_IC, kvm_vcpu, arch.ic);
+	OFFSET(VCPU_VTB, kvm_vcpu, arch.vtb);
+	OFFSET(VCPU_DSCR, kvm_vcpu, arch.dscr);
+	OFFSET(VCPU_AMR, kvm_vcpu, arch.amr);
+	OFFSET(VCPU_UAMOR, kvm_vcpu, arch.uamor);
+	OFFSET(VCPU_IAMR, kvm_vcpu, arch.iamr);
+	OFFSET(VCPU_CTRL, kvm_vcpu, arch.ctrl);
+	OFFSET(VCPU_DABR, kvm_vcpu, arch.dabr);
+	OFFSET(VCPU_DABRX, kvm_vcpu, arch.dabrx);
+	OFFSET(VCPU_DAWR, kvm_vcpu, arch.dawr);
+	OFFSET(VCPU_DAWRX, kvm_vcpu, arch.dawrx);
+	OFFSET(VCPU_CIABR, kvm_vcpu, arch.ciabr);
+	OFFSET(VCPU_HFLAGS, kvm_vcpu, arch.hflags);
+	OFFSET(VCPU_DEC, kvm_vcpu, arch.dec);
+	OFFSET(VCPU_DEC_EXPIRES, kvm_vcpu, arch.dec_expires);
+	OFFSET(VCPU_PENDING_EXC, kvm_vcpu, arch.pending_exceptions);
+	OFFSET(VCPU_CEDED, kvm_vcpu, arch.ceded);
+	OFFSET(VCPU_PRODDED, kvm_vcpu, arch.prodded);
+	OFFSET(VCPU_MMCR, kvm_vcpu, arch.mmcr);
+	OFFSET(VCPU_PMC, kvm_vcpu, arch.pmc);
+	OFFSET(VCPU_SIAR, kvm_vcpu, arch.siar);
+	OFFSET(VCPU_SDAR, kvm_vcpu, arch.sdar);
+	OFFSET(VCPU_SIER, kvm_vcpu, arch.sier);
+	OFFSET(VCPU_SLB, kvm_vcpu, arch.slb);
+	OFFSET(VCPU_SLB_MAX, kvm_vcpu, arch.slb_max);
+	OFFSET(VCPU_SLB_NR, kvm_vcpu, arch.slb_nr);
+	OFFSET(VCPU_FAULT_DSISR, kvm_vcpu, arch.fault_dsisr);
+	OFFSET(VCPU_FAULT_DAR, kvm_vcpu, arch.fault_dar);
+	OFFSET(VCPU_INTR_MSR, kvm_vcpu, arch.intr_msr);
+	OFFSET(VCPU_LAST_INST, kvm_vcpu, arch.last_inst);
+	OFFSET(VCPU_TRAP, kvm_vcpu, arch.trap);
+	OFFSET(VCPU_CFAR, kvm_vcpu, arch.cfar);
+	OFFSET(VCPU_PPR, kvm_vcpu, arch.ppr);
+	OFFSET(VCPU_FSCR, kvm_vcpu, arch.fscr);
+	OFFSET(VCPU_PSPB, kvm_vcpu, arch.pspb);
+	OFFSET(VCPU_EBBHR, kvm_vcpu, arch.ebbhr);
+	OFFSET(VCPU_EBBRR, kvm_vcpu, arch.ebbrr);
+	OFFSET(VCPU_BESCR, kvm_vcpu, arch.bescr);
+	OFFSET(VCPU_CSIGR, kvm_vcpu, arch.csigr);
+	OFFSET(VCPU_TACR, kvm_vcpu, arch.tacr);
+	OFFSET(VCPU_TCSCR, kvm_vcpu, arch.tcscr);
+	OFFSET(VCPU_ACOP, kvm_vcpu, arch.acop);
+	OFFSET(VCPU_WORT, kvm_vcpu, arch.wort);
+	OFFSET(VCORE_ENTRY_EXIT, kvmppc_vcore, entry_exit_map);
+	OFFSET(VCORE_IN_GUEST, kvmppc_vcore, in_guest);
+	OFFSET(VCORE_NAPPING_THREADS, kvmppc_vcore, napping_threads);
+	OFFSET(VCORE_KVM, kvmppc_vcore, kvm);
+	OFFSET(VCORE_TB_OFFSET, kvmppc_vcore, tb_offset);
+	OFFSET(VCORE_LPCR, kvmppc_vcore, lpcr);
+	OFFSET(VCORE_PCR, kvmppc_vcore, pcr);
+	OFFSET(VCORE_DPDES, kvmppc_vcore, dpdes);
+	OFFSET(VCPU_SLB_E, kvmppc_slb, orige);
+	OFFSET(VCPU_SLB_V, kvmppc_slb, origv);
 	DEFINE(VCPU_SLB_SIZE, sizeof(struct kvmppc_slb));
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	DEFINE(VCPU_TFHAR, offsetof(struct kvm_vcpu, arch.tfhar));
-	DEFINE(VCPU_TFIAR, offsetof(struct kvm_vcpu, arch.tfiar));
-	DEFINE(VCPU_TEXASR, offsetof(struct kvm_vcpu, arch.texasr));
-	DEFINE(VCPU_GPR_TM, offsetof(struct kvm_vcpu, arch.gpr_tm));
-	DEFINE(VCPU_FPRS_TM, offsetof(struct kvm_vcpu, arch.fp_tm.fpr));
-	DEFINE(VCPU_VRS_TM, offsetof(struct kvm_vcpu, arch.vr_tm.vr));
-	DEFINE(VCPU_VRSAVE_TM, offsetof(struct kvm_vcpu, arch.vrsave_tm));
-	DEFINE(VCPU_CR_TM, offsetof(struct kvm_vcpu, arch.cr_tm));
-	DEFINE(VCPU_LR_TM, offsetof(struct kvm_vcpu, arch.lr_tm));
-	DEFINE(VCPU_CTR_TM, offsetof(struct kvm_vcpu, arch.ctr_tm));
-	DEFINE(VCPU_AMR_TM, offsetof(struct kvm_vcpu, arch.amr_tm));
-	DEFINE(VCPU_PPR_TM, offsetof(struct kvm_vcpu, arch.ppr_tm));
-	DEFINE(VCPU_DSCR_TM, offsetof(struct kvm_vcpu, arch.dscr_tm));
-	DEFINE(VCPU_TAR_TM, offsetof(struct kvm_vcpu, arch.tar_tm));
+	OFFSET(VCPU_TFHAR, kvm_vcpu, arch.tfhar);
+	OFFSET(VCPU_TFIAR, kvm_vcpu, arch.tfiar);
+	OFFSET(VCPU_TEXASR, kvm_vcpu, arch.texasr);
+	OFFSET(VCPU_GPR_TM, kvm_vcpu, arch.gpr_tm);
+	OFFSET(VCPU_FPRS_TM, kvm_vcpu, arch.fp_tm.fpr);
+	OFFSET(VCPU_VRS_TM, kvm_vcpu, arch.vr_tm.vr);
+	OFFSET(VCPU_VRSAVE_TM, kvm_vcpu, arch.vrsave_tm);
+	OFFSET(VCPU_CR_TM, kvm_vcpu, arch.cr_tm);
+	OFFSET(VCPU_LR_TM, kvm_vcpu, arch.lr_tm);
+	OFFSET(VCPU_CTR_TM, kvm_vcpu, arch.ctr_tm);
+	OFFSET(VCPU_AMR_TM, kvm_vcpu, arch.amr_tm);
+	OFFSET(VCPU_PPR_TM, kvm_vcpu, arch.ppr_tm);
+	OFFSET(VCPU_DSCR_TM, kvm_vcpu, arch.dscr_tm);
+	OFFSET(VCPU_TAR_TM, kvm_vcpu, arch.tar_tm);
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
-	DEFINE(PACA_SVCPU, offsetof(struct paca_struct, shadow_vcpu));
+	OFFSET(PACA_SVCPU, paca_struct, shadow_vcpu);
 # define SVCPU_FIELD(x, f)	DEFINE(x, offsetof(struct paca_struct, shadow_vcpu.f))
 #else
 # define SVCPU_FIELD(x, f)
@@ -642,11 +634,11 @@ int main(void)
 	HSTATE_FIELD(HSTATE_DECEXP, dec_expires);
 	HSTATE_FIELD(HSTATE_SPLIT_MODE, kvm_split_mode);
 	DEFINE(IPI_PRIORITY, IPI_PRIORITY);
-	DEFINE(KVM_SPLIT_RPR, offsetof(struct kvm_split_mode, rpr));
-	DEFINE(KVM_SPLIT_PMMAR, offsetof(struct kvm_split_mode, pmmar));
-	DEFINE(KVM_SPLIT_LDBAR, offsetof(struct kvm_split_mode, ldbar));
-	DEFINE(KVM_SPLIT_DO_NAP, offsetof(struct kvm_split_mode, do_nap));
-	DEFINE(KVM_SPLIT_NAPPED, offsetof(struct kvm_split_mode, napped));
+	OFFSET(KVM_SPLIT_RPR, kvm_split_mode, rpr);
+	OFFSET(KVM_SPLIT_PMMAR, kvm_split_mode, pmmar);
+	OFFSET(KVM_SPLIT_LDBAR, kvm_split_mode, ldbar);
+	OFFSET(KVM_SPLIT_DO_NAP, kvm_split_mode, do_nap);
+	OFFSET(KVM_SPLIT_NAPPED, kvm_split_mode, napped);
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -656,32 +648,27 @@ int main(void)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 #else /* CONFIG_PPC_BOOK3S */
-	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
-	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
-	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
-	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
-	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
-	DEFINE(VCPU_SPRG9, offsetof(struct kvm_vcpu, arch.sprg9));
-	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
-	DEFINE(VCPU_FAULT_DEAR, offsetof(struct kvm_vcpu, arch.fault_dear));
-	DEFINE(VCPU_FAULT_ESR, offsetof(struct kvm_vcpu, arch.fault_esr));
-	DEFINE(VCPU_CRIT_SAVE, offsetof(struct kvm_vcpu, arch.crit_save));
+	OFFSET(VCPU_CR, kvm_vcpu, arch.cr);
+	OFFSET(VCPU_XER, kvm_vcpu, arch.xer);
+	OFFSET(VCPU_LR, kvm_vcpu, arch.lr);
+	OFFSET(VCPU_CTR, kvm_vcpu, arch.ctr);
+	OFFSET(VCPU_PC, kvm_vcpu, arch.pc);
+	OFFSET(VCPU_SPRG9, kvm_vcpu, arch.sprg9);
+	OFFSET(VCPU_LAST_INST, kvm_vcpu, arch.last_inst);
+	OFFSET(VCPU_FAULT_DEAR, kvm_vcpu, arch.fault_dear);
+	OFFSET(VCPU_FAULT_ESR, kvm_vcpu, arch.fault_esr);
+	OFFSET(VCPU_CRIT_SAVE, kvm_vcpu, arch.crit_save);
 #endif /* CONFIG_PPC_BOOK3S */
 #endif /* CONFIG_KVM */
 
 #ifdef CONFIG_KVM_GUEST
-	DEFINE(KVM_MAGIC_SCRATCH1, offsetof(struct kvm_vcpu_arch_shared,
-					    scratch1));
-	DEFINE(KVM_MAGIC_SCRATCH2, offsetof(struct kvm_vcpu_arch_shared,
-					    scratch2));
-	DEFINE(KVM_MAGIC_SCRATCH3, offsetof(struct kvm_vcpu_arch_shared,
-					    scratch3));
-	DEFINE(KVM_MAGIC_INT, offsetof(struct kvm_vcpu_arch_shared,
-				       int_pending));
-	DEFINE(KVM_MAGIC_MSR, offsetof(struct kvm_vcpu_arch_shared, msr));
-	DEFINE(KVM_MAGIC_CRITICAL, offsetof(struct kvm_vcpu_arch_shared,
-					    critical));
-	DEFINE(KVM_MAGIC_SR, offsetof(struct kvm_vcpu_arch_shared, sr));
+	OFFSET(KVM_MAGIC_SCRATCH1, kvm_vcpu_arch_shared, scratch1);
+	OFFSET(KVM_MAGIC_SCRATCH2, kvm_vcpu_arch_shared, scratch2);
+	OFFSET(KVM_MAGIC_SCRATCH3, kvm_vcpu_arch_shared, scratch3);
+	OFFSET(KVM_MAGIC_INT, kvm_vcpu_arch_shared, int_pending);
+	OFFSET(KVM_MAGIC_MSR, kvm_vcpu_arch_shared, msr);
+	OFFSET(KVM_MAGIC_CRITICAL, kvm_vcpu_arch_shared, critical);
+	OFFSET(KVM_MAGIC_SR, kvm_vcpu_arch_shared, sr);
 #endif
 
 #ifdef CONFIG_44x
@@ -690,45 +677,39 @@ int main(void)
 #endif
 #ifdef CONFIG_PPC_FSL_BOOK3E
 	DEFINE(TLBCAM_SIZE, sizeof(struct tlbcam));
-	DEFINE(TLBCAM_MAS0, offsetof(struct tlbcam, MAS0));
-	DEFINE(TLBCAM_MAS1, offsetof(struct tlbcam, MAS1));
-	DEFINE(TLBCAM_MAS2, offsetof(struct tlbcam, MAS2));
-	DEFINE(TLBCAM_MAS3, offsetof(struct tlbcam, MAS3));
-	DEFINE(TLBCAM_MAS7, offsetof(struct tlbcam, MAS7));
+	OFFSET(TLBCAM_MAS0, tlbcam, MAS0);
+	OFFSET(TLBCAM_MAS1, tlbcam, MAS1);
+	OFFSET(TLBCAM_MAS2, tlbcam, MAS2);
+	OFFSET(TLBCAM_MAS3, tlbcam, MAS3);
+	OFFSET(TLBCAM_MAS7, tlbcam, MAS7);
 #endif
 
 #if defined(CONFIG_KVM) && defined(CONFIG_SPE)
-	DEFINE(VCPU_EVR, offsetof(struct kvm_vcpu, arch.evr[0]));
-	DEFINE(VCPU_ACC, offsetof(struct kvm_vcpu, arch.acc));
-	DEFINE(VCPU_SPEFSCR, offsetof(struct kvm_vcpu, arch.spefscr));
-	DEFINE(VCPU_HOST_SPEFSCR, offsetof(struct kvm_vcpu, arch.host_spefscr));
+	OFFSET(VCPU_EVR, kvm_vcpu, arch.evr[0]);
+	OFFSET(VCPU_ACC, kvm_vcpu, arch.acc);
+	OFFSET(VCPU_SPEFSCR, kvm_vcpu, arch.spefscr);
+	OFFSET(VCPU_HOST_SPEFSCR, kvm_vcpu, arch.host_spefscr);
 #endif
 
 #ifdef CONFIG_KVM_BOOKE_HV
-	DEFINE(VCPU_HOST_MAS4, offsetof(struct kvm_vcpu, arch.host_mas4));
-	DEFINE(VCPU_HOST_MAS6, offsetof(struct kvm_vcpu, arch.host_mas6));
+	OFFSET(VCPU_HOST_MAS4, kvm_vcpu, arch.host_mas4);
+	OFFSET(VCPU_HOST_MAS6, kvm_vcpu, arch.host_mas6);
 #endif
 
 #ifdef CONFIG_KVM_EXIT_TIMING
-	DEFINE(VCPU_TIMING_EXIT_TBU, offsetof(struct kvm_vcpu,
-						arch.timing_exit.tv32.tbu));
-	DEFINE(VCPU_TIMING_EXIT_TBL, offsetof(struct kvm_vcpu,
-						arch.timing_exit.tv32.tbl));
-	DEFINE(VCPU_TIMING_LAST_ENTER_TBU, offsetof(struct kvm_vcpu,
-					arch.timing_last_enter.tv32.tbu));
-	DEFINE(VCPU_TIMING_LAST_ENTER_TBL, offsetof(struct kvm_vcpu,
-					arch.timing_last_enter.tv32.tbl));
+	OFFSET(VCPU_TIMING_EXIT_TBU, kvm_vcpu, arch.timing_exit.tv32.tbu);
+	OFFSET(VCPU_TIMING_EXIT_TBL, kvm_vcpu, arch.timing_exit.tv32.tbl);
+	OFFSET(VCPU_TIMING_LAST_ENTER_TBU, kvm_vcpu,
+			arch.timing_last_enter.tv32.tbu);
+	OFFSET(VCPU_TIMING_LAST_ENTER_TBL, kvm_vcpu,
+			arch.timing_last_enter.tv32.tbl);
 #endif
 
 #ifdef CONFIG_PPC_POWERNV
-	DEFINE(PACA_CORE_IDLE_STATE_PTR,
-			offsetof(struct paca_struct, core_idle_state_ptr));
-	DEFINE(PACA_THREAD_IDLE_STATE,
-			offsetof(struct paca_struct, thread_idle_state));
-	DEFINE(PACA_THREAD_MASK,
-			offsetof(struct paca_struct, thread_mask));
-	DEFINE(PACA_SUBCORE_SIBLING_MASK,
-			offsetof(struct paca_struct, subcore_sibling_mask));
+	OFFSET(PACA_CORE_IDLE_STATE_PTR, paca_struct, core_idle_state_ptr);
+	OFFSET(PACA_THREAD_IDLE_STATE, paca_struct, thread_idle_state);
+	OFFSET(PACA_THREAD_MASK, paca_struct, thread_mask);
+	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
 #endif
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
-- 
2.5.0
