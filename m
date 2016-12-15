Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfkZh5gkZzDw9T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 06:50:52 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBFJn9pv108193
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:50 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27buepaexh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 14:50:50 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
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
Subject: [PATCH v3 2/5] powerpc/mm: refactor {create, remove}_section_mapping()
Date: Thu, 15 Dec 2016 13:50:40 -0600
In-Reply-To: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1481831443-22761-3-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change {create,remove}_section_mapping() to be wrappers around functions
prefixed with "hash__".

This is preparation for the addition of their "radix__" variants. No
functional change.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
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
