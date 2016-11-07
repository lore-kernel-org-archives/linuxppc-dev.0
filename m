Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC5SY4yMzzDvTd
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 19:38:37 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA78QStr062673
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 03:38:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jb76xgxg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 03:38:35 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 01:38:34 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Add _PAGE_DEVMAP pte bit for ppc64.
Date: Mon,  7 Nov 2016 14:08:24 +0530
Message-Id: <20161107083824.23300-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
NOTE: We need other patches to enable pmem on ppc64. I am waiting
for dax pmd fault handling cleanup to hit upstream before I send
the changes. Meanwhile reserve the pte bit.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 9eed9d66d24f..af9e1a150ae7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -32,6 +32,8 @@
 #define _PAGE_SOFT_DIRTY	0x00000
 #endif
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
+#define _PAGE_DEVMAP		_RPAGE_SW1
+#define __HAVE_ARCH_PTE_DEVMAP
 
 
 #define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
@@ -485,6 +487,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkdevmap(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
+}
+
+static inline int pte_devmap(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
@@ -1030,6 +1042,18 @@ static inline bool arch_needs_pgtable_deposit(void)
 	return true;
 }
 
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	/*
+	 * No special ptes at pmd level.
+	 */
+	return __pmd(pmd_val(pmd) | _PAGE_DEVMAP);
+}
+
+static inline int pmd_devmap(pmd_t pmd)
+{
+	return pte_devmap(pmd_pte(pmd));
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.10.2
