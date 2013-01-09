Return-Path: <walken@google.com>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8CB822C0313
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 12:28:37 +1100 (EST)
Received: by mail-pb0-f53.google.com with SMTP id jt11so593864pbb.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2013 17:28:35 -0800 (PST)
From: Michel Lespinasse <walken@google.com>
To: Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Matt Turner <mattst88@gmail.com>, David Howells <dhowells@redhat.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [PATCH 5/8] mm: use vm_unmapped_area() in hugetlbfs on ia64
 architecture
Date: Tue,  8 Jan 2013 17:28:12 -0800
Message-Id: <1357694895-520-6-git-send-email-walken@google.com>
In-Reply-To: <1357694895-520-1-git-send-email-walken@google.com>
References: <1357694895-520-1-git-send-email-walken@google.com>
Cc: linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the ia64 hugetlb_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/ia64/mm/hugetlbpage.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
index 5ca674b74737..76069c18ee42 100644
--- a/arch/ia64/mm/hugetlbpage.c
+++ b/arch/ia64/mm/hugetlbpage.c
@@ -148,7 +148,7 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
 {
-	struct vm_area_struct *vmm;
+	struct vm_unmapped_area_info info;
 
 	if (len > RGN_MAP_LIMIT)
 		return -ENOMEM;
@@ -165,16 +165,14 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr, u
 	/* This code assumes that RGN_HPAGE != 0. */
 	if ((REGION_NUMBER(addr) != RGN_HPAGE) || (addr & (HPAGE_SIZE - 1)))
 		addr = HPAGE_REGION_BASE;
-	else
-		addr = ALIGN(addr, HPAGE_SIZE);
-	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (REGION_OFFSET(addr) + len > RGN_MAP_LIMIT)
-			return -ENOMEM;
-		if (!vmm || (addr + len) <= vmm->vm_start)
-			return addr;
-		addr = ALIGN(vmm->vm_end, HPAGE_SIZE);
-	}
+
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = addr;
+	info.high_limit = HPAGE_REGION_BASE + RGN_MAP_LIMIT;
+	info.align_mask = PAGE_MASK & (HPAGE_SIZE - 1);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
 }
 
 static int __init hugetlb_setup_sz(char *str)
-- 
1.7.7.3
