Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64580C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:17:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E96F20449
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E96F20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kjTR4H10zDqNJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:17:47 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj4v4QcXzDqMg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 22:59:59 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCjE3W064080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:57 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rx3j8k3r4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 08:59:57 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 13:59:56 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 13:59:54 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HCxriq46661850
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 12:59:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A41FBE053;
 Wed, 17 Apr 2019 12:59:53 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18353BE054;
 Wed, 17 Apr 2019 12:59:51 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 12:59:50 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v4 7/8] powerpc/mm/hash: Rename KERNEL_REGION_ID to
 LINEAR_MAP_REGION_ID
Date: Wed, 17 Apr 2019 18:29:19 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
References: <20190417125920.785-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041712-0020-0000-0000-00000ED8D03D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190369; UDB=6.00623770; IPR=6.00971167; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 12:59:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041712-0021-0000-0000-000065774C77
Message-Id: <20190417125920.785-8-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904170089
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

The region actually point to linear map. Rename the #define to
clarify thati.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h     | 4 ++--
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 2 +-
 arch/powerpc/mm/copro_fault.c                 | 4 ++--
 arch/powerpc/mm/slb.c                         | 4 ++--
 arch/powerpc/platforms/cell/spu_base.c        | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 7faa3d7214c0..1d1183048cfd 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -89,7 +89,7 @@
  * Region IDs
  */
 #define USER_REGION_ID		0
-#define KERNEL_REGION_ID	1
+#define LINEAR_MAP_REGION_ID	1
 #define VMALLOC_REGION_ID	NON_LINEAR_REGION_ID(H_VMALLOC_START)
 #define IO_REGION_ID		NON_LINEAR_REGION_ID(H_KERN_IO_START)
 #define VMEMMAP_REGION_ID	NON_LINEAR_REGION_ID(H_VMEMMAP_START)
@@ -120,7 +120,7 @@ static inline int get_region_id(unsigned long ea)
 		return USER_REGION_ID;
 
 	if (ea < H_KERN_VIRT_START)
-		return KERNEL_REGION_ID;
+		return LINEAR_MAP_REGION_ID;
 
 	VM_BUG_ON(id != 0xc);
 	BUILD_BUG_ON(NON_LINEAR_REGION_ID(H_VMALLOC_START) != 2);
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index b146448109fd..5d2adf3c1325 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -788,7 +788,7 @@ static inline unsigned long get_kernel_context(unsigned long ea)
 	 * Depending on Kernel config, kernel region can have one context
 	 * or more.
 	 */
-	if (region_id == KERNEL_REGION_ID) {
+	if (region_id == LINEAR_MAP_REGION_ID) {
 		/*
 		 * We already verified ea to be not beyond the addr limit.
 		 */
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 9b0321061bc8..f137286740cb 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -129,8 +129,8 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
 		vsidkey = SLB_VSID_KERNEL;
 		break;
-	case KERNEL_REGION_ID:
-		pr_devel("%s: 0x%llx -- KERNEL_REGION_ID\n", __func__, ea);
+	case LINEAR_MAP_REGION_ID:
+		pr_devel("%s: 0x%llx -- LINEAR_MAP_REGION_ID\n", __func__, ea);
 		psize = mmu_linear_psize;
 		ssize = mmu_kernel_ssize;
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index a0c37f428d60..2c4e01781c10 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -691,7 +691,7 @@ static long slb_allocate_kernel(unsigned long ea, unsigned long id)
 	unsigned long flags;
 	int ssize;
 
-	if (id == KERNEL_REGION_ID) {
+	if (id == LINEAR_MAP_REGION_ID) {
 
 		/* We only support upto MAX_PHYSMEM_BITS */
 		if ((ea & EA_MASK) > (1UL << MAX_PHYSMEM_BITS))
@@ -790,7 +790,7 @@ long do_slb_fault(struct pt_regs *regs, unsigned long ea)
 	 * first class kernel code. But for performance it's probably nicer
 	 * if they go via fast_exception_return too.
 	 */
-	if (id >= KERNEL_REGION_ID) {
+	if (id >= LINEAR_MAP_REGION_ID) {
 		long err;
 #ifdef CONFIG_DEBUG_VM
 		/* Catch recursive kernel SLB faults. */
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 4770cce1bfe2..6646f152d57b 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -224,7 +224,7 @@ static void __spu_kernel_slb(void *addr, struct copro_slb *slb)
 	unsigned long ea = (unsigned long)addr;
 	u64 llp;
 
-	if (get_region_id(ea) == KERNEL_REGION_ID)
+	if (get_region_id(ea) == LINEAR_MAP_REGION_ID)
 		llp = mmu_psize_defs[mmu_linear_psize].sllp;
 	else
 		llp = mmu_psize_defs[mmu_virtual_psize].sllp;
-- 
2.20.1

