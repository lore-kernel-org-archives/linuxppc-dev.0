Return-Path: <linuxppc-dev+bounces-25280-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C89C55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:57:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDLss4r6Qz30NF;
	Tue, 04 Aug 2026 01:57:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785772657;
	cv=none; b=BUuwHYLzY8yIytRDbdnZNuqTKm4ExAxY5hYDuUqMFOcN9VZpMKpkX1e2kvs3VRiPcyhCrBWise48nhE9FO3dz/fEVHujdAqVh4cnZm5j1HYFLFfiBj3aZ1Qp1UU62ZslDhcAdSyOzYsrdNna6ZsZ4thSk87DX3p+GwLRPcpKIiU5S/9kLS3YO8Hzc/4ejFHTLL+myOrxyYW1fgMfsj1bgkloEhTXJj9tSZHaGXN5H4qPDTTP1+n0QghLLWACe7Tmts1vhOmQwm2WjOMC+MOwgJZTPn1dWfSxRzvmwxFyZfgi4pwDRZKvBOcjZP9z8YErDMnpndwKXBh9kd2+szkYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785772657; c=relaxed/relaxed;
	bh=Vz+/LM8LCnZwseX8VfY4MCeaNPXzCiQwMHjJdPZHzz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvGmEZZxYPmfzvTQ6tIkIUNFufXDtzqY3Q1DSHQObK4DnNnfhdL4yWkapW0i/RAXZsWqTUUobliMIsd3l1OxIdjjAcOjwLsDA26dKZ6Bu+/XuMyZaa/FNtHU//vPqvCPm+DPx+KQ6e4uUFE1SMiCkjHrVVBwZN1Yo0g98i0Knl+ouAGh591dZSgMdFll5ldnzvPIXGOPJAYbQ8Vn6czNOYuJtX/TNMRAdbjTwciGZXA4HZwWnqHhT4PcWz2hLybgicuKnWFe0EdgjNJGoXiqjok87+v8j6lkWDo1bbjvNrhAnLgua3HWLaoVCNT8z9WOsVb+reEh5OTVOfrd33Oo+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QuPbbZ5o; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QuPbbZ5o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDLsr3cBzz30DH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:57:36 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EI1NK2341775
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 15:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Vz+/LM8LCnZwseX8V
	fY4MCeaNPXzCiQwMHjJdPZHzz4=; b=QuPbbZ5oh32M/0Y0qzj3ZwD7KNi5pBjQd
	i1Z7XlJHFPNP5wvej5l3UL5IZqGrxVyP5Z55c8ZuKPojT8N+/il/9SqIe0XlvG5V
	ui+8VQpE2fE0BOvkkgqGl1Z3eg8l0v9JdJa3zkC+YUpn/PCACvMJ1BBymX2sT5Fd
	Mq9oz0ClPd288YBrYygqRLWPkYgVKKxA9Ga+kP5Icl4wVcsAwUsb7tuoxwqO4+dH
	QW0Mq4gZfG/ccB2dWNN1pJQVGD54q6dFkh6lshYF+3RDOzolGQjnSb59jHUTQw+T
	NPnujdBZTxN9fWxbMo9ElQCWhzHzAX6fBa05HXqHXfT3UFgHwsjVA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8euh9ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:57:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuHPU001201
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 15:57:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvx6s9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 15:57:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673FvSBe50004430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 15:57:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EBC12004B;
	Mon,  3 Aug 2026 15:57:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8551820040;
	Mon,  3 Aug 2026 15:57:27 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.27.35])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 15:57:27 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: [PATCH v2 1/4] powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation
Date: Mon,  3 Aug 2026 21:27:21 +0530
Message-ID: <20260803155724.3272052-2-mahesh@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803155724.3272052-1-mahesh@linux.ibm.com>
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GMMhJrvSNwpzzpzBKg35FRgJS9FAQPvY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX1XMacCDX8AVD
 NUJUqfVsyhX1j/suJvSISXmR7Dc3d/Mf6OvbvuGSaAT39aG+0ubWz1uKERr+Ig9PSBnwpbQCLbI
 Xfxkhcsub74RWTSXgiIY7VFHqf/6AJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX2DVAv/+XCsEF
 /QT+b+rt23yLp7RHS9YexcNw0gfQd0im+wLZNixH1Qdncg7PRyYoHLi2SA5f/q8g/ZDmGgafypR
 F2OEH3YEn/pgvEemq31s8XJRB9auEZrFrJenBLVNNskakPoz/M4rCZGcNyYSkKtvMXeUV1S3eGh
 tcPMxtXb001XizxC+VlnE5yRFVTeRkMW0ZykEKlGlMRbZgaztlvxb1pTt0MeXls3H94M+QWM1kx
 s6/BuD8dqkkz1xNVCj0hoXAMvun69K8e9C79+wXYy1I/UMU3rxJ0SnBBazeI0Cbw9LTEbZ46Am4
 q9xb1QlSZrb/26I5mnPaDuO6JKzyK+MaVqHhTxS+MvguXj5TLhcTwYvytcaDIkIV6UxiOuVUcJO
 EebtZNjqF1vQrTrYFbIRPLqvQ9ZpqgOz0E5TchsP0C9DYr8cWrRGDwofBdKw8/CMuA4T/oCgPgM
 6rxWo5TiRhUpMmccvgg==
