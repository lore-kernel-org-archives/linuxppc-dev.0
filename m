Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gn8p51k4zF2Mr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 16:52:10 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id m21-v6so22247112pgv.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 23:52:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 2/2] powerpc/64s/radix: do not flush TLB on spurious fault
Date: Wed,  9 May 2018 16:51:52 +1000
Message-Id: <20180509065152.14213-3-npiggin@gmail.com>
In-Reply-To: <20180509065152.14213-1-npiggin@gmail.com>
References: <20180509065152.14213-1-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/tlbflush.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/tlbflush.h b/arch/powerpc/include/asm/book3s/64/tlbflush.h
index 0cac17253513..9c43431e01c5 100644
--- a/arch/powerpc/include/asm/book3s/64/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/64/tlbflush.h
@@ -137,6 +137,13 @@ static inline void flush_all_mm(struct mm_struct *mm)
 #define flush_tlb_page(vma, addr)	local_flush_tlb_page(vma, addr)
 #define flush_all_mm(mm)		local_flush_all_mm(mm)
 #endif /* CONFIG_SMP */
+
+#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
+static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+						unsigned long address)
+{
+}
+
 /*
  * flush the page walk cache for the address
  */
-- 
2.17.0
