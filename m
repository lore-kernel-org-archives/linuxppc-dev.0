Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vq22R0JT8zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Mar 2017 09:55:26 +1100 (AEDT)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.or
Subject: [v1 5/5] mm: teach platforms not to zero struct pages memory
Date: Thu, 23 Mar 2017 19:01:53 -0400
Message-Id: <1490310113-824438-6-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
References: <1490310113-824438-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we are using deferred struct page initialization feature, most of
"struct page"es are getting initialized after other CPUs are started, and
hence we are benefiting from doing this job in parallel. However, we are
still zeroing all the memory that is allocated for "struct pages" using the
boot CPU.  This patch solves this problem, by deferring zeroing "struct
pages" to only when they are initialized.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/powerpc/mm/init_64.c |    2 +-
 arch/sparc/mm/init_64.c   |    2 +-
 arch/x86/mm/init_64.c     |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index eb4c270..24faf2d 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -181,7 +181,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 		if (vmemmap_populated(start, page_size))
 			continue;
 
-		p = vmemmap_alloc_block(page_size, node, true);
+		p = vmemmap_alloc_block(page_size, node, VMEMMAP_ZERO);
 		if (!p)
 			return -ENOMEM;
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index d91e462..280834e 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2542,7 +2542,7 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 		pte = pmd_val(*pmd);
 		if (!(pte & _PAGE_VALID)) {
 			void *block = vmemmap_alloc_block(PMD_SIZE, node,
-							  true);
+							  VMEMMAP_ZERO);
 
 			if (!block)
 				return -ENOMEM;
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 46101b6..9d8c72c 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1177,7 +1177,7 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 			void *p;
 
 			p = __vmemmap_alloc_block_buf(PMD_SIZE, node, altmap,
-						      true);
+						      VMEMMAP_ZERO);
 			if (p) {
 				pte_t entry;
 
-- 
1.7.1
