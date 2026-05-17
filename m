Return-Path: <linuxppc-dev+bounces-21009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF7ACD4F4A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 May 2026 17:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJSrx5CX2z2xjN;
	Mon, 18 May 2026 03:40:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779039649;
	cv=none; b=IbZwFTBtbZqevCd37xzif+6qNk+xSjxqU5a7/YTn5DmNVKgpdI9rJSsW7YjO7FMQynKhVRXS4/AXigdHaNKnnBFL0QOwHVne9zzqDOMGrUbh/j56s5Pi3bwIemirwe5lXnx8u+7GuAFE32lsRbLy6TgGsjvksXQWxBgqAjbOgJR6cOstTOeWE2b2Jbqwy6rJsQXSqSuqSI3J7Ac9ScmoqEwUJmkrpnGqDJCKsU68YvYbOjBc6Bxodo7HUNK8RWSRWfPTenZt7J/w1RMez3NYInbvpDQukCr338Pt2AvT/F7/9qGvTSga/4DAP1STVObZnWjj0l8V8GOvileyqQ0IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779039649; c=relaxed/relaxed;
	bh=SZp77nDRgk8UCryrIML11mAyYjGZXI/yRiPXaatMvhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuUBVucqxlJmFeb3efINbYUOhb6FCvnuCc6FYt6xf3Fds9Vaebt4ZOE7KEV3Tk+nAVeflBB/ueFCorP1BySR8Iy6ssPXnaiWZmmPlVLC4MMnPyDfl9LLnR3ubsfU0o6oJS/jsAZYxVzRgGRVtpjgevJSQ3xcw55BW5XgJ/7Oiatu8qifDHjPBWIfebuPFum/uD8mvvVXT+OWTCaqcUtpyQjm+C/H3v+hDYLI3rUeKTyliqCJjGgRrRGSGGP1LAlqlaBX59ZFBG1anyD3EUt5cgMLg6tm+1TacH0lQ9BU++LJGSEgDkJrauNljGgZE1zTevlD9vldlgbhsVfm/P0DyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IyE2Cmou; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IyE2Cmou;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJSrw1q1hz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 03:40:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H6vrj43913287;
	Sun, 17 May 2026 17:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SZp77nDRgk8UCryrI
	ML11mAyYjGZXI/yRiPXaatMvhU=; b=IyE2CmouOzsPJOeIfgGqPUMGCsQ9MJXLO
	l6hhfd46S6olueB4Cx/L4tZjWd0C3TG0pig4SoSCmYaeHFUNTGfM6/QjoyHZUNLN
	YR24l5Kh0l+E4qGaNC9pLg9Rj13oWZs5BGUKmjgFfpIrX3/2MZp/RNs+0v4qTn0X
	4H2xXtVit3TAWDg3zWkpuEUJSVS82LwjpJ4TkfffacCi79zHSlywRB636AmwczT2
	R6QoGjB4Iqx19iGqWP35YaWIrDTPl82i9MnjYxO9VReeU5Bl9B9infi0oNk3ZsNn
	128vC1hwjgZBW4jMvBY46B6Y2e7ABKJIxq4u61Hp/tqhAp0dTVEbA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xmnsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64HHdNXV005638;
	Sun, 17 May 2026 17:40:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjtf58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 May 2026 17:40:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64HHeTDu56426812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 17 May 2026 17:40:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C79620043;
	Sun, 17 May 2026 17:40:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 231DF20040;
	Sun, 17 May 2026 17:40:27 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 17 May 2026 17:40:26 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v4 1/5] powerpc/bpf: fix alignment of long branch trampoline address
