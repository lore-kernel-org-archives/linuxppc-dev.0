Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9B761A003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 13:29:37 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2561914017B
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 13:29:36 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 07:59:34 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7DE99E004C
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 07:59:41 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC2U5Al54460466
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 08:00:05 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC2TVRD024802
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 07:59:31 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/mm: Use PAGE_FACTOR
Date: Wed, 12 Nov 2014 13:29:28 +1100
Message-Id: <1415759368-23747-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PAGE_FACTOR was defined to reflect the difference between configured
page size and fixed 4KB page size. Replace (PAGE_SHIFT - HW_PAGE_SHIFT)
with PAGE_FACTOR.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_low_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 057cbbb..5094f32 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -514,7 +514,7 @@ htab_insert_pte:
 	andis.	r0,r31,_PAGE_4K_PFN@h
 	srdi	r5,r31,PTE_RPN_SHIFT
 	bne-	htab_special_pfn
-	sldi	r5,r5,PAGE_SHIFT-HW_PAGE_SHIFT
+	sldi	r5,r5,PAGE_FACTOR
 	add	r5,r5,r25
 htab_special_pfn:
 	sldi	r5,r5,HW_PAGE_SHIFT
@@ -544,7 +544,7 @@ htab_call_hpte_insert1:
 	andis.	r0,r31,_PAGE_4K_PFN@h
 	srdi	r5,r31,PTE_RPN_SHIFT
 	bne-	3f
-	sldi	r5,r5,PAGE_SHIFT-HW_PAGE_SHIFT
+	sldi	r5,r5,PAGE_FACTOR
 	add	r5,r5,r25
 3:	sldi	r5,r5,HW_PAGE_SHIFT
 
-- 
1.8.3.2
