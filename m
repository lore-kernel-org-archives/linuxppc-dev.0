Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26F1D1A033E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:14:00 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 22:13:58 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 34A552CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:57 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1HCDne933554528
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:57 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1HCDOYr013563
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:13:24 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 3/4] powerpc/mm: Rename the vmemmap_backing struct and its
 elements
Date: Wed, 17 Feb 2016 17:42:58 +0530
Message-Id: <1455711179-20357-3-git-send-email-khandual@linux.vnet.ibm.com>
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

The structure to track single virtual to physical mapping has
been renamed from vmemmap_backing to vmemmap_hw_map which sounds
more appropriate. This forms a single entry of the global linked
list tracking all of the vmemmap physical mapping. The changes
are as follows.

	vmemmap_backing.list -> vmemmap_hw_map.link
	vmemmap_backing.phys -> vmemmap_hw_map.paddr
	vmemmap_backing.virt_addr -> vmemmap_hw_map.vaddr

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h | 16 +++++++---
 arch/powerpc/kernel/machine_kexec.c   |  8 ++---
 arch/powerpc/mm/init_64.c             | 58 +++++++++++++++++------------------
 3 files changed, 44 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 69ef28a..e03b41c 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -11,12 +11,18 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 
-struct vmemmap_backing {
-	struct vmemmap_backing *list;
-	unsigned long phys;
-	unsigned long virt_addr;
+/*
+ * This structure tracks a single virtual page mapping from
+ * the vmemmap ddress space. This element is required to
+ * track virtual to physical mapping of page structures in
+ * absense of a page table at boot time.
+ */
+struct vmemmap_hw_map {
+	struct vmemmap_hw_map *link;
+	unsigned long paddr;
+	unsigned long vaddr;
 };
-extern struct vmemmap_backing *vmemmap_list;
+extern struct vmemmap_hw_map *vmemmap_list;
 
 /*
  * Functions that deal with pagetables that could be at any level of
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 015ae55..0d90798 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -80,10 +80,10 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_SYMBOL(vmemmap_list);
 	VMCOREINFO_SYMBOL(mmu_vmemmap_psize);
 	VMCOREINFO_SYMBOL(mmu_psize_defs);
-	VMCOREINFO_STRUCT_SIZE(vmemmap_backing);
-	VMCOREINFO_OFFSET(vmemmap_backing, list);
-	VMCOREINFO_OFFSET(vmemmap_backing, phys);
-	VMCOREINFO_OFFSET(vmemmap_backing, virt_addr);
+	VMCOREINFO_STRUCT_SIZE(vmemmap_hw_map);
+	VMCOREINFO_OFFSET(vmemmap_hw_map, link);
+	VMCOREINFO_OFFSET(vmemmap_hw_map, paddr);
+	VMCOREINFO_OFFSET(vmemmap_hw_map, vaddr);
 	VMCOREINFO_STRUCT_SIZE(mmu_psize_def);
 	VMCOREINFO_OFFSET(mmu_psize_def, shift);
 #endif
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d6b9b4d..9b5dea3 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -194,7 +194,7 @@ static int __meminit vmemmap_populated(unsigned long start, int page_size)
 #ifdef CONFIG_PPC_BOOK3E
 static void __meminit vmemmap_create_mapping(unsigned long start,
 					     unsigned long page_size,
-					     unsigned long phys)
+					     unsigned long paddr)
 {
 	/* Create a PTE encoding without page size */
 	unsigned long i, flags = _PAGE_PRESENT | _PAGE_ACCESSED |
@@ -207,11 +207,11 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 	flags |= mmu_psize_defs[mmu_vmemmap_psize].enc << 8;
 
 	/* For each PTE for that area, map things. Note that we don't
-	 * increment phys because all PTEs are of the large size and
+	 * increment paddr because all PTEs are of the large size and
 	 * thus must have the low bits clear
 	 */
 	for (i = 0; i < page_size; i += PAGE_SIZE)
-		BUG_ON(map_kernel_page(start + i, phys, flags));
+		BUG_ON(map_kernel_page(start + i, paddr, flags));
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -223,9 +223,9 @@ static void vmemmap_remove_mapping(unsigned long start,
 #else /* CONFIG_PPC_BOOK3E */
 static void __meminit vmemmap_create_mapping(unsigned long start,
 					     unsigned long page_size,
-					     unsigned long phys)
+					     unsigned long paddr)
 {
-	int  mapped = htab_bolt_mapping(start, start + page_size, phys,
+	int  mapped = htab_bolt_mapping(start, start + page_size, paddr,
 					pgprot_val(PAGE_KERNEL),
 					mmu_vmemmap_psize,
 					mmu_kernel_ssize);
@@ -245,19 +245,19 @@ static void vmemmap_remove_mapping(unsigned long start,
 
 #endif /* CONFIG_PPC_BOOK3E */
 
-struct vmemmap_backing *vmemmap_list;
-static struct vmemmap_backing *next;
+struct vmemmap_hw_map *vmemmap_list;
+static struct vmemmap_hw_map *next;
 static int num_left;
 static int num_freed;
 
-static __meminit struct vmemmap_backing * vmemmap_list_alloc(int node)
+static __meminit struct vmemmap_hw_map * vmemmap_list_alloc(int node)
 {
-	struct vmemmap_backing *vmem_back;
+	struct vmemmap_hw_map *vmem_back;
 	/* get from freed entries first */
 	if (num_freed) {
 		num_freed--;
 		vmem_back = next;
-		next = next->list;
+		next = next->link;
 
 		return vmem_back;
 	}
@@ -269,7 +269,7 @@ static __meminit struct vmemmap_backing * vmemmap_list_alloc(int node)
 			WARN_ON(1);
 			return NULL;
 		}
-		num_left = PAGE_SIZE / sizeof(struct vmemmap_backing);
+		num_left = PAGE_SIZE / sizeof(struct vmemmap_hw_map);
 	}
 
 	num_left--;
@@ -277,11 +277,11 @@ static __meminit struct vmemmap_backing * vmemmap_list_alloc(int node)
 	return next++;
 }
 
-static __meminit void vmemmap_list_populate(unsigned long phys,
+static __meminit void vmemmap_list_populate(unsigned long paddr,
 					    unsigned long start,
 					    int node)
 {
-	struct vmemmap_backing *vmem_back;
+	struct vmemmap_hw_map *vmem_back;
 
 	vmem_back = vmemmap_list_alloc(node);
 	if (unlikely(!vmem_back)) {
@@ -289,9 +289,9 @@ static __meminit void vmemmap_list_populate(unsigned long phys,
 		return;
 	}
 
-	vmem_back->phys = phys;
-	vmem_back->virt_addr = start;
-	vmem_back->list = vmemmap_list;
+	vmem_back->paddr = paddr;
+	vmem_back->vaddr = start;
+	vmem_back->link = vmemmap_list;
 
 	vmemmap_list = vmem_back;
 }
@@ -329,13 +329,13 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 #ifdef CONFIG_MEMORY_HOTPLUG
 static unsigned long vmemmap_list_free(unsigned long start)
 {
-	struct vmemmap_backing *vmem_back, *vmem_back_prev;
+	struct vmemmap_hw_map *vmem_back, *vmem_back_prev;
 
 	vmem_back_prev = vmem_back = vmemmap_list;
 
 	/* look for it with prev pointer recorded */
-	for (; vmem_back; vmem_back = vmem_back->list) {
-		if (vmem_back->virt_addr == start)
+	for (; vmem_back; vmem_back = vmem_back->link) {
+		if (vmem_back->vaddr == start)
 			break;
 		vmem_back_prev = vmem_back;
 	}
@@ -347,16 +347,16 @@ static unsigned long vmemmap_list_free(unsigned long start)
 
 	/* remove it from vmemmap_list */
 	if (vmem_back == vmemmap_list) /* remove head */
-		vmemmap_list = vmem_back->list;
+		vmemmap_list = vmem_back->link;
 	else
-		vmem_back_prev->list = vmem_back->list;
+		vmem_back_prev->link = vmem_back->link;
 
 	/* next point to this freed entry */
-	vmem_back->list = next;
+	vmem_back->link = next;
 	next = vmem_back;
 	num_freed++;
 
-	return vmem_back->phys;
+	return vmem_back->paddr;
 }
 
 void __ref vmemmap_free(unsigned long start, unsigned long end)
@@ -427,20 +427,20 @@ void register_page_bootmem_memmap(unsigned long section_nr,
  */
 struct page *realmode_pfn_to_page(unsigned long pfn)
 {
-	struct vmemmap_backing *vmem_back;
+	struct vmemmap_hw_map *vmem_back;
 	struct page *page;
 	unsigned long page_size = 1 << mmu_psize_defs[mmu_vmemmap_psize].shift;
 	unsigned long pg_va = (unsigned long) pfn_to_page(pfn);
 
-	for (vmem_back = vmemmap_list; vmem_back; vmem_back = vmem_back->list) {
-		if (pg_va < vmem_back->virt_addr)
+	for (vmem_back = vmemmap_list; vmem_back; vmem_back = vmem_back->link) {
+		if (pg_va < vmem_back->vaddr)
 			continue;
 
 		/* After vmemmap_list entry free is possible, need check all */
 		if ((pg_va + sizeof(struct page)) <=
-				(vmem_back->virt_addr + page_size)) {
-			page = (struct page *) (vmem_back->phys + pg_va -
-				vmem_back->virt_addr);
+				(vmem_back->vaddr + page_size)) {
+			page = (struct page *) (vmem_back->paddr + pg_va -
+				vmem_back->vaddr);
 			return page;
 		}
 	}
-- 
2.1.0
