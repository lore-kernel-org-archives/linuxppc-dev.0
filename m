Return-Path: <linuxppc-dev+bounces-21190-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0359BCD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 19:39:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlN72mc6z2yRF;
	Wed, 20 May 2026 05:38:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779219527;
	cv=none; b=BypKHSLKe+5PsF9tnllP0QNx+acuHZml2wgw5uMkjCUQ1oj24b+LI47BXFwMbUOpqzb3qlv7R9qod5kREZnMg19UswaXCTvC4gQYzzzMfioxkKXd6BAukviaKlmn11+wW+vz2YlD/rZy4fX2NHQxErWvpn1XI3sVkvx/rP+ry1k9lysX0ndju+v5maHeTQZf3Sd75gVO5FMv08l/2bT4vwr9CSqZpAUXtQIR2zWL2Ep2hyztUURqibdL8swAci8VkDXmu/Qd5WKAGSBG00oDqraIyTaTl26Rak8CvfzE0n7B9r/OgnHg5bd6zqlFJLtJXQvBFfS8gw5W+pNU3SSjhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779219527; c=relaxed/relaxed;
	bh=UGBaf2e/e94EaICpC0vjDtDj5LYLiK0IqM78/lfvR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSYUpQHpW/ZSr/dnOxB4Ct0gL3H0xnulzsmKwq/Q6FWlUONQxcFexyebhOBdf/onM0rnhSvGcKJjra+PunKBtBe3TC2afrlc3SDhqcbeD6OhqL55HrmZ0azrmlCzoHfPg3URugoIKuWnOITf9D+8qSzVoorhLVE+KqxQraJMTdZIwTazHNZOrYp4tw5FdYzJU0EFiMr5ALd0sSxJx3U+465aY0LpCvckDk8K968x8kluZwM04WolcNZR8/mOgsxMfBtdOxKUs3a5x1pYanwvDZ9EakLJxkl1vWQQfUv5vT5BxTOzLN/+RVao9aQFIjTRuiOutZ+OqK0Lul0rmQZiQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bZJyWDRe; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bZJyWDRe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlN64cNqz3bwR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 05:38:46 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JFtMtk1562366;
	Tue, 19 May 2026 19:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UGBaf2e/e94EaICpC
	0vjDtDj5LYLiK0IqM78/lfvR3A=; b=bZJyWDRez51EjM5jtPac4mhnHjPXh3Qbp
	R0iewXIIfTidpWigAtZcRHT1JZPwVBeS5si22CcGjxRVUCwM8WbooV2ATyUcHRfF
	M4Va4NhbXaFYerOC99cd+BEJBYHOz3V6aBZov1qbwavjMhVGbPX56N6I13aUjhTa
	TLrB9/FfVSV5FSUK94GN0eEYnx8lYiXcf88VQPmpfJL/zvgeZXjJzp2eUFQuBdFp
	qDEIzcba9BkL1YlDDvBoeDhZn8Dq0tMcPtEyhnqXsq7mRPegCqffd8GsJusWCSke
	iYIp4G8Hv7Xdc6Qjn8CNnzjiH5wp83QzhQmlfYdyask92aFvhUvQg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8e0kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JJO5ZX028483;
	Tue, 19 May 2026 19:38:25 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gc0m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JJcLc746006550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 19:38:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8372B20043;
	Tue, 19 May 2026 19:38:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F67620040;
	Tue, 19 May 2026 19:38:19 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 19:38:19 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [PATCH v5 5/6] powerpc64/bpf: fix compare instruction emitted for tailcall
Date: Tue, 19 May 2026 19:38:11 -0400
Message-ID: <20260519233812.18787-6-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519233812.18787-1-adubey@linux.ibm.com>
References: <20260519233812.18787-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NiBTYWx0ZWRfX7Mj/E2t2ykeP
 ZwH5Y7IRsSiaRRUzUiBJQvz5bfNZPdIdJIeEMZyXbi7xg1Z6kfqbLXtx079OuHrR8LPACxGWbqB
 nHO7TC2yFVVz7Qd1oSFOkw8VsAWVukfb8jC89dqMe8RquALTdDDhYj7cqCNAlWGX4LwvFxiC+9M
 V7YCBehNLmnYGdvsRDN3Nqnmh47VWYcVy8X3WtF74NawzXe/pC5lj3y0mDE4V51naveFcTE8SHP
 67BAzFqZqddj5YbheAMV17voDetwj+fTRfpi83RpWq7Us8ev1A0hWERj8eRm0uz7QQk/6irRBT1
 H9MS4s+rDCkiwpkPjHluHoly2P7xbg0jl9UzKQYh1TbL+gyv40n4f3fcRe8Aqm89XsmznrqzU3H
 DDA7V7c49bD3mG9zWkqJN5gG+vYhSBzuVgPFRp2gljLQVpoSwUVklS+VAeZ7xUYtOVgLWC/1Q7m
 7M5SvmveHgR969AK9uQ==
X-Proofpoint-GUID: mS1pgS64aVTCOEOHKK0SFVQZB-Ymtkro
X-Proofpoint-ORIG-GUID: mS1pgS64aVTCOEOHKK0SFVQZB-Ymtkro
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0cbc32 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ChPpPKTfPU_lHkPiKQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190196

From: Abhishek Dubey <adubey@linux.ibm.com>

The tail_call_info field can contain either a scalar counter
value or a 64-bit pointer to the counter, using a 32-bit
compare (cmplwi) only checks the lower 32 bits, which can lead
to incorrect comparisions when location of counter is near 4GB
boundary. Use instruction cmpldi for accurate comparision in
all cases.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 56a923d3908e..eb476c582bc5 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -764,7 +764,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 * Setting the tail_call_info in trampoline's frame
 		 * depending on if previous frame had value or reference.
 		 */
-		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLDI(_R3, MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 885dc8cf55a2..74fce3cf6c5e 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -276,7 +276,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		 */
 		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
 		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
-		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2),
 								-(BPF_PPC_TAILCALL)));
@@ -651,7 +651,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	PPC_BCC_SHORT(COND_GE, out);
 
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_LE, 8);
 
 	/* dereference TMP_REG_1 */
@@ -661,7 +661,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/*
@@ -696,7 +696,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_info.
 	 */
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_GT, 8);
 
 	/* First get address of tail_call_info */
-- 
2.52.0


