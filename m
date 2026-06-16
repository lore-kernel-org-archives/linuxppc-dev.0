Return-Path: <linuxppc-dev+bounces-22687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D52CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:14:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfcCX2gyjz3bqh;
	Tue, 16 Jun 2026 16:14:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781590488;
	cv=none; b=de61pZ0gJW2MNp1P8vYJz52dfcoKd3ZHBinhnZFgDM16YuPzffXhRNoSxqqjtdEEaL/5EYbSdRJD/ZPXian4mb0IL4FJ85pnZCMHtLKOVMJ7nDpvXC+ihSx5ICkDkYdRovEs9RNoniyFy1EiXSb20dRQtDINb7SIIiMRq/yXVa3nojto9BityPgmtRjULZlbAKRfe68tXlvdKgXovMqHcEE5gbdRUZK2UuZ7WqIDuwo/tX3aHgtwWoGuOVWg7hV4j3gYbWc+rm6KfTLzWYM6LqH/3DgYhQJ1E3SqAgio1JorCrAT1aP8bUzRnwEVyZWnrbPMiIkbODBXmyI9gcZFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781590488; c=relaxed/relaxed;
	bh=rlU5BcaXnAnX2jMdjc2PrtoT7Aax1X+MrdrRVe5g3n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYfiILLXI3ZllVoeUX/wGy+7/mPnc5SrsFFY3gAOC+/2t26SCzU51ohkwn26OQcCH1auXflrsTy3E1kOdFTpXfMWXLxRch6nCXvQBA681X00lTj1GPQI3zd3EZEmkGNzURYh+fCeIc1CenspFAKyzByNFZtDUjDn7jdXyvEh6Qc/VwvszfQzinXxHwQfbG3iO8/cHBhKVE23k7Nf/dzD1ePATgsw3idFkuETH0N1A3ia4TPxoRtIJ0CK/Ql2swSnso+MRpEVAoLsBHwkApNvDtrmtJ0qbBdh5rCsXhaIMYfGIRc9rVCgctXI567MlqR1k9nFkJAmLABlzhyLMdUYIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BghTmB4/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BghTmB4/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfcCW4nJbz2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 16:14:47 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0nHgT4002463;
	Tue, 16 Jun 2026 06:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rlU5BcaXnAnX2jMdjc2PrtoT7Aax1X+MrdrRVe5g3
	n0=; b=BghTmB4/nJgew6Fj/EpkGLUA1F6JedLoqyES97fKREBtHxDOBoKCXVljr
	NhGJfuEbRcnAChMBJAx8tcYpJtUxJWBKwOYpYL3gzcwZAIKSqjpPiLcubs+vgVVf
	zF+Fprqsk7vbK1SOSrJdJE9kwnCTNSYviZww0oE26wTixESRe4NpF/T8yXBdFuiE
	O1spOjWeJzsBIdGYxXGJ6y4Q7aov0YeN/MVrWzTfLhge1abkekUKq8ah/WXQqjRD
	Y/KiKhXDgojfn66wczqPXzasBz6+tzohDfOdvWDlRyfu8oY6gcvDlvQOqiRrv1RD
	pT79/1WSBGXgOBgg1c0GykahFWOWQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h8481f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:14:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G65uUA022211;
	Tue, 16 Jun 2026 06:14:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhq26j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:14:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G6EdRs50069842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:14:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9548020040;
	Tue, 16 Jun 2026 06:14:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A24120049;
	Tue, 16 Jun 2026 06:14:37 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.ibm.com.com (unknown [9.124.214.227])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 06:14:37 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        Christophe Leroy <chleroy@kernel.org>,
        Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v3] powerpc/fadump: define MIN_RMA in bytes rather than MB
Date: Tue, 16 Jun 2026 11:44:35 +0530
Message-ID: <310b040acef712fdc79e3e37d0f4c2213938b556.1781589284.git.sayalip@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX/8Mi6OVMkOuX
 QJNagnqa5UH779nuXniEtg+E6Ph2s39G7IYLsr/usi6rrElOOhjlTZXUyLFDH5QD9XZD1PBS2x3
 iT97Aa+/lhh2/fSw9YhdkNZ2Prh3cYA=
X-Proofpoint-ORIG-GUID: JlEgJbzQi-XtYL1Fwib994mS5ewkrXSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX3RHNs8gnLo9M
 P18yGsqm60t1LqqeDstwklEJS4eh0RxY+/PN6tDZS+SLnx27Bp3KUw47UAw1izDsnsEFzJr1L31
 zrgTb7Vd0o7ItqJRh+gkBwn89R9HIY28zqUo22sY7kf3rl7Ggu0olTJYc7Esm92VoSu9IouUcjd
 B6N0HnTphF+DOKz4umPYnQPm9FHltzWIk4sjSUkS8mqxyVuH5jWQ3+EeUqJ9bkA4lOl0UXKkw7B
 rmBy1+mKWuY34Cf/7DtEJKPTYY+bETcF6pTg4ALNapnXWBqre7BvrVuxASIAkHfgZrmUsXZ50cK
 ZQWVVZyTFc2OiQI4MSJrnoBVGnIRXC1JjZphaR9R1rh0Usiq10woANwstArkKJ6M5qdIgszyyfI
 jMYoKFDnTK5W5Lf921JMti3+GxnmHYe1CHiwCVIp1LgHEWTThaU43+5vwKW5xh3L4UU8SzrtzhF
 jRFJhRa5qm6tpw1kfpw==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a30e9d4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=V5IkddXKl1bmZkoB-WMA:9
X-Proofpoint-GUID: MYfToGb-s0yif-vM1WBUoxt619fSUwjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160055

The MIN_RMA size checks in fadump_setup_param_area() use
(MIN_RMA * 1024 * 1024), which is evaluated in int and can
overflow when MIN_RMA is increased to values such as SZ_2G,
triggering compiler warnings such as:

warning: integer overflow in expression of type 'int'
results in '0' [-Woverflow]

Define MIN_RMA directly in bytes using SZ_1M and update the
callers accordingly. This avoids repeated unit conversions and
prevents integer overflow.

Also convert MIN_RMA back to MB when populating the firmware
architecture vector, since firmware expects the value in MB.

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Sayali Patil <sayalip@linux.ibm.com>
---

V2 -> V3:
- Commit message rephrased.

V2: https://lore.kernel.org/all/a9d56fe88218a7034296f1974568543a0ce2d973.1781265400.git.sayalip@linux.ibm.com/

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


