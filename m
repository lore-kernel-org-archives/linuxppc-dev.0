Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC52C004D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 15:07:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B74320645
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 15:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B74320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42f0Ht3tJ8zF36x
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 02:07:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42f0166fQ5zF31q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 01:54:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9MEsat5091146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 10:54:47 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n9gebgyk0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 10:54:46 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 22 Oct 2018 10:54:43 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 22 Oct 2018 10:54:41 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9MEsfPP25886946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Oct 2018 14:54:41 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC203AC05B;
 Mon, 22 Oct 2018 14:54:40 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0149DAC059;
 Mon, 22 Oct 2018 14:54:40 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.163.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 22 Oct 2018 14:54:39 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 9/9] powerpc/pkey: Define functions as static
Date: Mon, 22 Oct 2018 11:54:20 -0300
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540220060-30162-1-git-send-email-leitao@debian.org>
References: <1540220060-30162-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18102214-0072-0000-0000-000003B9D426
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009916; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01106373; UDB=6.00572935; IPR=6.00886458; 
 MB=3.00023857; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-22 14:54:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102214-0073-0000-0000-000049D7F291
Message-Id: <1540220060-30162-9-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-22_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=784 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810220128
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
Cc: Breno Leitao <leitao@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sparse tool is showing some warnings on pkeys.c file, mainly related to
storage class identifiers. There are static variables and functions not
declared as such. The same thing happens with an extern function, which
misses the header inclusion.

	arch/powerpc/mm/pkeys.c:14:6: warning: symbol 'pkey_execute_disable_supported' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:16:6: warning: symbol 'pkeys_devtree_defined' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:19:6: warning: symbol 'pkey_amr_mask' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:20:6: warning: symbol 'pkey_iamr_mask' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:21:6: warning: symbol 'pkey_uamor_mask' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:22:6: warning: symbol 'execute_only_key' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:60:5: warning: symbol 'pkey_initialize' was not declared. Should it be static?
	arch/powerpc/mm/pkeys.c:404:6: warning: symbol 'arch_vma_access_permitted' was not declared. Should it be static?

This patch fix al the warning, basically turning all global variables that
are not declared as extern at asm/pkeys.h into static.

It also includes asm/mmu_context.h header, which contains the definition of
arch_vma_access_permitted.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/mm/pkeys.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b271b283c785..04b60a8f6e69 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -6,20 +6,21 @@
  */
 
 #include <asm/mman.h>
+#include <asm/mmu_context.h>
 #include <asm/setup.h>
 #include <linux/pkeys.h>
 #include <linux/of_device.h>
 
 DEFINE_STATIC_KEY_TRUE(pkey_disabled);
-bool pkey_execute_disable_supported;
 int  pkeys_total;		/* Total pkeys as per device tree */
-bool pkeys_devtree_defined;	/* pkey property exported by device tree */
 u32  initial_allocation_mask;   /* Bits set for the initially allocated keys */
 u32  reserved_allocation_mask;  /* Bits set for reserved keys */
-u64  pkey_amr_mask;		/* Bits in AMR not to be touched */
-u64  pkey_iamr_mask;		/* Bits in AMR not to be touched */
-u64  pkey_uamor_mask;		/* Bits in UMOR not to be touched */
-int  execute_only_key = 2;
+static bool pkey_execute_disable_supported;
+static bool pkeys_devtree_defined;	/* property exported by device tree */
+static u64 pkey_amr_mask;		/* Bits in AMR not to be touched */
+static u64 pkey_iamr_mask;		/* Bits in AMR not to be touched */
+static u64 pkey_uamor_mask;		/* Bits in UMOR not to be touched */
+static int execute_only_key = 2;
 
 #define AMR_BITS_PER_PKEY 2
 #define AMR_RD_BIT 0x1UL
@@ -57,7 +58,7 @@ static inline bool pkey_mmu_enabled(void)
 		return cpu_has_feature(CPU_FTR_PKEY);
 }
 
-int pkey_initialize(void)
+static int pkey_initialize(void)
 {
 	int os_reserved, i;
 
-- 
2.19.0

