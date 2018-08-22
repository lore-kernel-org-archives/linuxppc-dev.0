Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wfPL2jFfzF2Q2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 06:32:54 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7MHDtBX027559
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 13:16:16 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m19wce289-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 13:16:16 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 22 Aug 2018 11:16:15 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/mm/books3s: Add new pte bit to mark pte
 temporarily invalid.
Date: Wed, 22 Aug 2018 22:46:04 +0530
Message-Id: <20180822171605.15054-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When splitting a huge pmd pte, we need to mark the pmd entry invalid. We
can do that by clearing _PAGE_PRESENT bit. But then that will be taken as a
swap pte. In order to differentiate between the two use a software pte bit
when invalidating.

For regular pte, due to bd5050e38aec ("powerpc/mm/radix: Change pte relax
sequence to handle nest MMU hang") we need to mark the pte entry invalid when
relaxing access permission. Instead of marking pte_none which can result in
different page table walk routines possibly skipping this pte entry, invalidate
it but still keep it marked present.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 676118743a06..13a688fc8cd0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -44,6 +44,16 @@
 
 #define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
+/*
+ * We need to mark a pmd pte invalid while splitting. We can do that by clearing
+ * the _PAGE_PRESENT bit. But then that will be taken as a swap pte. In order to
+ * differentiate between two use a SW field when invalidating.
+ *
+ * We do that temporary invalidate for regular pte entry in ptep_set_access_flags
+ *
+ * This is used only when _PAGE_PRESENT is cleared.
+ */
+#define _PAGE_INVALID		_RPAGE_SW0
 
 /*
  * Top and bottom bits of RPN which can be used by hash
@@ -568,7 +578,13 @@ static inline pte_t pte_clear_savedwrite(pte_t pte)
 
 static inline int pte_present(pte_t pte)
 {
-	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
+	/*
+	 * A pte is considerent present if _PAGE_PRESENT is set.
+	 * We also need to consider the pte present which is marked
+	 * invalid during ptep_set_access_flags. Hence we look for _PAGE_INVALID
+	 * if we find _PAGE_PRESENT cleared.
+	 */
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_INVALID));
 }
 
 #ifdef CONFIG_PPC_MEM_KEYS
-- 
2.17.1
