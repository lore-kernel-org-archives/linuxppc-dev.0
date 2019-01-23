Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120E3C282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:15:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5320121726
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5320121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kyks64H1zDqLb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:15:01 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kyj22F1dzDqGP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:13:25 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0N86qgY085392
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 03:13:23 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2q6mfj0bdy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 03:13:23 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 23 Jan 2019 08:13:21 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 23 Jan 2019 08:13:19 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0N8DI7F8585574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Jan 2019 08:13:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A882EA405B;
 Wed, 23 Jan 2019 08:13:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E177A4060;
 Wed, 23 Jan 2019 08:13:17 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.69.250])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 23 Jan 2019 08:13:17 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH] arch/powerpc/radix: Fix kernel crash with mremap
In-Reply-To: <20190123062138.22644-1-aneesh.kumar@linux.ibm.com>
References: <20190123062138.22644-1-aneesh.kumar@linux.ibm.com>
Date: Wed, 23 Jan 2019 13:43:15 +0530
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19012308-0012-0000-0000-000002EBBE77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012308-0013-0000-0000-00002122ECA0
Message-Id: <878szbdc6c.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-23_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230062
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> With support for split pmd lock, we use pmd page pmd_huge_pte pointer to store
> the deposited page table. In those config when we move page tables we need to
> make sure we move the depoisted page table to the right pmd page. Otherwise this
> can result in crash when we withdraw of deposited page table because we can find
> the pmd_huge_pte NULL.
>
> c0000000004a1230 __split_huge_pmd+0x1070/0x1940
> c0000000004a0ff4 __split_huge_pmd+0xe34/0x1940 (unreliable)
> c0000000004a4000 vma_adjust_trans_huge+0x110/0x1c0
> c00000000042fe04 __vma_adjust+0x2b4/0x9b0
> c0000000004316e8 __split_vma+0x1b8/0x280
> c00000000043192c __do_munmap+0x13c/0x550
> c000000000439390 sys_mremap+0x220/0x7e0
> c00000000000b488 system_call+0x5c/0x70
>

This was done on top of "NestMMU pte upgrade workaround for mprotect" series

> Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

For applying to merge branch you can use the below patch

From 33d28f144d41ecbba074ceefd234983422469e4b Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Mon, 21 Jan 2019 16:43:17 +0530
Subject: [PATCH] arch/powerpc/radix: Fix kernel crash with mremap

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
index 2e6ada28da64..c9bfe526ca9d 100644
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
index f3c31f5e1026..65eaf784f866 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -400,3 +400,25 @@ void arch_report_meminfo(struct seq_file *m)
 		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
 }
 #endif /* CONFIG_PROC_FS */
+
+/* For hash translation mode, we use the deposited table to store
+ * hash slot information and they are stored at PTRS_PER_PMD
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



