Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPtX54J1zDqZm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:32:36 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GANhYu136264
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:33 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2978e6k0rq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:33 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:32:33 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 03/11] powerpc/mm: Cleanup bits definition between hash and
 radix.
Date: Thu, 16 Mar 2017 16:02:01 +0530
In-Reply-To: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660329-22501-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define everything based on bits present in pgtable.h. This will help in easily
identifying overlapping bits between hash/radix.

No functional change with this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h |  4 ++++
 arch/powerpc/include/asm/book3s/64/hash.h     |  9 +++++----
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 10 ++--------
 arch/powerpc/include/asm/book3s/64/radix.h    |  6 ++++++
 4 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f3dd21efa2ea..b39f0b86405e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -6,6 +6,10 @@
 #define H_PUD_INDEX_SIZE  5
 #define H_PGD_INDEX_SIZE  12
 
+/*
+ * 64k aligned address free up few of the lower bits of RPN for us
+ * We steal that here. For more deatils look at pte_pfn/pfn_pte()
+ */
 #define H_PAGE_COMBO	0x00001000 /* this is a combo 4k page */
 #define H_PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f7b721bbf918..ec2828b1db07 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -13,12 +13,13 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define H_PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
+#define H_PAGE_BUSY		_RPAGE_SW1 /* software: PTE & hash are busy */
 #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
 #define H_PAGE_F_GIX_SHIFT	57
-#define H_PAGE_F_GIX		(7ul << 57)	/* HPTE index within HPTEG */
-#define H_PAGE_F_SECOND		(1ul << 60)	/* HPTE is in 2ndary HPTEG */
-#define H_PAGE_HASHPTE		(1ul << 61)	/* PTE has associated HPTE */
+/* (7ul << 57) HPTE index within HPTEG */
+#define H_PAGE_F_GIX		(_RPAGE_RSV2 | _RPAGE_RSV3 | _RPAGE_RSV4)
+#define H_PAGE_F_SECOND		_RPAGE_RSV1	/* HPTE is in 2ndary HPTEG */
+#define H_PAGE_HASHPTE		_RPAGE_SW0	/* PTE has associated HPTE */
 
 #ifdef CONFIG_PPC_64K_PAGES
 #include <asm/book3s/64/hash-64k.h>
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8f4d41936e5a..c39bc4cb9247 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -44,14 +44,8 @@
 #endif
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
 
-/*
- * For P9 DD1 only, we need to track whether the pte's huge.
- */
-#define _PAGE_LARGE	_RPAGE_RSV1
-
-
-#define _PAGE_PTE		(1ul << 62)	/* distinguishes PTEs from pointers */
-#define _PAGE_PRESENT		(1ul << 63)	/* pte contains a translation */
+#define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
+#define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
 /*
  * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
  * Instead of fixing all of them, add an alternate define which
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 9e0bb7cd6e22..2a2ea47a9bd2 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -11,6 +11,12 @@
 #include <asm/book3s/64/radix-4k.h>
 #endif
 
+/*
+ * For P9 DD1 only, we need to track whether the pte's huge.
+ */
+#define _PAGE_LARGE	_RPAGE_RSV1
+
+
 #ifndef __ASSEMBLY__
 #include <asm/book3s/64/tlbflush-radix.h>
 #include <asm/cpu_has_feature.h>
-- 
2.7.4
