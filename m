Return-Path: <linuxppc-dev+bounces-17564-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF029EC143A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2026 13:02:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQGDY40RJz30Lw;
	Wed, 04 Mar 2026 00:02:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772542957;
	cv=none; b=m66+CGjIuARanqNRjQythBWB83Esr1nxR7MlvS9pSDDaqCl/2NTaUwvExNgW5qoMoNuQ3FXEkxBHdBcyoUs9DUsrhKQG0AjBeZEIsTqd4/w0z5LKD8Etozvwrq1GAjUX/Qsc5VCsroebKk1U9uhleCkJC60u5K1h7vPcB5OoIIO0H32H3H7uDQwlYgYQvJbVA1M1qNrWESOrQjENQPEJgTN91zKN2vIQdWCTiJvVet7cZHp8gkRXYjII1FTmSVsRKndANWwdLtG7fBNR9btZmY4CHCrxbUelumdxFUJ/bxddmof6fjkJmBBeEoIXjjJAZPfDY92YVKe/t7n3Am4i0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772542957; c=relaxed/relaxed;
	bh=dh+vb6Mxxjxnpt48S/cIVDnUNMgHHcP7USQv6bS5opM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5IqSasn+RlwJpZFlGY+Q+DpvNIUGyP8Ct6Q624ISfbYTCy9twwlmHFNOSJO0wZGoLZkXMA+sXavb42+wkqP4sUloPLIz41PVzUi7aFgll8xxC+s5qgPYqx9VTfTbahnJaYFmjyYGO/4GEI3pvru2TSCvYHEVGH95Pm/e7oAebnuv7yF3vyufm69dgBd2tBn71iyG+e+loy5yjX1P4XHtDspkkKBYEcUsmBFzbok5hfPxanUACorUMR98UJgcsyg7ziyxhzRcQwuju0M+C6sN5MDVtQIpeo8gsZ8tlrOTC6lRDwsqdt5zDRg60Zg8OuhgAbFwWTYIrf671lW8MVU/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oYqYC0/G; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oYqYC0/G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQGDX00Zgz3bp0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 00:02:35 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6233xQhh1938926;
	Tue, 3 Mar 2026 13:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dh+vb6Mxxjxnpt48S
	/cIVDnUNMgHHcP7USQv6bS5opM=; b=oYqYC0/GTbuKjzI4QOcKBKl5Zx+kW295F
	KcrZYPl8tAdlrq9NKTOXWqAOBVO1dcihIlRJgOVDkuswpFNWRauev/jKWVaRm5gL
	gD4hPGvxBm/a7JHWqdlJqcDxliqyvZ/aRlyuvq2RtIskzLvFO7NlLHwXMXwy538g
	72QebrN5R4fD4IA54x+g9SpOm0MHbPd7dHVwW75XAk09qCC+QllahvoY6XOl+/wr
	iJaVrls7yljqJaNLPoP0FQinHHtEjEwn3Ay3oglZu0vVaiVOY+hppEBUJ5PMFQ1M
	lkze/CA/tcNrUr5Qo35ZTHryZ+mJVDaJOWlZ+pvduuiQoG0KA0ikQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrj30bk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:02:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623979pB003266;
	Tue, 3 Mar 2026 13:02:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y2cj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 13:02:17 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623D2Due31785468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 13:02:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 905D92004D;
	Tue,  3 Mar 2026 13:02:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8439F20043;
	Tue,  3 Mar 2026 13:02:11 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.78.106.17])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Mar 2026 13:02:11 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: bpf@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Abhishek Dubey <adubey@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v3 1/6] powerpc64/bpf: do not increment tailcall count when prog is NULL
