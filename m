Return-Path: <linuxppc-dev+bounces-21186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126DACD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 19:38:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlMh5pxyz3bqh;
	Wed, 20 May 2026 05:38:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779219504;
	cv=none; b=TRAniZAL7PsZicX94PJutc5xfI3aMqe+ifVnXRVcwlg7TOSsAjxrWFugYTbVHSH+T38hqeE74hk3+renELlL5yTH8eVTMHFHmiOFkQFPmlY2BiTeJXWtdTWKEq4WcYRHOxRb7cCgH0VA6YEMPtHvYiflJUhH1XoPjatarTbe30+a8LZm5y66QQCkRho5erLx6YxmjJxbhCl6MgLhzFtbqDsfBR4jDU/z2W+MO8esPzlSFW9ff922+9OUNh4b7Da3aTK/gA+uj9UZTTZfZ1Zm6o5ZQkX4lovNOs6dL7BiSUSEXlSabiVQtEBndNibNReUCYVdFWY/3ipt4qrM6YicdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779219504; c=relaxed/relaxed;
	bh=M1OLEal/ff1Xc9jJhC6bzziCcZCN5OGWK0Vyc1dZhGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnxC2Ue3eBwwM4trVJa6JudKy013j65t0lv2CjEmRPk60IUgHrzPm5Uw+JWYwBeMhjaZ1HOHzOK9uucMaVQihR7l5rFFlaIiEKty7iedOGQ/6z0CTzzFueUxarMok+fw0IbQog0/EsthvCLpSSyo0WB55hjij0eNGa5pyxGoUwKysCEkO9BgoeY8sfX35SqxDwpNwkFNyKSGtJ/B3MwbtHzju+qCxhf20FFAQXehTgDy558RUurDLAkEdGSoYuySs/G8byKgR9XYtMVHoa8Fby7BUURgszStpDUBsKREcwYFqGC1WP3nmkLDnVpfoWBXU+X3LpStkN+q/+t2hFmY0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HJiSIsee; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HJiSIsee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlMf4BG0z2yCM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 05:38:22 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J9TV1A3952986;
	Tue, 19 May 2026 19:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M1OLEal/ff1Xc9jJh
	C6bzziCcZCN5OGWK0Vyc1dZhGk=; b=HJiSIseeqQaSw/+o6FJeyvlA//XkOC8wO
	OLdvMVFrpuwraBwvHwNIBknkuzBJVA0NfO2r619NQTc52sWdqU+DDC/WBwlHZXBM
	JuOKgvcuuFJeLKJ8oHYiI7cz7VAM9wXjTp3KYjMtkRJMkh4W1iIOQWwmHnvH79Xx
	0N1NbQLKLBZVkN7NogeJhh/e+9mXJLywmDvis7al8jSm9ZlVhZ3RmUkl57Mt1o13
	BiI+53uAryU0ZyYMFBZsMTioslBZzPU+Z39J0ox9V/8XZ+SqiMhoMgfODCYsK8jT
	Yk5XGdhp/tdAnAoMdZIjarNpSWRzvDA8cV4iOcCJbcIg6VqZ5Jekw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xxvgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JJOFpE023848;
	Tue, 19 May 2026 19:38:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhm58x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JJbvP049283508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 19:37:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C83C20040;
	Tue, 19 May 2026 19:37:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C14B20043;
	Tue, 19 May 2026 19:37:55 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 19:37:55 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 1/6] powerpc/bpf: fix alignment of long branch trampoline address
Date: Tue, 19 May 2026 19:38:07 -0400
Message-ID: <20260519233812.18787-2-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NiBTYWx0ZWRfXy12VjEoybycZ
 2GkhAgzSOMD1gwPerBoR6h3yZvIBgV+oNOsn60W040IGqlu+3sukcwCvmttMvEreR85qu3WoaiV
 835k+NJdY978zWha5ZRcN86G+IwXCAVDnzGgYuMJoPoZYAhQ/HehV/LaK71mj2OKIKUgTkYW0YG
 t7/AOqF1PF6i+UEWkBI46lNRnHvkvQ3fTOJx8phpteNogEEc5+ccvE19rBMi/kgUD9ibZgAJjut
 6Cd/FDFhzuvQyFdF9eEa+lKkc/FgolI5680tEcJ0CGIkwsDPOzR9pYBHNvy/3JPzEWJkhYFEURZ
 +Fa6LILZO5O75/t+Ctde573oV5ai79cm/iuOkePRgQ0yaX1I/Hp4I6wWyF4RTzyCBc6SNcX3VFf
 jdYH7Jj5VdVGphG8tn1uptLgcW5xkQB9CCyYdqCzXQotRGfXvulsT8ujZGPXKfToW9aF3iLjBLG
 CTIWhyzV1sUxHZ+bXNw==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0cbc1a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=tageLvkH9Vam3SOoJP4A:9
