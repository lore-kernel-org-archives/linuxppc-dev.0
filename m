Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xplfS5QnZzDrYd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 04:07:44 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v88I4Q8Y013600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Sep 2017 14:07:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cux39p47r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 14:07:42 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 8 Sep 2017 19:07:40 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v3 08/20] mm: Protect SPF handler against anon_vma changes
Date: Fri,  8 Sep 2017 20:06:52 +0200
In-Reply-To: <1504894024-2750-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1504894024-2750-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1504894024-2750-9-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The speculative page fault handler must be protected against anon_vma
changes. This is because page_add_new_anon_rmap() is called during the
speculative path.

In addition, don't try speculative page fault if the VMA don't have an
anon_vma structure allocated because its allocation should be
protected by the mmap_sem.

In __vma_adjust() when importer->anon_vma is set, there is no need to
protect against speculative page faults since speculative page fault
is aborted if the vma->anon_vma is not set.

When calling page_add_new_anon_rmap() vma->anon_vma is necessarily
valid since we checked for it when locking the pte and the anon_vma is
removed once the pte is unlocked. So even if the speculative page
fault handler is running concurrently with do_unmap(), as the pte is
locked in unmap_region() - through unmap_vmas() - and the anon_vma
unlinked later, because we check for the vma sequence counter which is
updated in unmap_page_range() before locking the pte, and then in
free_pgtables() so when locking the pte the change will be detected.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 mm/memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index f008042ab24e..401b13cbfc3c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -617,7 +617,9 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
 		 */
+		write_seqcount_begin(&vma->vm_sequence);
 		unlink_anon_vmas(vma);
+		write_seqcount_end(&vma->vm_sequence);
 		unlink_file_vma(vma);
 
 		if (is_vm_hugetlb_page(vma)) {
@@ -631,7 +633,9 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			       && !is_vm_hugetlb_page(next)) {
 				vma = next;
 				next = vma->vm_next;
+				write_seqcount_begin(&vma->vm_sequence);
 				unlink_anon_vmas(vma);
+				write_seqcount_end(&vma->vm_sequence);
 				unlink_file_vma(vma);
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
-- 
2.7.4
