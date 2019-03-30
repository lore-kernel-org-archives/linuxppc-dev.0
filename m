Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18EC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 05:43:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C498D218A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 05:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C498D218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WSFC2vmtzDqXC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 16:43:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WSCR3rF7zDqX6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 16:41:38 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2U5YDQF142305
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:41:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rhu8dwe33-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:41:35 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Sat, 30 Mar 2019 05:41:34 -0000
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 30 Mar 2019 05:41:30 -0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2U5fTBm15728746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 30 Mar 2019 05:41:30 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E096D6E04C;
 Sat, 30 Mar 2019 05:41:29 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3861A6E04E;
 Sat, 30 Mar 2019 05:41:27 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.85.132])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat, 30 Mar 2019 05:41:26 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, akpm@linux-foundation.org,
 Jan Kara <jack@suse.cz>
Subject: [PATCH] mm: Fix modifying of page protection by insert_pfn_pmd()
Date: Sat, 30 Mar 2019 11:11:21 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19033005-0016-0000-0000-000009991E5D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010838; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181690; UDB=6.00618514; IPR=6.00962416; 
 MB=3.00026217; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-30 05:41:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19033005-0017-0000-0000-000042A193B0
Message-Id: <20190330054121.27831-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-30_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903300038
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, stable@vger.kernel.org,
 linux-nvdimm@lists.01.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With some architectures like ppc64, set_pmd_at() cannot cope with
a situation where there is already some (different) valid entry present.

Use pmdp_set_access_flags() instead to modify the pfn which is built to
deal with modifying existing PMD entries.

This is similar to
commit cae85cb8add3 ("mm/memory.c: fix modifying of page protection by insert_pfn()")

We also do similar update w.r.t insert_pfn_pud eventhough ppc64 don't support
pud pfn entries now.

CC: stable@vger.kernel.org
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/huge_memory.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 404acdcd0455..f7dca413c4b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -755,6 +755,20 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmd);
+	if (!pmd_none(*pmd)) {
+		if (write) {
+			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
+				goto out_unlock;
+			}
+			entry = pmd_mkyoung(*pmd);
+			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
+				update_mmu_cache_pmd(vma, addr, pmd);
+		}
+		goto out_unlock;
+	}
+
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
@@ -770,6 +784,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
+out_unlock:
 	spin_unlock(ptl);
 }
 
@@ -821,6 +836,20 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	spinlock_t *ptl;
 
 	ptl = pud_lock(mm, pud);
+	if (!pud_none(*pud)) {
+		if (write) {
+			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
+				goto out_unlock;
+			}
+			entry = pud_mkyoung(*pud);
+			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
+				update_mmu_cache_pud(vma, addr, pud);
+		}
+		goto out_unlock;
+	}
+
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
@@ -830,6 +859,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
+
+out_unlock:
 	spin_unlock(ptl);
 }
 
-- 
2.20.1

