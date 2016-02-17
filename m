Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F7A11A033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:14:01 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 22:14:00 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3C96E357803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:58 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HCDoic6029814
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:58 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HCDPbV013587
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:26 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 4/4] powerpc/mm: Rename global tracker for virtual to physical
 mapping
Date: Wed, 17 Feb 2016 17:42:59 +0530
Message-Id: <1455711179-20357-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455711179-20357-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This renames the global list which tracks all the virtual to physical
mapping and also the global list which tracks all the available unused
vmemmap_hw_map node structures. It also attempts to explain the purpose
of these global linked lists and points out a possible race condition.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h |  2 +-
 arch/powerpc/kernel/machine_kexec.c   |  2 +-
 arch/powerpc/mm/init_64.c             | 82 +++++++++++++++++++++--------------
 3 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index e03b41c..6e21a2a 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -22,7 +22,7 @@ struct vmemmap_hw_map {
 	unsigned long paddr;
 	unsigned long vaddr;
 };
-extern struct vmemmap_hw_map *vmemmap_list;
+extern struct vmemmap_hw_map *vmemmap_global;
 
 /*
  * Functions that deal with pagetables that could be at any level of
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 0d90798..eb6876c 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -77,7 +77,7 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #if defined(CONFIG_PPC64) && defined(CONFIG_SPARSEMEM_VMEMMAP)
-	VMCOREINFO_SYMBOL(vmemmap_list);
+	VMCOREINFO_SYMBOL(vmemmap_global);
 	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
 	VMCOREINFO_SYMBOL(mmu_psize_defs);
 	VMCOREINFO_STRUCT_SIZE(vmemmap_hw_map);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index 9b5dea3..d998f3f 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -245,45 +245,63 @@ static void vmemmap_remove_mapping(unsigned long start,
 
 #endif /* CONFIG_PPC_BOOK3E */
 
-struct vmemmap_hw_map *vmemmap_list;
-static struct vmemmap_hw_map *next;
-static int num_left;
-static int num_freed;
+/*
+ * vmemmap virtual address space does not have a page table to track
+ * existing physical mapping. The vmemmap_global list maintains the
+ * physical mapping at all times where as the vmemmap_avail list
+ * maintains the available vmemmap_hw_map structures which got deleted
+ * from the vmemmap_global list during system runtime (memory hotplug
+ * remove operation for example). They freed structures are reused later
+ * when new requests come in without allocating new fresh memory. This
+ * pointer also tracks the allocated vmemmap_hw_map structures as we
+ * allocate one full page memory at a time when we dont have any.
+ */
+struct vmemmap_hw_map *vmemmap_global;
+static struct vmemmap_hw_map *vmemmap_avail;
+
+/* XXX: The same pointer vmemmap_avail tracks individual chunks inside
+ * the allocated full page during the boot time and again tracks the
+ * freeed nodes during runtime. It is racy but it does not happen as
+ * both they are separated by the boot process. Will create problem if
+ * some how we have memory hotplug operation during boot !!
+ */
+static int free_chunk;		/* Allocated chunks available */
+static int free_node;		/* Freeed nodes available */
 
