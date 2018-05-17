Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mhxQ5CslzF14y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 16:59:22 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id az12-v6so1940123plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:59:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3] KVM: PPC: Book3S HV: lockless tlbie for HPT hcalls
Date: Thu, 17 May 2018 16:59:10 +1000
Message-Id: <20180517065910.11693-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tlbies to an LPAR do not have to be serialised since POWER4/PPC970,
after which the MMU_FTR_LOCKLESS_TLBIE feature was introduced to
avoid tlbie locking.

Since commit c17b98cf6028 ("KVM: PPC: Book3S HV: Remove code for
PPC970 processors"), KVM no longer supports processors that do not
have this feature, so the tlbie locking can be removed completely.
A sanity check for the feature is put in kvmppc_mmu_hv_init.

Testing was done on a POWER9 system in HPT mode, with a -smp 32 guest
in HPT mode. 32 instances of the powerpc fork benchmark from selftests
were run with --fork, and the results measured.

Without this patch, total throughput was about 13.5K/sec, and this is
the top of the host profile:

   74.52%  [k] do_tlbies
    2.95%  [k] kvmppc_book3s_hv_page_fault
    1.80%  [k] calc_checksum
    1.80%  [k] kvmppc_vcpu_run_hv
    1.49%  [k] kvmppc_run_core

After this patch, throughput was about 51K/sec, with this profile:

   21.28%  [k] do_tlbies
    5.26%  [k] kvmppc_run_core
    4.88%  [k] kvmppc_book3s_hv_page_fault
    3.30%  [k] _raw_spin_lock_irqsave
    3.25%  [k] gup_pgd_range

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v2:
- Removed the locking code completely (thanks mpe)
- Updated changelog (thanks mpe)

 arch/powerpc/include/asm/kvm_host.h |  1 -
 arch/powerpc/kvm/book3s_64_mmu_hv.c |  3 +++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 21 ---------------------
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 17498e9a26e4..7756b0c6da75 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -269,7 +269,6 @@ struct kvm_arch {
 	unsigned long host_lpcr;
 	unsigned long sdr1;
 	unsigned long host_sdr1;
-	int tlbie_lock;
 	unsigned long lpcr;
 	unsigned long vrma_slb_v;
 	int mmu_ready;
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index a670fa5fbe50..37cd6434d1c8 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -272,6 +272,9 @@ int kvmppc_mmu_hv_init(void)
 	if (!cpu_has_feature(CPU_FTR_HVMODE))
 		return -EINVAL;
 
+	if (!mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
+		return -EINVAL;
+
 	/* POWER7 has 10-bit LPIDs (12-bit in POWER8) */
 	host_lpid = mfspr(SPRN_LPID);
 	rsvd_lpid = LPID_RSVD;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 78e6a392330f..89d909b3b881 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -434,24 +434,6 @@ static inline int is_mmio_hpte(unsigned long v, unsigned long r)
 		(HPTE_R_KEY_HI | HPTE_R_KEY_LO));
 }
 
-static inline int try_lock_tlbie(unsigned int *lock)
-{
-	unsigned int tmp, old;
-	unsigned int token = LOCK_TOKEN;
-
-	asm volatile("1:lwarx	%1,0,%2\n"
-		     "	cmpwi	cr0,%1,0\n"
-		     "	bne	2f\n"
-		     "  stwcx.	%3,0,%2\n"
-		     "	bne-	1b\n"
-		     "  isync\n"
-		     "2:"
-		     : "=&r" (tmp), "=&r" (old)
-		     : "r" (lock), "r" (token)
-		     : "cc", "memory");
-	return old == 0;
-}
-
 static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		      long npages, int global, bool need_sync)
 {
@@ -463,8 +445,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 	 * the RS field, this is backwards-compatible with P7 and P8.
 	 */
 	if (global) {
-		while (!try_lock_tlbie(&kvm->arch.tlbie_lock))
-			cpu_relax();
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
 		for (i = 0; i < npages; ++i) {
@@ -483,7 +463,6 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		}
 
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-		kvm->arch.tlbie_lock = 0;
 	} else {
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
-- 
2.17.0
