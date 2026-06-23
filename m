Return-Path: <linuxppc-dev+bounces-22938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18498CDB470
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glF9z0K6kz2ygh;
	Wed, 24 Jun 2026 05:14:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782242071;
	cv=none; b=WLLPSZIcvFQuYkuI5ZFGYVI1uIMHvqUWsfCToj475nYp5LwZtdRk8GjtRKkgfRFScSx6vasf2YqaQfQjLIxNzUawl0ATFciC/lvrDAtqSCS5fZMR4oEr3Hhtr++CBWKaDuAAUe37rSjGYlAWzTqZ9qvri5TaVdsbkr86qMM8D/apryc3UV0khfYoK4dgPUx8BxQiYmw3OsB9aV6hqK3waQVkXYZ8MaWazZtdnYSjyVBrI5KrR6aI/naqt0vHX7NsPW5VrkAHrSYwOD6xfvuxXBZg56ACO22bfo4rrciXOhyPrrky8pmqoaaFrVmm2inTWUv+bE4Jbt0fJ5xMbo3vPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782242071; c=relaxed/relaxed;
	bh=POq00zGX1MSeLgeUhwKIIr7K72QlYu7l0zuSosQqLYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVimBqS8M7SG2wIaOfcCQB1sVfWzEE58aJmpLqkp4AnlCoI9/ExUaxtdxSh0f9suA6PcCie119Z6Wf4U08NDcHSvgWyskJVKXnCr2X5zhWqFjNW746+B/r3YIbSBiqgnMabjhLtPvIi/vQG7hOt34gA7uOaR/MNJAbjF0p5y+Y9NiaYsEZainB6b9lFurm/lyLMJ+RygAF1ATEjeD2k7wSaotMnV0nkORglhg2bump3q7i23qdFQLOLQwH6hyc0tiBNQ5sAgCvuOh3v6kQ8cU+E/Zp3ldMjIiZ5JtHvPL+TYwDkzhXlNiToX7OhPvWcanIq6mpga9WzDlg5Hro0+0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SZCiBmJb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SZCiBmJb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glF9y1NQLz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2026 05:14:30 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmMtx2135782;
	Tue, 23 Jun 2026 19:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=POq00zGX1MSeLgeUh
	wKIIr7K72QlYu7l0zuSosQqLYs=; b=SZCiBmJbMka334Ja1+sGF3GQ5JVpplHLU
	YOoD0axSyrpZzH1hchBqHzQcFZx2l68EQ8cKPFdpRJXgiiE3O9lQqAeLZXFPn9dy
	kXvPKT1ewdZKs9Mr/0ROUsKsp4aLWxaTorkbLvir2o2OWcSBQi3Fd6PdZralwuF+
	ZeGc/gVma5W8A6KpUZyojuCk0L/JpxyzAabcdsMwPHYXuI3TahaXqvH+eajtpIYM
	RQN7RNDKJ/X9H68p8XmdpFe4BHLLAHdmXtZSPsXJ0xnMkOsJXq1lRBbL0zuYiPdq
	Rb/toS60LCocijXiYbsEGzZKP3yGJkwq9jMFoNqCzzysDavTISLUw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqrcrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4dX4024854;
	Tue, 23 Jun 2026 19:14:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qd5xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJEARI43581888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:14:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F372004F;
	Tue, 23 Jun 2026 19:14:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACD5D20040;
	Tue, 23 Jun 2026 19:14:08 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:14:08 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH bpf v9 2/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Tue, 23 Jun 2026 19:14:05 -0400
Message-ID: <20260623231411.6216-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623231411.6216-1-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3adb07 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=zNWzhmgQJiTj23IEir8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX/qDluq13FDRf
 aRIgHACpz48nbzlKV7N4eV5lgbkTpAEKj5+SGGDO9Z6XF/BYbDbhKnpjuuZj1QohAebAYTAdRQ+
 gUkhmaH4/VmFnTePqFUh7ko3P06Av6geR1JFZyhLNOxkZtdSrO3uqw0ZF4UJ4DWZoAl/EgHkqFo
 Rhppa6L2a89eES8gsfgtS3jz1UMXtSdRaEC+v4gZWsWz9FbTF6Ldlys93KaH8VQCFXMtoffv4LX
 PFL59RP4sQVO5z7Dw0s434bz8TtDMTpGAizNRoehE2ClaS+nxYXlCTEd6FTlJSyMi4yUxg7mKeX
 +u/h7cgQHDTGHhM0haoNEzi67rHqlMkpeDdAYtpmraAEX+M3OiCcf/iz6yNNxgAPt1ku9EQ+icH
 5Pi4ulxr84Ni+AR5xrrjQY7axNNnzw==
