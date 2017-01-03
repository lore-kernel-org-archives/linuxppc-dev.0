Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttQmf4wWkzDqFq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 07:40:02 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v03KcdLI118042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 15:39:57 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rdf7qmmr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 15:39:57 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 15:39:56 -0500
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: [PATCH] powerpc/mm: fix memory hotplug BUG() on radix
Date: Tue,  3 Jan 2017 14:39:51 -0600
Message-Id: <1483475991-16999-1-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory hotplug is leading to hash page table calls, even on radix:

...
	arch_add_memory
		create_section_mapping
			htab_bolt_mapping
				BUG_ON(!ppc_md.hpte_insert);

To fix, refactor {create,remove}_section_mapping() into hash__ and
radix__ variants. Leave the radix versions stubbed for now.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
It was suggested that this fix be separated from the rest of the
set which implements the radix page mapping/unmapping.

 arch/powerpc/include/asm/book3s/64/hash.h |  5 +++++
 arch/powerpc/mm/hash_utils_64.c           |  4 ++--
 arch/powerpc/mm/pgtable-book3s64.c        | 18 ++++++++++++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f61cad3..dd90574 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -201,6 +201,11 @@ extern int __meminit hash__vmemmap_create_mapping(unsigned long start,
 					      unsigned long phys);
 extern void hash__vmemmap_remove_mapping(unsigned long start,
 				     unsigned long page_size);
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int hash__create_section_mapping(unsigned long start, unsigned long end);
+int hash__remove_section_mapping(unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMORY_HOTPLUG */
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_H */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b9a062f..96a4fb7 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -743,7 +743,7 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int create_section_mapping(unsigned long start, unsigned long end)
+int hash__create_section_mapping(unsigned long start, unsigned long end)
 {
 	int rc = htab_bolt_mapping(start, end, __pa(start),
 				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
@@ -757,7 +757,7 @@ int create_section_mapping(unsigned long start, unsigned long end)
 	return rc;
 }
 
-int remove_section_mapping(unsigned long start, unsigned long end)
+int hash__remove_section_mapping(unsigned long start, unsigned long end)
 {
 	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
 				     mmu_kernel_ssize);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index ebf9782..653ff6c 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -126,3 +126,21 @@ void mmu_cleanup_all(void)
 	else if (mmu_hash_ops.hpte_clear_all)
 		mmu_hash_ops.hpte_clear_all();
 }
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+int create_section_mapping(unsigned long start, unsigned long end)
+{
+	if (radix_enabled())
+		return -ENODEV;
+
+	return hash__create_section_mapping(start, end);
+}
+
+int remove_section_mapping(unsigned long start, unsigned long end)
+{
+	if (radix_enabled())
+		return -ENODEV;
+
+	return hash__remove_section_mapping(start, end);
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
-- 
1.8.3.1
