Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBlnH6S6CzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 21:22:11 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v2 17/20] KVM: PPC: Book3S HV: Invalidate TLB on radix guest
 vcpu movement
Date: Mon, 30 Jan 2017 21:21:50 +1100
Message-Id: <1485771713-24801-18-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
References: <1485771713-24801-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With radix, the guest can do TLB invalidations itself using the tlbie
(global) and tlbiel (local) TLB invalidation instructions.  Linux guests
use local TLB invalidations for translations that have only ever been
accessed on one vcpu.  However, that doesn't mean that the translations
have only been accessed on one physical cpu (pcpu) since vcpus can move
around from one pcpu to another.  Thus a tlbiel might leave behind stale
TLB entries on a pcpu where the vcpu previously ran, and if that task
then moves back to that previous pcpu, it could see those stale TLB
entries and thus access memory incorrectly.  The usual symptom of this
is random segfaults in userspace programs in the guest.

To cope with this, we detect when a vcpu is about to start executing on
a thread in a core that is a different core from the last time it
executed.  If that is the case, then we mark the core as needing a
TLB flush and then send an interrupt to any thread in the core that is
currently running a vcpu from the same guest.  This will get those vcpus
out of the guest, and the first one to re-enter the guest will do the
TLB flush.  The reason for interrupting the vcpus executing on the old
core is to cope with the following scenario:

	CPU 0			CPU 1			CPU 4
	(core 0)			(core 0)			(core 1)

	VCPU 0 runs task X      VCPU 1 runs
	core 0 TLB gets
	entries from task X
	VCPU 0 moves to CPU 4
							VCPU 0 runs task X
							Unmap pages of task X
							tlbiel

				(still VCPU 1)			task X moves to VCPU 1
				task X runs
				task X sees stale TLB
				entries

That is, as soon as the VCPU starts executing on the new core, it
could unmap and tlbiel some page table entries, and then the task
could migrate to one of the VCPUs running on the old core and
potentially see stale TLB entries.

Since the TLB is shared between all the threads in a core, we only
use the bit of kvm->arch.need_tlb_flush corresponding to the first
thread in the core.  To ensure that we don't have a window where we
can miss a flush, this moves the clearing of the bit from before the
actual flush to after it.  This way, two threads might both do the
flush, but we prevent the situation where one thread can enter the
guest before the flush is finished.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_host.h     |  2 ++
 arch/powerpc/kvm/book3s_hv.c            | 45 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c     | 11 ++++++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 38 +++++++++++++++++++---------
 4 files changed, 82 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index da1421a..b2dbeac 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -263,6 +263,7 @@ struct kvm_arch {
 	unsigned long hpt_mask;
 	atomic_t hpte_mod_interest;
 	cpumask_t need_tlb_flush;
+	cpumask_t cpu_in_guest;
 	int hpt_cma_alloc;
 	u8 radix;
 	pgd_t *pgtable;
@@ -661,6 +662,7 @@ struct kvm_vcpu_arch {
 	int state;
 	int ptid;
 	int thread_cpu;
+	int prev_cpu;
 	bool timer_running;
 	wait_queue_head_t cpu_run;
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 401e4cc..50c230e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1821,6 +1821,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	vcpu->arch.vcore = vcore;
 	vcpu->arch.ptid = vcpu->vcpu_id - vcore->first_vcpuid;
 	vcpu->arch.thread_cpu = -1;
+	vcpu->arch.prev_cpu = -1;
 
 	vcpu->arch.cpu_type = KVM_CPU_3S_64;
 	kvmppc_sanity_check(vcpu);
@@ -1950,11 +1951,33 @@ static void kvmppc_release_hwthread(int cpu)
 	tpaca->kvm_hstate.kvm_split_mode = NULL;
 }
 
+static void do_nothing(void *x)
+{
+}
+
+static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	cpu = cpu_first_thread_sibling(cpu);
+	cpumask_set_cpu(cpu, &kvm->arch.need_tlb_flush);
+	/*
+	 * Make sure setting of bit in need_tlb_flush precedes
+	 * testing of cpu_in_guest bits.  The matching barrier on
+	 * the other side is the first smp_mb() in kvmppc_run_core().
+	 */
+	smp_mb();
+	for (i = 0; i < threads_per_core; ++i)
+		if (cpumask_test_cpu(cpu + i, &kvm->arch.cpu_in_guest))
+			smp_call_function_single(cpu + i, do_nothing, NULL, 1);
+}
+
 static void kvmppc_start_thread(struct kvm_vcpu *vcpu, struct kvmppc_vcore *vc)
 {
 	int cpu;
 	struct paca_struct *tpaca;
 	struct kvmppc_vcore *mvc = vc->master_vcore;
+	struct kvm *kvm = vc->kvm;
 
 	cpu = vc->pcpu;
 	if (vcpu) {
@@ -1965,6 +1988,27 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu, struct kvmppc_vcore *vc)
 		cpu += vcpu->arch.ptid;
 		vcpu->cpu = mvc->pcpu;
 		vcpu->arch.thread_cpu = cpu;
+
+		/*
+		 * With radix, the guest can do TLB invalidations itself,
+		 * and it could choose to use the local form (tlbiel) if
+		 * it is invalidating a translation that has only ever been
+		 * used on one vcpu.  However, that doesn't mean it has
+		 * only ever been used on one physical cpu, since vcpus
+		 * can move around between pcpus.  To cope with this, when
+		 * a vcpu moves from one pcpu to another, we need to tell
+		 * any vcpus running on the same core as this vcpu previously
+		 * ran to flush the TLB.  The TLB is shared between threads,
+		 * so we use a single bit in .need_tlb_flush for all 4 threads.
+		 */
+		if (kvm_is_radix(kvm) && vcpu->arch.prev_cpu != cpu) {
+			if (vcpu->arch.prev_cpu >= 0 &&
+			    cpu_first_thread_sibling(vcpu->arch.prev_cpu) !=
+			    cpu_first_thread_sibling(cpu))
+				radix_flush_cpu(kvm, vcpu->arch.prev_cpu, vcpu);
+			vcpu->arch.prev_cpu = cpu;
+		}
+		cpumask_set_cpu(cpu, &kvm->arch.cpu_in_guest);
 	}
 	tpaca = &paca[cpu];
 	tpaca->kvm_hstate.kvm_vcpu = vcpu;
