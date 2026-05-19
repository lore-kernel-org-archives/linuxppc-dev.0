Return-Path: <linuxppc-dev+bounces-21184-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059A1CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 19:38:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKlMg0Hq7z2yFK;
	Wed, 20 May 2026 05:38:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779219502;
	cv=none; b=VeemVU4FEf+KFRAabiMR+CyBMuiC6dpjDD0GsuBuby9rHdal13eYuRIKh2cMyygH/d4NkaRvZuh4ZOAAczEsmr5zDKHi5Hb7sLQNkJjYXcY0IQeUeucJbjvNJB31p7khLbsAfzglUbW5WHoY0jCqmVkv3ElxxbJ4tu7ZH10Jzf1E97Xnc5CO5YD3dIZoHJ4RHEdbRhPa35sPsRPoe4gl3jcxWWeiH7KGAyKRHLGd77tZeIZj32IIfhJywc9VEwlXY8jU+viRIylncvzmr+L3DbGEgbogEnJO6v+TEiJFFvsKLt10FaT4JbGW5tz+vz7GDQcKQ7vdB6dMpZDz//G7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779219502; c=relaxed/relaxed;
	bh=KjeIqzrx14MzELBl328sI8stsSxQnlBSGg3BMM+DOLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsoL6Jr8+ufli1gjX/OX7LiRSq/iuaj8yuvWQNV4h9HOoVbMGUXew6a2+rJ7y6iFluuWo7YAHbJfq+tdXUrtX8mzIfjnSqIPWuZ57MWmxhXsyTc3FUZWk9cyQSR9E0GPLimWf1uy0M/tff/EbeRUaX9p4RmCkdZc6t72UY3CfS8fJrOz+55MByxVYLv9wsIf683255FFxTS3eFiRPpvspStM9Icj55ppvyu659ayEf7t/sPPvdFIzVwQxSttITxaJO3gsusW8NGLJvj4jsD82e5J16Mg5HnAgjab++dONPIxeEIuxeIQW/S6t/UBn3b7moz0DB910iwBra0ENo3KKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RYGVD8r/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RYGVD8r/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adubey@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKlMc68KSz2xSG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 05:38:20 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JG9GEY883231;
	Tue, 19 May 2026 19:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KjeIqzrx14MzELBl3
	28sI8stsSxQnlBSGg3BMM+DOLw=; b=RYGVD8r/Pd0GhBHmSgL88NgUQ6rfa+Y1O
	ZLOLULMbwE44+9Mlcc38n3z7dZPqE86PIiMYkkNNUhOErCGx1yZpQJuMUkmOesIR
	wjkGcbxMBAdOxWv5YjgPcmh8+lkje/rNnSDrJJI1QCVxPR8BLRv61Lj+8nM696WO
	rTMvH+RewxF/STwkHvHqlIRlKAAThfRS96L1zzc7va12elvSvZYy5EyiCqTm9Q2s
	lXoVMqOLup2rx5ARt5xsZwyRq5Zne27ro8vKGbETqW9We/rZWgmzGLUIZ0/WeovY
	YH9uMl639cN4ljilznvrSsGVZVJjUxHkOZpCVmfXCExBvKgrhz83Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mpt75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JJOGje020218;
	Tue, 19 May 2026 19:38:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vvbyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 19:38:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JJc1we23200094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 19:38:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5663D20043;
	Tue, 19 May 2026 19:38:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5521D20040;
	Tue, 19 May 2026 19:37:59 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 19:37:59 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v5 2/6] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Tue, 19 May 2026 19:38:08 -0400
Message-ID: <20260519233812.18787-3-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: F_wq_G0CGo5Lvj_t-0JA6JvSY2cuTEZe
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0cbc1e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Lb6AdhTzggfNSiIQzXIA:9
X-Proofpoint-ORIG-GUID: F_wq_G0CGo5Lvj_t-0JA6JvSY2cuTEZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE5NiBTYWx0ZWRfX9QZ27V3KV6Tc
 fnFxClMx0XJ08UUdFRqufhftMbAM9wVIUX/+kIl6+435I9GZ3B+QA6b/MZFiLBv+B+on8Y5iu98
 GmXHoMxSoOB/u4SeVxQcq2hRVVILEf7W1O+G6R/l5kuMMab/UbB0LdwuNxAWLgxTNV8AtdjBXR/
 2zXlAFGxfonXIX9V6PulYezkDwfptU0HOehJW978CMdAypJvRoSGJEIqWEZ6MmSJY/eQHbJQpul
 tjLyFTEoZlY7l3vR0zDo/6AoJ8xBty/hREjSRqvbGyTd+GyCk4VyU4qHNNUNKuqtjmbhmR+z9W0
 dtOsO9ketRKuzmi+mpFn8XM2t2B/m45iEa3ZgIiWuRhnqdiUMuV05nKlGEIuwGTPYRJUYo+fCc/
 zQBog+cteU0Sx9W2MPxeNxDD80h2Ri4akj2PNFd0RAg+S6zDCEG3pgxgTQaHds1CUoLNGiOKkhC
 A4pqFWp7l7he9ugPjFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190196

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
 arch/powerpc/net/bpf_jit_comp.c | 41 ++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 00b86ed97cb5..56a923d3908e 100644
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
@@ -62,11 +63,11 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * dummy_tramp_addr must be 8-byte aligned for load-register
 	 * compatibility. Since fimage is guaranteed >= 8-byte aligned
 	 * by the allocator, alignment depends only on the instruction
-	 * count offset. The OOL stub has 4 instructions (with
-	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 3 instructions (without)
+	 * count offset. The stubs block has 11 instructions (with
+	 * CONFIG_PPC_FTRACE_OUT_OF_LINE) or 10 instructions (without)
 	 * before dummy_tramp_addr.
 	 *
-	 * Emit a NOP here if (ctx->idx + ool_instrs) is odd, so that
+	 * Emit a NOP here if (ctx->idx + stubs_instrs) is odd, so that
 	 * dummy_tramp_addr lands at an even instruction offset (== 8-byte
 	 * aligned from an 8-byte aligned base).
 	 *
@@ -76,8 +77,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * jited_len signifies correct program size.
 	 */
 
-	ool_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 4 : 3;
-	if (!image || ((ctx->idx + ool_instrs) & 1))
+	stubs_instrs = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 11 : 10;
+	if (!image || ((ctx->idx + stubs_instrs) & 1))
 		EMIT(PPC_RAW_NOP());
 
 	/*      nop     // optional, for alignment of dummy_tramp_addr
@@ -97,28 +98,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 
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
@@ -1288,6 +1290,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1295,14 +1298,14 @@ static void do_isync(void *info __maybe_unused)
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
@@ -1404,10 +1407,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
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