X-Proofpoint-GUID: GMMhJrvSNwpzzpzBKg35FRgJS9FAQPvY
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a70ba6d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=BtEmzuLscOc4H7GTDRoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

Current Power system firmware caps the PVR list array size at 16 entries
during CAS (Client Architecture Support) negotiation. Passing more than
capped size to older firmware could cause an undefined behaviour and
breaks compatibility.

Future Power system firmware releases will lift this restriction and
support greater than 16 array entries.

Ensure that when running on Power11 or below hardware, the number
of PVR entries passed during CAS negotiation does not exceed the
firmware-imposed limit of 16.

In prom_send_capabilities(), compute start_index to skip the oldest
leading pvrs[] entries when running on Power11 or below hardware, so
that the pointer passed to ibm,client-architecture-support points to
ibm_architecture_vec.pvrs[start_index], presenting exactly 16 entries to
firmware.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
---
Change in v2:
- Define a named macro CAS_MAX_PVR_ENTRIES
---
 arch/powerpc/kernel/prom_init.c | 35 ++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 53503937de0ee..6b50870759fd9 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -86,6 +86,12 @@
  */
 #define ADDR(x)		(u32)(unsigned long)(x)
 
+/*
+ * Current Power system firmware caps the PVR list array size at 16 entries
+ * during CAS (Client Architecture Support) negotiation.
+ */
+#define CAS_MAX_PVR_ENTRIES	16
+
 #ifdef CONFIG_PPC64
 #define OF_WORKAROUNDS	0
 #else
@@ -979,6 +985,10 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 			.mask = cpu_to_be32(0xfffe0000), /* POWER5/POWER5+ */
 			.val  = cpu_to_be32(0x003a0000),
 		},
+		{
+			.mask = cpu_to_be32(0xffffffff), /* all 2.04-compliant and earlier */
+			.val  = cpu_to_be32(0x0f000001),
+		},
 		{
 			.mask = cpu_to_be32(0xffff0000), /* POWER6 */
 			.val  = cpu_to_be32(0x003e0000),
@@ -1032,13 +1042,9 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
 			.val  = cpu_to_be32(0x0f000003),
 		},
 		{
-			.mask = cpu_to_be32(0xffffffff), /* all 2.05-compliant */
+			.mask = cpu_to_be32(0xfffffffd), /* all 2.05-compliant */
 			.val  = cpu_to_be32(0x0f000002),
 		},
-		{
-			.mask = cpu_to_be32(0xfffffffe), /* all 2.04-compliant and earlier */
-			.val  = cpu_to_be32(0x0f000001),
-		},
 	},
 
 	.num_vectors = NUM_VECTORS(6),
@@ -1347,7 +1353,6 @@ static void __init prom_check_platform_support(void)
 	};
 	int prop_len = prom_getproplen(prom.chosen,
 				       "ibm,arch-vec-5-platform-support");
-
 	/*
 	 * First copy the architecture vec template
 	 *
@@ -1403,6 +1408,22 @@ static void __init prom_send_capabilities(void)
 	ihandle root;
 	prom_arg_t ret;
 	u32 cores;
+	int start_index = 0;
+
+	/*
+	 * Ensure that when running on Power11 or below hardware, the number
+	 * of PVR entries passed during CAS negotiation does not exceed the
+	 * firmware-imposed limit of 16.
+	 *
+	 * Compute the start_index to skip the oldest leading pvrs[] entries
+	 * when running on Power11 or below hardware, so that the pointer
+	 * passed to ibm,client-architecture-support points to
+	 * ibm_architecture_vec.pvrs[start_index], presenting exactly 16
+	 * entries to firmware.
+	 */
+	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > CAS_MAX_PVR_ENTRIES) &&
+	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
+		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - CAS_MAX_PVR_ENTRIES;
 
 	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if required */
 	prom_check_platform_support();
@@ -1427,7 +1448,7 @@ static void __init prom_send_capabilities(void)
 		if (call_prom_ret("call-method", 3, 2, &ret,
 				  ADDR("ibm,client-architecture-support"),
 				  root,
-				  ADDR(&ibm_architecture_vec)) == 0) {
+				  ADDR(&ibm_architecture_vec.pvrs[start_index])) == 0) {
 			/* the call exists... */
 			if (ret)
 				prom_printf("\nWARNING: ibm,client-architecture"
-- 
2.55.0


