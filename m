Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVp6Z1lMDzDrK5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:03:34 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i5so7367795pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 02:03:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Florian Weimer <fweimer@redhat.com>
Subject: [PATCH 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address
 boundary case allocation
Date: Mon,  6 Nov 2017 21:03:11 +1100
Message-Id: <20171106100315.29720-2-npiggin@gmail.com>
In-Reply-To: <20171106100315.29720-1-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When allocating VA space with a hint that crosses 128TB, the SLB addr_limit
variable is not expanded if addr is not > 128TB, but the slice allocation
looks at task_size, which is 512TB. This results in slice_check_fit()
incorrectly succeeding because the slice_count truncates off bit 128 of the
requested mask, so the comparison to the available mask succeeds.

Fix this by using mm->context.addr_limit instead of mm->task_size for
testing allocation limits. This causes such allocations to fail.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
Reported-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/mm/slice.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 45f6740dd407..567db541c0a1 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -96,7 +96,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
 {
 	struct vm_area_struct *vma;
 
-	if ((mm->task_size - len) < addr)
+	if ((mm->context.addr_limit - len) < addr)
 		return 0;
 	vma = find_vma(mm, addr);
 	return (!vma || (addr + len) <= vm_start_gap(vma));
@@ -133,7 +133,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
 		if (!slice_low_has_vma(mm, i))
 			ret->low_slices |= 1u << i;
 
-	if (mm->task_size <= SLICE_LOW_TOP)
+	if (mm->context.addr_limit <= SLICE_LOW_TOP)
 		return;
 
 	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++)
@@ -446,19 +446,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 
 	/* Sanity checks */
 	BUG_ON(mm->task_size == 0);
+	BUG_ON(mm->context.addr_limit == 0);
 	VM_BUG_ON(radix_enabled());
 
 	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
 	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
 		  addr, len, flags, topdown);
 
-	if (len > mm->task_size)
+	if (len > mm->context.addr_limit)
 		return -ENOMEM;
 	if (len & ((1ul << pshift) - 1))
 		return -EINVAL;
 	if (fixed && (addr & ((1ul << pshift) - 1)))
 		return -EINVAL;
-	if (fixed && addr > (mm->task_size - len))
+	if (fixed && addr > (mm->context.addr_limit - len))
 		return -ENOMEM;
 
 	/* If hint, make sure it matches our alignment restrictions */
@@ -466,7 +467,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		addr = _ALIGN_UP(addr, 1ul << pshift);
 		slice_dbg(" aligned addr=%lx\n", addr);
 		/* Ignore hint if it's too large or overlaps a VMA */
-		if (addr > mm->task_size - len ||
+		if (addr > mm->context.addr_limit - len ||
 		    !slice_area_is_free(mm, addr, len))
 			addr = 0;
 	}
-- 
2.15.0
