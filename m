Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DBF31A0616
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:59:54 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 03/18] powerpc/mm: Clean up memory hotplug failure paths
Date: Thu,  3 Mar 2016 12:59:34 +1100
Message-Id: <1456970389-28802-4-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
References: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This makes a number of cleanups to handling of mapping failures during
memory hotplug on Power:

For errors creating the linear mapping for the hot-added region:
  * This is now reported with EFAULT which is more appropriate than the
    previous EINVAL (the failure is unlikely to be related to the
    function's parameters)
  * An error in this path now prints a warning message, rather than just
    silently failing to add the extra memory.
  * Previously a failure here could result in the region being partially
    mapped.  We now clean up any partial mapping before failing.

For errors creating the vmemmap for the hot-added region:
   * This is now reported with EFAULT instead of causing a BUG() - this
     could happen for external reason (e.g. full hash table) so it's better
     to handle this non-fatally
   * An error message is also printed, so the failure won't be silent
   * As above a failure could cause a partially mapped region, we now
     clean this up.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/mm/hash_utils_64.c | 13 ++++++++++---
 arch/powerpc/mm/init_64.c       | 38 ++++++++++++++++++++++++++------------
 arch/powerpc/mm/mem.c           | 10 ++++++++--
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 99fbee0..fdcf9d1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -640,9 +640,16 @@ static unsigned long __init htab_get_table_size(void)
 #ifdef CONFIG_MEMORY_HOTPLUG
 int create_section_mapping(unsigned long start, unsigned long end)
 {
-	return htab_bolt_mapping(start, end, __pa(start),
-				 pgprot_val(PAGE_KERNEL), mmu_linear_psize,
-				 mmu_kernel_ssize);
+	int rc = htab_bolt_mapping(start, end, __pa(start),
+				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
+				   mmu_kernel_ssize);
+
+	if (rc < 0) {
+		int rc2 = htab_remove_mapping(start, end, mmu_linear_psize,
+					      mmu_kernel_ssize);
+		BUG_ON(rc2 && (rc2 != -ENOENT));
+	}
+	return rc;
 }
 
 int remove_section_mapping(unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index baa1a23..fbc9448 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -188,9 +188,9 @@ static int __meminit vmemmap_populated(unsigned long start, int page_size)
  */
 
 #ifdef CONFIG_PPC_BOOK3E
-static void __meminit vmemmap_create_mapping(unsigned long start,
-					     unsigned long page_size,
-					     unsigned long phys)
+static int __meminit vmemmap_create_mapping(unsigned long start,
+					    unsigned long page_size,
+					    unsigned long phys)
 {
 	/* Create a PTE encoding without page size */
 	unsigned long i, flags = _PAGE_PRESENT | _PAGE_ACCESSED |
@@ -208,6 +208,8 @@ static void __meminit vmemmap_create_mapping(unsigned long start,
 	 */
 	for (i = 0; i < page_size; i += PAGE_SIZE)
 		BUG_ON(map_kernel_page(start + i, phys, flags));
+
+	return 0;
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -217,15 +219,20 @@ static void vmemmap_remove_mapping(unsigned long start,
 }
 #endif
 #else /* CONFIG_PPC_BOOK3E */
-static void __meminit vmemmap_create_mapping(unsigned long start,
-					     unsigned long page_size,
-					     unsigned long phys)
+static int __meminit vmemmap_create_mapping(unsigned long start,
+					    unsigned long page_size,
+					    unsigned long phys)
 {
-	int  mapped = htab_bolt_mapping(start, start + page_size, phys,
-					pgprot_val(PAGE_KERNEL),
-					mmu_vmemmap_psize,
-					mmu_kernel_ssize);
-	BUG_ON(mapped < 0);
+	int rc = htab_bolt_mapping(start, start + page_size, phys,
+				   pgprot_val(PAGE_KERNEL),
+				   mmu_vmemmap_psize, mmu_kernel_ssize);
+	if (rc < 0) {
+		int rc2 = htab_remove_mapping(start, start + page_size,
+					      mmu_vmemmap_psize,
+					      mmu_kernel_ssize);
+		BUG_ON(rc2 && (rc2 != -ENOENT));
+	}
+	return rc;
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
@@ -304,6 +311,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 
 	for (; start < end; start += page_size) {
 		void *p;
+		int rc;
 
 		if (vmemmap_populated(start, page_size))
 			continue;
@@ -317,7 +325,13 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 		pr_debug("      * %016lx..%016lx allocated at %p\n",
 			 start, start + page_size, p);
 
-		vmemmap_create_mapping(start, page_size, __pa(p));
+		rc = vmemmap_create_mapping(start, page_size, __pa(p));
+		if (rc < 0) {
+			pr_warning(
+				"vmemmap_populate: Unable to create vmemmap mapping: %d\n",
+				rc);
+			return -EFAULT;
+		}
 	}
 
 	return 0;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d0f0a51..f980da6 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -119,12 +119,18 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 	struct zone *zone;
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int rc;
 
 	pgdata = NODE_DATA(nid);
 
 	start = (unsigned long)__va(start);
-	if (create_section_mapping(start, start + size))
-		return -EINVAL;
+	rc = create_section_mapping(start, start + size);
+	if (rc) {
+		pr_warning(
+			"Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
+			start, start + size, rc);
+		return -EFAULT;
+	}
 
 	/* this should work for most non-highmem platforms */
 	zone = pgdata->node_zones +
-- 
2.5.0
