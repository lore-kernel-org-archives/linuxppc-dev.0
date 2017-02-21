Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSD1y0nTzzDqGj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 19:19:49 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L8J09p024773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:19:47 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28r8s8jbnv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:19:46 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 01:19:46 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 5/5] powerpc/mm: Move hash specific pte bits to be top bits of
 RPN
Date: Tue, 21 Feb 2017 13:49:17 +0530
In-Reply-To: <1487665157-22893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487665157-22893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487665157-22893-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't support the full 57 bits of physical address and hence can overload
the top bits of RPN as hash specific pte bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 18 ++++++------------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index af3c88624d3a..205c04df9cf3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -6,20 +6,14 @@
  * Common bits between 4K and 64K pages in a linux-style PTE.
  * Additional bits may be defined in pgtable-hash64-*.h
  *
- * Note: We only support user read/write permissions. Supervisor always
- * have full read/write to pages above PAGE_OFFSET (pages below that
- * always use the user access permissions).
- *
- * We could create separate kernel read-only if we used the 3 PP bits
- * combinations that newer processors provide but we currently don't.
  */
-#define H_PAGE_BUSY		_RPAGE_SW1 /* software: PTE & hash are busy */
+#define H_PAGE_BUSY		_RPAGE_RPN45 /* software: PTE & hash are busy */
 #define H_PTE_NONE_MASK		_PAGE_HPTEFLAGS
-#define H_PAGE_F_GIX_SHIFT	57
-/* (7ul << 57) HPTE index within HPTEG */
-#define H_PAGE_F_GIX		(_RPAGE_RSV2 | _RPAGE_RSV3 | _RPAGE_RSV4)
-#define H_PAGE_F_SECOND		_RPAGE_RSV1	/* HPTE is in 2ndary HPTEG */
-#define H_PAGE_HASHPTE		_RPAGE_SW0	/* PTE has associated HPTE */
+#define H_PAGE_F_GIX_SHIFT	53
+/* (7ul << 53) HPTE index within HPTEG */
+#define H_PAGE_F_GIX		(_RPAGE_RPN44 | _RPAGE_RPN43 | _RPAGE_RPN42)
+#define H_PAGE_F_SECOND		_RPAGE_RPN41	/* HPTE is in 2ndary HPTEG */
+#define H_PAGE_HASHPTE		_RPAGE_RPN40	/* PTE has associated HPTE */
 /*
  * Max physical address bit we will use for now.
  *
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0ea69c91520b..3fd9e46e44c5 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -30,16 +30,29 @@
 #define _RPAGE_RSV2		0x0800000000000000UL
 #define _RPAGE_RSV3		0x0400000000000000UL
 #define _RPAGE_RSV4		0x0200000000000000UL
+
+#define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
+#define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
+
+/*
+ * Top and bottom bits of RPN which can be used by hash
+ * translation mode, because we expect them to be zero
+ * otherwise.
+ */
 #define _RPAGE_RPN0		0x01000
 #define _RPAGE_RPN1		0x02000
+#define _RPAGE_RPN45		0x0100000000000000UL
+#define _RPAGE_RPN44		0x0080000000000000UL
+#define _RPAGE_RPN43		0x0040000000000000UL
+#define _RPAGE_RPN42		0x0020000000000000UL
+#define _RPAGE_RPN41		0x0010000000000000UL
+#define _RPAGE_RPN40		0x0008000000000000UL
+
 /* Max physicall address bit as per radix table */
 #define _RPAGE_PA_MAX		57
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
-
-#define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
-#define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
 /*
  * Drivers request for cache inhibited pte mapping using _PAGE_NO_CACHE
  * Instead of fixing all of them, add an alternate define which
-- 
2.7.4