Date: Tue,  3 Mar 2026 18:32:03 +0530
Message-ID: <20260303130208.325249-2-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303130208.325249-1-hbathini@linux.ibm.com>
References: <20260303130208.325249-1-hbathini@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a6dbda cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Soa85jDk8zDDq4EPMLkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5OSBTYWx0ZWRfX2KfiV8FFZDFB
 RWI7HsZ1pF9qNe1ntBX4xLY1V2bC7va2orKLiWbWQsSHH33FmSUvAt5WwbLaW+8Ox9E5P+JCwFy
 4rYs4NPL0LH++MjMBCk0Tq3CmTS4QUb7SW3tSHJSSS4KDq6e/K85r3hC4Sy1FCwBZ1gSI35o3oQ
 xIEsKmA1sqBjJdu9+0R4Czru6cEGsJu849j0qyjaJpLVXuu/6CUH/WWwPJN5Xx7iDqLR2li7UjA
 bp4P6iltxpYv9peMEO5l4FFtt8xY095/avltdhKD/2jXDXmEs0btfCivUgCS5knZOZYGB9Tnjqw
 ZEkW2M5lb9+H9hAzQYPLSoAClCMQteiD6KgZEjeEaXI94XFeoKP6wwHgeDKHSPa9hyZVhYJ0hZY
 /eGWXaYg8zCyFEUxZpzFB5z9pE40/K+PNPFN4k7tKd9FkkhCYfcuB6+1R79kCJytSXT5aj8x7wu
 RN67JUwV/H9gTQSCChQ==
X-Proofpoint-GUID: NCGe2Ymsuz-r8PXr2WvRNTLIfHiXvMpS
X-Proofpoint-ORIG-GUID: NCGe2Ymsuz-r8PXr2WvRNTLIfHiXvMpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030099

Do not increment tailcall count, if tailcall did not succeed due to
missing BPF program.

Fixes: ce0761419fae ("powerpc/bpf: Implement support for tail calls")
Cc: stable@vger.kernel.org
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v3:
- Added Tested-by tag from Venkat.


 arch/powerpc/net/bpf_jit_comp64.c | 39 +++++++++++++++++--------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index b1a3945ccc9f..44ce8a8783f9 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -522,9 +522,30 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 
 	/*
 	 * tail_call_info++; <- Actual value of tcc here
+	 * Writeback this updated value only if tailcall succeeds.
 	 */
 	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), 1));
 
+	/* prog = array->ptrs[index]; */
+	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_2), b2p_index, 8));
+	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2), b2p_bpf_array));
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			offsetof(struct bpf_array, ptrs)));
+
+	/*
+	 * if (prog == NULL)
+	 *   goto out;
+	 */
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), 0));
+	PPC_BCC_SHORT(COND_EQ, out);
+
+	/* goto *(prog->bpf_func + prologue_size); */
+	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			offsetof(struct bpf_prog, bpf_func)));
+	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_2), bpf_to_ppc(TMP_REG_2),
+			  FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
+	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_2)));
+
 	/*
 	 * Before writing updated tail_call_info, distinguish if current frame
 	 * is storing a reference to tail_call_info or actual tcc value in
@@ -539,24 +560,6 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	/* Writeback updated value to tail_call_info */
 	EMIT(PPC_RAW_STD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), 0));
 
-	/* prog = array->ptrs[index]; */
-	EMIT(PPC_RAW_MULI(bpf_to_ppc(TMP_REG_1), b2p_index, 8));
-	EMIT(PPC_RAW_ADD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), b2p_bpf_array));
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_array, ptrs)));
-
-	/*
-	 * if (prog == NULL)
-	 *   goto out;
-	 */
-	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), 0));
-	PPC_BCC_SHORT(COND_EQ, out);
-
-	/* goto *(prog->bpf_func + prologue_size); */
-	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1), offsetof(struct bpf_prog, bpf_func)));
-	EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_1),
-			FUNCTION_DESCR_SIZE + bpf_tailcall_prologue_size));
-	EMIT(PPC_RAW_MTCTR(bpf_to_ppc(TMP_REG_1)));
-
 	/* tear down stack, restore NVRs, ... */
 	bpf_jit_emit_common_epilogue(image, ctx);
 
-- 
2.53.0


