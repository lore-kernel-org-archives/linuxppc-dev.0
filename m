Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29AFC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557A1206B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 13:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557A1206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kjv70nNTzDqF1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 23:36:35 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kj9w1mL9zDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 23:04:20 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3HCk1oA016173
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:04:18 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rx3p0k2cx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 09:04:17 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 17 Apr 2019 14:04:16 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Apr 2019 14:04:14 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3HD4Dlh53936286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Apr 2019 13:04:13 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05949C6063;
 Wed, 17 Apr 2019 13:04:13 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7D76C6057;
 Wed, 17 Apr 2019 13:04:10 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.40.202])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 17 Apr 2019 13:04:10 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, paulus@samba.org, mpe@ellerman.id.au,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 4/6] powerpc/mm: Move slb_addr_linit to early_init_mmu
Date: Wed, 17 Apr 2019 18:33:49 +0530
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
References: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041713-0004-0000-0000-000014FE9B76
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010943; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01190371; UDB=6.00623771; IPR=6.00971169; 
 MB=3.00026484; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-17 13:04:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041713-0005-0000-0000-00008B4B102A
Message-Id: <20190417130351.3805-5-aneesh.kumar@linux.ibm.com>
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

Avoid #ifdef in generic code. Also enables us to do this specific to
MMU translation mode on book3s64

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/kernel/setup-common.c | 11 -----------
 arch/powerpc/mm/hash_utils_64.c    |  2 ++
 arch/powerpc/mm/tlb_nohash.c       |  6 ++++++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 2e5dfb6e0823..a07de8608484 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -947,17 +947,6 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = klimit;
 
-#ifdef CONFIG_PPC_MM_SLICES
-#ifdef CONFIG_PPC64
-	if (!radix_enabled())
-		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
-#elif defined(CONFIG_PPC_8xx)
-	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
-#else
-#error	"context.addr_limit not initialized."
-#endif
-#endif
-
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	mm_iommu_init(&init_mm);
 #endif
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5a2bd132f92e..2cb3a456f5b5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1041,6 +1041,8 @@ void __init hash__early_init_mmu(void)
 	 */
 	htab_initialize();
 
+	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
+
 	pr_info("Initializing hash mmu with SLB\n");
 	/* Initialize SLB management */
 	slb_initialize();
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index ac23dc1c6535..088e0a6b5ade 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -800,5 +800,11 @@ void __init early_init_mmu(void)
 #ifdef CONFIG_PPC_47x
 	early_init_mmu_47x();
 #endif
+
+#ifdef CONFIG_PPC_MM_SLICES
+#if defined(CONFIG_PPC_8xx)
+	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
+#endif
+#endif
 }
 #endif /* CONFIG_PPC64 */
-- 
2.20.1

