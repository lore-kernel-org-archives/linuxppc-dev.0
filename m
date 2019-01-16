Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FFC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B4E2086D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B4E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fh5D2QzyzDqWr
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 20:01:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fgt45pzrzDqTJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 19:51:24 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0G8n394083407
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:51:22 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q1ybepax6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 03:51:21 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 16 Jan 2019 08:51:21 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 16 Jan 2019 08:51:17 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0G8pGBH21299290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Jan 2019 08:51:16 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8014E12405C;
 Wed, 16 Jan 2019 08:51:16 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4538F124052;
 Wed, 16 Jan 2019 08:51:14 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.92])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 16 Jan 2019 08:51:14 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, akpm@linux-foundation.org, x86@kernel.org
Subject: [PATCH V5 5/5] arch/powerpc/mm/hugetlb: NestMMU workaround for
 hugetlb mprotect RW upgrade
Date: Wed, 16 Jan 2019 14:20:35 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011608-2213-0000-0000-0000033E30AA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010416; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01147213; UDB=6.00597570; IPR=6.00927509; 
 MB=3.00025150; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-16 08:51:20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011608-2214-0000-0000-00005CFD9593
Message-Id: <20190116085035.29729-6-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=511 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901160075
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

NestMMU requires us to mark the pte invalid and flush the tlb when we do a
RW upgrade of pte. We fixed a variant of this in the fault path in commit
Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 12 ++++++++++
 arch/powerpc/mm/hugetlbpage-hash64.c         | 25 ++++++++++++++++++++
 arch/powerpc/mm/hugetlbpage-radix.c          | 17 +++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 5b0177733994..66c1e4f88d65 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -13,6 +13,10 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 				unsigned long len, unsigned long pgoff,
 				unsigned long flags);
 
+extern void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+						unsigned long addr, pte_t *ptep,
+						pte_t old_pte, pte_t pte);
+
 static inline int hstate_get_psize(struct hstate *hstate)
 {
 	unsigned long shift;
@@ -42,4 +46,12 @@ static inline bool gigantic_page_supported(void)
 /* hugepd entry valid bit */
 #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
 
+#define huge_ptep_modify_prot_start huge_ptep_modify_prot_start
+extern pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep);
+
+#define huge_ptep_modify_prot_commit huge_ptep_modify_prot_commit
+extern void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t old_pte, pte_t new_pte);
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 2e6a8f9345d3..367ce3a4a503 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -121,3 +121,28 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
+
+pte_t huge_ptep_modify_prot_start(struct vm_area_struct *vma,
+				  unsigned long addr, pte_t *ptep)
+{
+	unsigned long pte_val;
+	/*
+	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
+	 * possible. Also keep the pte_present true so that we don't take
+	 * wrong fault.
+	 */
+	pte_val = pte_update(vma->vm_mm, addr, ptep,
+			     _PAGE_PRESENT, _PAGE_INVALID, 1);
+
+	return __pte(pte_val);
+}
+
+void huge_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
+				  pte_t *ptep, pte_t old_pte, pte_t pte)
+{
+
+	if (radix_enabled())
+		return radix__huge_ptep_modify_prot_commit(vma, addr, ptep,
+							   old_pte, pte);
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 2486bee0f93e..11d9ea28a816 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -90,3 +90,20 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 
 	return vm_unmapped_area(&info);
 }
+
+void radix__huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep,
+					 pte_t old_pte, pte_t pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	/*
+	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
+	 * we set the new value.
+	 */
+	if (is_pte_rw_upgrade(pte_val(old_pte), pte_val(pte)) &&
+	    (atomic_read(&mm->context.copros) > 0))
+		radix__flush_hugetlb_page(vma, addr);
+
+	set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+}
-- 
2.20.1

