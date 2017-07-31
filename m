Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLdcb5pJ3zDsSp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 22:12:31 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id q85so26012630pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 05:12:31 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] powerpc/mm/radix: Fix relocatable radix mappings for
 STRICT_RWX
Date: Mon, 31 Jul 2017 22:11:01 +1000
Message-Id: <20170731121103.6984-2-bsingharora@gmail.com>
In-Reply-To: <20170731121103.6984-1-bsingharora@gmail.com>
References: <20170731121103.6984-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mappings now do perfect kernel pte mappings even when the
kernel is relocated. This patch refactors create_physical_mapping()
and mark_rodata_ro(). create_physical_mapping() is now largely done with
a helper called __create_physical_mapping(), which is defined differently
for when CONFIG_STRICT_KERNEL_RWX is enabled and when its not.

The goal of the patchset is to provide minimal changes when the
CONFIG_STRICT_KERNEL_RWX is disabled, when enabled however, we do
split the linear mapping so that permissions are strictly adherent
to expectations from the user.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/pgtable-radix.c | 183 +++++++++++++++++++++++++++++++++-------
 1 file changed, 151 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 671a45d..6e0176d 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -164,8 +164,14 @@ void radix__mark_rodata_ro(void)
 	end = (unsigned long)__init_begin;
 
 	radix__change_memory_range(start, end, _PAGE_WRITE);
+
+	start = (unsigned long)__start_interrupts - PHYSICAL_START;
+	end = (unsigned long)__end_interrupts - PHYSICAL_START;
+
+	radix__change_memory_range(start, end, _PAGE_WRITE);
 }
 
+
 void radix__mark_initmem_nx(void)
 {
 	unsigned long start = (unsigned long)__init_begin;
@@ -173,6 +179,7 @@ void radix__mark_initmem_nx(void)
 
 	radix__change_memory_range(start, end, _PAGE_EXEC);
 }
+
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
 static inline void __meminit print_mapping(unsigned long start,
@@ -185,31 +192,36 @@ static inline void __meminit print_mapping(unsigned long start,
 	pr_info("Mapped range 0x%lx - 0x%lx with 0x%lx\n", start, end, size);
 }
 
-static int __meminit create_physical_mapping(unsigned long start,
-					     unsigned long end)
+/*
+ * Create physical mapping and return the last mapping size
+ * If the call is successful, end_of_mapping will return the
+ * last address mapped via this call, if not, it will leave
+ * the value untouched.
+ */
+static int __meminit __create_physical_mapping(unsigned long vstart,
+				unsigned long vend, pgprot_t prot,
+				unsigned long *end_of_mapping)
 {
-	unsigned long vaddr, addr, mapping_size = 0;
-	pgprot_t prot;
-	unsigned long max_mapping_size;
-#ifdef CONFIG_STRICT_KERNEL_RWX
-	int split_text_mapping = 1;
-#else
-	int split_text_mapping = 0;
-#endif
+	unsigned long mapping_size = 0;
+	static unsigned long previous_size;
+	unsigned long addr, start, end;
 
+	start = __pa(vstart);
+	end = __pa(vend);
 	start = _ALIGN_UP(start, PAGE_SIZE);
+
+	pr_devel("physical_mapping start %lx->%lx, prot %lx\n",
+		 vstart, vend, pgprot_val(prot));
+
 	for (addr = start; addr < end; addr += mapping_size) {
-		unsigned long gap, previous_size;
+		unsigned long gap;
 		int rc;
 
 		gap = end - addr;
 		previous_size = mapping_size;
-		max_mapping_size = PUD_SIZE;
 
-retry:
 		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
-		    mmu_psize_defs[MMU_PAGE_1G].shift &&
-		    PUD_SIZE <= max_mapping_size)
+		    mmu_psize_defs[MMU_PAGE_1G].shift)
 			mapping_size = PUD_SIZE;
 		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
 			 mmu_psize_defs[MMU_PAGE_2M].shift)
@@ -217,40 +229,147 @@ static int __meminit create_physical_mapping(unsigned long start,
 		else
 			mapping_size = PAGE_SIZE;
 
-		if (split_text_mapping && (mapping_size == PUD_SIZE) &&
-			(addr <= __pa_symbol(__init_begin)) &&
-			(addr + mapping_size) >= __pa_symbol(_stext)) {
-			max_mapping_size = PMD_SIZE;
-			goto retry;
+		if (previous_size != mapping_size) {
+			print_mapping(start, addr, previous_size);
+			start = addr;
+			previous_size = mapping_size;
 		}
 
-		if (split_text_mapping && (mapping_size == PMD_SIZE) &&
-		    (addr <= __pa_symbol(__init_begin)) &&
-		    (addr + mapping_size) >= __pa_symbol(_stext))
-			mapping_size = PAGE_SIZE;
+		rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
+						prot, mapping_size);
+		if (rc)
+			return rc;
+	}
 
