Return-Path: <linuxppc-dev+bounces-21558-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249B2CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:26:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLlP12Dnz2yD6;
	Wed, 27 May 2026 17:26:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779866785;
	cv=none; b=I/4pXvS2Xt5lsEoZYdkuFM1IBhyJKEjwv56CFRmUzIme3vpZCH/Czjl3jr38aixFPwwbsEm7yhSpLe7sGEmsr4BNbsKqQc+x+M7b/FExTmoym0BTWEq9R98nESTZCjsU0bWLgsWL7S02B/nRyKz7RxVJfxOrtvuec/2x0U0/e/2aitAlhUxutIMeKt9uDlhoTeSa7wRt/K10T1qPHcdG69X2cNfDLk9b+3xXuvN9uGNhx7eMBxrrCggoYkUzATD8LSeqTFPHkBQPb91A8xYi/V3EeNSG5RBkdhsAO7FdTEuBQdMjXH5Lsiyh2zlLRHYeRTIOjVozGpg5bexxNdP6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779866785; c=relaxed/relaxed;
	bh=sMy/yg2bgPTpqRxfxUL65wrvYdAvGYyUjEGjNoudFL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUZSZOuWtl7NnMUTianyvRNlElrQnuliSaTgJSLh8jVeN5UPlN3wQGOJ5kKrmBULU9R5Q6WvLS0JN4zWEbA+m6k9wXN95q5c2LgnbtWyxvcg06gGtbifqXZNaTz6n7CQi5HpK/N0Et4U6DTS3hGhPEPJTW84QopMQAnBwLyccWdAgYCQSFfs30ed93C1F0A0NOZ9RX0dVre1IRslt+K9qJWCFU+SqCBk6kl+vNygxenC0GmHXPM7JwL9kD3Rmb1TDUmhqL3tSH4CCTFzOcnoqGwl6kdIiFOlf+riObDyGZDz+7sGqXSPV9Yd2viVfxzN1okJ1mgbK5KLP7HM5DTRaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n28H1suN; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n28H1suN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLlN3LXhz2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:26:24 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4vkq3851596;
	Wed, 27 May 2026 07:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sMy/yg2bgPTpqRxfx
	UL65wrvYdAvGYyUjEGjNoudFL4=; b=n28H1suN5QwAjQC7ns/3egmpSDqrpA/+b
	6SiMpzLxg+m2Io0MwAiyvzmke88EpcuK/+Ekypro8ZgzHSb2fwmP37yKOTAdbqM1
	6eHtw//UJsWY3zhbRfikYwXEH3riuPhjhc1L6bhZtA+4yQfsioCibrwfJnlu5nXU
	MduxpJrHqjylRbF+UNJAe74Qnh2CpxVeY7drsqK95SRLOYqmiew3vi+ECctpdfZ5
	O9shQ6ZED6oiTFQpeUDRt9Fw7mtuZkBk+4XAdGF6t2J9wJEInI4IF7dNh+Fmb+v4
	hSVe8m9QZk7Fi1fRzU3qGWwxj1HMNaFgYhf9L9e/gyeYWp2yqlNNQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4pdf08y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:26:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R7O8g1014805;
	Wed, 27 May 2026 07:26:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbhww8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:26:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R7Q9Un27001322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:26:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9837C20043;
	Wed, 27 May 2026 07:26:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 508B22004B;
	Wed, 27 May 2026 07:26:06 +0000 (GMT)
