Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E89301A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 12:45:55 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 Jun 2015 12:45:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CD89B2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 12:45:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5H2iRGl58065150
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 12:44:36 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5H2i4rI010518
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 12:44:05 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] powerpc/mm: PTE_RPN_MAX is not used, remove the same
Date: Wed, 17 Jun 2015 08:13:40 +0530
Message-Id: <1434509021-24168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the unused #define

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index c5a755ef7011..b7c8d079c121 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -85,10 +85,8 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
  * 64-bit PTEs
  */
 #if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
-#define PTE_RPN_MAX	(1ULL << (64 - PTE_RPN_SHIFT))
 #define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
 #else
-#define PTE_RPN_MAX	(1UL << (32 - PTE_RPN_SHIFT))
 #define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
 #endif
 
-- 
2.1.4
