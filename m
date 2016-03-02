Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AF961A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 19:46:31 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 2 Mar 2016 14:16:26 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u228kN7u8257818
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 14:16:23 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u228kKdW014545
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Mar 2016 14:16:22 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC] powerpc/mm: Add validation for platform reserved memory ranges
Date: Wed,  2 Mar 2016 14:16:12 +0530
Message-Id: <1456908372-18876-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For partition running on PHYP, there can be a adjunct partition
which shares the virtual address range with the operating system.
Virtual address ranges which can be used by the adjunct partition
are communicated with virtual device node of the device tree with
a property known as "ibm,reserved-virtual-addresses". This patch
introduces a new function named 'validate_reserved_va_range' which
is called inside 'setup_system' to validate that these reserved
virtual address ranges do not overlap with the address ranges used
by the kernel for all supported memory contexts. This helps prevent
the possibility of getting return codes similar to H_RESOURCE for
H_PROTECT hcalls for conflicting HPTE entries.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h  |  1 +
 arch/powerpc/kernel/setup_64.c  |  2 ++
 arch/powerpc/mm/hash_utils_64.c | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3d5abfe..95257c1 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -124,6 +124,7 @@ extern unsigned int __start___mmu_ftr_fixup, __stop___mmu_ftr_fixup;
 /* MMU initialization */
 extern void early_init_mmu(void);
 extern void early_init_mmu_secondary(void);
+extern void validate_reserved_va_range(void);
 
 extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				       phys_addr_t first_memblock_size);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5c03a6a..04bc592 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -546,6 +546,8 @@ void __init setup_system(void)
 	smp_release_cpus();
 #endif
 
+	validate_reserved_va_range();
+
 	pr_info("Starting Linux %s %s\n", init_utsname()->machine,
 		 init_utsname()->version);
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ba59d59..03adafc 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -810,6 +810,57 @@ void __init early_init_mmu(void)
 	slb_initialize();
 }
 
+/*
+ * PAPR says that each record contains 3 * 32 bit element, hence 12 bytes.
+ * First two element contains the abbreviated virtual address (high order
+ * 32 bits and low order 32 bits generates the abbreviated virtual address
+ * of 64 bits which need to be concatenated with 12 bits of 0 at the end
+ * to generate the actual 76 bit reserved virtual address) and size of the
+ * reserved virtual address range is encoded in next 32 bit element as number
+ * of 4K pages.
+ */
+#define	BYTES_PER_RVA_RECORD	12
+
+/*
+ * Linux uses 65 bits (MAX_PHYSMEM_BITS + CONTEXT_BITS) from available 78
+ * bit wide virtual address range. As reserved virtual address range comes
+ * as an abbreviated form of 64 bits, we will use a partial address mask
+ * (65 bit mask >> 12) to match it for simplicity.
+ */
+#define	PARTIAL_USED_VA_MASK	0x1FFFFFFFFFFFFFULL
+
+void __init validate_reserved_va_range(void)
+{
+	struct device_node *np;
+	struct property *prop;
+	unsigned int size, count, i;
+	const __be32 *value;
+	__be64 vaddr;
+
+	np = of_find_node_by_name(NULL, "vdevice");
+	if (!np)
+		return;
+
+	prop = of_find_property(np, "ibm,reserved-virtual-addresses", NULL);
+	if (!prop)
+		return;
+
+	value = of_get_property(np, "ibm,reserved-virtual-addresses", &size);
+	if (!value)
+		return;
+
+	count = size / BYTES_PER_RVA_RECORD;
+	for (i = 0; i < count; i++) {
+		vaddr = ((__be64) value[i * 3] << 32) | value[i * 3 + 1];
+		if (vaddr & ~PARTIAL_USED_VA_MASK) {
+			pr_info("Reserved virtual address range starting "
+				"at [%llx000] verified for overlap\n", vaddr);
+			continue;
+		}
+		BUG_ON("Reserved virtual address range overlapping");
+	}
+}
+
 #ifdef CONFIG_SMP
 void early_init_mmu_secondary(void)
 {
-- 
2.1.0
