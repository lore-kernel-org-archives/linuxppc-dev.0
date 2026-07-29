Return-Path: <linuxppc-dev+bounces-25019-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C015C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 14:54:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Fj82vwZz2yps;
	Thu, 30 Jul 2026 00:54:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785336860;
	cv=none; b=ECYj5VuuLsqGAtCW+rGuOSYKPtVYItrxgQMt6TRLGBOcdv41aKXkz3VcSTKnsr+FY9mAsJ9kT0/mkYGLVHUYf/u8YBmfthFHE64PDwJROwc5B6XiiKL+2QQCM5iKEyt+gJsP1BKcUDE0PoGDevku44G5T2pRQGM5W6q3nr9xhG1A99wA8LVUFD51lDV6wxl7yCoOLxA9yQPyZmDzJDYBJhCg92iliPGhIozTV0hzksIc362NXvoQ1KQRDRNX99fRIsfey1eXl78439NbtEckLUwfDqVdyafR3XYjNYVzViX8bQPXM6FYjhQGMdaD/JQ3Mm/B7dRtqpzu8dYOr+0FAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785336860; c=relaxed/relaxed;
	bh=rwBLBpLGiusQn3U5DPKBs3ULyYvdoXSWjqaddnR4kr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UsbGv0iMcUqYDIpmgibtbsP1bk5OgYKEEcuSEylkTrQuhGvuC4+N/uJB+UFNQdE0cxgTxkfBzIAGMdWEajpawzVAMGs3tyhVSmX+Htq+ADM3GAvLO5K0pZfmWpvBO3wJ/EreIFf0Wh6TbUq2nATpXKoucIwBrr2NSI4zcol0RDe3IEmPM3xkBfaXVvzHTpoyx/12r1lS6s6a7E7+EoKNQrwUR8C9/ZPL1wQqXunQJCFWeYeGhtuqW/PNA+yYUxK+xCngwIe3Z0EWgIMdal7VEAlnLzQ3ofYggVx1j7McCWh72G4fVTJRNMDiwxp7Ug/CmyZafhpxrfL7cOaBgEK+BA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OHx83Ab+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OHx83Ab+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Fj711tWz2yks
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 00:54:18 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEm6Wi290630
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rwBLBpLGiusQn3U5D
	PKBs3ULyYvdoXSWjqaddnR4kr8=; b=OHx83Ab+/yA7RgIIWKQpG4pAfN8GI+Kr9
	kw16R7pVBlAOOWdM9+NOkOHv/NmRl0LAptpUFp3L7twVN4iHlh8WoYlFLLhdMQQH
	GwlyW9CSVl2lVxeVUByL+M+00V3vDy6PT7/jP+G8qePFUHTAeZOV9XHIy1yFJiEo
	2P0lgMTjegBLE4cmKlzhh0PSb5irXBU9LRjQABCgVOK+XdC1L0oYJrTPPy0lvWJM
	P4olL2A91evP13toSoCf5w/WqynHA81hRwFNQB1+rj++OUwklshi6BwSM406i8fN
	Nvs/Dx28Qlf0qn0eJjbS7zqX/RjGvmlA0gyhG4Lwn9z3O/Vsvbf2g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7k83p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 14:54:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEfLGA029151;
	Wed, 29 Jul 2026 14:54:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk75mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 14:54:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEsCj335520784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:54:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B85E020043;
	Wed, 29 Jul 2026 14:54:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 733E020040;
	Wed, 29 Jul 2026 14:54:11 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.23.158])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:54:11 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/4] powerpc: Add Power12 architected mode
Date: Wed, 29 Jul 2026 20:24:04 +0530
Message-ID: <20260729145405.3230272-4-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729145405.3230272-1-mahesh@linux.ibm.com>
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
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
X-Proofpoint-GUID: RxrAq03o7Use9JTeHsHHDVOnTdQS5guE
X-Proofpoint-ORIG-GUID: FjA8wP5-KTVcV-oa-qh_--wVWSTiCijC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX0pjiALrM9YU1
 3cSH4ph6hzgcK2kf0gS/dkUNjcr5tGDIOfpm9tsBKj5iwGFZSiigZuEeSVWK9rc6J8/NnjrneE1
 D3n9/wqXowMRBmmLNjIoygVJOJYPJ6tQGVe5DWEQXKJDQbz64WZwcWQ9l+Ce56Zf059wUTci/2j
 Ph4QJVmpwS66stBpEdfZfe+/xG6FGpIX0rjjofOrn3As+t7iADWu7ei8gbwqp3DvS+ebZvQVQ2w
 Cm42UixGD1Be4dKz/uA5zKNkTbM746L4Yqvy+vuLQUSTgLOgim6GgVA1uo4/9AWQvMNfOCYSbNb
 ARQ+xAc2G78p5RBvdYmTQvGlhwDsUAc7BcHxa6Lq1qmzTmGZDAPvitf68n9hOKjhSGleceUr8nB
 PL3Ttq3EdFfqvZaDiFMcMtVBItFUElXDhisGlKTSUDdjK9iMLF7Qdg7HENsWsvJNXGhHmvR99/C
 WDafqZbI47CZtF3fivw==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6a1418 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=MTFVyhIjbT-r1TZvI9sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX/eGOup4TbdzT
 yB3OoW70Xelw34l4x4nbkfqjFNlfBe0MUK3JNa3E+fDfmEIW/dwUXy/Yq8sLHIU7X/+LFFSyANz
 UL/Q9kVQ+KBDL2hpOPFTp7UIH7/UdLE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290120

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

