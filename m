Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqpVG1TkXzDwNJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 13:19:34 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB42J8uE001256
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Dec 2017 21:19:32 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2empsk31jt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Dec 2017 21:19:31 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 3 Dec 2017 19:19:30 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/mm/ Add proper pte access check helper
Date: Mon,  4 Dec 2017 07:49:12 +0530
In-Reply-To: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20171204021912.25974-3-aneesh.kumar@linux.vnet.ibm.com>
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
_PAGE_USER access instead of _PAGE_PRESENT. Also add pte_user check just to make sure
we are not accessing kernel mapping.

Even though there is code duplication, keeping the low level pte accessors
different for different platforms helps in code readability.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 23 +++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 23 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 016579ef16d3..30a155c0a6b0 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -311,6 +311,29 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
+/*
+ * We only find page table entry in the last level
+ * Hence no need for other accessors
+ */
+#define pte_access_permitted pte_access_permitted
+static inline bool pte_access_permitted(pte_t pte, bool write)
+{
+	unsigned long pteval = pte_val(pte);
+	/*
+	 * A read-only access is controlled by _PAGE_USER bit.
+	 * We have _PAGE_READ set for WRITE and EXECUTE
+	 */
+	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
+
+	if (write)
+		need_pte_bits |= _PAGE_WRITE;
+
+	if ((pteval & need_pte_bits) != need_pte_bits)
+		return false;
+
+	return true;
+}
+
 /* Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  *
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 5c68f4a59f75..fc4376c8d444 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -45,6 +45,29 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
+/*
+ * We only find page table entry in the last level
+ * Hence no need for other accessors
+ */
+#define pte_access_permitted pte_access_permitted
+static inline bool pte_access_permitted(pte_t pte, bool write)
+{
+	unsigned long pteval = pte_val(pte);
+	/*
+	 * A read-only access is controlled by _PAGE_USER bit.
+	 * We have _PAGE_READ set for WRITE and EXECUTE
+	 */
+	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
+
+	if (write)
+		need_pte_bits |= _PAGE_WRITE;
+
+	if ((pteval & need_pte_bits) != need_pte_bits)
+		return false;
+
+	return true;
+}
+
 /* Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
  *
-- 
2.14.3
