Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3333FC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:07:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEF52086D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEF52086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dTg34fJ9zDqRF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:07:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dTNf1nykzDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 20:55:14 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0E9mW4L011222
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 04:55:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q0mxwrvaq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 04:55:11 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 14 Jan 2019 09:55:10 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 14 Jan 2019 09:55:06 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0E9t5cS24445040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 09:55:05 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 458B2AE062;
 Mon, 14 Jan 2019 09:55:05 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7D09AE05C;
 Mon, 14 Jan 2019 09:55:02 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.106])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 14 Jan 2019 09:55:02 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: akpm@linux-foundation.org, Michal Hocko <mhocko@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Andrea Arcangeli <aarcange@redhat.com>, mpe@ellerman.id.au
Subject: [PATCH V7 4/4] powerpc/mm/iommu: Allow large IOMMU page size only for
 hugetlb backing
Date: Mon, 14 Jan 2019 15:24:37 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
References: <20190114095438.32470-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011409-0040-0000-0000-000004B17D6B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010402; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01146284; UDB=6.00593882; IPR=6.00926570; 
 MB=3.00025118; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-14 09:55:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011409-0041-0000-0000-000008BC8573
Message-Id: <20190114095438.32470-6-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140081
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

THP pages can get split during different code paths. An incremented reference
count does imply we will not split the compound page. But the pmd entry can be
converted to level 4 pte entries. Keep the code simpler by allowing large
IOMMU page size only if the guest ram is backed by hugetlb pages.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/mm/mmu_context_iommu.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
index f11a2f15071f..74d43f522dc2 100644
--- a/arch/powerpc/mm/mmu_context_iommu.c
+++ b/arch/powerpc/mm/mmu_context_iommu.c
@@ -98,8 +98,6 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	struct mm_iommu_table_group_mem_t *mem;
 	long i, ret = 0, locked_entries = 0;
 	unsigned int pageshift;
-	unsigned long flags;
-	unsigned long cur_ua;
 
 	mutex_lock(&mem_list_mutex);
 
@@ -169,22 +167,14 @@ static long mm_iommu_do_alloc(struct mm_struct *mm, unsigned long ua,
 	for (i = 0; i < entries; ++i) {
 		struct page *page = mem->hpages[i];
 
-		cur_ua = ua + (i << PAGE_SHIFT);
-		if (mem->pageshift > PAGE_SHIFT && PageCompound(page)) {
-			pte_t *pte;
+		/*
+		 * Allow to use larger than 64k IOMMU pages. Only do that
+		 * if we are backed by hugetlb.
+		 */
+		if ((mem->pageshift > PAGE_SHIFT) && PageHuge(page)) {
 			struct page *head = compound_head(page);
-			unsigned int compshift = compound_order(head);
-			unsigned int pteshift;
-
-			local_irq_save(flags); /* disables as well */
-			pte = find_linux_pte(mm->pgd, cur_ua, NULL, &pteshift);
-
-			/* Double check it is still the same pinned page */
-			if (pte && pte_page(*pte) == head &&
-			    pteshift == compshift + PAGE_SHIFT)
-				pageshift = max_t(unsigned int, pteshift,
-						PAGE_SHIFT);
-			local_irq_restore(flags);
+
+			pageshift = compound_order(head) + PAGE_SHIFT;
 		}
 		mem->pageshift = min(mem->pageshift, pageshift);
 		/*
-- 
2.20.1

