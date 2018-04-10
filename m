Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L6S36yBdzF1y2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:49:07 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id 61-v6so7448396plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 05:49:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 4/5] KVM: PPC: Book3S HV: handle need_tlb_flush in C
 before low-level guest entry
Date: Tue, 10 Apr 2018 22:48:41 +1000
Message-Id: <20180410124842.30184-5-npiggin@gmail.com>
In-Reply-To: <20180410124842.30184-1-npiggin@gmail.com>
References: <20180410124842.30184-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move this flushing out of assembly and have it use Linux TLB
flush implementations introduced earlier. This allows powerpc:tlbie
trace events to be used.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c            | 21 +++++++++++-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 43 +------------------------
 2 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 81e2ea882d97..5d4783b5b47a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2680,7 +2680,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	int sub;
 	bool thr0_done;
 	unsigned long cmd_bit, stat_bit;
-	int pcpu, thr;
+	int pcpu, thr, tmp;
 	int target_threads;
 	int controlled_threads;
 	int trap;
@@ -2780,6 +2780,25 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		return;
 	}
 
+	/*
+	 * Do we need to flush the TLB for the LPAR? (see TLB comment above)
+         * On POWER9, individual threads can come in here, but the
+         * TLB is shared between the 4 threads in a core, hence
+         * invalidating on one thread invalidates for all.
+         * Thus we make all 4 threads use the same bit here.
+         */
+	tmp = pcpu;
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		tmp &= ~0x3UL;
+	if (cpumask_test_cpu(tmp, &vc->kvm->arch.need_tlb_flush)) {
+		if (kvm_is_radix(vc->kvm))
+			radix__local_flush_tlb_lpid(vc->kvm->arch.lpid);
+		else
+			hash__local_flush_tlb_lpid(vc->kvm->arch.lpid);
+		/* Clear the bit after the TLB flush */
+		cpumask_clear_cpu(tmp, &vc->kvm->arch.need_tlb_flush);
+	}
+
 	kvmppc_clear_host_core(pcpu);
 
 	/* Decide on micro-threading (split-core) mode */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bd63fa8a08b5..6a23a0f3ceea 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -647,49 +647,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPID,r7
 	isync
 
-	/* See if we need to flush the TLB */
-	lhz	r6,PACAPACAINDEX(r13)	/* test_bit(cpu, need_tlb_flush) */
-BEGIN_FTR_SECTION
-	/*
-	 * On POWER9, individual threads can come in here, but the
-	 * TLB is shared between the 4 threads in a core, hence
-	 * invalidating on one thread invalidates for all.
-	 * Thus we make all 4 threads use the same bit here.
-	 */
-	clrrdi	r6,r6,2
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
-	clrldi	r7,r6,64-6		/* extract bit number (6 bits) */
-	srdi	r6,r6,6			/* doubleword number */
-	sldi	r6,r6,3			/* address offset */
-	add	r6,r6,r9
-	addi	r6,r6,KVM_NEED_FLUSH	/* dword in kvm->arch.need_tlb_flush */
-	li	r8,1
-	sld	r8,r8,r7
-	ld	r7,0(r6)
-	and.	r7,r7,r8
-	beq	22f
-	/* Flush the TLB of any entries for this LPID */
-	lwz	r0,KVM_TLB_SETS(r9)
-	mtctr	r0
-	li	r7,0x800		/* IS field = 0b10 */
-	ptesync
-	li	r0,0			/* RS for P9 version of tlbiel */
-	bne	cr7, 29f
-28:	tlbiel	r7			/* On P9, rs=0, RIC=0, PRS=0, R=0 */
-	addi	r7,r7,0x1000
-	bdnz	28b
-	b	30f
-29:	PPC_TLBIEL(7,0,2,1,1)		/* for radix, RIC=2, PRS=1, R=1 */
-	addi	r7,r7,0x1000
-	bdnz	29b
-30:	ptesync
-23:	ldarx	r7,0,r6			/* clear the bit after TLB flushed */
-	andc	r7,r7,r8
-	stdcx.	r7,0,r6
-	bne	23b
-
 	/* Add timebase offset onto timebase */
-22:	ld	r8,VCORE_TB_OFFSET(r5)
+	ld	r8,VCORE_TB_OFFSET(r5)
 	cmpdi	r8,0
 	beq	37f
 	mftb	r6		/* current host timebase */
-- 
2.17.0
