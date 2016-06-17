Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW8m65t9QzDqsT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 16:02:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5H5xVkd090527
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 02:02:11 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jswdekqf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 02:02:11 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 00:02:10 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Don't add memory coherence if cache
 inhibited is set
Date: Fri, 17 Jun 2016 11:32:00 +0530
Message-Id: <1466143320-8203-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

H_ENTER hcall handling in qemu had assumptions that a cache inhibited
hpte entry won't have memory conference set. Also older kernel
mentioned that some version of pHyp required this (the code removed
by the below commit says:

    /* Make pHyp happy */
    if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
            hpte_r &= ~HPTE_R_M;

But with older kernel we had some inconsistent memory conherence
mapping. We always enabled memory conherence in the page fault path and
removed memory conherence is _PAGE_NO_CACHE was set when we mapped the
page via htab_bolt_mapping. The commit mentioned below tried to
consolidate that by always enabling memory conherence. But as mentioned
above that breaks Qemu H_ENTER handling.

This patch update this such that we enable memory conherence only if
cache inhibited is not set and bring fault handling, lpar and bolt
mapping in sync.

Fixes: commit 30bda41aba4e("powerpc/mm: Drop WIMG in favour of new constant")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index fcf676f7f522..32bf92d2e7ff 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -201,9 +201,8 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 	/*
 	 * We can't allow hardware to update hpte bits. Hence always
 	 * set 'R' bit and set 'C' if it is a write fault
-	 * Memory coherence is always enabled
 	 */
-	rflags |=  HPTE_R_R | HPTE_R_M;
+	rflags |=  HPTE_R_R;
 
 	if (pteflags & _PAGE_DIRTY)
 		rflags |= HPTE_R_C;
@@ -213,10 +212,15 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 
 	if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_TOLERANT)
 		rflags |= HPTE_R_I;
-	if ((pteflags & _PAGE_CACHE_CTL ) == _PAGE_NON_IDEMPOTENT)
+	else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT)
 		rflags |= (HPTE_R_I | HPTE_R_G);
-	if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
-		rflags |= (HPTE_R_I | HPTE_R_W);
+	else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
+		rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);
+	else
+		/*
+		 * Add memory coherence if cache inhibited is not set
+		 */
+		rflags |= HPTE_R_M;
 
 	return rflags;
 }
-- 
2.7.4
