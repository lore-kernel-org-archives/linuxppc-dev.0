Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSD1l6nv2zDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 19:19:39 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L8J1PE138251
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:19:38 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28rekc7d3e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:19:37 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 03:19:35 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/5] powerpc/mm: Express everything based on Radix page table
 defines
Date: Tue, 21 Feb 2017 13:49:14 +0530
In-Reply-To: <1487665157-22893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487665157-22893-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1487665157-22893-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index b39f0b86405e..7be54f9590a3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -10,8 +10,8 @@
  * 64k aligned address free up few of the lower bits of RPN for us
  * We steal that here. For more deatils look at pte_pfn/pfn_pte()
  */
-#define H_PAGE_COMBO	0x00001000 /* this is a combo 4k page */
-#define H_PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
+#define H_PAGE_COMBO	_RPAGE_RPN0 /* this is a combo 4k page */
+#define H_PAGE_4K_PFN	_RPAGE_RPN1 /* PFN is for a single 4k page */
 /*
  * We need to differentiate between explicit huge page and THP huge
  * page, since THP huge page also need to track real subpage details
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8ae9e0be3a6f..dec136742cd7 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -30,6 +30,8 @@
 #define _RPAGE_RSV2		0x0800000000000000UL
 #define _RPAGE_RSV3		0x0400000000000000UL
 #define _RPAGE_RSV4		0x0200000000000000UL
+#define _RPAGE_RPN0		0x01000
+#define _RPAGE_RPN1		0x02000
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
-- 
2.7.4
