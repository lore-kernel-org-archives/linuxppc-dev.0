Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5B8C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 06:10:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D184861919
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 06:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D184861919
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8fDx2RDnz3c6r
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 17:10:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BVUkOZiH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=BVUkOZiH; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8fC00tqtz303J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 17:08:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12U64MKf194457; Tue, 30 Mar 2021 02:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TS9igLUj0tKvJs3r312Me+UdojDWEPpC08X+X+DnEi4=;
 b=BVUkOZiHgCOClju7omFdTdrdZVPMIUwJwpx9ysMAAQPXZlzn2ZcDhrAaOnchor0vOcPY
 Pf59XUw4HzZln/8T+3MuWlxzT/NMhQ3pJjlKoYh8w9TP1Iu6MTXYnSIlDsM5XDwmi3c4
 w2imK1n+UeeAhp5WD5dazkFIEH7zTIwi1O4G8rLS/pR4HQkYYryRDan3EiLcxymFo3+G
 73S0wz2L5AA16DldqILTqZqoAFEeCxt5X2rKJyACiYi9+/jq3Y9KUCKmI6APj0nZEcHz
 Nt+HvDt4zL/hhAhQFnQbB7r2pnEidEnc7krwi9dd4g8C50nI0jSQl8qazDMjps6sWSQn cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37jhsc3kh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Mar 2021 02:08:20 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12U66Pnn007643;
 Tue, 30 Mar 2021 02:08:19 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 37jhsc3kgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Mar 2021 02:08:19 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12U62npF022726;
 Tue, 30 Mar 2021 06:08:19 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 37jtub5dd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Mar 2021 06:08:19 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 12U68IG430474702
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Mar 2021 06:08:18 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAEDC7805F;
 Tue, 30 Mar 2021 06:08:17 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36B7878067;
 Tue, 30 Mar 2021 06:08:15 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.52.226])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 30 Mar 2021 06:08:14 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: linux-mm@kvack.org, akpm@linux-foundation.org
Subject: [PATCH v3 3/9] mm/mremap: Use pmd/pud_poplulate to update page table
 entries
Date: Tue, 30 Mar 2021 11:37:46 +0530
Message-Id: <20210330060752.592769-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330060752.592769-1-aneesh.kumar@linux.ibm.com>
References: <20210330060752.592769-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i3Fk6juu6TWvAyjWByy8FzffH4VpSQ6G
X-Proofpoint-GUID: MNg2vl6KYzLo3-Od0MfsHC3ZS_Ntib2i
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-30_01:2021-03-26,
 2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300043
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

pmd/pud_populate is the right interface to be used to set the respective
page table entries. Some architectures like ppc64 do assume that set_pmd/pud_at
can only be used to set a hugepage PTE. Since we are not setting up a hugepage
PTE here, use the pmd/pud_populate interface.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/mremap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec8f840399ed..574287f9bb39 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -26,6 +26,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/pgalloc.h>
 
 #include "internal.h"
 
@@ -257,9 +258,8 @@ static bool move_normal_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	pmd_clear(old_pmd);
 
 	VM_BUG_ON(!pmd_none(*new_pmd));
+	pmd_populate(mm, new_pmd, (pgtable_t)pmd_page_vaddr(pmd));
 
-	/* Set the new pmd */
-	set_pmd_at(mm, new_addr, new_pmd, pmd);
 	flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
@@ -306,8 +306,7 @@ static bool move_normal_pud(struct vm_area_struct *vma, unsigned long old_addr,
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-	/* Set the new pud */
-	set_pud_at(mm, new_addr, new_pud, pud);
+	pud_populate(mm, new_pud, (pmd_t *)pud_page_vaddr(pud));
 	flush_tlb_range(vma, old_addr, old_addr + PUD_SIZE);
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
-- 
2.30.2

