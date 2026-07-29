Return-Path: <linuxppc-dev+bounces-25018-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5476EC54F55
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 14:54:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Fj674nJz2ykc;
	Thu, 30 Jul 2026 00:54:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785336858;
	cv=none; b=WjWG9h1vZvp4JnJ9PqXecTMXOCiMynR/pcy7KOPL3ihtWAQQ7OjICF8rrI7FTy/lsUirhK/SC08cevjlJ4oVFVyJ34HNqRT4klsdAoHNsf+BH7ZyE2/Z5kXDSt/0X9fdVLETLWTda54vJrygYLjaXQtHbtaTL+kap9IYt7q8enR2Tr7B3wlKXN4HaMupO0J22gRM5smvtsE0uVC4ZVEIYpnwv0XaKiieKeRsZ1XyAoq42j4khktL71gt29/bv6mY27jXhqT9DL85oHvBs48vKochts20Gr/1YbYIfLh7sxDuG5hESrRNFUNr00Dy+yrfdceX3NpitxlRELlG7EHpdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785336858; c=relaxed/relaxed;
	bh=qNaaHMufRXW1kXyosKdni9E+BR25zsAdXoQSm0wVNS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luOa1u6vGoMWS9W2XpA5bWZZ6e4I1m9F6iqP4YJO9Ta8l44RGX7cJyU0wkJe8ggEp/iumEOMsHk11373owfhI0sjm+tJB6LdgZXsfZxMrt7T0RzVrwLdslqETtqq4umDxqB9nCREiovCQbZe5xEAHpiwko0ENwUsTCHIQxfRZFdRsHH0E6DUtg5ESf08sfJV/G3y8uJEMhszzyIg1eLQu9BicqNIU7leKu6FfYc7sKgEnlpVeoNCo693a4mOkxOFBUNcHFcQ4a7W9XTgFzf/2vqKCTcwMzCKGFHkrzGXcnbx3zG5I89C/xRELITsWwwxFcPebsSuLWoWEjDxB31drQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jM95R15z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jM95R15z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Fj539Sqz2yDr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 00:54:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEmQvV213395
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qNaaHMufRXW1kXyos
	Kdni9E+BR25zsAdXoQSm0wVNS0=; b=jM95R15zAx7V8CWsmx3142gkVzFEPsiFy
	SeNpug+ZRoLuAAqA0HoeXGVT6uxxgx59FEkQVqGMzffXgr8wGxFqfh1q5mw60iWz
	JRah3vSFOcWIFjn/0BILRx/rdHGn9N+4/ijsDIoYRaV/LJQFzKNLKyYr7EqgMnCf
	+Lc00pi5izOMgbVQ2nakBA0aGPRVagfwqqV7oD7DnB8fG60aUIRElGg0zAA4zD8l
	EDvoIX3XeApQgPt7Nel1vkCeszfGJh9lZnD02QAm19kCe5PZUpXBEpaNUOsWu0m9
	8J8B0VaLUnTHiPquh35txcv/VvPDP7gvndNL5wnRjfZcz2TFVvMXA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjaet5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TEfKiI007381
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhf26t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 14:54:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TEs96P52167124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 14:54:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44A8820043;
	Wed, 29 Jul 2026 14:54:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6456220040;
	Wed, 29 Jul 2026 14:54:08 +0000 (GMT)
Received: from jupiter.ibm.com (unknown [9.39.23.158])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 14:54:08 +0000 (GMT)
From: Mahesh Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 1/4] powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation
Date: Wed, 29 Jul 2026 20:24:02 +0530
Message-ID: <20260729145405.3230272-2-mahesh@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXwsGBRgy+by5h
 GNnwaRzVRm3U/7d3L5Fee68ox5j/vzOl8ilNUZKunwVzAUsM2R6/EVOQyQSOiEfcts83eagS+/z
 lHHNrThlqIu/aw7MUS3r0ZAOveV92cE=
X-Proofpoint-GUID: 9MjF7PRNqkRtAiCf9c5gpAgttGPl4wGk
X-Proofpoint-ORIG-GUID: 9MjF7PRNqkRtAiCf9c5gpAgttGPl4wGk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXyhmB70BjB5Aa
 WMxaz4KwNyUz144Rzv+0JcLgzPd9Jrszg+gNyIcj4Mppqo0wC5k/xwhhR8F7+B4VVG08cWVzydd
 8hONKaaR28pbXAhviChYt7TOOF9Ddlxc66vNfV6d5oC8y0PmzDSY3IPmDmRsCrOF1tA1ZCe5WfM
 f0RPVYJuS0g52KS2xfNrjF6T82HrDgo9xz41EIM+orcwgHPs7RiZvejSoMOTDnrca4iL3yQJ5sK
 8DA0H0quaxOFqDjWV23TVLYmHtZfq5jhcYakKVrP3en7uUqRKOlPz6pkPWnAXugfWgOH1scDC1L
 mkqy0ASrpIh1pWdvRhEabv+QiCmnsjHQCsLK2LekfShvMXP3rIAYWQHYjN5YG5W3o5uOJDyewJx
 TrP5MfEdzEbg0WAziDMHTdayMt75FhG8T/+ZW97oYJTZ5w31AuqPQ2A21q820YE/FYGS5BCP8p0
 jbxKHG3uWLOQvBZRStQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6a1416 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Ae8wxykVshGZFWyNThcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290120

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
---
 arch/powerpc/kernel/prom_init.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 53503937de0e..f4f92cdaaa6b 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -979,6 +979,10 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
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
@@ -1032,13 +1036,9 @@ static const struct ibm_arch_vec ibm_architecture_vec_template __initconst = {
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
@@ -1347,7 +1347,6 @@ static void __init prom_check_platform_support(void)
 	};
 	int prop_len = prom_getproplen(prom.chosen,
 				       "ibm,arch-vec-5-platform-support");
-
 	/*
 	 * First copy the architecture vec template
 	 *
@@ -1403,6 +1402,11 @@ static void __init prom_send_capabilities(void)
 	ihandle root;
 	prom_arg_t ret;
 	u32 cores;
+	int start_index = 0;
+
+	if ((ARRAY_SIZE(ibm_architecture_vec_template.pvrs) > 16) &&
+	    (PVR_VER(mfspr(SPRN_PVR)) <= PVR_POWER11))
+		start_index = ARRAY_SIZE(ibm_architecture_vec_template.pvrs) - 16;
 
 	/* Check ibm,arch-vec-5-platform-support and fixup vec5 if required */
 	prom_check_platform_support();
@@ -1427,7 +1431,7 @@ static void __init prom_send_capabilities(void)
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