-		if (mapping_size != previous_size) {
-			print_mapping(start, addr, previous_size);
-			start = addr;
+	print_mapping(start, addr, mapping_size);
+	*end_of_mapping = (unsigned long)__va(addr);
+	return 0;
+}
+
+#ifdef CONFIG_STRICT_KERNEL_RWX
+static int __meminit create_physical_mapping(unsigned long start,
+					     unsigned long end)
+{
+	pgprot_t prot;
+	unsigned long rc;
+	unsigned long vstart, vend;
+	unsigned long gap;
+	unsigned long st = (unsigned long)_stext;
+	unsigned long ie = (unsigned long)__init_end;
+	unsigned long ib = (unsigned long)__init_begin;
+	unsigned long si = (unsigned long)__start_interrupts - PHYSICAL_START;
+	unsigned long ei = (unsigned long)__end_interrupts - PHYSICAL_START;
+
+
+	start = _ALIGN_UP(start, PAGE_SIZE);
+	vstart = (unsigned long)__va(start);
+	vend = (unsigned long)__va(end);
+
+	while (vstart < vend) {
+		if ((PHYSICAL_START > MEMORY_START) &&
+			(overlaps_interrupt_vector_text(vstart, vend))) {
+			/*
+			 * Is there a gap between start and start of interrupts.
+			 * We need to care for PHYSICAL_START here since we need
+			 * to nail down __start_interrupts..__end_interrupts as
+			 * physical offsets from 0.
+			 */
+			gap = _ALIGN_DOWN(si, PAGE_SIZE) - vstart;
+			if (gap > PAGE_SIZE) {
+				prot = PAGE_KERNEL;
+				rc = __create_physical_mapping(vstart, si, prot,
+								&vstart);
+				if (rc)
+					return rc;
+			}
+
+			prot = PAGE_KERNEL_X;
+			rc = __create_physical_mapping(vstart, ei, prot,
+							&vstart);
+			if (rc)
+				return rc;
 		}
 
-		vaddr = (unsigned long)__va(addr);
+		if (overlaps_kernel_text(vstart, vend)) {
+
+			gap = _ALIGN_DOWN(st, PAGE_SIZE) - vstart;
+			if (gap > PAGE_SIZE) {
+				prot = PAGE_KERNEL;
+				rc = __create_physical_mapping(vstart, st,
+								prot, &vstart);
+				if (rc)
+					return rc;
+			}
 
-		if (overlaps_kernel_text(vaddr, vaddr + mapping_size) ||
-		    overlaps_interrupt_vector_text(vaddr, vaddr + mapping_size))
+			/*
+			 *  __init_begin/end are special,they are marked
+			 *  executable but we'll turn rw off until __init_begin
+			 *  and if the mapping is not split here, it will spill
+			 *  over up to *  __init_end and allocations from that
+			 *  region will find  read-only permissions
+			 */
+			prot = PAGE_KERNEL_X;
+			rc = __create_physical_mapping(vstart, ib, prot,
+							&vstart);
+			if (rc)
+				return rc;
+
+			rc = __create_physical_mapping(vstart, ie, prot,
+							&vstart);
+			if (rc)
+				return rc;
+		}
+
+		prot = PAGE_KERNEL;
+		rc = __create_physical_mapping(vstart, vend, prot, &vstart);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+#else /* !CONFIG_STRICT_KERNEL_RWX */
+
+static int __meminit create_physical_mapping(unsigned long start,
+					     unsigned long end)
+{
+	pgprot_t prot;
+	unsigned long rc;
+	unsigned long vstart, vend;
+	unsigned long mapping_size;
+
+
+	start = _ALIGN_UP(start, PAGE_SIZE);
+	vstart = (unsigned long)__va(start);
+	vend = (unsigned long)__va(end);
+
+	while (vstart < vend) {
+		/*
+		 * STRICT_KERNEL_RWX is off, but we can't map all of
+		 * vstart--vend as * executable, lets split vend into
+		 * mapping_size and try
+		 */
+		mapping_size = min(vend - vstart, PUD_SIZE);
+
+		if (overlaps_kernel_text(vstart, vstart + mapping_size) ||
+			overlaps_interrupt_vector_text(vstart,
+					vstart + mapping_size))
 			prot = PAGE_KERNEL_X;
 		else
 			prot = PAGE_KERNEL;
 
-		rc = radix__map_kernel_page(vaddr, addr, prot, mapping_size);
+		rc = __create_physical_mapping(vstart, vstart + mapping_size,
+						prot, &vstart);
 		if (rc)
 			return rc;
 	}
 
-	print_mapping(start, addr, mapping_size);
 	return 0;
 }
 
+#endif /* CONFIG_STRICT_KERNEL_RWX */
+
 static void __init radix_init_pgtable(void)
 {
 	unsigned long rts_field;
-- 
2.9.4
