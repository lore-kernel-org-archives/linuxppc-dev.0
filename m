Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYL0461w1zDrLy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 08:06:28 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7HM5GqU077878
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 18:06:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cdj1xmece-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 18:06:26 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 17 Aug 2017 23:06:23 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v2 15/20] mm: Try spin lock in speculative path
Date: Fri, 18 Aug 2017 00:05:14 +0200
In-Reply-To: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1503007519-26777-16-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is a deadlock when a CPU is doing a speculative page fault and
another one is calling do_unmap().

The deadlock occurred because the speculative path try to spinlock the
pte while the interrupt are disabled. When the other CPU in the
unmap's path has locked the pte then is waiting for all the CPU to
invalidate the TLB. As the CPU doing the speculative fault have the
interrupt disable it can't invalidate the TLB, and can't get the lock.

Since we are in a speculative path, we can race with other mm action.
So let assume that the lock may not get acquired and fail the
speculative page fault.

Here are the stacks captured during the deadlock:

	CPU 0
	native_flush_tlb_others+0x7c/0x260
	flush_tlb_mm_range+0x6a/0x220
	tlb_flush_mmu_tlbonly+0x63/0xc0
	unmap_page_range+0x897/0x9d0
	? unmap_single_vma+0x7d/0xe0
	? release_pages+0x2b3/0x360
	unmap_single_vma+0x7d/0xe0
	unmap_vmas+0x51/0xa0
	unmap_region+0xbd/0x130
	do_munmap+0x279/0x460
	SyS_munmap+0x53/0x70

	CPU 1
	do_raw_spin_lock+0x14e/0x160
	_raw_spin_lock+0x5d/0x80
	? pte_map_lock+0x169/0x1b0
	pte_map_lock+0x169/0x1b0
	handle_pte_fault+0xbf2/0xd80
	? trace_hardirqs_on+0xd/0x10
	handle_speculative_fault+0x272/0x280
	handle_speculative_fault+0x5/0x280
	__do_page_fault+0x187/0x580
	trace_do_page_fault+0x52/0x260
	do_async_page_fault+0x19/0x70
	async_page_fault+0x28/0x30

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/memory.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0ba14a5797b2..8c701e4f59d3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2300,7 +2300,8 @@ static bool pte_spinlock(struct vm_fault *vmf)
 		goto out;
 
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
-	spin_lock(vmf->ptl);
+	if (unlikely(!spin_trylock(vmf->ptl)))
+		goto out;
 
 	if (vma_has_changed(vmf)) {
 		spin_unlock(vmf->ptl);
@@ -2336,8 +2337,20 @@ static bool pte_map_lock(struct vm_fault *vmf)
 	if (vma_has_changed(vmf))
 		goto out;
 
-	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
-				  vmf->address, &ptl);
+	/*
+	 * Same as pte_offset_map_lock() except that we call
+	 * spin_trylock() in place of spin_lock() to avoid race with
+	 * unmap path which may have the lock and wait for this CPU
+	 * to invalidate TLB but this CPU has irq disabled.
+	 * Since we are in a speculative patch, accept it could fail
+	 */
+	ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
+	pte = pte_offset_map(vmf->pmd, vmf->address);
+	if (unlikely(!spin_trylock(ptl))) {
+		pte_unmap(pte);
+		goto out;
+	}
+
 	if (vma_has_changed(vmf)) {
 		pte_unmap_unlock(pte, ptl);
 		goto out;
-- 
2.7.4