X-Proofpoint-GUID: YViJPrlwF3HjZJH9vUPaL_amcMgSKcJS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX4TnX9xlN7G06
 xUyWruyuwT3DAfS15BLUEaiN8wgee/YiY0iOC8RM+tCGPBfkQYaYkLsYVFx9O+qCrwVcELYLNq6
 9dBrWzrXBc18Wt327JOeP7daVKzt4lw=
X-Proofpoint-ORIG-GUID: YViJPrlwF3HjZJH9vUPaL_amcMgSKcJS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230155

From: Abhishek Dubey <adubey@linux.ibm.com>

Move the long branch address field to the bottom of the long
branch stub. This allows uninterrupted disassembly until the
last 8 bytes. The last bytes exclusion is logically necessary to
prevent disassembly failure, otherwise the actual program layout
is never altered. Hence no effect on overall program size.
Also, align dummy_tramp_addr field with 8-byte boundary.

Following is disassembler output for test program with moved down
dummy_tramp_addr field:
.....
.....
pc:68    left:44     a6 03 08 7c  :  mtlr 0
pc:72    left:40     bc ff ff 4b  :  b .-68
pc:76    left:36     a6 02 68 7d  :  mflr 11
pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
pc:84    left:28     a6 02 88 7d  :  mflr 12
pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
pc:92    left:20     a6 03 89 7d  :  mtctr 12
pc:96    left:16     a6 03 68 7d  :  mtlr 11
pc:100   left:12     20 04 80 4e  :  bctr
pc:104   left:8      c0 34 1d 00  :

Failure log:
Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
Disassembly logic can truncate at 104, ignoring last 8 bytes.

Update the dummy_tramp_addr field offset calculation from the end
of the program to reflect its new location, for bpf_arch_text_poke()
to update the actual trampoline's address in this field.

All BPF trampoline selftests continue to pass with this patch applied.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |  3 +-
 arch/powerpc/net/bpf_jit_comp.c   | 51 ++++++++++++++++---------------
 arch/powerpc/net/bpf_jit_comp32.c |  3 +-
 arch/powerpc/net/bpf_jit_comp64.c |  3 +-
 4 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 71e6e7d01057..6632de9871dd 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -217,7 +217,8 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx);
 void bpf_jit_build_epilogue(u32 *image, u32 *fimage, struct codegen_context *ctx);
 void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx);
 void bpf_jit_realloc_regs(struct codegen_context *ctx);
-int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr);
+int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx, int tmp_reg,
+										long exit_addr);
 void prepare_for_fsession_fentry(u32 *image, struct codegen_context *ctx, int cookie_cnt,
 								int cookie_off, int retval_off);
 void store_func_meta(u32 *image, struct codegen_context *ctx, u64 func_meta, int func_meta_off);
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a8e70a1cdb15..e36efc09e133 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -52,9 +52,10 @@ asm (
 void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
-	int ool_stub_sz;
+	int stub_sz;
 
 	/*
+	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
 	 * In the final pass, align the mis-aligned dummy_tramp_addr field
 	 * in the fimage. The alignment NOP must appear before OOL stub,
 	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
@@ -62,13 +63,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * dummy_tramp_addr must be 8-byte aligned for load-register
 	 * compatibility. The fimage can be non 8-byte aligned, so final
 	 * alignment depends on start of fimage and the stub's instruction
-	 * count offset. The OOL stub size is 4 instructions (with
-	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
-	 * before dummy_tramp_addr.
-	 *
-	 * Emit a NOP here if (ctx->idx + ool_stub_sz) is odd, so that
-	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
-	 * aligned from an 8-byte aligned base).
+	 * count. The stubs block has 11 instructions (with
+	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 10 instructions (without)
+	 * before dummy_tramp_addr field. Emit a NOP if the address of
+	 * dummy_tramp_addr is non aligned.
 	 *
 	 * In pass=0 when image==NULL, conservatively account for space
 	 * required to accommodate alignment NOP. In case final pass skips
@@ -76,8 +74,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * jited_len signifies correct program size.
 	 */
 
-	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
-	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
+	stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 44 : 40;
+	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stub_sz, SZL))
 		EMIT(PPC_RAW_NOP());
 
 	/*
@@ -98,35 +96,37 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 
 	/*
 	 * Long branch stub:
-	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 *	mflr	r11
 	 *	bcl	20,31,$+4
-	 *	mflr	r12
-	 *	ld	r12, -8-SZL(r12)
+	 *	mflr	r12	// lr/r12 stores pc of current(this) inst.
+	 *	ld	r12, 20(r12) // offset(dummy_tramp_addr) from prev inst. is 20
 	 *	mtctr	r12
-	 *	mtlr	r11 // needed to retain ftrace ABI
+	 *	mtlr	r11	// needed to retain ftrace ABI
 	 *	bctr
+	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 */
-	if (image)
-		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
-
-	ctx->idx += SZL / 4;
 	long_branch_stub_idx = ctx->idx;
 	EMIT(PPC_RAW_MFLR(_R11));
 	EMIT(PPC_RAW_BCL4());
 	EMIT(PPC_RAW_MFLR(_R12));
