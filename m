Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H9WQ6h1kzF1r1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 03:56:50 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id k6-v6so15114965pls.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 10:56:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 2/2] KVM: PPC: Book3S HV: lockless tlbie for HPT hcalls
Date: Fri,  6 Apr 2018 03:56:31 +1000
Message-Id: <20180405175631.31381-3-npiggin@gmail.com>
In-Reply-To: <20180405175631.31381-1-npiggin@gmail.com>
References: <20180405175631.31381-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tlbies to an LPAR do not have to be serialised since POWER4,
MMU_FTR_LOCKLESS_TLBIE can be used to avoid the spin lock in
do_tlbies.

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
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 78e6a392330f..0221a0f74f07 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -439,6 +439,9 @@ static inline int try_lock_tlbie(unsigned int *lock)
 	unsigned int tmp, old;
 	unsigned int token = LOCK_TOKEN;
 
+	if (mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
+		return 1;
+
 	asm volatile("1:lwarx	%1,0,%2\n"
 		     "	cmpwi	cr0,%1,0\n"
 		     "	bne	2f\n"
@@ -452,6 +455,12 @@ static inline int try_lock_tlbie(unsigned int *lock)
 	return old == 0;
 }
 
+static inline void unlock_tlbie_after_sync(unsigned int *lock)
+{
+	if (mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE))
+		return;
+}
+
 static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		      long npages, int global, bool need_sync)
 {
@@ -483,7 +492,7 @@ static void do_tlbies(struct kvm *kvm, unsigned long *rbvalues,
 		}
 
 		asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-		kvm->arch.tlbie_lock = 0;
+		unlock_tlbie_after_sync(&kvm->arch.tlbie_lock);
 	} else {
 		if (need_sync)
 			asm volatile("ptesync" : : : "memory");
-- 
2.16.3
