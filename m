Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF8CC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 06:23:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712BA217D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 06:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712BA217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kwGD2M8JzDqM3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 17:23:32 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kwDW3nRJzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 17:22:03 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0N6IUC1127054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 01:22:01 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q6jmgrnvq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 01:22:01 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 23 Jan 2019 06:22:00 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Jan 2019 06:21:58 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0N6LvF914090286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Jan 2019 06:21:57 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6AF247805C;
 Wed, 23 Jan 2019 06:21:57 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F39A67805E;
 Wed, 23 Jan 2019 06:21:54 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.85.74.253])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 23 Jan 2019 06:21:54 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH] arch/powerpc/radix: Fix kernel crash with mremap
Date: Wed, 23 Jan 2019 11:51:38 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012306-8235-0000-0000-00000E4F14B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010460; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000275; SDB=6.01150478; UDB=6.00599554; IPR=6.00930815; 
 MB=3.00025250; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-23 06:21:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012306-8236-0000-0000-0000442EEF34
Message-Id: <20190123062138.22644-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230049
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With support for split pmd lock, we use pmd page pmd_huge_pte pointer to store
the deposited page table. In those config when we move page tables we need to
make sure we move the depoisted page table to the right pmd page. Otherwise this
can result in crash when we withdraw of deposited page table because we can find
the pmd_huge_pte NULL.

c0000000004a1230 __split_huge_pmd+0x1070/0x1940
c0000000004a0ff4 __split_huge_pmd+0xe34/0x1940 (unreliable)
c0000000004a4000 vma_adjust_trans_huge+0x110/0x1c0
c00000000042fe04 __vma_adjust+0x2b4/0x9b0
c0000000004316e8 __split_vma+0x1b8/0x280
c00000000043192c __do_munmap+0x13c/0x550
c000000000439390 sys_mremap+0x220/0x7e0
c00000000000b488 system_call+0x5c/0x70

Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 22 +++++++-------------
 arch/powerpc/mm/pgtable-book3s64.c           | 22 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 92eaea164700..11703bfd3a63 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1258,21 +1258,13 @@ extern pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 
 #define pmd_move_must_withdraw pmd_move_must_withdraw
 struct spinlock;
-static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
-					 struct spinlock *old_pmd_ptl,
-					 struct vm_area_struct *vma)
-{
-	if (radix_enabled())
-		return false;
-	/*
-	 * Archs like ppc64 use pgtable to store per pmd
-	 * specific information. So when we switch the pmd,
-	 * we should also withdraw and deposit the pgtable
-	 */
-	return true;
-}
-
-
+extern int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+				  struct spinlock *old_pmd_ptl,
+				  struct vm_area_struct *vma);
+/*
+ * Hash translation mode use the deposited table to store hash pte
+ * slot information.
+ */
 #define arch_needs_pgtable_deposit arch_needs_pgtable_deposit
 static inline bool arch_needs_pgtable_deposit(void)
 {
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 47c742f002ea..257baf342bff 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -425,3 +425,25 @@ void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 						      ptep, old_pte, pte);
 	set_pte_at(vma->vm_mm, addr, ptep, pte);
 }
+
+/* For hash translation mode, we use the deposited table to store
+ * store hash slot information and they are stored at PTRS_PER_PMD
+ * offset from related pmd location. Hence a pmd move requires
+ * deposit and withdraw.
+
+ * For radix translation with split pmd ptl, we store the deposited
+ * table in the pmd page. Hence if we have different pmd page we need
+ * to withdraw during pmd move.
+
+ * With hash we use deposited table always irrespective of anon or not.
+ * With radix we use deposited table only for anonymous mapping.
+ */
+int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
+			   struct spinlock *old_pmd_ptl,
+			   struct vm_area_struct *vma)
+{
+	if (radix_enabled())
+		return (new_pmd_ptl != old_pmd_ptl) && vma_is_anonymous(vma);
+
+	return true;
+}
-- 
2.20.1

