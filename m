Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gn8l423QzF2D3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 16:52:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w129so19731120pfd.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 23:52:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/2] powerpc/64s/radix: do not flush TLB when relaxing access
Date: Wed,  9 May 2018 16:51:51 +1000
Message-Id: <20180509065152.14213-2-npiggin@gmail.com>
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

Radix flushes the TLB when updating ptes to increase permissiveness
of protection (increase access authority). Book3S does not require
TLB flushing in this case, and it is not done on hash. This patch
avoids the flush for radix.

>From Power ISA v3.0B, p.1090:

    Setting a Reference or Change Bit or Upgrading Access Authority
    (PTE Subject to Atomic Hardware Updates)

    If the only change being made to a valid PTE that is subject to
    atomic hardware updates is to set the Reference or Change bit to 1
    or to add access authorities, a simpler sequence suffices because
    the translation hardware will refetch the PTE if an access is
    attempted for which the only problems were reference and/or change
    bits needing to be set or insufficient access authority.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 1 -
 arch/powerpc/mm/pgtable.c          | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 518518fb7c45..6e991eaccab4 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -40,7 +40,6 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	if (changed) {
 		__ptep_set_access_flags(vma->vm_mm, pmdp_ptep(pmdp),
 					pmd_pte(entry), address);
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9f361ae571e9..5b07a626df5b 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,7 +224,8 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 		if (!is_vm_hugetlb_page(vma))
 			assert_pte_locked(vma->vm_mm, address);
 		__ptep_set_access_flags(vma->vm_mm, ptep, entry, address);
-		flush_tlb_page(vma, address);
+		if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+			flush_tlb_page(vma, address);
 	}
 	return changed;
 }
-- 
2.17.0
