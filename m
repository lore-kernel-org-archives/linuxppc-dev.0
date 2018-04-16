Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pb8l3WYHzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 14:32:55 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id r14so3231585pgq.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:32:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] KVM: PPC: Book3S HV: radix use correct tlbie sequence
 in kvmppc_radix_tlbie_page
Date: Mon, 16 Apr 2018 14:32:36 +1000
Message-Id: <20180416043240.8796-2-npiggin@gmail.com>
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

The standard eieio ; tlbsync ; ptesync must follow tlbie to ensure it
is ordered with respect to subsequent operations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 5d9bafe9a371..81d5ad26f9a1 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -160,7 +160,7 @@ static void kvmppc_radix_tlbie_page(struct kvm *kvm, unsigned long addr,
 	if (cpu_has_feature(CPU_FTR_P9_TLBIE_BUG))
 		asm volatile(PPC_TLBIE_5(%0, %1, 0, 0, 1)
 			     : : "r" (addr), "r" (kvm->arch.lpid) : "memory");
-	asm volatile("ptesync": : :"memory");
+	asm volatile("eieio ; tlbsync ; ptesync": : :"memory");
 }
 
 unsigned long kvmppc_radix_update_pte(struct kvm *kvm, pte_t *ptep,
-- 
2.17.0
