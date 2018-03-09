Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zyfYF4jnHzF1rn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 07:46:09 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w29Kk4nc011655
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Mar 2018 15:46:07 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gkyv8bsej-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Mar 2018 15:46:07 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Fri, 9 Mar 2018 15:46:05 -0500
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: bsingharora@gmail.com, aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Subject: [PATCH] powerpc/mm: Fix section mismatch warning in
 stop_machine_change_mapping()
Date: Fri,  9 Mar 2018 17:45:58 -0300
Message-Id: <1520628358-1762-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the warning messages for stop_machine_change_mapping(), and a number
of other affected functions in its call chain.

All modified functions are under CONFIG_MEMORY_HOTPLUG, so __meminit
is okay (keeps them / does not discard them).

Boot-tested on powernv/power9/radix-mmu and pseries/power8/hash-mmu.

    $ make -j$(nproc) CONFIG_DEBUG_SECTION_MISMATCH=y vmlinux
    ...
      MODPOST vmlinux.o
    WARNING: vmlinux.o(.text+0x6b130): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping()
    The function stop_machine_change_mapping() references
    the function __meminit create_physical_mapping().
    This is often because stop_machine_change_mapping lacks a __meminit 
    annotation or the annotation of create_physical_mapping is wrong.

    WARNING: vmlinux.o(.text+0x6b13c): Section mismatch in reference from the function stop_machine_change_mapping() to the function .meminit.text:create_physical_mapping()
    The function stop_machine_change_mapping() references
    the function __meminit create_physical_mapping().
    This is often because stop_machine_change_mapping lacks a __meminit 
    annotation or the annotation of create_physical_mapping is wrong.
    ...

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mem.c              |  4 ++--
 arch/powerpc/mm/pgtable-book3s64.c |  4 ++--
 arch/powerpc/mm/pgtable-radix.c    | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index fe8c611..85245ef 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -127,7 +127,7 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
 	return -ENODEV;
 }
 
-int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
+int __meminit arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		bool want_memblock)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
@@ -148,7 +148,7 @@ int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-int arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
+int __meminit arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 422e802..bd6ca74 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -155,7 +155,7 @@ void mmu_cleanup_all(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int create_section_mapping(unsigned long start, unsigned long end)
+int __meminit create_section_mapping(unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
 		return radix__create_section_mapping(start, end);
@@ -163,7 +163,7 @@ int create_section_mapping(unsigned long start, unsigned long end)
 	return hash__create_section_mapping(start, end);
 }
 
-int remove_section_mapping(unsigned long start, unsigned long end)
+int __meminit remove_section_mapping(unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
 		return radix__remove_section_mapping(start, end);
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 2e10a96..ab9db0a 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -695,7 +695,7 @@ struct change_mapping_params {
 	unsigned long aligned_end;
 };
 
-static int stop_machine_change_mapping(void *data)
+static int __meminit stop_machine_change_mapping(void *data)
 {
 	struct change_mapping_params *params =
 			(struct change_mapping_params *)data;
@@ -742,7 +742,7 @@ static void remove_pte_table(pte_t *pte_start, unsigned long addr,
 /*
  * clear the pte and potentially split the mapping helper
  */
-static void split_kernel_mapping(unsigned long addr, unsigned long end,
+static void __meminit split_kernel_mapping(unsigned long addr, unsigned long end,
 				unsigned long size, pte_t *pte)
 {
 	unsigned long mask = ~(size - 1);
@@ -835,7 +835,7 @@ static void remove_pud_table(pud_t *pud_start, unsigned long addr,
 	}
 }
 
-static void remove_pagetable(unsigned long start, unsigned long end)
+static void __meminit remove_pagetable(unsigned long start, unsigned long end)
 {
 	unsigned long addr, next;
 	pud_t *pud_base;
@@ -863,12 +863,12 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 	radix__flush_tlb_kernel_range(start, end);
 }
 
-int __ref radix__create_section_mapping(unsigned long start, unsigned long end)
+int __meminit radix__create_section_mapping(unsigned long start, unsigned long end)
 {
 	return create_physical_mapping(start, end);
 }
 
-int radix__remove_section_mapping(unsigned long start, unsigned long end)
+int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
 {
 	remove_pagetable(start, end);
 	return 0;
@@ -888,7 +888,7 @@ int __meminit radix__vmemmap_create_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-void radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
+void __meminit radix__vmemmap_remove_mapping(unsigned long start, unsigned long page_size)
 {
 	remove_pagetable(start, start + page_size);
 }
-- 
1.8.3.1