PVR value of 0x0f000008 means we are arch v3.2 compliant (i.e.
Power12). This is used by phyp and kvm when booting as a pseries guest
to detect the presence of new Power12 features and to enable the
appropriate hwcap and facility bits.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
---
 arch/powerpc/include/asm/prom.h           |  1 +
 arch/powerpc/include/uapi/asm/cputable.h  |  1 +
 arch/powerpc/kernel/cpu_specs_book3s_64.h | 14 ++++++++++++++
 arch/powerpc/kernel/prom_init.c           | 12 ++++++++++--
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
index f4991d10d89e..cd025c7225ee 100644
--- a/arch/powerpc/include/asm/prom.h
+++ b/arch/powerpc/include/asm/prom.h
@@ -118,6 +118,7 @@ extern unsigned int boot_cpu_node_count;
 
 #define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
 #define OV1_PPC_3_1			0x40	/* set if we support PowerPC 3.1 */
+#define OV1_PPC_3_2			0x20	/* set if we support PowerPC 3.2 */
 
 /* Option vector 2: Open Firmware options supported */
 #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index bc9bd225f587..68215b7ce67e 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -53,6 +53,7 @@
 #define PPC_FEATURE2_ARCH_3_1		0x00040000 /* ISA 3.1 */
 #define PPC_FEATURE2_MMA		0x00020000 /* Matrix Multiply Assist */
 #define PPC_FEATURE2_ARCH_3_2		0x00010000 /* ISA 3.2 */
+#define PPC_FEATURE2_DMF		0x00008000 /* Dense Math Facility */
 
 /*
  * IMPORTANT!
diff --git a/arch/powerpc/kernel/cpu_specs_book3s_64.h b/arch/powerpc/kernel/cpu_specs_book3s_64.h
index 7619dd157646..26fa40aa34db 100644
--- a/arch/powerpc/kernel/cpu_specs_book3s_64.h
+++ b/arch/powerpc/kernel/cpu_specs_book3s_64.h
@@ -303,6 +303,20 @@ static struct cpu_spec cpu_specs[] __initdata = {
 		.cpu_restore		= __restore_cpu_power10,
 		.platform		= "power11",
 	},
+	{	/* 3.2-compliant processor, i.e. Power12 "architected" mode */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x0f000008,
+		.cpu_name		= "Power12 (architected)",
+		.cpu_features		= CPU_FTRS_POWER12,
+		.cpu_user_features	= COMMON_USER_POWER12,
+		.cpu_user_features2	= COMMON_USER2_POWER12,
+		.mmu_features		= MMU_FTRS_POWER12,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.cpu_setup		= __setup_cpu_power12,
+		.cpu_restore		= __restore_cpu_power12,
+		.platform		= "power12",
+	},
 	{	/* Power7 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003f0000,
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f4f92cdaaa6b..0d54718b0929 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -947,7 +947,7 @@ struct option_vector7 {
 } __packed;
 
 struct ibm_arch_vec {
-	struct { __be32 mask, val; } pvrs[16];
+	struct { __be32 mask, val; } pvrs[18];
 
 	u8 num_vectors;
 
@@ -1015,6 +1015,14 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 			.mask = cpu_to_be32(0xffff0000), /* POWER11 */
 			.val  = cpu_to_be32(0x00820000),
 		},
+		{
+			.mask = cpu_to_be32(0xffff0000), /* POWER12 */
+			.val  = cpu_to_be32(0x00830000),
+		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 3.2-compliant */
+			.val  = cpu_to_be32(0x0f000008),
+		},
 		{
 			.mask = cpu_to_be32(0xffffffff), /* P11 compliant */
 			.val  = cpu_to_be32(0x0f000007),
@@ -1048,7 +1056,7 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 		.byte1 = 0,
 		.arch_versions = OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
 				 OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
-		.arch_versions3 = OV1_PPC_3_00 | OV1_PPC_3_1,
+		.arch_versions3 = OV1_PPC_3_00 | OV1_PPC_3_1 | OV1_PPC_3_2,
 	},
 
 	.vec2_len = VECTOR_LENGTH(sizeof(struct option_vector2)),
-- 
2.55.0


