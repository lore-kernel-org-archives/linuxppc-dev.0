Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406fK86zCFzF1xd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 08:03:24 +1100 (AEDT)
Received: by mail-wr0-x242.google.com with SMTP id s10so10086028wra.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 14:03:24 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Mathieu Malaterre <malat@debian.org>
Subject: [PATCH] powerpc/mm/radix: Fix always false comparison against
 MMU_NO_CONTEXT
Date: Thu, 22 Mar 2018 22:03:18 +0100
Message-Id: <20180322210318.21349-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 9690c1574268 ("powerpc/mm/radix: Fix always false comparison
against MMU_NO_CONTEXT") an issue was discovered where `mm->context.id` was
being truncated to an `unsigned int`, while the PID is actually an
`unsigned long`. Update the earlier patch by fixing one remaining
occurrence. Discovered during a compilation with W=1:

  arch/powerpc/mm/tlb-radix.c:702:19: error: comparison is always false due to limited range of data type [-Werror=type-limits]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/mm/tlb-radix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index f6d61a75e739..f2d27d61ec48 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -697,7 +697,7 @@ void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 extern void radix_kvm_prefetch_workaround(struct mm_struct *mm)
 {
-	unsigned int pid = mm->context.id;
+	unsigned long pid = mm->context.id;
 
 	if (unlikely(pid == MMU_NO_CONTEXT))
 		return;
-- 
2.11.0
