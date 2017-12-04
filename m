Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqpVB32wXzDrJ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 13:19:30 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB42JDCn022221
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Dec 2017 21:19:27 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2emu0g5txd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Dec 2017 21:19:27 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 3 Dec 2017 19:19:26 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/mm/book3s/64: Add proper pte access check helper
Date: Mon,  4 Dec 2017 07:49:11 +0530
In-Reply-To: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20171204021912.25974-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pte_access_premitted get called in get_user_pages_fast path. If we have marked
the pte PROT_NONE, we should not allow a read access on the address. With
the current implementation we are not checking the READ and only check for
WRITE. This is needed on archs like ppc64 that implement PROT_NONE using
RWX access instead of _PAGE_PRESENT. Also add pte_user check just to make sure
we are not accessing kernel mapping.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 41 ++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 2006fec40a00..efa5bd6bc1d3 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -520,6 +520,30 @@ static inline int pte_present(pte_t pte)
 {
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT));
 }
+
+#define pte_access_permitted pte_access_permitted
+static inline bool pte_access_permitted(pte_t pte, bool write)
+{
+	unsigned long pteval = pte_val(pte);
+	/* Also check for pte_user */
+	unsigned long clear_pte_bits = _PAGE_PRIVILEGED;
+	/*
+	 * _PAGE_READ is needed for any access and will be
+	 * cleared for PROT_NONE
+	 */
+	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_READ;
+
+	if (write)
+		need_pte_bits |= _PAGE_WRITE;
+
+	if ((pteval & need_pte_bits) != need_pte_bits)
+		return false;
+
+	if ((pteval & clear_pte_bits) == clear_pte_bits)
+		return false;
+	return true;
+}
+
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
@@ -824,6 +848,11 @@ static inline int pud_bad(pud_t pud)
 	return hash__pud_bad(pud);
 }
 
+#define pud_access_permitted pud_access_permitted
+static inline bool pud_access_permitted(pud_t pud, bool write)
+{
+	return pte_access_permitted(pud_pte(pud), write);
+}
 
 #define pgd_write(pgd)		pte_write(pgd_pte(pgd))
 static inline void pgd_set(pgd_t *pgdp, unsigned long val)
@@ -863,6 +892,12 @@ static inline int pgd_bad(pgd_t pgd)
 	return hash__pgd_bad(pgd);
 }
 
+#define pgd_access_permitted pgd_access_permitted
+static inline bool pgd_access_permitted(pgd_t pgd, bool write)
+{
+	return pte_access_permitted(pgd_pte(pgd), write);
+}
+
 extern struct page *pgd_page(pgd_t pgd);
 
 /* Pointers in the page table tree are physical addresses */
@@ -984,6 +1019,12 @@ static inline int pmd_protnone(pmd_t pmd)
 #define __pmd_write(pmd)	__pte_write(pmd_pte(pmd))
 #define pmd_savedwrite(pmd)	pte_savedwrite(pmd_pte(pmd))
 
+#define pmd_access_permitted pmd_access_permitted
+static inline bool pmd_access_permitted(pmd_t pmd, bool write)
+{
+	return pte_access_permitted(pmd_pte(pmd), write);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot);
 extern pmd_t mk_pmd(struct page *page, pgprot_t pgprot);
-- 
2.14.3
