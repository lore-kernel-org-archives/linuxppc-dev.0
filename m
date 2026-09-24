Return-Path: <linuxppc-dev+bounces-28092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC99C98310
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 06:31:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr3r80Rdxz30RN;
	Thu, 24 Sep 2026 16:31:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790231463;
	cv=none; b=PthtS3xlqxGTmzABvGjdJ7v5MbTQYQ+FF4LjTzrl9fPLbAiIcgmD6uQedlEI/4SGHev7rseKdTrQlPMQOTOAonwWeq93An+cjhSVE7Nef86/rh1epESSDcmVo+lZDRyJykrDdXpFtzCYjG0gXbe8Hp2C97U/P2pGMF+wQLfQah1xfGuaQBJMcAEEBlo9xKWe5ODuh432fYOfR3rNhMf2LdTwjTaqRHOFpD/OD+uKaMZvJd5vnRdE7Yi63Sk4X6cce6DT6pkI6YhQWqMNpBsvRUDaJdToCc29xpEtWeHzmUDE3Fk1zmhrbUAfaToK2V5h4FwKvu3zxfvPhNFm5xaMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790231463; c=relaxed/relaxed;
	bh=NmsiSWkwnbaD+OPz+kMmMspiHeTRhDK1KZ52ww62gIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmaioLq60SJZVg6A4DiMf2jeReHTJmZg9MO8jz7MirTHCS1JEbH2ByIcxp3GKFeU7De3JQd51KPmN0MqFZjoWCcZi44nZZ/tur9i2DPWe04V+qLDRCZsoW3ZpKJ1FtvSawiGPuisUq9zYUt+HZBTG8qVTBAbKOo0FK2qLjtrTyxax4aLBJYYf4hEM9B9a2rFCkXbfRNTWBe1m5Ln8BuuhQK0ROdn0mwpLWYfElA5dqSkG3HuhxhkAUShrX31BZn3F5XYPcD1av2HyleAr4GjYsu5qvsKVev9QVXm0kD1IFXPc5DaKCFO4cYou2OMI0muYnAv7ZIMQI8DCOrMsFtynQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dq1gAjKg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dq1gAjKg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=jyoti@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr3r65vqTz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 16:31:02 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5bRU73657693;
	Thu, 24 Sep 2026 06:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NmsiSWkwnbaD+OPz+kMmMspiHeTRhDK1KZ52ww62g
	Is=; b=dq1gAjKgA+mwOKPdtlYWhYktUQONVvlWAYGUsv8VcCJtH9is3SG7//P3J
	V4OyqFT1uPqoOmX6lHmE78NcKJwHXSEWzrvCyP1PF/Wnk80svlBzBEmIaOAdJ4pq
	3F4nZMGBMrgvJJAcugyHOaXPT9UWOnYZoI7Qzxz3n3HS2KNzRmp044anqE6zc0EN
	hhTt0gPD1/+LIw3a9hnx3TXRTTppefVAWMGYpoR0DvxJeGJZDgqx55HK2k7Td3Xi
	h23oDDKPt/8u10xkCoNqdZoLiN9RwB2IP1Tt9ROJo6n7iwI6VEAdqDRHTILGmK6G
	4cUDxe2g7kZD2lGiyjez2dfrGxtyA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1ydba-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 06:30:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lVXu212315;
	Thu, 24 Sep 2026 06:30:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7e8n4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 06:30:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O6Um1M36045240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 06:30:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11B9D20043;
	Thu, 24 Sep 2026 06:30:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C689920040;
	Thu, 24 Sep 2026 06:30:45 +0000 (GMT)
Received: from li-4c4c4544-0042-3610-8056-b8c04f473234.bl1-in.ibm.com (unknown [9.123.3.44])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 06:30:45 +0000 (GMT)
From: Jyoti Gupta <jyoti@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        sourabhjain@linux.ibm.com
Subject: [PATCH] powerpc/mpic: Fix memory leak of mpic on error paths
Date: Thu, 24 Sep 2026 12:00:10 +0530
Message-ID: <20260924063010.188642-1-jyoti@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-ORIG-GUID: keLXHVt--QJVkXwIml3a8EQjLHY1n-hp
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab4c39d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VyWIBLCL5DJSJingBiIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX0wzMJmfz0UBj
 VisDwuxb1QfMVC2J/V8z6Sv7vFxguecgvppdL0nLfgtNnzzVfFlBqEPaAlZA9FN6kQ2bQvgUGaa
 iH8MvYYQO/EfiHaHD3903bYlouAtt0c=
X-Proofpoint-GUID: fS8pDrQD__2__750kqTv2N_rTjs3xP8w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyNiBTYWx0ZWRfX0Ue0kXWmYmaR
 v1juuvjVY5a/Ef6joIulsI6VuwX1+KYZv/jnJeNhKoJdz8Xw5kx6z15r4Y5lzwR1uEzl63TKEn/
 aOp2McIooSsHN9uXgkjTL8eyY8zDsCqOas9EURHyt822NIyJ9o0dBGOxwTyCNZ0LzvLOzqflEDa
 zhg2lMVHZ3UFKXQQKDtm9Qv2wqXp7q1CdgAPdGA1KT6XICnx3KX5UOn7SlmSRX0LJ8fRZfUHv/Y
 Q/bDSAwt16+hVk3VWoMapaIH93Ibyu4OvtnsZ0Uf9UY1YR1oDa09Agv6QwU5NSEfJbNM7t/mRTG
 alxqJOZo+wcvhRpXyuHaZibCdnNJb2KPBbIll8FM1sFwcsJyx5QhW5juriL+Ll2jVYPYflGrkQp
 VN5P2dXiFGpnYJsnv4Kv9sj9ORfuqQJtFxzGcp3nkBNHR1XJlxoumz1Nowm+Oa7QtItTYCdlpiP
 mgbD4morcJW3+CLIxEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240026

mpic_alloc() allocates struct mpic (and optionally the protected
sources bitmap) but does not free them when mpic_setup_error_int() or
irq_domain_create_linear() fails, leaking the memory.

Initialise mpic to NULL and free the bitmap and the mpic in the common
error path before dropping the device node reference. The register
mappings are not released here.

Signed-off-by: Jyoti Gupta <jyoti@linux.ibm.com>
---
 arch/powerpc/sysdev/mpic.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 6e8fa94985f3..e777b33f170d 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1221,7 +1221,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 				const char *name)
 {
 	int i, psize, intvec_top;
-	struct mpic *mpic;
+	struct mpic *mpic = NULL;
 	u32 greg_feature;
 	const char *vers;
 	const u32 *psrc;
@@ -1488,10 +1488,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 						 intvec_top,
 						 &mpic_host_ops, mpic);
 
-	/*
-	 * FIXME: The code leaks the MPIC object and mappings here; this
-	 * is very unlikely to fail but it ought to be fixed anyways.
-	 */
 	if (mpic->irqhost == NULL)
 		goto err_of_node_put;
 
@@ -1527,6 +1523,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	return mpic;
 
 err_of_node_put:
+	if (mpic)
+		bitmap_free(mpic->protected);
+	kfree(mpic);
 	of_node_put(node);
 	return NULL;
 }
-- 
2.55.0


