Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BBds3jFSzF2Js
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 02:30:09 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so1804148plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 08:30:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 1/3] powerpc/64s: do not flush TLB when relaxing access
Date: Thu, 29 Mar 2018 01:29:49 +1000
Message-Id: <20180328152951.6422-2-npiggin@gmail.com>
In-Reply-To: <20180328152951.6422-1-npiggin@gmail.com>
References: <20180328152951.6422-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Book3S does not require TLB flushing when protection is being relaxed.
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
 arch/powerpc/mm/pgtable-book3s64.c | 1 -
 arch/powerpc/mm/pgtable.c          | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 422e80253a33..de49cedcbc84 100644
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
2.16.1
