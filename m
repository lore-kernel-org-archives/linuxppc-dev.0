Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sPvXn1Mg5zDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Sep 2016 17:49:28 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u817hKBN125059
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Sep 2016 03:49:26 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 256cqbsfnu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Sep 2016 03:49:26 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Thu, 1 Sep 2016 01:49:24 -0600
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] [V3] powerpc/mm: Add validation for platform reserved memory
 ranges
Date: Thu,  1 Sep 2016 15:48:44 +0800
Message-Id: <1472716124-3344-1-git-send-email-rui.teng@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

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
Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
---
- Tested on both POWER8 LE and BE platforms

Changes in V3:
- Use u32 and u64 to store the virtual address and use CPU endian mask.

Changes in V2:
- Added braces to the definition of LINUX_VA_BITS
- Adjusted tabs as spaces for the definition of PARTIAL_LINUX_VA_MASK

---
 arch/powerpc/mm/hash_utils_64.c | 68 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..85c5123 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1733,3 +1733,71 @@ void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
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
+	u32	high_addr;
+	u32	low_addr;
+	u32	nr_pages_4K;
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
+	int records, i;
+	u64 vaddr;
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
+		of_property_read_u32_index(np,
+			"ibm,reserved-virtual-addresses",
+				3 * i, &rva.high_addr);
+		of_property_read_u32_index(np,
+			"ibm,reserved-virtual-addresses",
+				3 * i + 1, &rva.low_addr);
+		of_property_read_u32_index(np,
+			"ibm,reserved-virtual-addresses",
+				3 * i + 2, &rva.nr_pages_4K);
+
+		vaddr =  rva.high_addr;
+		vaddr =  (vaddr << 32) | rva.low_addr;
+		if (unlikely(!(vaddr & ~PARTIAL_LINUX_VA_MASK))) {
+			pr_err("RVA [0x%llx000000 (0x%x in bytes)] overlapped\n",
+					vaddr, rva.nr_pages_4K * 4096);
+			BUG();
+		}
+	}
+	of_node_put(np);
+	return 0;
+}
+device_initcall(validate_reserved_va_range);
-- 
2.7.4
