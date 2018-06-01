Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y0Gs2hq3zF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 20:01:41 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id d2-v6so445818pga.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jun 2018 03:01:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v4 1/7] powerpc/64s/radix: do not flush TLB when relaxing
 access
Date: Fri,  1 Jun 2018 20:01:15 +1000
Message-Id: <20180601100121.393-2-npiggin@gmail.com>
In-Reply-To: <20180601100121.393-1-npiggin@gmail.com>
References: <20180601100121.393-1-npiggin@gmail.com>
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

The nest MMU on POWER9 does not re-fetch the PTE after such an access
attempt before faulting, so address spaces with a coprocessor
attached will continue to flush in these cases.

This reduces tlbies for a kernel compile workload from 1.28M to 0.95M,
tlbiels from 20.17M 19.68M.

fork --fork --exec benchmark improved 2.77% (12000->12300).

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 0ddfe591cd24..d6f74cbf0fed 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1108,7 +1108,12 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 		__radix_pte_update(ptep, 0, new_pte);
 	} else {
 		__radix_pte_update(ptep, 0, set);
-		radix__flush_tlb_page_psize(mm, address, psize);
+		/*
+		 * Book3S does not require a TLB flush when relaxing access
+		 * restrictions when the address space is not attached to a
+		 * NMMU, because the core MMU will reload the pte after taking
+		 * an access fault, which is defined by the architectue.
+		 */
 	}
 	asm volatile("ptesync" : : : "memory");
 }
-- 
2.17.0
