Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pb8y0wLCzF1S0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 14:33:04 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id e7-v6so9313419plt.6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:33:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] KVM: PPC: Book3S HV: radix handle process scoped LPID
 flush in C, with relocation on
Date: Mon, 16 Apr 2018 14:32:39 +1000
Message-Id: <20180416043240.8796-5-npiggin@gmail.com>
In-Reply-To: <20180416043240.8796-1-npiggin@gmail.com>
References: <20180416043240.8796-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The radix guest code can has fewer restrictions about what context it
can run in, so move this flushing out of assembly and have it use the
Linux TLB flush implementations introduced previously.

This allows powerpc:tlbie trace events to be used.

This changes the tlbiel sequence to only execute RIC=2 flush once on
the first set flushed, which matches the rest of the Linux flushing.
This does not change semantics of the flush.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv.c            | 26 +++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 ++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 81e2ea882d97..c1660df41190 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2901,6 +2901,32 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	for (sub = 0; sub < core_info.n_subcores; ++sub)
 		spin_unlock(&core_info.vc[sub]->lock);
 
+	if (kvm_is_radix(vc->kvm)) {
+		int tmp = pcpu;
+
+		/*
+		 * Do we need to flush the process scoped TLB for the LPAR?
+		 *
+		 * On POWER9, individual threads can come in here, but the
+		 * TLB is shared between the 4 threads in a core, hence
+		 * invalidating on one thread invalidates for all.
+		 * Thus we make all 4 threads use the same bit here.
+		 *
+		 * Hash must be flushed in realmode in order to use tlbiel.
+		 */
+		mtspr(SPRN_LPID, vc->kvm->arch.lpid);
+		isync();
+
+		if (cpu_has_feature(CPU_FTR_ARCH_300))
+			tmp &= ~0x3UL;
+
+		if (cpumask_test_cpu(tmp, &vc->kvm->arch.need_tlb_flush)) {
+			radix__local_flush_tlb_lpid_guest(vc->kvm->arch.lpid);
+			/* Clear the bit after the TLB flush */
+			cpumask_clear_cpu(tmp, &vc->kvm->arch.need_tlb_flush);
+		}
+	}
+
 	/*
 	 * Interrupts will be enabled once we get into the guest,
 	 * so tell lockdep that we're about to enable interrupts.
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bd63fa8a08b5..d4c7bb3e777e 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -636,6 +636,10 @@ kvmppc_hv_entry:
 	/* Primary thread switches to guest partition. */
 	cmpwi	r6,0
 	bne	10f
+
+	/* Radix has already switched LPID and flushed core TLB */
+	bne	cr7,22f
+
 	lwz	r7,KVM_LPID(r9)
 BEGIN_FTR_SECTION
 	ld	r6,KVM_SDR1(r9)
@@ -647,7 +651,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
 	mtspr	SPRN_LPID,r7
 	isync
 
-	/* See if we need to flush the TLB */
+	/* See if we need to flush the TLB. Hash has to be done in RM */
 	lhz	r6,PACAPACAINDEX(r13)	/* test_bit(cpu, need_tlb_flush) */
 BEGIN_FTR_SECTION
 	/*
@@ -674,15 +678,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	li	r7,0x800		/* IS field = 0b10 */
 	ptesync
 	li	r0,0			/* RS for P9 version of tlbiel */
-	bne	cr7, 29f
 28:	tlbiel	r7			/* On P9, rs=0, RIC=0, PRS=0, R=0 */
 	addi	r7,r7,0x1000
 	bdnz	28b
-	b	30f
-29:	PPC_TLBIEL(7,0,2,1,1)		/* for radix, RIC=2, PRS=1, R=1 */
-	addi	r7,r7,0x1000
-	bdnz	29b
-30:	ptesync
+	ptesync
 23:	ldarx	r7,0,r6			/* clear the bit after TLB flushed */
 	andc	r7,r7,r8
 	stdcx.	r7,0,r6
-- 
2.17.0
