Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3499AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:20:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36FC320666
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 03:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FC320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438kW42gZ4zDqg4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 14:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 438kHd6C1jzDqX8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 14:10:05 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB534Lfw040909
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Dec 2018 22:10:04 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p6494vn52-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 22:10:04 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 5 Dec 2018 03:10:02 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 5 Dec 2018 03:09:59 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB539wSN19398814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Dec 2018 03:09:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8887E112062;
 Wed,  5 Dec 2018 03:09:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1ECEB112065;
 Wed,  5 Dec 2018 03:09:55 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.73.253])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed,  5 Dec 2018 03:09:54 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, akpm@linux-foundation.org
Subject: [PATCH V3 4/5] mm/hugetlb: Add prot_modify_start/commit sequence for
 hugetlb update
Date: Wed,  5 Dec 2018 08:39:30 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205030931.12037-1-aneesh.kumar@linux.ibm.com>
References: <20181205030931.12037-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18120503-0052-0000-0000-000003618254
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010173; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127133; UDB=6.00585424; IPR=6.00907267; 
 MB=3.00024450; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-05 03:10:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120503-0053-0000-0000-00005EFDF493
Message-Id: <20181205030931.12037-5-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-04_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=736 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812050027
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Architectures like ppc64 requires to do a conditional tlb flush based on the old
and new value of pte. Follow the regular pte change protection sequence for
hugetlb too. This allow the architectures to override the update sequence.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/hugetlb.h | 20 ++++++++++++++++++++
 mm/hugetlb.c            |  8 +++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 087fd5f48c91..39e78b80375c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -543,6 +543,26 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 	set_huge_pte_at(mm, addr, ptep, pte);
 }
 #endif
+
+#ifndef huge_ptep_modify_prot_start
+#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
+static inline pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+						unsigned long addr, pte_t *ptep)
+{
+	return huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+}
+#endif
+
+#ifndef huge_ptep_modify_prot_commit
+#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
+static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+						unsigned long addr, pte_t *ptep,
+						pte_t old_pte, pte_t pte)
+{
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 #define alloc_huge_page(v, a, r) NULL
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 705a3e9cc910..353bff385595 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4388,10 +4388,12 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 			continue;
 		}
 		if (!huge_pte_none(pte)) {
-			pte = huge_ptep_get_and_clear(mm, address, ptep);
-			pte = pte_mkhuge(huge_pte_modify(pte, newprot));
+			pte_t old_pte;
+
+			old_pte = huge_ptep_modify_prot_start(vma, address, ptep);
+			pte = pte_mkhuge(huge_pte_modify(old_pte, newprot));
 			pte = arch_make_huge_pte(pte, vma, NULL, 0);
-			set_huge_pte_at(mm, address, ptep, pte);
+			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
 		}
 		spin_unlock(ptl);
-- 
2.19.2

