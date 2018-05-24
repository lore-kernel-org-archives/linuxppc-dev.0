Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40sHFb0NLFzF1Qt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 03:59:14 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id w19-v6so1515383plq.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 May 2018 10:59:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v3 2/7] powerpc/64s/radix: do not flush TLB on spurious fault
Date: Fri, 25 May 2018 03:58:48 +1000
Message-Id: <20180524175853.19695-3-npiggin@gmail.com>
In-Reply-To: <20180524175853.19695-1-npiggin@gmail.com>
References: <20180524175853.19695-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the case of a spurious fault (which can happen due to a race with
another thread that changes the page table), the default Linux mm code
calls flush_tlb_page for that address. This is not required because
the pte will be re-fetched. Hash does not wire this up to a hardware
TLB flush for this reason. This patch avoids the flush for radix.

>From Power ISA v3.0B, p.1090:

    Setting a Reference or Change Bit or Upgrading Access Authority
    (PTE Subject to Atomic Hardware Updates)

    If the only change being made to a valid PTE that is subject to
    atomic hardware updates is to set the Refer- ence or Change bit to
    1 or to add access authorities, a simpler sequence suffices
    because the translation hardware will refetch the PTE if an access
    is attempted for which the only problems were reference and/or
    change bits needing to be set or insufficient access authority.

The nest MMU on POWER9 does not re-fetch the PTE after such an access
attempt before faulting, so address spaces with a coprocessor
attached will continue to flush in these cases.

This reduces tlbies for a kernel compile workload from 0.95M to 0.90M.

fork --fork --exec benchmark improved 0.5% (12300->12400).

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 0cac17253513..ebf572ea621e 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -4,7 +4,7 @@
 
 #define MMU_NO_CONTEXT	~0UL
 
-
+#include <linux/mm_types.h>
 #include <asm/book3s/64/tlbflush-hash.h>
 #include <asm/book3s/64/tlbflush-radix.h>
 
@@ -137,6 +137,16 @@ static inline void flush_all_mm(struct mm_struct *mm)
 #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
 #define flush_all_mm(mm)		local_flush_all_mm(mm)
 #endif /* CONFIG_SMP */
+
+#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
+static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+						unsigned long address)
+{
+	/* See ptep_set_access_flags comment */
+	if (atomic_read(&vma->vm_mm->context.copros) > 0)
+		flush_tlb_page(vma, address);
+}
+
 /*
  * flush the page walk cache for the address
  */
-- 
2.17.0
