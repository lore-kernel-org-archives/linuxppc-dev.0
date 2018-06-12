Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414lDr5HDVzF4C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 19:38:19 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so14052820pll.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 02:38:19 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>, stable@kernel.org
Subject: [PATCH] powerpc/64s/radix: Fix radix_kvm_prefetch_workaround paca
 access of not possible CPU
Date: Tue, 12 Jun 2018 19:38:08 +1000
Message-Id: <20180612093808.30679-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If possible CPUs are limited (e.g., by kexec), then the kvm prefetch
workaround function can access the paca pointer for a !possible CPU.

Fixes: d2e60075a3d44 ("powerpc/64: Use array of paca pointers and allocate pacas individually")
Cc: stable@kernel.org
Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Tested-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
[kdump still seems to have a problem upstream, but this solves one crash]

 arch/powerpc/mm/tlb-radix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 67a6e86d3e7e..06ea845d8033 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -1043,6 +1043,8 @@ extern void radix_kvm_prefetch_workaround(struct mm_struct *mm)
 		for (; sib <= cpu_last_thread_sibling(cpu) && !flush; sib++) {
 			if (sib == cpu)
 				continue;
+			if (!cpu_possible(sib))
+				continue;
 			if (paca_ptrs[sib]->kvm_hstate.kvm_vcpu)
 				flush = true;
 		}
-- 
2.17.0
