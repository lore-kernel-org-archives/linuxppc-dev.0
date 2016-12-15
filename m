Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfkZh5d0TzDw6K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:50:51 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFJn6Sd081137
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:49 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27bv3m10n9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:49 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Thu, 15 Dec 2016 12:50:48 -0700
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH v3 3/5] powerpc/mm: add radix__create_section_mapping()
Date: Thu, 15 Dec 2016 13:50:41 -0600
In-Reply-To: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1481831443-22761-4-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the linear page mapping function for radix, used by memory hotplug.
This is similar to vmemmap_populate().

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  4 ++++
 arch/powerpc/mm/pgtable-book3s64.c         |  2 +-
 arch/powerpc/mm/pgtable-radix.c            | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index b4d1302..43c2571 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -291,5 +291,9 @@ static inline unsigned long radix__get_tree_size(void)
 	}
 	return rts_field;
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int radix__create_section_mapping(unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 653ff6c..2b13f6b 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -131,7 +131,7 @@ void mmu_cleanup_all(void)
 int create_section_mapping(unsigned long start, unsigned long end)
 {
 	if (radix_enabled())
-		return -ENODEV;
+		return radix__create_section_mapping(start, end);
 
 	return hash__create_section_mapping(start, end);
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 54bd70e..8201d1f 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -465,6 +465,25 @@ void radix__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	memblock_set_current_limit(first_memblock_base + first_memblock_size);
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int radix__create_section_mapping(unsigned long start, unsigned long end)
+{
+	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
+
+	/* Align to the page size of the linear mapping. */
+	start = _ALIGN_DOWN(start, page_size);
+
+	for (; start < end; start += page_size) {
+		int rc = radix__map_kernel_page(start, __pa(start),
+						PAGE_KERNEL, page_size);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
 int __meminit radix__vmemmap_create_mapping(unsigned long start,
 				      unsigned long page_size,
-- 
1.8.3.1
