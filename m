Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSD1q0Db3zDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 19:19:42 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L8J3p3120938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:19:41 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r120en0k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:19:40 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 03:19:39 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/5] powerpc/mm: Lower the max real address to 51 bits
Date: Tue, 21 Feb 2017 13:49:15 +0530
In-Reply-To: <1487665157-22893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487665157-22893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487665157-22893-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Max value supported by hardware is 51 bits address. Radix page table define
a slot of 57 bits for future expansion. We restrict the value supported in
linux kernel 51 bits, so that we can use the bits between 57-51 for storing
hash linux page table bits. This is done in the next patch.

This will free up the software page table bits to be used for features
that are needed for both hash and radix. The current hash linux page table
format doesn't have any free software bits. Moving hash linux page table
specific bits to top of RPN field free up the software bits for other purpose.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index dec136742cd7..f1381f85c00a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -32,6 +32,25 @@
 #define _RPAGE_RSV4		0x0200000000000000UL
 #define _RPAGE_RPN0		0x01000
 #define _RPAGE_RPN1		0x02000
+/* Max physicall address bit as per radix table */
+#define _RPAGE_PA_MAX		57
+/*
+ * Max physical address bit we will use for now.
+ *
+ * This is mostly a hardware limitation and for now Power9 has
+ * a 51 bit limit.
+ *
+ * This is different from the number of physical bit required to address
+ * the last byte of memory. That is defined by MAX_PHYSMEM_BITS.
+ * MAX_PHYSMEM_BITS is a linux limitation imposed by the maximum
+ * number of sections we can support (SECTIONS_SHIFT).
+ *
+ * This is different from Radix page table limitation above and
+ * should always be less than that. The limit is done such that
+ * we can overload the bits between _RPAGE_PA_MAX and _PAGE_PA_MAX
+ * for hash linux page table specific bits.
+ */
+#define _PAGE_PA_MAX		51
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
@@ -45,10 +64,11 @@
  */
 #define _PAGE_NO_CACHE		_PAGE_TOLERANT
 /*
- * We support 57 bit real address in pte. Clear everything above 57, and
+ * We support _RPAGE_PA_MAX bit real address in pte. On the linux side
+ * we are limited by _PAGE_PA_MAX. Clear everything above _PAGE_PA_MAX
  * every thing below PAGE_SHIFT;
  */
-#define PTE_RPN_MASK	(((1UL << 57) - 1) & (PAGE_MASK))
+#define PTE_RPN_MASK	(((1UL << _PAGE_PA_MAX) - 1) & (PAGE_MASK))
 /*
  * set of bits not changed in pmd_modify. Even though we have hash specific bits
  * in here, on radix we expect them to be zero.
-- 
2.7.4
