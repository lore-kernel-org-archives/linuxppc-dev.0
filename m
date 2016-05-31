Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJk6H4DX3zDqcy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 16:26:47 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 31 May 2016 00:26:45 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm/hash: Fix the reference bit update when
 handling hash fault
Date: Tue, 31 May 2016 11:56:30 +0530
Message-Id: <1464675991-13023-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1464675991-13023-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we converted the asm routines to C functions, we missed updating
HPTE_R_R based on _PAGE_ACCESSED. ASM code used to copy over the lower
bits from pte via.

andi.	r3,r30,0x1fe		/* Get basic set of flags */

Fixes: 'commit 89ff725051d1 ("powerpc/mm: Convert __hash_page_64K to C")'

We also update the code such that we won't update the Change bit ('C'
bit) always. This was added by
'commit c5cf0e30bf3d8 ("powerpc: Fix buglet with MMU hash management")'

With hash64, we need to make sure that hardware doesn't do a pte update
directly. This is because we do end up with entries in TLB with no hash
page table entry. This happens because when we find hash bucket full,
we "evict" a more/less random entry from it. When we do that we don't
invalidate the TLB (hpte_remove) because we assume the old translation
is still technically "valid". For more info look at
'commit 0608d692463("powerpc/mm: Always invalidate tlb on hpte invalidate and
update")'. Thus it's critical that valid hash PTEs always have reference
bit set and writeable ones have change bit set. We do this by hashing a
non-dirty linux PTE as read-only and always setting _PAGE_ACCESSED
(and thus R) when hashing anything else in. Any attempt by Linux at
clearing those bits also removes the corresponding hash entry.

Commitc 5cf0e30bf3d8 did that for 'C' bit by enabling 'C' bit always.
We don't really need to do that because we never map a RW pte entry
without setting 'C' bit. On READ fault on a RW pte entry, we still map
it READ only, hence a store update in the page will still cause a hash
pte fault.

This patch reverts the part of the c5cf0e30bf3d8
("[PATCH] powerpc: Fix buglet with MMU hash management") and retain
the updatepp part.
- If we hit the updatepp path on native, the old code without that
  commit, would fail to set C bcause native_hpte_updatepp()
  was implemented to filter the same bits as H_PROTECT and not let C
  through thus we would "upgrade" a RO HPTE to RW without setting C
  thus causing the bug. So the real fix in that commit was the change
  to native_hpte_updatepp

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 59268969a0bc..b2740c67e172 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -159,6 +159,19 @@ static struct mmu_psize_def mmu_psize_defaults_gp[] = {
 	},
 };
 
+/*
+ * 'R' and 'C' update notes:
+ *  - Under pHyp or KVM, the updatepp path will not set C, thus it *will*
+ *     create writeable HPTEs without C set, because the hcall H_PROTECT
+ *     that we use in that case will not update C
+ *  - The above is however not a problem, because we also don't do that
+ *     fancy "no flush" variant of eviction and we use H_REMOVE which will
+ *     do the right thing and thus we don't have the race I described earlier
+ *
+ *    - Under bare metal,  we do have the race, so we need R and C set
+ *    - We make sure R is always set and never lost
+ *    - C is _PAGE_DIRTY, and *should* always be set for a writeable mapping
+ */
 unsigned long htab_convert_pte_flags(unsigned long pteflags)
 {
 	unsigned long rflags = 0;
@@ -186,9 +199,14 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 			rflags |= 0x1;
 	}
 	/*
-	 * Always add "C" bit for perf. Memory coherence is always enabled
+	 * We can't allow hardware to update hpte bits. Hence always
+	 * set 'R' bit and set 'C' if it is a write fault
+	 * Memory coherence is always enabled
 	 */
-	rflags |=  HPTE_R_C | HPTE_R_M;
+	rflags |=  HPTE_R_R | HPTE_R_M;
+
+	if (pteflags & _PAGE_DIRTY)
+		rflags |= HPTE_R_C;
 	/*
 	 * Add in WIG bits
 	 */
-- 
2.7.4
