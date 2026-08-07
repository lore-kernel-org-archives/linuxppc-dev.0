Return-Path: <linuxppc-dev+bounces-25562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F291CC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:43:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGj2r5P0hz3c3w;
	Fri, 07 Aug 2026 21:43:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786103012;
	cv=none; b=JaIaeMOeoO49sm295cuNVfCFliSrXL4fnWTKH0gTl2v2bjQ28aGsTztTLnGaApVtffPXgSa7y4MVDV8/RnTs7n7CjfnXFaf4ayDEW7OBRc4E2e0wx/Jj339h4FUVRgjENff3Ixf4ZQ2ZQ56wMEXYVH8yJelkJv2Hv/lZh9IoGwO1NPWYINRoQnjH4WifdksALrpIAkGupaROmJxPfUuYx8MNyXOyqeI0mBivNZH7mB3Rx1tJ/vGbbjj8qrFFPDC36oKtdWtT3ldZ/dIPP4P4vcM+3MhnTHHIrVHR5zDfjJ7jOLqf0I90FDIIF0tfwsiLe1sVC7IWhYKuHN7UQrYIrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786103012; c=relaxed/relaxed;
	bh=hOE2rAOrQ+pZgW9nF7gOeXU4b2UUb2wh3b3YEAq1PVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7gMweQ4jhEJANw/UcnBru801jS4TSv7KvNg002YWF+ohlkrntWCrU78MISLVZmUHUo1KWFHjj1l2cYH+eAshnyauPCq/dnW6oeFOMjOolVRly09+/LuXMBiXz+vsB+YO1LEeYq9zp1YQP8Tnb/4/nUOE49sJYAlz4QBVtMCO/U4JwPxadHKefpyDlYR9n9CcB43e0nsIqU78eql5iNfyI6RIDMEc9jxzqmPrF7MOOp1OWDvvHLMo9JSTJmoEq9LIHT/NEk9WXVbg4UgMYpNt5thRZaaOqT2Y9QdsNtpiy6AfYx4x93JtOsXHF/ECvKS7X93HpCPpdO5epYc+95ixA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EbMckW0S; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EbMckW0S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGj2r0y3fz3c3g
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 21:43:31 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IU4l4162425;
	Fri, 7 Aug 2026 11:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hOE2rAOrQ+pZgW9nF
	7gOeXU4b2UUb2wh3b3YEAq1PVk=; b=EbMckW0Say7TSbY+HQCrXllPRpkYTRQe1
	ie9zfqIykW5dPJ7fWJ8g6bcYns48AyJphuar0BQnqMk226aovRS/CorG4aMKB9dL
	affVlhIKdWwM2W+jWxRNRr2Q+VH+ZXkZ9B2tgnjuACRzq9YMCCq3OZposQmPMYQ/
	e243i0pqMXcKyFaKpSmYoi4ELhFOR5tAUF0G5viTw2V9BB5NoHU8uO9+aY/ixExL
	3p2UnQhBe4eB/qsJOdsCSAWTts8fF04fZGYd2ofqC5oMTVZGuDS2hHH8oyv8VQxM
	LJXAlL2ZwmXJl7zFj6n/QoaYgir+uwA4AurZ3KUs1eOSD/RnNo4yw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyunkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677BfJ9D013129;
	Fri, 7 Aug 2026 11:43:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kfh7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 11:43:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677BhAYV29229412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 11:43:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1293520040;
	Fri,  7 Aug 2026 11:43:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90F1220043;
	Fri,  7 Aug 2026 11:43:06 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.23.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 11:43:06 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v11 5/8] powerpc64/bpf: fix compare instruction emitted for tailcall
Date: Fri,  7 Aug 2026 17:12:40 +0530
Message-ID: <aa9bf28598b952da8ce8ac5fa78105dda028ece4.1786099877.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1786099877.git.skb99@linux.ibm.com>
References: <cover.1786099877.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75c4d3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ChPpPKTfPU_lHkPiKQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX73I4/UshlSNa
 ZK6ny3XwK16ZWiFF4jHeDOxxzBjugLBy00yMdtW7Ve5LMrgI2ZoQAbpeDjlpfydzWzNwmdQ/XUg
 APcJafNUp+aoPwqlkJqvoHZR9B4yeag=
X-Proofpoint-ORIG-GUID: daS0q46J821Pywov9gm6-OOv_NbrCnGv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NyBTYWx0ZWRfX6D8MuIYzR/EQ
 iaVv9TKrVAmUxNO8Msm8/syTnbU9azEsoqSWli/GSe1B+47q7g5hSw5GP2myufFAim4emuW0HE+
 0Z1LDIlLtu28tjFd6LBoTFvgs1rtWJhKaCCPj95B9eqnZMqjusbLZg1E19puWcpZNCHI4UcSugD
 HXn2BOblnjzLnizD8rcIxYbn5kq5AEec+62GAiO//pJNfi3Gg8+/KkYj9tniX+DcoMn5M3ywhPl
 eWSn9rvvlpVG0OB/c+fAO0wbK3DpjXBJCP8QlhTRNqGTeDqiKhq/WsJuZSD4XUfeNGYp1nufDPh
 0SSl78laouLeZPBATURZdXETEUhtWOtEqq0i+AYBWwvIgiRS6eHQ7ImF2YUHc1UvywIP/i5jdeR
 5BP19utRI8c/G4cvLk6Q9Mn0KwH//cpPt8nvilFNnuLDE72zatHWsGuk2E1ut/YtmqXm5b7rZC6
 rbTqgA2GKZOg32IZXBg==
X-Proofpoint-GUID: daS0q46J821Pywov9gm6-OOv_NbrCnGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070087

From: Abhishek Dubey <adubey@linux.ibm.com>

The tail_call_info field can contain either a scalar counter
value or a 64-bit pointer to the counter, using a 32-bit
compare (cmplwi) only checks the lower 32 bits, which can lead
to incorrect comparisions when location of counter is near 4GB
boundary. Use instruction cmpldi/cmplwi for accurate comparision
in corresponding cases.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        | 6 ++++++
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 6632de9871dd..af510da12d8e 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -188,6 +188,12 @@ struct codegen_context {
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
 
+#ifdef CONFIG_PPC64
+#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLDI(a, i)
+#else
+#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLWI(a, i)
+#endif
+
 #ifdef CONFIG_PPC32
 #define BPF_FIXUP_LEN	3 /* Three instructions => 12 bytes */
 #else
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index bdae835e4b71..757b36bfbac3 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -768,7 +768,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 * Setting the tail_call_info in trampoline's frame
 		 * depending on if previous frame had value or reference.
 		 */
-		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLLI(_R3, MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 951eb10ca1f6..e80312171aa7 100644
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
@@ -662,7 +662,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	PPC_BCC_SHORT(COND_GE, out);
 
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_LE, 8);
 
 	/* dereference TMP_REG_1 */
@@ -672,7 +672,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/*
@@ -707,7 +707,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_info.
 	 */
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_GT, 8);
 
 	/* First get address of tail_call_info */
-- 
2.54.0


