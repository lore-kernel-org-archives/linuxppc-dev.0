Return-Path: <linuxppc-dev+bounces-21670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F714CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 21:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRL454nbMz2yfs;
	Fri, 29 May 2026 07:59:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780005557;
	cv=none; b=ozMwUW43Kj+INnsoI4cD2vD8lauNVM8Yb2SkWlpSKC0Eh3+wIWbSD61uWbhy8fyJ03mwbDJ1NOl2mimDBlzFzKvvxdFxdkuIFL0UsPdn6zg6HXXJ+ErXcoW7DeVi/z/a9iBrnpN2iBmoh+g2V8+LML4zXd++uoCIw4b1kF+au4msnMXJMsyRcxocNRL6Hd6d9PNaScxvtg1N1hzu7kzSiLm7ytqT4tcFsbRfbWtw224IFd/4wopO37Vg3ei/N8d9mf1jwakPuqkFb8vitENEM6jkqvMB2iB7OyMr6y3xI+TxURi1/3iJNzf5INEUSZ//DbsZ/FWsavu19fcaVVmPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780005557; c=relaxed/relaxed;
	bh=rqsPjtKw/chYKAwgy3VfL0g3fsmTrtLqqRsaawObWqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=is43pPywJWL7qkWKTcZ2+RagXkfoRPOlTxX+U2QAVD+saUOWszynd4rJm7jZn2f5RTU2VUps/IpEP+w17ds4XbWi8MjpPV2ao6TR2JNFSNEAMPmbRCf+Jnj/jChp5oBS5JfqawmFYYhrdcjv46dWIOAjD7hpssST0WTbzyG8og07LX+5R8J3srzffyiYECRaz3b2cPSfhJvLZPyyO33cIhMprkq9GSCfxyndQ/gG54n7m+0mYHWkVE6MQPSXw6NHE4woggiGxXM9hvHOwkX8XHd08iBGsBUIBFS7mU2NyDFW75ZI3h8T7Pp8htZN8Rayr3s0s/MLWqzd/1w1BfSmAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KAvkVSo+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KAvkVSo+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRL446vYtz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 07:59:16 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlvpg2418445;
	Thu, 28 May 2026 21:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rqsPjtKw/chYKAwgy
	3VfL0g3fsmTrtLqqRsaawObWqo=; b=KAvkVSo+6LTBiqV7sK+kg6wNRE2Wq5iFj
	PSk7KhnH+4cw2O/OSP9aSBsf59dhPtwIRQTIpcCpNAfsPPxg+DD3fGjE1DhwaWnJ
	2z2pBh8WOIGfXcpfLpXTin352z2oUvxZ7mo1NGkVkn/maVleK7LgLoJ+TxT0bZu2
	XJhPekkqEcWY1Bxfjn2J8rJTCjHg+kDL3f+qadh//MYVfvYFBwQlckMA9ww/ASkT
	QOe/vnIO9QyLyeKC2coKidwnEnMlIuM6nu7MCjtaiCDXepPNsb1/gg5GvNKziluJ
	pR+S2criEfW92MlKDJmUmwTIbt2g2rN/NouWJD4qZppfhFhKPb80Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884nenp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SLdCCG002630;
	Thu, 28 May 2026 21:59:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrba8jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 21:59:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SLwwGI13894038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 21:58:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CDBD20043;
	Thu, 28 May 2026 21:58:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C1E320040;
	Thu, 28 May 2026 21:58:56 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 21:58:56 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        bot+bpf-ci@kernel.org
Subject: [PATCH v6 2/6] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Thu, 28 May 2026 21:58:51 -0400
Message-ID: <20260529015855.364704-3-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260529015855.364704-1-adubey@linux.ibm.com>
References: <20260529015855.364704-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a18baa7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Lb6AdhTzggfNSiIQzXIA:9
X-Proofpoint-ORIG-GUID: qZDytffywN4KN3HqmUb3cVxWIddK-ZBa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDIxOCBTYWx0ZWRfX+cBY01vl0+TZ
 mHOAs9MwZ91hUmhfCFOY1SHH4Im5IZZLJj0AMhKTWdgBp40Z/UlO1Swq4J4fwETOKXextkEfEfi
 yWmePV06L9J9us73o+4RZvM41V/fdLwECeF9p4IC4ZwrmeY/Xvoc68x+kfEKcDwfJ+iV9Z4aC7O
 yJfq/IMHxH05deSw3J+45GoWd56QLYYJL8I6Fs7E5XvwClaikPJ3OsnFcYEisWYbtdkJOua41lq
 m4TTxAstWUvrZbroWzAJrll9IZ0w9TXOfHs1EeM6rZfpuRXFTMMDGKd92BeJdkJgWDZPbp0z5T8
 XVTHkufOMMmBMFa7ZsIvs0Thcd5Wrc1sdQTkfNCT4vFAGyshMTBkqENE+YAflcSbvws2kffE93h
 ZW25jUS96B/wClW78zmJ1VqjANRMNwiGsSB8kc8oKsqyaMK02k7wK+kq1AoJiSIGyf+E9cTMFH8
 8KIXzep1oDP2IEMH8ag==
X-Proofpoint-GUID: qZDytffywN4KN3HqmUb3cVxWIddK-ZBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280218

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

Reported-by: bot+bpf-ci@kernel.org
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 46 +++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 3492d82d147f..9885a68f64f4 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -52,9 +52,10 @@ asm (
 void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
-	int ool_instrs;
+	int stubs_instrs;
 
 	/*
+	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
 	 * In the final pass, align the mis-aligned dummy_tramp_addr field
 	 * in the fimage. The alignment NOP must appear before OOL stub,
 	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
@@ -62,13 +63,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * dummy_tramp_addr must be 8-byte aligned for load-register
 	 * compatibility. The fimage can be non 8-byte aligned, so final
 	 * alignment depends on start of fimage and the stub's instruction
-	 * count offset. The OOL stub has 4 instructions (with
-	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
-	 * before dummy_tramp_addr.
-	 *
-	 * Emit a NOP here if (ctx->idx + ool_instrs) is odd, so that
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
 
-	ool_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4*4 : 3*4;
-	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_instrs, 8))
+	stubs_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11*4 : 10*4;
+	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stubs_instrs, 8))
 		EMIT(PPC_RAW_NOP());
 
 	/*
@@ -98,28 +96,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 
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
@@ -1289,6 +1288,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1296,14 +1296,14 @@ static void do_isync(void *info __maybe_unused)
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
@@ -1405,10 +1405,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
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
-- 
2.52.0


