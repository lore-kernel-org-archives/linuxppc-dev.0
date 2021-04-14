Return-Path: <SRS0=qW4V=JL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45192C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 09:03:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68AB61166
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 09:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68AB61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FKxMy2lpRz3dXT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Apr 2021 19:03:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DIKiOCrQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=DIKiOCrQ; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FKxHv5Fzwz3btZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Apr 2021 18:59:55 +1000 (AEST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13E8ZTIb192052; Wed, 14 Apr 2021 04:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=i65kXbTvHAI1hADMIBYsWa4GqKMsxIIL7ZSOR4VojdE=;
 b=DIKiOCrQ7vUSoevGehV5TE4histin70V5vjhUP3AFVJeDkrMoGZDWiyeKmiN9I0zppu7
 X3KsK7jpw0QIkhgF7EK+kdWogEgCxYDFxzP407BZorq+EfWysmzECUDXeDCQk00fAGSQ
 399c+4tZ8eKXFmrb5KBWh7vd23E4UTYLqGuACXH+5vF1yxlvCZuWGT1g6ixGb1hLTDHD
 EXZqlqA7ZsJX6NFLWsAtq5AuURN43lMFzN0IySfS8Tjp0yv6Q5Ne7DhftD/4s9NkIXPk
 2U7DXsV/JmqI9mlCSIqNjpbjaAc64aH4hkrIBKyvfxprI4Qlro617RNMiSRw9t5GQaS1 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 37wvaua1vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Apr 2021 04:59:49 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13E8aUqo194635;
 Wed, 14 Apr 2021 04:59:49 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 37wvaua1v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Apr 2021 04:59:49 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13E8wk08010808;
 Wed, 14 Apr 2021 08:59:48 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma04dal.us.ibm.com with ESMTP id 37u3n97pfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Apr 2021 08:59:48 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 13E8xlEE37159216
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Apr 2021 08:59:47 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8B32AE062;
 Wed, 14 Apr 2021 08:59:47 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAF41AE05C;
 Wed, 14 Apr 2021 08:59:44 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.77.205.193])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 14 Apr 2021 08:59:44 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Subject: [PATCH v4 7/9] mm/mremap: Move TLB flush outside page table lock
Date: Wed, 14 Apr 2021 14:29:13 +0530
Message-Id: <20210414085915.301189-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414085915.301189-1-aneesh.kumar@linux.ibm.com>
References: <20210414085915.301189-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u0EZXN1PNZs34DTRe0XIlEa4979s0xMS
X-Proofpoint-GUID: oeSkyGWtQULWeHCULieUuj-VzEn-y1FL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-14_03:2021-04-14,
 2021-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104140060
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kaleshsingh@google.com, npiggin@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, joel@joelfernandes.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Move TLB flush outside page table lock so that kernel does
less with page table lock held. Releasing the ptl with old
TLB contents still valid will behave such that such access
happened before the level3 or level2 entry update.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/mremap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0e7b11daafee..7ac1df8e6d51 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -259,7 +259,7 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pmd_lock(vma->vm_mm, old_pmd);
+	old_ptl = pmd_lock(mm, old_pmd);
 	new_ptl = pmd_lockptr(mm, new_pmd);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -271,11 +271,11 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pmd_none(*new_pmd));
 	pmd_populate(mm, new_pmd, (pgtable_t)pmd_page_vaddr(pmd));
 
-	flush_pte_tlb_pwc_range(vma, old_addr, old_addr + PMD_SIZE, true);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
 
+	flush_pte_tlb_pwc_range(vma, old_addr, old_addr + PMD_SIZE, true);
 	return true;
 }
 #else
@@ -306,7 +306,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(vma->vm_mm, old_pud);
+	old_ptl = pud_lock(mm, old_pud);
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
@@ -318,11 +318,11 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, (pmd_t *)pud_page_vaddr(pud));
-	flush_pte_tlb_pwc_range(vma, old_addr, old_addr + PUD_SIZE, true);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
 
+	flush_pte_tlb_pwc_range(vma, old_addr, old_addr + PUD_SIZE, true);
 	return true;
 }
 #else
-- 
2.30.2

