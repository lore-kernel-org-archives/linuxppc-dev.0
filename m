Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 4B10ADE29C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:46:40 +1100 (EST)
Date: Thu, 22 Nov 2007 08:46:38 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/10] powerpc: Implement kmap_atomic_pfn on powerpc
Message-ID: <20071122154638.GA26514@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is needed for the ppc32 /dev/oldmem driver of crash dump.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 include/asm-powerpc/highmem.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/highmem.h b/include/asm-powerpc/highmem.h
index f7b21ee..88d9e05 100644
--- a/include/asm-powerpc/highmem.h
+++ b/include/asm-powerpc/highmem.h
@@ -117,6 +117,24 @@ static inline void kunmap_atomic(void *kvaddr, enum km_type type)
 	pagefault_enable();
 }
 
+/* This is the same as kmap_atomic() but can map memory that doesn't
+ * have a struct page associated with it.
+ */
+static inline void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
+{
+	unsigned int idx;
+	unsigned long vaddr;
+
+	pagefault_disable();
+
+	idx = type + KM_TYPE_NR * smp_processor_id();
+	vaddr = KMAP_FIX_BEGIN + idx * PAGE_SIZE;
+	set_pte_at(&init_mm, vaddr, kmap_pte+idx, pfn_pte(pfn, kmap_prot));
+	flush_tlb_page(NULL, vaddr);
+
+	return (void*) vaddr;
+}
+
 static inline struct page *kmap_atomic_to_page(void *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long) ptr;
-- 
1.5.3.4