-static __meminit struct vmemmap_hw_map * vmemmap_list_alloc(int node)
+static __meminit struct vmemmap_hw_map * vmemmap_global_alloc(int node)
 {
 	struct vmemmap_hw_map *vmem_back;
 	/* get from freed entries first */
-	if (num_freed) {
-		num_freed--;
-		vmem_back = next;
-		next = next->link;
+	if (free_node) {
+		free_node--;
+		vmem_back = vmemmap_avail;
+		vmemmap_avail = vmemmap_avail->link;
 
 		return vmem_back;
 	}
 
 	/* allocate a page when required and hand out chunks */
-	if (!num_left) {
-		next = vmemmap_alloc_block(PAGE_SIZE, node);
-		if (unlikely(!next)) {
+	if (!free_chunk) {
+		vmemmap_avail = vmemmap_alloc_block(PAGE_SIZE, node);
+		if (unlikely(!vmemmap_avail)) {
 			WARN_ON(1);
 			return NULL;
 		}
-		num_left = PAGE_SIZE / sizeof(struct vmemmap_hw_map);
+		free_chunk = PAGE_SIZE / sizeof(struct vmemmap_hw_map);
 	}
 
-	num_left--;
+	free_chunk--;
 
-	return next++;
+	return vmemmap_avail++;
 }
 
-static __meminit void vmemmap_list_populate(unsigned long paddr,
+static __meminit void vmemmap_global_populate(unsigned long paddr,
 					    unsigned long start,
 					    int node)
 {
 	struct vmemmap_hw_map *vmem_back;
 
-	vmem_back = vmemmap_list_alloc(node);
+	vmem_back = vmemmap_global_alloc(node);
 	if (unlikely(!vmem_back)) {
 		WARN_ON(1);
 		return;
@@ -291,9 +309,9 @@ static __meminit void vmemmap_list_populate(unsigned long paddr,
 
 	vmem_back->paddr = paddr;
 	vmem_back->vaddr = start;
-	vmem_back->link = vmemmap_list;
+	vmem_back->link = vmemmap_global;
 
-	vmemmap_list = vmem_back;
+	vmemmap_global = vmem_back;
 }
 
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
@@ -315,7 +333,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 		if (!p)
 			return -ENOMEM;
 
-		vmemmap_list_populate(__pa(p), start, node);
+		vmemmap_global_populate(__pa(p), start, node);
 
 		pr_debug("      * %016lx..%016lx allocated at %p\n",
 			 start, start + page_size, p);
@@ -327,11 +345,11 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-static unsigned long vmemmap_list_free(unsigned long start)
+static unsigned long vmemmap_global_free(unsigned long start)
 {
 	struct vmemmap_hw_map *vmem_back, *vmem_back_prev;
 
-	vmem_back_prev = vmem_back = vmemmap_list;
+	vmem_back_prev = vmem_back = vmemmap_global;
 
 	/* look for it with prev pointer recorded */
 	for (; vmem_back; vmem_back = vmem_back->link) {
@@ -345,16 +363,16 @@ static unsigned long vmemmap_list_free(unsigned long start)
 		return 0;
 	}
 
-	/* remove it from vmemmap_list */
-	if (vmem_back == vmemmap_list) /* remove head */
-		vmemmap_list = vmem_back->link;
+	/* remove it from vmemmap_global */
+	if (vmem_back == vmemmap_global) /* remove head */
+		vmemmap_global = vmem_back->link;
 	else
 		vmem_back_prev->link = vmem_back->link;
 
-	/* next point to this freed entry */
-	vmem_back->link = next;
-	next = vmem_back;
-	num_freed++;
+	/* vmemmap_avail point to this freed entry */
+	vmem_back->link = vmemmap_avail;
+	vmemmap_avail = vmem_back;
+	free_node++;
 
 	return vmem_back->paddr;
 }
@@ -378,7 +396,7 @@ void __ref vmemmap_free(unsigned long start, unsigned long end)
 		if (vmemmap_populated(start, page_size))
 			continue;
 
-		addr = vmemmap_list_free(start);
+		addr = vmemmap_global_free(start);
 		if (addr) {
 			struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
 
@@ -432,11 +450,11 @@ struct page *realmode_pfn_to_page(unsigned long pfn)
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 	unsigned long pg_va = (unsigned long) pfn_to_page(pfn);
 
-	for (vmem_back = vmemmap_list; vmem_back; vmem_back = vmem_back->link) {
+	for (vmem_back = vmemmap_global; vmem_back; vmem_back = vmem_back->link) {
 		if (pg_va < vmem_back->vaddr)
 			continue;
 
-		/* After vmemmap_list entry free is possible, need check all */
+		/* After vmemmap_global entry free is possible, need check all */
 		if ((pg_va + sizeof(struct page)) <=
 				(vmem_back->vaddr + page_size)) {
 			page = (struct page *) (vmem_back->paddr + pg_va -
-- 
2.1.0
