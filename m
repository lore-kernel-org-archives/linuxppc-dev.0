Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BAAC51A005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 20:56:35 +1100 (AEDT)
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 15:26:27 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u279u2wQ37683296
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 15:26:03 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27FPEKo015841
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 20:55:15 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc/mm: Add validation for platform reserved memory
 ranges
Date: Mon,  7 Mar 2016 15:25:59 +0530
Message-Id: <1457344559-2505-1-git-send-email-khandual@linux.vnet.ibm.com>
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
is called  during initialization to validate that these reserved
virtual address ranges do not overlap with the address ranges used
by the kernel for all supported memory contexts. This helps prevent
the possibility of getting return codes similar to H_RESOURCE for
H_PROTECT hcalls for conflicting HPTE entries.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
- Tested on both POWER8 LE and BE platforms

Changes in V2:
- Added braces to the definition of LINUX_VA_BITS
- Adjusted tabs as spaces for the definition of PARTIAL_LINUX_VA_MASK

 arch/powerpc/mm/hash_utils_64.c | 77 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ba59d59..b47f667 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1564,3 +1564,80 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(ppc64_rma_size);
 }
+
+/*
+ * PAPR says that each reserved virtual address range record
+ * contains three be32 elements which is of toal 12 bytes.
+ * First two be32 elements contain the abbreviated virtual
+ * address (high order 32 bits and low order 32 bits that
+ * generate the abbreviated virtual address of 64 bits which
+ * need to be concatenated with 24 bits of 0 at the end) and
+ * the third be32 element contains the size of the reserved
+ * virtual address range as number of consecutive 4K pages.
+ */
+struct reserved_va_record {
+	__be32	high_addr;
+	__be32	low_addr;
+	__be32	nr_pages_4K;
+};
+
+/*
+ * Linux uses 65 bits (CONTEXT_BITS + ESID_BITS + SID_SHIFT)
+ * of virtual address. As reserved virtual address comes in
+ * as an abbreviated form (64 bits) from the device tree, we
+ * will use a partial address bit mask (65 >> 24) to match it
+ * for simplicity.
+ */
+#define RVA_LESS_BITS		24
+#define LINUX_VA_BITS		(CONTEXT_BITS + ESID_BITS + SID_SHIFT)
+#define PARTIAL_LINUX_VA_MASK	((1ULL << (LINUX_VA_BITS - RVA_LESS_BITS)) - 1)
+
+static int __init validate_reserved_va_range(void)
+{
+	struct reserved_va_record rva;
+	struct device_node *np;
+	int records, ret, i;
+	__be64 vaddr;
+
+	np = of_find_node_by_name(NULL, "vdevice");
+	if (!np)
+		return -ENODEV;
+
+	records = of_property_count_elems_of_size(np,
+			"ibm,reserved-virtual-addresses",
+				sizeof(struct reserved_va_record));
+	if (records < 0)
+		return records;
+
+	for (i = 0; i < records; i++) {
+		ret = of_property_read_u32_index(np,
+			"ibm,reserved-virtual-addresses",
+				3 * i, &rva.high_addr);
+		if (ret)
+			return ret;
+
+		ret = of_property_read_u32_index(np,
+			"ibm,reserved-virtual-addresses",
+				3 * i + 1, &rva.low_addr);
+		if (ret)
+			return ret;
+
+		ret = of_property_read_u32_index(np,
+			"ibm,reserved-virtual-addresses",
+				3 * i + 2, &rva.nr_pages_4K);
+		if (ret)
+			return ret;
+
+		vaddr =  rva.high_addr;
+		vaddr =  (vaddr << 32) | rva.low_addr;
+		if (vaddr & cpu_to_be64(~PARTIAL_LINUX_VA_MASK))
+			continue;
+
+		pr_err("RVA [0x%llx000000 (0x%x in bytes)] overlapped\n",
+					vaddr, rva.nr_pages_4K * 4096);
+		BUG();
+	}
+	of_node_put(np);
+	return 0;
+}
+__initcall(validate_reserved_va_range);
-- 
2.1.0