@@ -2552,6 +2596,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		kvmppc_release_hwthread(pcpu + i);
 		if (sip && sip->napped[i])
 			kvmppc_ipi_thread(pcpu + i);
+		cpumask_clear_cpu(pcpu + i, &vc->kvm->arch.cpu_in_guest);
 	}
 
 	kvmppc_set_host_core(pcpu);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6c1ac3d..b095afc 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -43,6 +43,7 @@ static void *real_vmalloc_addr(void *x)
 static int global_invalidates(struct kvm *kvm, unsigned long flags)
 {
 	int global;
+	int cpu;
 
 	/*
 	 * If there is only one vcore, and it's currently running,
@@ -60,8 +61,14 @@ static int global_invalidates(struct kvm *kvm, unsigned long flags)
 		/* any other core might now have stale TLB entries... */
 		smp_wmb();
 		cpumask_setall(&kvm->arch.need_tlb_flush);
-		cpumask_clear_cpu(local_paca->kvm_hstate.kvm_vcore->pcpu,
-				  &kvm->arch.need_tlb_flush);
+		cpu = local_paca->kvm_hstate.kvm_vcore->pcpu;
+		/*
+		 * On POWER9, threads are independent but the TLB is shared,
+		 * so use the bit for the first thread to represent the core.
+		 */
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			cpu = cpu_first_thread_sibling(cpu);
+		cpumask_clear_cpu(cpu, &kvm->arch.need_tlb_flush);
 	}
 
 	return global;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 5a0749b..2da08d7 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -598,30 +598,44 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 
 	/* See if we need to flush the TLB */
 	lhz	r6,PACAPACAINDEX(r13)	/* test_bit(cpu, need_tlb_flush) */
+BEGIN_FTR_SECTION
+	/*
+	 * On POWER9, individual threads can come in here, but the
+	 * TLB is shared between the 4 threads in a core, hence
+	 * invalidating on one thread invalidates for all.
+	 * Thus we make all 4 threads use the same bit here.
+	 */
+	clrrdi	r6,r6,2
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	clrldi	r7,r6,64-6		/* extract bit number (6 bits) */
 	srdi	r6,r6,6			/* doubleword number */
 	sldi	r6,r6,3			/* address offset */
 	add	r6,r6,r9
 	addi	r6,r6,KVM_NEED_FLUSH	/* dword in kvm->arch.need_tlb_flush */
-	li	r0,1
-	sld	r0,r0,r7
+	li	r8,1
+	sld	r8,r8,r7
 	ld	r7,0(r6)
-	and.	r7,r7,r0
+	and.	r7,r7,r8
 	beq	22f
-23:	ldarx	r7,0,r6			/* if set, clear the bit */
-	andc	r7,r7,r0
-	stdcx.	r7,0,r6
-	bne	23b
 	/* Flush the TLB of any entries for this LPID */
-	lwz	r6,KVM_TLB_SETS(r9)
-	li	r0,0			/* RS for P9 version of tlbiel */
-	mtctr	r6
+	lwz	r0,KVM_TLB_SETS(r9)
+	mtctr	r0
 	li	r7,0x800		/* IS field = 0b10 */
 	ptesync
-28:	tlbiel	r7
+	li	r0,0			/* RS for P9 version of tlbiel */
+	bne	cr7, 29f
+28:	tlbiel	r7			/* On P9, rs=0, RIC=0, PRS=0, R=0 */
 	addi	r7,r7,0x1000
 	bdnz	28b
-	ptesync
+	b	30f
+29:	PPC_TLBIEL(7,0,2,1,1)		/* for radix, RIC=2, PRS=1, R=1 */
+	addi	r7,r7,0x1000
+	bdnz	29b
+30:	ptesync
+23:	ldarx	r7,0,r6			/* clear the bit after TLB flushed */
+	andc	r7,r7,r8
+	stdcx.	r7,0,r6
+	bne	23b
 
 	/* Add timebase offset onto timebase */
 22:	ld	r8,VCORE_TB_OFFSET(r5)
-- 
2.7.4
