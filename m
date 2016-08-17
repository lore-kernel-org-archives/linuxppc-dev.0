Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDtxv6vjFzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 01:51:31 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7HFmXWl020231
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:51:29 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24v70j8wk7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 11:51:29 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 17 Aug 2016 09:51:28 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: [RFC v2 1/2] powerpc/mm: refactor {create,remove}_section_mapping()
Date: Wed, 17 Aug 2016 10:51:22 -0500
In-Reply-To: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
References: <1471449083-15931-1-git-send-email-arbab@linux.vnet.ibm.com>
Message-Id: <1471449083-15931-2-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change {create,remove}_section_mapping() to be inline wrappers around
functions prefixed with "hash__".

This is preparation for the addition of their "radix__" variants. No
functional change.

Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h |  5 +++++
 arch/powerpc/include/asm/sparsemem.h      | 14 ++++++++++++--
 arch/powerpc/mm/hash_utils_64.c           |  4 ++--
 3 files changed, 19 insertions(+), 4 deletions(-)

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
diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
index f6fc0ee..5014e0d 100644
--- a/arch/powerpc/include/asm/sparsemem.h
+++ b/arch/powerpc/include/asm/sparsemem.h
@@ -16,8 +16,18 @@
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-extern int create_section_mapping(unsigned long start, unsigned long end);
-extern int remove_section_mapping(unsigned long start, unsigned long end);
+static inline int create_section_mapping(unsigned long start,
+					 unsigned long end)
+{
+	return hash__create_section_mapping(start, end);
+}
+
+static inline int remove_section_mapping(unsigned long start,
+					 unsigned long end)
+{
+	return hash__remove_section_mapping(start, end);
+}
+
 #ifdef CONFIG_NUMA
 extern int hot_add_scn_to_nid(unsigned long scn_addr);
 #else
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 0821556..2a203cd 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -688,7 +688,7 @@ static unsigned long __init htab_get_table_size(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-int create_section_mapping(unsigned long start, unsigned long end)
+int hash__create_section_mapping(unsigned long start, unsigned long end)
 {
 	int rc = htab_bolt_mapping(start, end, __pa(start),
 				   pgprot_val(PAGE_KERNEL), mmu_linear_psize,
@@ -702,7 +702,7 @@ int create_section_mapping(unsigned long start, unsigned long end)
 	return rc;
 }
 
-int remove_section_mapping(unsigned long start, unsigned long end)
+int hash__remove_section_mapping(unsigned long start, unsigned long end)
 {
 	int rc = htab_remove_mapping(start, end, mmu_linear_psize,
 				     mmu_kernel_ssize);
-- 
1.8.3.1
