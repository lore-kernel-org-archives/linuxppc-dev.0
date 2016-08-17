Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDtxx0QH9zDqdr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 01:51:32 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7HFMlkG061106
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:51:30 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vmf0556n-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:51:30 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 11:51:28 -0400
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [RFC v2 2/2] powerpc/mm: add radix__{create, remove}_section_mapping()
Date: Wed, 17 Aug 2016 10:51:23 -0500
In-Reply-To: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1471449083-15931-3-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add radix variants of the memory hotplug mapping functions.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  5 +++++
 arch/powerpc/include/asm/sparsemem.h       |  8 ++++++++
 arch/powerpc/mm/pgtable-radix.c            | 23 +++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index df29422..97e71cb 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -229,6 +229,11 @@ extern void radix__vmemmap_remove_mapping(unsigned long start,
 extern int radix__map_kernel_page(unsigned long ea, unsigned long pa,
 				 pgprot_t flags, unsigned int psz);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+int radix__create_section_mapping(unsigned long start, unsigned long end);
+void radix__remove_section_mapping(unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 static inline unsigned long radix__get_tree_size(void)
 {
 	unsigned long rts_field;
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index 5014e0d..42fe87e 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -19,12 +19,20 @@
 static inline int create_section_mapping(unsigned long start,
 					 unsigned long end)
 {
+	if (radix_enabled())
+		return radix__create_section_mapping(start, end);
+
 	return hash__create_section_mapping(start, end);
 }
 
 static inline int remove_section_mapping(unsigned long start,
 					 unsigned long end)
 {
+	if (radix_enabled()) {
+		radix__remove_section_mapping(start, end);
+		return 0;
+	}
+
 	return hash__remove_section_mapping(start, end);
 }
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index af897d9..ee0286c 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -527,3 +527,26 @@ int radix__has_transparent_hugepage(void)
 	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
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
+	        if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+void radix__remove_section_mapping(unsigned long start, unsigned long end)
+{
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
-- 
1.8.3.1
