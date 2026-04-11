Return-Path: <linuxppc-dev+bounces-19649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6B4F3ED50
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 18:14:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftMJH00Gnz2yVB;
	Sun, 12 Apr 2026 04:14:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775931262;
	cv=none; b=dGvijXgLb5Gzz7O1OcI8CH+EiW646/0K2aW7H1noFsy+NAKoZadD81DcgfR9QhpNl7dlZaI/Eq8fqKpM+xXiNetn404SAWmj/HPyD/EStR7TxxIRRQVRBuwlbEo7kfDX26VAptYJPTEVtBda8m0OpHzGQtXZ3Zt7mzIaMdxoP1jMOzVzKCNBDJhLiqTEYmCM72FuQRaLTHEnPipQRrRu0CHFNRYHjZqJG8xMs9rizvvSHQFd4rlPoBQGymyWa3M9f31PxHBP39CilUgBShdl2c2ruoSuBfPkkuPUJU6wZm4xkkdYj1h7/uOiELQxD2ANkmE9QLeP6YL47oDEsTjDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775931262; c=relaxed/relaxed;
	bh=okqET8qXffFn3bcT77J1rirq+BLrIQ84Y4jERf3WtP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8Eh6HzhRPug6q2JamT8CqOkP5pXsRdy0+DYoaLmFEJFXAKsbrkhn4QrftBXeHP4Z7wC5dDMilqcbx5QPx/mZyG51bJItv8MMrdUCvxq9j5+xWV6HdYWGdh0ezA0hf91m7B6PQwuK/bqlMaNZPa0jjCmiPKgkRO7mMSyoo9+pM8St9429Cq4/lQ+mMwmzvJjBWkQp6d0e1JUHhAAQlSpRHFKsQu7maEkmGsW87F1RvTyPmTGzOGx9bjFqdIUNxI15Q6R0N7xXUTZjj9MLo7QMFdxbYUPaMM1AGxMsCX7RHkHdiTyCsv49lZZD0ZrvPvcr2/M/rhSXsDAVw4FX53dZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B71b5cIa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B71b5cIa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftMJF6TMxz2ypV
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 04:14:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63BBtxaJ3453530;
	Sat, 11 Apr 2026 18:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=okqET8qXffFn3bcT7
	7J1rirq+BLrIQ84Y4jERf3WtP4=; b=B71b5cIarCnjoWDaUcL0rvwNzVo2xXF1q
	WMBJX+ijFJDL/CBsQCOkGAQRh6rMWojrUknZCoMP4G5vI22hmDadq0gkQ4O5Y71P
	x5xvxU1IgeUfw1b9MwEvQwPpwrw4gcY26FRW2s1RiFono3Shn+dCoufto5TlfQRq
	ND1BMo76rm6kFtrjTfapxGa4jmhG8D6A/FYBYPlZVew1il/H89dikd8VHxoSNtCt
	Sj4xDfh/oowrAxoBCH2RgJNEwJAcrGCDvWN+u4a3S9qs3FPQh5++W+gCDaQ/F8P6
	ecViXUxRBjtT0qq/f+PPtR5z96ajxd080g7QZ4MkuWeMM071/XKoQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqeswrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63BFBQo7026707;
	Sat, 11 Apr 2026 18:14:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg8d4ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63BIE1Hd42009004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 18:14:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1288320043;
	Sat, 11 Apr 2026 18:14:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C06520040;
	Sat, 11 Apr 2026 18:13:59 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Apr 2026 18:13:58 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 1/5] powerpc/bpf: fix alignment of long branch trampoline  address
Date: Sat, 11 Apr 2026 18:14:09 -0400
Message-ID: <20260411221413.44304-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260411221413.44304-1-adubey@linux.ibm.com>
References: <20260411221413.44304-1-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NyBTYWx0ZWRfXxyhoLYSo2DWk
 4ZnQxP53yLgsDw/g5oeG/rtCZVxhaspX15CfU++Mu5hxRXcRCeSse0BUVvv8UDw1rHekIg3EOeR
 9HgpWxpylTtA5DhjuzqfPijEFu5XToPPnFZ9WLwCAlyJZfydejK4+0KZGwRn2mIeyCAFVTElM1S
 pnQ8+wjMBm0NG34VAeeuQiDRkoGCOpW58YdfQfLbaLxEnVfOxlgjqR3W6bRorcHVQG9Xm7rotgG
 hHPqen4MZP+IKSS7vwpHyjgyI3B0d4L1hPEtsznTnayY18Lg+jxPRmFXpoCqXRaYR/vMmG+ipnU
 f18z2gUGYEH5IphmlQY76HBg1T6p340ng/XzKhp6dP1jJl0bb1M05H6HUWcNst4Ft+K0xqDmzNB
 xwaQwMl38dzwZ+dEdxtxPOeqGQ/r6FlhtJ4k31odUK4GUd3VTBsVz1oGvsvnuxiEX+WovkxpcR1
 mqPCTOXjfcNEi1wGCfQ==
X-Proofpoint-GUID: ylayNv7NcPVycVb0Tk-LPgqtq2OwoLP-
X-Proofpoint-ORIG-GUID: ylayNv7NcPVycVb0Tk-LPgqtq2OwoLP-
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69da8f6d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=3Zv-X24pnbuftgYs6HsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110157

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
index 7354e1d72f79..1184ad15d5a4 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -208,8 +208,8 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct codegen_context *ctx,
 		       u32 *addrs, int pass, bool extra_pass);
 void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx);
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx);
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
 int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a62a9a92b7b5..c255b30a37b0 100644
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
+	 *
+	 * Need alignment NOP in following conditions:
+	 *
+	 * OOL stub aligned	CONFIG_PPC_FTRACE_OUT_OF_LINE	Alignment NOP
+	 *      Y                               Y                     N
+	 *      Y                               N                     Y
+	 *      N                               Y                     Y
+	 *      N                               N                     N
+	 */
+#ifdef CONFIG_PPC64
+	if (fimage && image) {
+		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
+
+		if (IS_ALIGNED(pc, 8) ^
+			IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
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
@@ -240,7 +264,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	bpf_jit_build_prologue(NULL, &cgctx);
 	addrs[fp->len] = cgctx.idx * 4;
-	bpf_jit_build_epilogue(NULL, &cgctx);
+	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
 
 	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
 	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
@@ -275,7 +299,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 			fp = org_fp;
 			goto out_addrs;
 		}
-		bpf_jit_build_epilogue(code_base, &cgctx);
+		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index c5e26d231cd5..d4873979ae9d 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -348,7 +348,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 	}
 }
 
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	bpf_jit_emit_common_epilogue(image, ctx);
 
@@ -357,7 +357,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 
 	EMIT(PPC_RAW_BLR());
 
-	bpf_jit_build_fentry_stubs(image, ctx);
+	bpf_jit_build_fentry_stubs(image, fimage, ctx);
 }
 
 /*
-- 
2.52.0


