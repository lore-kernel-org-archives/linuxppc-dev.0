Return-Path: <linuxppc-dev+bounces-19650-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A14BF3ED50
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 18:14:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ftMJK4K7rz2ypV;
	Sun, 12 Apr 2026 04:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775931265;
	cv=none; b=A+72+xh42vEOTio2buYYLgtwQutfCVsx0ocboiNgBznJt9HjP8joGlJnrAOa6DldHNWrWzCpirSCg4/jRbbFtUpesPckg4ZHWCEaU52DII+BhkwcEvIXUbzOTbt4srj5f7P6JahsnV7uR6DPstptouUAXQjhmbJBHspLAElVXFOt0e59wQyXGY189Meku0TOtOvSZjIs4xypXwvKnNWfBYfR7zos8Mimf0Qmx67PXiSGSLIt7ejO4hPqvF1hJABJKUQBAFKNw/UD4dDy6BywWtpgQsf9N/DlczKosFIG/qkipkk+5cSIJcEhOkNvmwh9hWs7FV0GXNjnXm8384VdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775931265; c=relaxed/relaxed;
	bh=5hX2IA1gVoidJXqVDB9SGb2K3fToT1fugzo1EB9Q+KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYK1fBzH6daFBQJzr9b86J7Bx5KJimX+Ug7wzQP/agyXL04ifnUgAJ6X4ULxC5wyEgy6Jelw24Vq8QTmpaDxv4e2D81SjKJc24f1dpdK/Uz+mpNljR2XCyVAD+4bW1OTEYcs//bV+prjlhXvMAFjf3g0A3SQsJwucJ3FWaSVcNDS4v0Ls1eMvUcNFvPKo7Vtt6N2QL+AMXHvtY7rDEM+uMfAUYed5xadvvhxT4CN8NgZyyPj/D62LmEGMYpUW1o4hPyBfQEPWR77bxQMkwNe99FJXAGVKBeVBVvIoxgoshdJaN2wlcrxIBrXNaRjkH5/2OPFWCU/4nqP96x5ag0ArQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i35IdX+4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i35IdX+4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ftMJJ3s6pz2yrK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Apr 2026 04:14:24 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63B7uL8v3062980;
	Sat, 11 Apr 2026 18:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5hX2IA1gVoidJXqVD
	B9SGb2K3fToT1fugzo1EB9Q+KA=; b=i35IdX+4DGswsMKbLxXnVUJzdsRNWOjJh
	4OVNxdfaMmJCO8WawLMbhyydIL6+hLWdboMx/d2TJkULx3M53siqs9Itbuom5MWO
	eaX3Q3Ld6lFeUBoxE7+/f+PANNzPPrCQSkJ8lVQpnVbNghkk58lue0ZurL4mVLjC
	6KUObBcvCsL5YvKcob6rfArbn/IYzeFunEx+MUsaNQwNtkHSwk2AwcVk001U6yDi
	V7x8UrXdqK4d2rvUNetY/S9bsrzGEdWecD1VWU4Zl8ZKHLvuF09HzJnSQOVu/kpg
	bKNOappvh6iao5yB2g8qW46F+WH35bPD3Ozbxzy0qLL2GtG+h6r6g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdxwsrmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63BD5RTC014356;
	Sat, 11 Apr 2026 18:14:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg5578b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 Apr 2026 18:14:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63BIE4U653215522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 18:14:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A82E420043;
	Sat, 11 Apr 2026 18:14:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1CF620040;
	Sat, 11 Apr 2026 18:14:02 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 11 Apr 2026 18:14:02 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v3 2/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Sat, 11 Apr 2026 18:14:10 -0400
Message-ID: <20260411221413.44304-3-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDE1NyBTYWx0ZWRfXzN8uFByKrmN0
 4evKjqxAdqx/IKp0JsmgMbk8F0MQ/uBn0gy/lMstIVUA9iK89FGCAJZhgPH0EArRJQelmmf+GHw
 BMUd0dfosh6GbEC0uACBaMoSQPbNsJhJhtMqVCwOyninu8cLh4SzjJ0tmsK5JoZgjtKhzlbloTh
 RdmEi4XaQOPGwTRid5TeWFUZ1MOOKGRcW2Nmame3tr8wwiDZjW6f2gVP5lTePW1wvq9CVb8ZwXG
 34Br8Is7RdTd0qwqVc5KJZn0g56w7m/vpOuMGhpQSK8DkJNIYRTQcyyQ8OUCuWZ9eT2/CM2fMnj
 Cv/mySN7GW95yIR1ULSmM8VCBDl0ETctH5oQ4aXQGGv8OJKtO5ng5lhPRBprLRbeuV+SWMdGcOR
 E+NQSsOCfqIcbzEbXXd3McjNEF3s4QKIyBlAuV5lIb423MeKHYTM6iBwNUVfv6vz4umCc7C1l1s
 tvTH9prgpLvBqwHvwUg==
X-Proofpoint-ORIG-GUID: LHHDgYUUlXZ1kUqaksyCTxxybqeQsxp0
X-Authority-Analysis: v=2.4 cv=TId1jVla c=1 sm=1 tr=0 ts=69da8f71 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=wRVbdlKoTiVShp7l6ZUA:9
X-Proofpoint-GUID: LHHDgYUUlXZ1kUqaksyCTxxybqeQsxp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110157

From: Abhishek Dubey <adubey@linux.ibm.com>

Move the long branch address space to the bottom of the long
branch stub. This allows uninterrupted disassembly until the
last 8 bytes. Exclude these last bytes from the overall
program length to prevent failure in assembly generation.
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
 arch/powerpc/net/bpf_jit_comp.c | 42 +++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c255b30a37b0..c2ac4e355464 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -58,20 +58,22 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * in the fimage. The alignment NOP must appear before OOL stub,
 	 * to make ool_stub_idx & long_branch_stub_idx constant from end.
 	 *
+	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
+	 *
 	 * Need alignment NOP in following conditions:
 	 *
 	 * OOL stub aligned	CONFIG_PPC_FTRACE_OUT_OF_LINE	Alignment NOP
-	 *      Y                               Y                     N
-	 *      Y                               N                     Y
-	 *      N                               Y                     Y
-	 *      N                               N                     N
+	 *      Y                               Y                     Y
+	 *      Y                               N                     N
+	 *      N                               Y                     N
+	 *      N                               N                     Y
 	 */
 #ifdef CONFIG_PPC64
 	if (fimage && image) {
 		unsigned long pc = (unsigned long)fimage + CTX_NIA(ctx);
 
-		if (IS_ALIGNED(pc, 8) ^
-			IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE))
+		if (~(IS_ALIGNED(pc, 8) ^
+			IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE)))
 			EMIT(PPC_RAW_NOP());
 	}
 #endif
@@ -93,28 +95,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 
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
@@ -1155,6 +1158,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1162,14 +1166,14 @@ static void do_isync(void *info __maybe_unused)
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
@@ -1271,10 +1275,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
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


