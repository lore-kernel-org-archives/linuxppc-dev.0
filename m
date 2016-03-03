Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DD9B1A06A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:59:54 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 08/18] pseries: Automatically resize HPT for memory hot
 add/remove
Date: Thu,  3 Mar 2016 12:59:39 +1100
Message-Id: <1456970389-28802-9-git-send-email-david@gibson.dropbear.id.au>
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

We've now implemented code in the pseries platform to use the new PAPR
interface to allow resizing the hash page table (HPT) at runtime.

This patch uses that interface to automatically attempt to resize the HPT
when memory is hot added or removed.  This tries to always keep the HPT at
a reasonable size for our current memory size.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/sparsemem.h |  1 +
 arch/powerpc/mm/hash_utils_64.c      | 29 +++++++++++++++++++++++++++++
 arch/powerpc/mm/mem.c                |  4 ++++
 3 files changed, 34 insertions(+)

diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index f6fc0ee..737335c 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -16,6 +16,7 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
 extern int create_section_mapping(unsigned long start, unsigned long end);
 extern int remove_section_mapping(unsigned long start, unsigned long end);
 #ifdef CONFIG_NUMA
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0809bea..6fbc27a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -645,6 +645,35 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
+void resize_hpt_for_hotplug(unsigned long new_mem_size)
+{
+	unsigned target_hpt_shift;
+
+	if (!ppc_md.resize_hpt)
+		return;
+
+	target_hpt_shift = htab_shift_for_mem_size(new_mem_size);
+
+	/*
+	 * To avoid lots of HPT resizes if memory size is fluctuating
+	 * across a boundary, we deliberately have some hysterisis
+	 * here: we immediately increase the HPT size if the target
+	 * shift exceeds the current shift, but we won't attempt to
+	 * reduce unless the target shift is at least 2 below the
+	 * current shift
+	 */
+	if ((target_hpt_shift > ppc64_pft_size)
+	    || (target_hpt_shift < (ppc64_pft_size - 1))) {
+		int rc;
+
+		rc = ppc_md.resize_hpt(target_hpt_shift);
+		if (rc)
+			printk(KERN_WARNING
+			       "Unable to resize hash page table to target order %d: %d\n",
+			       target_hpt_shift, rc);
+	}
+}
+
 int create_section_mapping(unsigned long start, unsigned long end)
 {
 	int rc = htab_bolt_mapping(start, end, __pa(start),
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f980da6..4938ee7 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -121,6 +121,8 @@ int arch_add_memory(int nid, u64 start, u64 size, bool for_device)
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int rc;
 
+	resize_hpt_for_hotplug(memblock_phys_mem_size());
+
 	pgdata = NODE_DATA(nid);
 
 	start = (unsigned long)__va(start);
@@ -161,6 +163,8 @@ int arch_remove_memory(u64 start, u64 size)
 	 */
 	vm_unmap_aliases();
 
+	resize_hpt_for_hotplug(memblock_phys_mem_size());
+
 	return ret;
 }
 #endif
-- 
2.5.0