X-Proofpoint-ORIG-GUID: -VcPibKlYGaOxe_FsRALU5oa3yHz_qWB
X-Proofpoint-GUID: -VcPibKlYGaOxe_FsRALU5oa3yHz_qWB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190196

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
 arch/powerpc/net/bpf_jit_comp.c   | 38 +++++++++++++++++++++++++++----
 arch/powerpc/net/bpf_jit_comp32.c |  4 ++--
 arch/powerpc/net/bpf_jit_comp64.c |  4 ++--
 4 files changed, 39 insertions(+), 11 deletions(-)

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
index 53ab97ad6074..00b86ed97cb5 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -49,11 +49,38 @@ asm (
 "	.popsection				;"
 );
 
-void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
+	int ool_instrs;
 
 	/*
+	 * In the final pass, align the mis-aligned dummy_tramp_addr field
+	 * in the fimage. The alignment NOP must appear before OOL stub,
+	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
+	 *
+	 * dummy_tramp_addr must be 8-byte aligned for load-register
+	 * compatibility. Since fimage is guaranteed >= 8-byte aligned
+	 * by the allocator, alignment depends only on the instruction
+	 * count offset. The OOL stub has 4 instructions (with
+	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
+	 * before dummy_tramp_addr.
+	 *
+	 * Emit a NOP here if (ctx->idx + ool_instrs) is odd, so that
+	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
+	 * aligned from an 8-byte aligned base).
+	 *
+	 * In pass=0 when image==NULL, conservatively account for space
+	 * required to accommodate alignment NOP. In case final pass skips
+	 * emitting alignment NOP, the image buffer have 4 spare bytes and
+	 * jited_len signifies correct program size.
+	 */
+
+	ool_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
+	if (!image || ((ctx->idx + ool_instrs) & 1))
+		EMIT(PPC_RAW_NOP());
+
+	/*      nop     // optional, for alignment of dummy_tramp_addr
 	 * Out-of-line stub:
 	 *	mflr	r0
 	 *	[b|bl]	tramp
@@ -70,7 +97,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 
 	/*
 	 * Long branch stub:
-	 *	.long	<dummy_tramp_addr>
+	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 *	mflr	r11
 	 *	bcl	20,31,$+4
 	 *	mflr	r12
@@ -81,6 +108,7 @@ void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context *ctx)
 	 */
 	if (image)
 		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
+
 	ctx->idx += SZL / 4;
 	long_branch_stub_idx = ctx->idx;
 	EMIT(PPC_RAW_MFLR(_R11));
@@ -107,7 +135,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
-		bpf_jit_build_epilogue(image, ctx);
+		bpf_jit_build_epilogue(image, NULL, ctx);
 	}
 
 	return 0;
@@ -286,7 +314,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	bpf_jit_build_prologue(NULL, &cgctx);
 	addrs[fp->len] = cgctx.idx * 4;
-	bpf_jit_build_epilogue(NULL, &cgctx);
+	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
 
 	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
 	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
@@ -318,7 +346,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
 		}
-		bpf_jit_build_epilogue(code_base, &cgctx);
+		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..95bda0dee925 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -229,7 +229,7 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 
 }
 
-void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
+void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	EMIT(PPC_RAW_MR(_R3, bpf_to_ppc(BPF_REG_0)));
 
@@ -237,7 +237,7 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 
 	EMIT(PPC_RAW_BLR());
 
-	bpf_jit_build_fentry_stubs(image, ctx);
+	bpf_jit_build_fentry_stubs(image, fimage, ctx);
 }
 
 /* Relative offset needs to be calculated based on final image location */
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


