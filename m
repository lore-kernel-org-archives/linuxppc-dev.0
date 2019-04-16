Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C3C282DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFFA20693
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 10:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFFA20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k1l716cmzDqFF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 20:27:15 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44k1KC3HbpzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 20:08:15 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3GA6gYo137305
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:08:13 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rwavv5jtu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 06:08:10 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 16 Apr 2019 11:07:57 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Apr 2019 11:07:54 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3GA7rdh35520556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Apr 2019 10:07:53 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 791A0AC064;
 Tue, 16 Apr 2019 10:07:53 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF2A8AC05B;
 Tue, 16 Apr 2019 10:07:51 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.209])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 16 Apr 2019 10:07:51 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH v3 8/8] powerpc/mm/hash: Rename KERNEL_REGION_ID to
 LINEAR_MAP_REGION_ID
Date: Tue, 16 Apr 2019 15:37:22 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
References: <20190416100722.10324-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041610-0040-0000-0000-000004E1A07F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010937; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01189843; UDB=6.00623449; IPR=6.00970634; 
 MB=3.00026465; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-16 10:07:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041610-0041-0000-0000-000008ECAAC6
Message-Id: <20190416100722.10324-9-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-16_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904160069
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
index c6850a5a931d..e86c338f3ad7 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -77,7 +77,7 @@
  * Region IDs
  */
 #define USER_REGION_ID		0
-#define KERNEL_REGION_ID	1
+#define LINEAR_MAP_REGION_ID	1
 #define VMALLOC_REGION_ID	NON_LINEAR_REGION_ID(VMALLOC_START)
 #define IO_REGION_ID		NON_LINEAR_REGION_ID(KERN_IO_START)
 #define VMEMMAP_REGION_ID	NON_LINEAR_REGION_ID(VMEMMAP_BASE)
@@ -108,7 +108,7 @@ static inline int get_region_id(unsigned long ea)
 		return USER_REGION_ID;
 
 	if (ea < KERN_VIRT_START)
-		return KERNEL_REGION_ID;
+		return LINEAR_MAP_REGION_ID;
 
 	VM_BUG_ON(id != 0xc);
 	BUILD_BUG_ON(NON_LINEAR_REGION_ID(VMALLOC_START) != 2);
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
index 508573c56411..756cf087590b 100644
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