Date: Sun, 17 May 2026 17:40:39 -0400
Message-ID: <20260517214043.12975-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260517214043.12975-1-adubey@linux.ibm.com>
References: <20260517214043.12975-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE5MCBTYWx0ZWRfX5EMnFofdD+fg
 uMhbvwMuAMYXgOqm0b3m1jgnyFdLmqaTktA3MxoemNRpiWBCDTBWRvqVSF7/8kFMwjBgUs7wzaA
 q2SIt3vTO5nczmS8qZdqDyPsJet81rh4QVGR/xSPi/Q9n5dbBW5Uad42u3Z7brVTApLQ2FXwz7Z
 2X8xnebOsDYYGLpUkJCaGwFrqnr11FMOwlDU/Sg13lij9oUSTbEe9ukkmA061kf1Fsh2MzLgmyH
 XIJDkLM8sr3ZotY+gasaXRllCw9XpUpPOqk/73XbNLNVBx8KmM99sRJgIIiWzgWuiGPvoYZC8g4
 5lXBoNXzja9J86SdePXfdz8EGG4s73gDVYGzN4CNdGC9Ie2xAo4ldB8/PL9X+OpITtTnPE4Sz83
 Ua9aw1egzWEUWNaMdeRCpQGMNo4J1ytBM6pcXVsX8wPL7US0tzgm2/t9EvAHPdAscELHblQqg0a
 gBFsATpp5sDrXmU0ZTQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a09fd92 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=3Zv-X24pnbuftgYs6HsA:9
X-Proofpoint-ORIG-GUID: QFMwR_TzpNMjkXvMx6tjFctDD6tEccWv
X-Proofpoint-GUID: QFMwR_TzpNMjkXvMx6tjFctDD6tEccWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170190

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure the dummy trampoline address field present between the OOL stub
and the long branch stub is 8-byte aligned, for memory compatibility
when content loaded to a register.

Reported-by: Hari Bathini <hbathini@linux.ibm.com>
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  4 ++--
 arch/powerpc/net/bpf_jit_comp.c   | 34 ++++++++++++++++++++++++++-----
 arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index f32de8704d4d..71e6e7d01057 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -214,8 +214,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass);
 void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
 void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 53ab97ad6074..ef7614177cb1 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -49,11 +49,34 @@ asm (
 "	.popsection				;"
 );
 
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
 
 	/*
+	 * In the final pass, align the mis-aligned dummy_tramp_addr field
+	 * in the fimage. The alignment NOP must appear before OOL stub,
+	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
+	 */
+#ifdef CONFIG_PPC64
+	if (fimage && image) {
+		/*
+		 * pc points to first instruction of OOL stub,
+		 * dummy_tramp_addr is past 4/3 instructions depending on
+		 * CONFIG_PPC_FTRACE_OUT_OF_LINE is enabled/not respectively.
+		 *
+		 * The decision to emit alignment NOP must depend on the alignment
+		 * of dummy_tramp_addr field.
+		 */
+		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
+		pc += IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
+
+		if (!IS_ALIGNED(pc, 8))
+			EMIT(PPC_RAW_NOP());
+	}
+#endif
+
+	/*      nop     // optional, for alignment of dummy_tramp_addr
 	 * Out-of-line stub:
 	 *	mflr	r0
 	 *	[b|bl]	tramp
@@ -70,7 +93,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 
 	/*
 	 * Long branch stub:
-	 *	.long	<dummy_tramp_addr>
+	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 *	mflr	r11
 	 *	bcl	20,31,$+4
 	 *	mflr	r12
@@ -81,6 +104,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 	 */
 	if (image)
 		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
+
 	ctx->idx += SZL / 4;
 	long_branch_stub_idx = ctx->idx;
 	EMIT(PPC_RAW_MFLR(_R11));
@@ -107,7 +131,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
-		bpf_jit_build_epilogue(image, ctx);
+		bpf_jit_build_epilogue(image, NULL, ctx);
 	}
 
 	return 0;
@@ -286,7 +310,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	bpf_jit_build_prologue(NULL, &cgctx);
 	addrs[fp->len] = cgctx.idx * 4;
-	bpf_jit_build_epilogue(NULL, &cgctx);
+	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
 
 	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
 	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
@@ -318,7 +342,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
 		}
-		bpf_jit_build_epilogue(code_base, &cgctx);
+		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index db364d9083e7..885dc8cf55a2 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -398,7 +398,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 	}
 }
 
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	bpf_jit_emit_common_epilogue(image, ctx);
 
@@ -407,7 +407,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 
 	EMIT(PPC_RAW_BLR());
 
-	bpf_jit_build_fentry_stubs(image, ctx);
+	bpf_jit_build_fentry_stubs(image, fimage, ctx);
 }
 
 /*
-- 
2.52.0


