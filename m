Return-Path: <linuxppc-dev+bounces-19233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88317D6AB10
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 20:40:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmtz71qzkz2xls;
	Fri, 03 Apr 2026 07:40:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775162435;
	cv=none; b=jQadvMIIJEVkbPAczddaI8RKBbGOFZ6cVbxLat35dOPEGHxBmDefUM3CuivaDT4TwW5sg1ZowNWmD04rYeT9bLr/SlvtCkjgoTX3qC9Sa0Fh22m7Hk2zdirUdUJeugVqpFIFQ2I0lDRiSR0Uj+MBEbkxpbunRKNBygbS9h0b6+sHUS6CQJoMA2zZnq5Q/liIcnK4keqkLmHckn2jv/cR6kDd0qfEDpYFD5g1Nilr0mW/x60y4Jfs3KDouNSeJzQHJwlIj9FK+lirBXDHM8634Cn8QASbLGuf9E/VaZwGJXrcGIjs8CwUqPM9UGMq6aW1DRkdPB5Zue06pG540B2SPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775162435; c=relaxed/relaxed;
	bh=ElHlGoYhMZvaZJfevYH+kkwmc//+8gdtGxhxzXKnApM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpf0Wm2xZNaZAw+dhRNJZc6GRPPPrDgwOmjl9nDlTjxvBVxMUkgC0YYncHiYzyei7aTNfE1bz47GXaFepnOCYEuazI5Or1w+SkIh8TozWp7WJXkqZ5Ghm/5M0Qsesc0t/FTt2ZaKm5v/3B+L4cRQlRlLXIyQaA4ZkvymwETlDUMGRo41d/O6PdCXbxwqc4bCwd0nsTfpQpNc1uymUI5NF2syfYIf5MHVzVbZ7K7RMmgp1lXJd5C1menycGncZCaBuX8UWxvmVLD1hW42+Q75TCJoGQot8Q/WhjTYJeuYnXiyBo3yhEIKFrUvL4e2qq0KbOzWnLYWJBs5P0AUgjmd7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EiPwsbaA; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EiPwsbaA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmtz647rGz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:40:34 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632Cxu51445873;
	Thu, 2 Apr 2026 20:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ElHlGoYhMZvaZJfev
	YH+kkwmc//+8gdtGxhxzXKnApM=; b=EiPwsbaA+s6lTI7ubGfA/2/pU5aQJgoO9
	BUa5bt4X4oCLZnkyGSQz2mGeM1jadR9PnYTIXHxJ5Sb2ojJEN22WzPTAeiZ0qtx0
	H/4/FfpteHeZnHc/37PZFVMhI1gOQR2XPiHqXJw3CzD6jF+Z3cvYyeLSwpMka7ng
	dx31VHHbcTJHqswcNQ9YyzhLGL8+0lONphlDvBO4Odjb+akHGfUlg0uR8UPw5Tu1
	u167KEsAqHhDm2eNR+cSXQiZ6VOfZu9KZbgtIxmjokGMNxVwX4BYvx0sOoL15BMf
	nQr56C+4X4nxCp6N5Ezja3HMnzPNj9WfzvhtwMeIerjGkEjhWbgow==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g26m19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632JwgmV006362;
	Thu, 2 Apr 2026 20:40:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spybr1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 20:40:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632KeEUj49021192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 20:40:14 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BBD120043;
	Thu,  2 Apr 2026 20:40:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86F2720040;
	Thu,  2 Apr 2026 20:40:12 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 20:40:12 +0000 (GMT)
From: adubey@linux.ibm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v2 1/5] powerpc/bpf: fix alignment of long branch trampoline address
Date: Thu,  2 Apr 2026 20:40:07 -0400
Message-ID: <20260403004011.44417-2-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403004011.44417-1-adubey@linux.ibm.com>
References: <20260403004011.44417-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69ced433 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=3Zv-X24pnbuftgYs6HsA:9
X-Proofpoint-ORIG-GUID: 2HHi8Yon406oz8mEtFKepZSgvswjWp5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE4MSBTYWx0ZWRfX+IJgG9XwO4SI
 fTAGKUMZX2D1hK51ehKXbqwoI1LH67ldPfpxgqIzNlQGIJRQ6f/KXJuRCGvE33D6Iwy86Zdfo08
 POoPWvo++Nc2Hi6axiZfZpE0GOB/LCGkc41zSGllxnm+I69g27PTuGF/+PdnLSrGG1DnCuNtpdV
 jrmJFAbgHK9rAS8a378GWgyYFr5QViC5cfLC0B3FFTsEMQgKeIu9443f58m0gxxvgtcIRuUOb88
 lWjharVqxoJS/dqWvtF5CphPvyv82xLN1Bd6h/0hhEpj3qxmcQOvMpbkiWkn6eeMLbcrInn7zgB
 SmRzwQb9Xb0Kwj4fhfHu57HKYtFY3V5hq7tWdZWUSYry4UzjYO1pId1U/JPceJLjBV/I+WWj8Nr
 uTsCr5KESqBSVBurqFm6xxBeqabTYnWKtQ/+a7ALZJpagPgOyeHkxOfid27rijH8kWs2/g+Tl7g
 1oUdIENH8nqQxlNqhtg==
X-Proofpoint-GUID: 2HHi8Yon406oz8mEtFKepZSgvswjWp5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_03,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020181

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure the dummy trampoline address field present between the OOL stub
and the long branch stub is 8-byte aligned, for compatibility when
loaded into a register.

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
index 9b2b456b0765..3cbb3647f7a0 100644
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
+	 * In the final pass, align the mis-aligned dummy tramp address
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
@@ -308,7 +332,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	 */
 	bpf_jit_build_prologue(NULL, &cgctx);
 	addrs[fp->len] = cgctx.idx * 4;
-	bpf_jit_build_epilogue(NULL, &cgctx);
+	bpf_jit_build_epilogue(NULL, NULL, &cgctx);
 
 	fixup_len = fp->aux->num_exentries * BPF_FIXUP_LEN * 4;
 	extable_len = fp->aux->num_exentries * sizeof(struct exception_table_entry);
@@ -343,7 +367,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 			fp = org_fp;
 			goto out_addrs;
 		}
-		bpf_jit_build_epilogue(code_base, &cgctx);
+		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
 			pr_info("Pass %d: shrink = %d, seen = 0x%x\n", pass,
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index d39241444cd9..57992c1e8386 100644
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


