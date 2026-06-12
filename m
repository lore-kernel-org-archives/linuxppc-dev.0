Return-Path: <linuxppc-dev+bounces-22553-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE11CD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 12:02:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcJ6n1PPlz2ykX;
	Fri, 12 Jun 2026 22:02:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781265761;
	cv=none; b=H9fHajxsWurXKaXgJ1saF5cCCs7cWCBJOh5pKS0j7bb5Ej2g04te4cxqlF6RF/f/IBTGVuXz4RdnUwskjWsyYmR3XkoFNLbI1GdPBYglVIuf/XrClKyolFhuLQMeir9K36dkw25STdK53OcWHvtHLB0YpI0cHutxhyd6CjajWMTSHYBUdDBja62a+Na062yyesKmKWeXDVWZSDdJJFAUW2Hqx2f5sCnj4E5MQJNcFNaRvyDrgsuFncSgVX34NzF+x5au0caIa1mqWficvUweBVtgI4R15yaJTvIG9sRsrbmZL7GBu2DhlHCueeYen+ug2Lg4ZAc7Fuq9dAt+9lW3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781265761; c=relaxed/relaxed;
	bh=wz2ikP3Nw2GSt6Y/722QnYvuk7BcnHAtqYwQfInxAtw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NFSWUhLBNJLiF6zYw3s/MjipPUXQNpFx/3YQf9B9CenJlP1qDqPntdzdvUljBqgApQBGf4OnjYDuvZ0KHn0aL1uaclnocFffU5XmHHDkKHiNZGepCoyKuIk7Fa5+Y7a+7b2B5nIwkx9Wn35UH2eYC/3a7ZyIKVRWBe4L7jkrV3V697lHwVqd7es5GCMNFS5M6gWvPg8A5raRaHUt6N812JQHZMZQ9Nih5jshhcOaT7OIDF+ekhAonb2yFNwdc5m9d6qFJ+k2IGJe8YK0V327aKRFnD0wsH3rTv4xbuwxwTUOmH3tLx/8VK0VSiU7nJmn+kueIBs0MDk50f7/hx8XUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AkuPZp+u; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AkuPZp+u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcJ6l61NKz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 22:02:39 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C005hg3872908;
	Fri, 12 Jun 2026 12:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wz2ikP3Nw2GSt6Y/722QnYvuk7BcnHAtqYwQfInxA
	tw=; b=AkuPZp+ud3SnDNt7fu4CTVz8ENODxTMqvCXaRRdPjcAbNAHTTCv2mHbFo
	x+YsVQu8iSTdy0sSBgW3vzFEZGA+oPd62Nz7BeOQk/fJZdnIbMP/z1C3mRHQRtQg
	WAJrWsbA5d6ImxW3dy12Yko+DiUsJe2jVxfvzuRQ7N9+RJwpEDSTQVZMiFT1Z5H4
	TBAbrBxU/54T+uR7OroQ5ivBqw2PwMnHs7YDNhq1ifJN0529maojHPWgduJu+y04
	JEMVU2DJcISDP1ZQTP03HC5AFNSTUJzOrn4Aa/yAY/C2gwz8kPBDoFU3LSmfIgUW
	8c6GSTTMrELQW5QTqP27bbSTn/ffQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8f0swu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:02:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65CBnhu2031852;
	Fri, 12 Jun 2026 12:02:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09qq6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 12:02:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65CC2MjH37028262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jun 2026 12:02:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F30D2004B;
	Fri, 12 Jun 2026 12:02:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29DC420040;
	Fri, 12 Jun 2026 12:02:20 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.211.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jun 2026 12:02:19 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        Christophe Leroy <chleroy@kernel.org>,
        Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2] powerpc/fadump: define MIN_RMA in bytes value to fix overflow
