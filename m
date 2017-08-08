Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRcQf0Kh3zDqps
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 00:36:09 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78EXaCt123950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 10:36:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7eqnjjmw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 10:36:07 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 15:36:05 +0100
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
Subject: [PATCH 04/16] mm: VMA sequence count
Date: Tue,  8 Aug 2017 16:35:37 +0200
In-Reply-To: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1502202949-8138-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1502202949-8138-5-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Peter Zijlstra <peterz@infradead.org>

Wrap the VMA modifications (vma_adjust/unmap_page_range) with sequence
counts such that we can easily test if a VMA is changed.

The unmap_page_range() one allows us to make assumptions about
page-tables; when we find the seqcount hasn't changed we can assume
page-tables are still valid.

The flip side is that we cannot distinguish between a vma_adjust() and
the unmap_page_range() -- where with the former we could have
re-checked the vma bounds against the address.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[Port to 4.12 kernel]
[Fix lock dependency between mapping->i_mmap_rwsem and vma->vm_sequence]
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/mm_types.h |  1 +
 mm/memory.c              |  2 ++
 mm/mmap.c                | 21 ++++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f384bb62d8e..d7d6dae4c009 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -342,6 +342,7 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+	seqcount_t vm_sequence;
 } __randomize_layout;
 
 struct core_thread {
diff --git a/mm/memory.c b/mm/memory.c
index 11c5fe5f62bb..7d61f64916a2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1380,6 +1380,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 	unsigned long next;
 
 	BUG_ON(addr >= end);
+	write_seqcount_begin(&vma->vm_sequence);
 	tlb_start_vma(tlb, vma);
 	pgd = pgd_offset(vma->vm_mm, addr);
 	do {
@@ -1389,6 +1390,7 @@ void unmap_page_range(struct mmu_gather *tlb,
 		next = zap_p4d_range(tlb, vma, pgd, addr, next, details);
 	} while (pgd++, addr = next, addr != end);
 	tlb_end_vma(tlb, vma);
+	write_seqcount_end(&vma->vm_sequence);
 }
 
 
diff --git a/mm/mmap.c b/mm/mmap.c
index f19efcf75418..140b22136cb7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -557,6 +557,8 @@ void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
 	else
 		mm->highest_vm_end = vm_end_gap(vma);
 
+	seqcount_init(&vma->vm_sequence);
+
 	/*
 	 * vma->vm_prev wasn't known when we followed the rbtree to find the
 	 * correct insertion point for that vma. As a result, we could not
@@ -798,6 +800,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
+	write_seqcount_begin(&vma->vm_sequence);
+	if (next && next != vma)
+		write_seqcount_begin_nested(&next->vm_sequence,
+					    SINGLE_DEPTH_NESTING);
+
 	anon_vma = vma->anon_vma;
 	if (!anon_vma && adjust_next)
 		anon_vma = next->anon_vma;
@@ -902,6 +909,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		mm->map_count--;
 		mpol_put(vma_policy(next));
 		kmem_cache_free(vm_area_cachep, next);
+		write_seqcount_end(&next->vm_sequence);
 		/*
 		 * In mprotect's case 6 (see comments on vma_merge),
 		 * we must remove another next too. It would clutter
@@ -931,11 +939,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		if (remove_next == 2) {
 			remove_next = 1;
 			end = next->vm_end;
+			write_seqcount_end(&vma->vm_sequence);
 			goto again;
-		}
-		else if (next)
+		} else if (next) {
+			if (next != vma)
+				write_seqcount_begin_nested(&next->vm_sequence,
+							    SINGLE_DEPTH_NESTING);
 			vma_gap_update(next);
-		else {
+		} else {
 			/*
 			 * If remove_next == 2 we obviously can't
 			 * reach this path.
@@ -961,6 +972,10 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	if (insert && file)
 		uprobe_mmap(insert);
 
+	if (next && next != vma)
+		write_seqcount_end(&next->vm_sequence);
+	write_seqcount_end(&vma->vm_sequence);
+
 	validate_mm(mm);
 
 	return 0;
-- 
2.7.4
