Return-Path: <linuxppc-dev+bounces-25947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A21C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 04:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPHDh2mQ0z2yMk;
	Tue, 18 Aug 2026 14:44:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787028292;
	cv=none; b=h6ZOE7CCfjfZqaut902w+MDTyo/+VcaTm/WlFXNsYCjBV/OeJuVOCDYyd4DoCZqr5U3hz3J7R3y7qmAcFoYbODrxkLf0WwFWfj2W82EGXjDBcR23KTFDANvxJGBXxuGWNIIC8JhllsCiegwACAT0z5E0S8w5HKleshw2+aRAcLxq28XaGsugmI36gayEQVOZqjKSngvj+4oN+hlv9RYL4w/eB+3CwqSwgk+67MTg6IRhajToQ+wXiS/g5O/Cu675tX1tckw59b9aV++9xOPxg6POmaSPfr6G95IFid7d7qqwrOa4G4L1PFS89VQWse4Cd7Zx/yc1DAzs7pBNEzg8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787028292; c=relaxed/relaxed;
	bh=VNoeJ1pi0IaQw+BsRbeWlLnMs+GZmcWZQJyyRm1dwFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkJjdvfBUZyo3gZLQ4QnNxZIz14r0w1lTaehW0izCjfZRAVi7/Z4RG+rjVNvhyU6lzRS2mD+nwvL+K//zO98lK3F0N1O2zsYeZSiYApHjniGrYvuPLeXgia+R5vyx3/VChv0spvU4YAdeN1fb4EqU3iIL6QT6bXoJPqC+gbx2FJv0sn+CJ2xeC/aKYUSxyn7qLkm74chnzLw0MMeEsjccfZ/QjTj4aAKE8qlz03t5q/qYUFLpcnWN7+C6obj2XDGQpwURxCTtgLc9d+/XN2FAcVgwDHViPQ0nf3wgToEZ1hWR4HVT1QcysUkrMuKFKm8YB5OTjKVYUUFMtcs5kF76w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LejyrPZt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LejyrPZt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPHDg3slHz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 14:44:51 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1jRi2669108;
	Tue, 18 Aug 2026 04:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VNoeJ1pi0IaQw+BsR
	beWlLnMs+GZmcWZQJyyRm1dwFM=; b=LejyrPZtnuQpzIlSfsAuM0vS0vxDa2Mio
	MtywJRlEYeabhMAeI1bRANvv10H9DrFZkebEhXTsTnPY4BTab2+Cn+g2NRu8jZXU
	2rqLCzzDQOwJbK0mqVt3qz+hyPQalrkr1rC5TMZlia9p58VUlUtAzYICiTCCfOL1
	d7YxlXjJqT3Oo9g8d7UB7+j11NT1jeYc1n6zZPPfa4P+188T/XllUfcd+ppDiWC5
	AiiPRmjJTd/pwaLZaHnXpDvlPU3JljoeivJR9ZnNLrBBgNqdYDeKX3LBWL4s+iVY
	521esh5lVVo+wPKWs967xF0MzDzKxLIP4UT54hF0TqnW2sd+tqh+Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt5jnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fKiZ028611;
	Tue, 18 Aug 2026 04:44:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq1h02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4iSY747055352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:44:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B22D2004B;
	Tue, 18 Aug 2026 04:44:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9636320040;
	Tue, 18 Aug 2026 04:44:17 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:17 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 3/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Tue, 18 Aug 2026 10:13:36 +0530
Message-ID: <cbbffb007454434ad67a7a09cfe26bd68e1edb5c.1787027080.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a83e331 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Lb6AdhTzggfNSiIQzXIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfX5P4DFg59l1Yj
 BUgW56npiH28bO1InjgN6LHBSbk2rp9fAaJEJz9IRyw+IPdtnRtOGorHZXrKSqpxpx0LUogCy+Y
 t5UnViITjpb8u+82PWBtD1194/yX378=
X-Proofpoint-GUID: 7__X4WYXxZCTUyIknnoXO2KMLUp2aYfj
X-Proofpoint-ORIG-GUID: 7__X4WYXxZCTUyIknnoXO2KMLUp2aYfj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXxJAQl6xLyhqv
 9qiLDGzgqmdZAXbVmlo+fxgk96NdjTuatEKdtfMaHAB+3rxoi/2OJWKOc+z9eR6xjDwmu+9Z76C
 tp+2mAyu74Kc3qW7x6jZCWH5IaWXYQ4QoqoID706hAakaaQEVu3kxYZTzZx++n379dC8MM0wFdi
 7JxJU6drbUFof4y9+JJXfOG1jT1SPoURctvPXO4k+9T4fjOpjFg+Hz6Zz3OtMcaiw2iEOyB+hqC
 /3wxh4k0KnzpKCxYgWWOPcsSaIH0N3DHP8iuwuWATWsOA+yB2KgzcvR0IQ23YZwhq6qyz8IDzr5
 RRnSSu+P002p1hO1/6lMWxiIrkotlXujvp02YV7h0hj1uGTPJofuvD8fPTKjD02B92cGFwshuql
 KqErCGVwOE8KLqINdlsWIX/dbfIoLvzYk5DL6bPgFcIzaah1sD+SUt35fnTooGyN+r8Cu+fAiMI
 uWVHdUL6qagsp6jy0VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180031

From: Abhishek Dubey <adubey@linux.ibm.com>

Move the long branch address field to the bottom of the long
branch stub. This allows uninterrupted disassembly until the
last 4/8 bytes. The last bytes exclusion is logically necessary to
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

Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 46 +++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index caea53cde063..870cbffdbb93 100644
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
+	 *	.long	<dummy_tramp_addr>  // SZL bytes aligned
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
@@ -1313,6 +1312,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1320,14 +1320,14 @@ static void do_isync(void *info __maybe_unused)
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
@@ -1429,10 +1429,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
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
2.55.0