Received: from dhcp-9-123-0-29.bl1-in.ibm.com (unknown [9.123.0.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:26:06 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v2 5/5] powerpc/powernv: Map EEH error types to OPAL error injection types
Date: Wed, 27 May 2026 12:54:33 +0530
Message-ID: <20260527072433.94510-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OdqoyBTY c=1 sm=1 tr=0 ts=6a169c96 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=aHHZtgvgEZ6nWDfOVG8A:9
X-Proofpoint-GUID: 2FjB6-LlE4KAwhul2vBTOsThNsA15i7F
X-Proofpoint-ORIG-GUID: NWsKInkaMVpbUGQZ38N5cMPi0i1BDwfn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2NyBTYWx0ZWRfX955XKsFCGX7a
 U/sJSPB7oGX9QZFd/c95IH8+Yd6ovpzEy6cqrrZUnxnUIIqTDMf34/bRCaS6mfLNoKB8PDAmU9F
 m6qVmstlFuXciVwO+NVTq2poN4D/lfWghdbwcSl5JEDtQ+Ltzg9/lo6mMd2LbCkF5lutXLZn1PW
 ZPX0UnB918oqFCZX2jt9az8ihV5edjwOjN5uCvMsQ8c4DLSDFWtyftQmNpuXXWH4a0q2RJTeVIO
 khHjr6+ej42drSZj86mosirScm70mZh9ciEpqT7furzLXUaKZgboMRJ81pv/gmA6f5Cx57w0p8s
 ujWW+6FJlyzmCB3EmK8BMNBkGm5eOY8cwnh0PNLPx5uC8FkKAcMY+FjmRk2xtw8tRPWZmY5mJQP
 UOFkfljymf19PJqQDNdwLJevqzBkVpWvBYZ2A+Y7JWrOTK5YMBZKgbRL50P3eg3iZlvvI3S0H6M
 x4YLYyAVyvr4WOs/mCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270067

Add a mapping layer in pnv_eeh_err_inject() to translate generic EEH
error types to OPAL-specific error injection types. This decouples the
VFIO error injection interface from OPAL implementation details.

Map EEH_ERR_TYPE_32 to OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
EEH_ERR_TYPE_64 to OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Return -EINVAL
for unsupported error types.

This provides better abstraction between the generic EEH layer and
platform-specific implementation.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/uapi/asm/eeh.h          | 20 ++++++++++++++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 11 +++++++++--
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
index 86645cab2827..d88d82796905 100644
--- a/arch/powerpc/include/uapi/asm/eeh.h
+++ b/arch/powerpc/include/uapi/asm/eeh.h
@@ -16,8 +16,24 @@
 #define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
 
 /* EEH error types and functions */
-#define EEH_ERR_TYPE_32			0       /* 32-bits error	*/
-#define EEH_ERR_TYPE_64			1       /* 64-bits error	*/
+#define EEH_ERR_TYPE_FATAL                  0x1   /* Fatal error */
+#define EEH_ERR_TYPE_RECOVERED_RANDOM       0x2   /* Recovered random event */
+#define EEH_ERR_TYPE_RECOVERED_SPECIAL      0x3   /* Recovered special event */
+#define EEH_ERR_TYPE_CORRUPTED_PAGE         0x4   /* Corrupted page */
+#define EEH_ERR_TYPE_CORRUPTED_SLB          0x5   /* Corrupted SLB */
+#define EEH_ERR_TYPE_TRANSLATOR_FAILURE     0x6   /* Translator failure */
+#define EEH_ERR_TYPE_32                     0x7   /* 32-bit IOA bus error */
+#define EEH_ERR_TYPE_PLATFORM_SPECIFIC      0x8   /* Platform specific */
+#define EEH_ERR_TYPE_CORRUPTED_DCACHE_START 0x9   /* Corrupted D-cache start */
+#define EEH_ERR_TYPE_CORRUPTED_DCACHE_END   0xA   /* Corrupted D-cache end */
+#define EEH_ERR_TYPE_CORRUPTED_ICACHE_START 0xB   /* Corrupted I-cache start */
+#define EEH_ERR_TYPE_CORRUPTED_ICACHE_END   0xC   /* Corrupted I-cache end */
+#define EEH_ERR_TYPE_CORRUPTED_TLB_START    0xD   /* Corrupted TLB start */
+#define EEH_ERR_TYPE_CORRUPTED_TLB_END      0xE   /* Corrupted TLB end */
+#define EEH_ERR_TYPE_64                     0xF   /* 64-bit IOA bus error */
+#define EEH_ERR_TYPE_UPSTREAM_IO_ERROR      0x10  /* Upstream IO error */
+
+/* EEH supported function types */
 #define EEH_ERR_FUNC_MIN		0
 #define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
 #define EEH_ERR_FUNC_LD_MEM_DATA	1
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..ee156d397e93 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1169,8 +1169,15 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 	struct pnv_phb *phb = hose->private_data;
 	s64 rc;
 
-	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
-	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
+	/* Map generic EEH Type to OPAL Type */
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
+		break;
+	case EEH_ERR_TYPE_64:
+		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
+		break;
+	default:
 		pr_warn("%s: Invalid error type %d\n",
 			__func__, type);
 		return -ERANGE;
-- 
2.54.0


