Return-Path: <walken@google.com>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7551F2C00B4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2013 12:28:31 +1100 (EST)
Received: by mail-pa0-f48.google.com with SMTP id fa1so687153pad.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Jan 2013 17:28:29 -0800 (PST)
From: Michel Lespinasse <walken@google.com>
To: Rik van Riel <riel@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Matt Turner <mattst88@gmail.com>, David Howells <dhowells@redhat.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/8] mm: use vm_unmapped_area() on parisc architecture
Date: Tue,  8 Jan 2013 17:28:08 -0800
Message-Id: <1357694895-520-2-git-send-email-walken@google.com>
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

Update the parisc arch_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/parisc/kernel/sys_parisc.c |   46 ++++++++++++++------------------------
 1 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f76c10863c62..6ab138088076 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -35,18 +35,15 @@
 
 static unsigned long get_unshared_area(unsigned long addr, unsigned long len)
 {
-	struct vm_area_struct *vma;
+	struct vm_unmapped_area_info info;
 
-	addr = PAGE_ALIGN(addr);
-
-	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vma || addr + len <= vma->vm_start)
-			return addr;
-		addr = vma->vm_end;
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = PAGE_ALIGN(addr);
+	info.high_limit = TASK_SIZE;
+	info.align_mask = 0;
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
 }
 
 #define DCACHE_ALIGN(addr) (((addr) + (SHMLBA - 1)) &~ (SHMLBA - 1))
@@ -63,30 +60,21 @@ static unsigned long get_unshared_area(unsigned long addr, unsigned long len)
  */
 static int get_offset(struct address_space *mapping)
 {
-	int offset = (unsigned long) mapping << (PAGE_SHIFT - 8);
-	return offset & 0x3FF000;
+	return (unsigned long) mapping >> 8;
 }
 
 static unsigned long get_shared_area(struct address_space *mapping,
 		unsigned long addr, unsigned long len, unsigned long pgoff)
 {
-	struct vm_area_struct *vma;
-	int offset = mapping ? get_offset(mapping) : 0;
-
-	offset = (offset + (pgoff << PAGE_SHIFT)) & 0x3FF000;
+	struct vm_unmapped_area_info info;
 
-	addr = DCACHE_ALIGN(addr - offset) + offset;
-
-	for (vma = find_vma(current->mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vma || addr + len <= vma->vm_start)
-			return addr;
-		addr = DCACHE_ALIGN(vma->vm_end - offset) + offset;
-		if (addr < vma->vm_end) /* handle wraparound */
-			return -ENOMEM;
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = PAGE_ALIGN(addr);
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & (SHMLBA - 1);
+	info.align_offset = (get_offset(mapping) + pgoff) << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
 }
 
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
-- 
1.7.7.3
