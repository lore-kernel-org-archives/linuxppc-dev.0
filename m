Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L6Rz43xSzF1x2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:49:03 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 61-v6so7448281plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 05:49:03 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/5] KVM: PPC: Book3S HV: kvmhv_p9_set_lpcr use Linux
 flush function
Date: Tue, 10 Apr 2018 22:48:40 +1000
Message-Id: <20180410124842.30184-4-npiggin@gmail.com>
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

The existing flush uses the radix value for sets, and uses R=0
tlbiel instructions. This can't be quite right, but I'm not entirely
sure if this is the right way to fix it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_hv_builtin.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index 0b9b8e188bfa..577769fbfae9 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -676,7 +676,7 @@ static void wait_for_sync(struct kvm_split_mode *sip, int phase)
 
 void kvmhv_p9_set_lpcr(struct kvm_split_mode *sip)
 {
-	unsigned long rb, set;
+	struct kvm *kvm = local_paca->kvm_hstate.kvm_vcpu->kvm;
 
 	/* wait for every other thread to get to real mode */
 	wait_for_sync(sip, PHASE_REALMODE);
@@ -689,14 +689,10 @@ void kvmhv_p9_set_lpcr(struct kvm_split_mode *sip)
 	/* Invalidate the TLB on thread 0 */
 	if (local_paca->kvm_hstate.tid == 0) {
 		sip->do_set = 0;
-		asm volatile("ptesync" : : : "memory");
-		for (set = 0; set < POWER9_TLB_SETS_RADIX; ++set) {
-			rb = TLBIEL_INVAL_SET_LPID +
-				(set << TLBIEL_INVAL_SET_SHIFT);
-			asm volatile(PPC_TLBIEL(%0, %1, 0, 0, 0) : :
-				     "r" (rb), "r" (0));
-		}
-		asm volatile("ptesync" : : : "memory");
+		if (kvm_is_radix(kvm))
+			radix__local_flush_tlb_lpid(kvm->arch.lpid);
+		else
+			hash__local_flush_tlb_lpid(kvm->arch.lpid);
 	}
 
 	/* indicate that we have done so and wait for others */
-- 
2.17.0
