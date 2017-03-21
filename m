Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnfwm1WPBzDqZP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 04:30:48 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2LHTPRv009092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:30:37 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ambpfbk5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 13:30:37 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 13:30:36 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 08/10] powerpc/mm: Define all PTE bits based on radix
 definitions.
Date: Tue, 21 Mar 2017 22:59:58 +0530
In-Reply-To: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490117400-9891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490117400-9891-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
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
index 4d4ff9a324f0..96566df547a8 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -36,6 +36,8 @@
 #define _RPAGE_RSV2		0x0800000000000000UL
 #define _RPAGE_RSV3		0x0400000000000000UL
 #define _RPAGE_RSV4		0x0200000000000000UL
+#define _RPAGE_RPN0		0x01000
+#define _RPAGE_RPN1		0x02000
 
 #define _PAGE_SOFT_DIRTY	_RPAGE_SW3 /* software: software dirty tracking */
 #define _PAGE_SPECIAL		_RPAGE_SW2 /* software: special page */
-- 
2.7.4