Date: Fri, 12 Jun 2026 17:32:18 +0530
Message-ID: <a9d56fe88218a7034296f1974568543a0ce2d973.1781265400.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEwNiBTYWx0ZWRfX4jGFIlIxTBUN
 2GRn0vZljHjZY5kDqP1RI1eeoOksckZsnED0EusRtGImrOFmtyqCXbKMuIGlWLffEMmosDRuKsc
 jhT1lJG62n7sHnzNC+5GBbAHbY+wD/GQc/L7RP9K81ZpDxxSMuU0oXjZDRQPnQEE9vMTTavyslF
 3IMC7zGXpuWxalyuW5zHyYPdn9ElMaQGbGfbeJvg9HIXHxGmQ01wR4van11syOLcUiWBnwpF/EH
 kXKBa9sbcvrk8QLRBsc3TLAC4kc9FtKIfRjMbVVzx0fIJVj1bFhRvnjwwC2rJgLu/vQh3MFve8f
 vui8qSBS9+MsnOezWMRQ09uY+zrUtflJbqLeFK0WMzvMHWG21JBiGdPvK8QwlQeIRq4CBSLNMk4
 pR31Lu56QDy07Wr93ULen7aGrRlk24tPD4I5aZLa61HrOLmXUjJvMmSKVInua2/FzqPuLUI8UoK
 P6NoDpGS1UqWE8QKVag==
X-Authority-Analysis: v=2.4 cv=dr7rzVg4 c=1 sm=1 tr=0 ts=6a2bf555 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1i_jHMy692ru-q50ErsA:9
X-Proofpoint-ORIG-GUID: fqA2s5MBrWjCBfi2dtlvnK_CUggccUmN
X-Proofpoint-GUID: QIMmEXVxx0_Gw62XlHNBI8bsbC42R_z2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEwNiBTYWx0ZWRfXylL2bUj8I+KG
 VOfXNeyPvu2IKNgv6vNmLvZOLqw+5VVe14xHYKW/JLeGQ0ptEIqGnfWsRNjK+iOkb7nnPntT36a
 cskPgmcePkZKiiopTTuYWhfg/uibaLI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120106

The MIN_RMA size checks in fadump_setup_param_area() use
(MIN_RMA * 1024 * 1024), which is evaluated in int and can
overflow when MIN_RMA is increased to values such as SZ_2G.
This triggers compiler warnings such as:

warning: integer overflow in expression of type 'int'
results in '0' [-Woverflow]

Define MIN_RMA directly in bytes using SZ_1M and update the
callers accordingly. This avoids repeated unit conversions and
prevents integer overflow.

Also convert MIN_RMA back to MB when populating the firmware
architecture vector, since firmware expects the value in MB.

Fixes: b7bb46062457 ("powerpc/fadump: fix additional param memory reservation for HASH MMU")
Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---
 arch/powerpc/include/asm/prom.h | 4 +++-
 arch/powerpc/kernel/fadump.c    | 4 ++--
 arch/powerpc/kernel/prom_init.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index f679a11a7e7f..f4991d10d89e 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -12,12 +12,14 @@
  * Updates for PPC64 by Peter Bergner & David Engebretsen, IBM Corp.
  */
 #include <linux/types.h>
+#include <linux/sizes.h>
 #include <asm/firmware.h>
 
 struct device_node;
 struct property;
 
-#define MIN_RMA			768		/* Minimum RMA (in MB) for CAS negotiation */
+/* Minimum RMA in bytes for CAS negotiation */
+#define MIN_RMA			(768ULL * SZ_1M)
 
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
 #define OF_DT_END_NODE		0x2		/* End node */
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 501d43bf18f3..bb41150b363c 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1759,10 +1759,10 @@ void __init fadump_setup_param_area(void)
 		 * 2. The range should be between MIN_RMA and RMA size (ppc64_rma_size)
 		 * 3. It must not overlap with the fadump reserved area.
 		 */
-		if (ppc64_rma_size < MIN_RMA*1024*1024)
+		if (ppc64_rma_size < MIN_RMA)
 			return;
 
-		range_start = MIN_RMA * 1024 * 1024;
+		range_start = MIN_RMA;
 		range_end = min(ppc64_rma_size, fw_dump.boot_mem_top);
 	}
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f26e80cbc615..53503937de0e 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1061,7 +1061,7 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 		.virt_base = cpu_to_be32(0xffffffff),
 		.virt_size = cpu_to_be32(0xffffffff),
 		.load_base = cpu_to_be32(0xffffffff),
-		.min_rma = cpu_to_be32(MIN_RMA),
+		.min_rma = cpu_to_be32(MIN_RMA / SZ_1M),
 		.min_load = cpu_to_be32(0xffffffff),	/* full client load */
 		.min_rma_percent = 0,	/* min RMA percentage of total RAM */
 		.max_pft_size = 48,	/* max log_2(hash table size) */
-- 
2.52.0