-	EMIT(PPC_RAW_LL(_R12, _R12, -8-SZL));
+	EMIT(PPC_RAW_LL(_R12, _R12, 20));
 	EMIT(PPC_RAW_MTCTR(_R12));
 	EMIT(PPC_RAW_MTLR(_R11));
 	EMIT(PPC_RAW_BCTR());
 
+	if (image)
+		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
+
+	ctx->idx += SZL / 4;
+
 	if (!bpf_jit_ool_stub) {
 		bpf_jit_ool_stub = (ctx->idx - ool_stub_idx) * 4;
 		bpf_jit_long_branch_stub = (ctx->idx - long_branch_stub_idx) * 4;
 	}
 }
 
-int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg, long exit_addr)
+int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
+							int tmp_reg, long exit_addr)
 {
 	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
 		PPC_JMP(exit_addr);
@@ -136,7 +136,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
-		bpf_jit_build_epilogue(image, NULL, ctx);
+		bpf_jit_build_epilogue(image, fimage, ctx);
 	}
 
 	return 0;
@@ -1289,6 +1289,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1296,14 +1297,14 @@ static void do_isync(void *info __maybe_unused)
  *	b	bpf_func + 4
  * 3. Long branch stub:
  * long_branch_stub:
- *	.long	<branch_addr>/<dummy_tramp>
  *	mflr	r11
  *	bcl	20,31,$+4
  *	mflr	r12
- *	ld	r12, -16(r12)
+ *	ld	r12, 20(r12)
  *	mtctr	r12
  *	mtlr	r11 // needed to retain ftrace ABI
  *	bctr
+ *	.long	<branch_addr>/<dummy_tramp>
  *
  * dummy_tramp is used to reduce synchronization requirements.
  *
@@ -1405,10 +1406,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	 * 1. Update the address in the long branch stub:
 	 * If new_addr is out of range, we will have to use the long branch stub, so patch new_addr
 	 * here. Otherwise, revert to dummy_tramp, but only if we had patched old_addr here.
+	 *
+	 * dummy_tramp_addr moved to bottom of long branch stub.
 	 */
 	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
 	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
-		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
+		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */
 				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
 				  (unsigned long)new_addr : (unsigned long)dummy_tramp);
 	if (ret)
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 95bda0dee925..f5b9441cf46a 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -1149,7 +1149,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 * we'll just fall through to the epilogue.
 			 */
 			if (i != flen - 1) {
-				ret = bpf_jit_emit_exit_insn(image, ctx, _R0, exit_addr);
+				ret = bpf_jit_emit_exit_insn(image, fimage,
+								ctx, _R0, exit_addr);
 				if (ret)
 					return ret;
 			}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 885dc8cf55a2..eaf816a07f14 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1726,7 +1726,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 * we'll just fall through to the epilogue.
 			 */
 			if (i != flen - 1) {
-				ret = bpf_jit_emit_exit_insn(image, ctx, tmp1_reg, exit_addr);
+				ret = bpf_jit_emit_exit_insn(image, fimage, ctx,
+								tmp1_reg, exit_addr);
 				if (ret)
 					return ret;
 			}
-- 
2.52.0


