Return-Path: <linuxppc-dev+bounces-26235-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659D6C61DE2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 07:17:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYL0L75czz2yDs;
	Mon, 31 Aug 2026 17:17:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788160626;
	cv=none; b=Izt5KTUDNGHKHqFwSp7yKqHTjX24CYsHH945RbZY+M3LwFpAkXcxNxlaLd6l+KSpZcBDfWY4Nz7Oj3KnEwkf7hPoA0+0uHu5awEFZocNGufXzMquXAFkz1+hbnOtAUVg+t11z18y4Irqav8y+dX0DJ6fGdCC2LGTQTn5fFlhU4yv+LfALuLlETXx1ivlV1pGBS0u9gA+YZuvTWoWb020rLxxpQLN+M9zyl+btFZ2Ck4kqk3sjBBX95Lqtr5iGvumHeWvBA77nLcfyYiat+i4q6F7sH6DLWtMqTYCZnWFoRiAHdCVxrBqHJRksSPmEpaCBLbssKpdzBK+vmEtnsss+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788160626; c=relaxed/relaxed;
	bh=UEy3iBjU8KWTIdtSf5xsaOas6NtuvbMh7Q5dg1lFSNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWNyl663aWANtE3FYNjh5b3hYejAEur/bCr/w2gXDuyEM+sVKckyhoA0bJaGT9NYyVhgq/BkviMR0RmatbpkHAXAqNYV3dCNKa8ZwQ+BHh2L0sLftka2u0tq/y7bTSjrLJOictKxW/06fb7uhnJ8Wv3S9Pubg8xRTwAT90h6LnXuJzQbdaMtsGhPgGPgpjkdzwCAjcZfiscTgK5YgIN+f0KBmT/mjS3D4xxpEnD66YNxMPAGVatgqsmid2kNivv59j9rv43swH2a19VvZ79voV1u7fq9Eg2AjSh+ZFYgLRLgiHv+BwIkdTor6QsmH9eVSjzz2QyUWmOB+G6cQSrp6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cz6Q7fK9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cz6Q7fK9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYL0L1lqlz2yFW
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 17:17:05 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V53CIw1162965;
	Mon, 31 Aug 2026 07:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UEy3iBjU8KWTIdtSf
	5xsaOas6NtuvbMh7Q5dg1lFSNA=; b=cz6Q7fK9SwX5XlWwVHZiD6kAh9oX74d5K
	f8RplugpH4Z0x1xtgusj6DZOjd66GGl928sRw4E+9PYWPd0bCL6OJZ94+MyzllVL
	lHhtR0/ulnnvtx+RkhP+cgfdyb9umZsuWuK1uRQcND13joA7gJwmOMgF9hssIvK2
	lCCmM4yWhBkpPy6SvvHqRtvJ0+eCysXFE9a4pGeYMiQpwrsHVXCepWOoWYBuRqvT
	FJH+pS5p9kMHqXIylHJCsLUcLKn59i1npnKTt8Iuis3QLBhCCCL49zsrOWJAoRgn
	IAdkqwgFqdztdoJJNU+iiOv1bEeBve35n9OmtMzODC7xUT6MlJ9Jw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhfxeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V6ucNo007413;
	Mon, 31 Aug 2026 07:16:48 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h4fja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V7GiAj30933688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 07:16:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECCA82004B;
	Mon, 31 Aug 2026 07:16:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1853E20043;
	Mon, 31 Aug 2026 07:16:39 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.67.146.121])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 07:16:38 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v13 5/8] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Mon, 31 Aug 2026 12:46:02 +0530
Message-ID: <647e37d4e0049cc9c9a6977ac112a445f6ced6c8.1788154635.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
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
X-Proofpoint-GUID: V2GaiGJHksjPaBe3LJ4AHVuMjX6PU-Uk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX1zgSGkCy8+wY
 uNlWuKPClkBf3gNG+pN+tt+zux4y+8xCLrLzAU7DNHngKJ9sg8u21PULmwxzO7WNWNgBQ/4MH6d
 /2Ix58o6BReNX/qyeTMO/kHOtQOMkEwscJ91B9ShlFqlq3fZ3xLEUahr5toT7RwlkbB9+PuUqAt
 irphw0jErT5sYw7fRC+LFrBvhNchLiVA3LeYHF8S1JqK+d2oZlbkFERDxaZphZ/i7SXADqhUkKl
 La88ZaNwbV6c2U6asfn8b6k9GPGROQN8zRd38MIbbjW7wXmzkx+4kC9OH6QWhK+Ne3hdhlKGo1y
 FIgYv0XtKMhugdpEDL17K8GVqt8dLdHqYEUKn2bFUVonArJzvplvskoxpHDI1N1gE2/g/I+ABfQ
 bFfRMB27ZGj7KPIuMU8JD34DygbsVr8LZYRC2Jc9HcIBmHav7mHYcSBfwa1MCSv9b++JFJtzv0b
 LFIxzr7/mYFPBO+PtsA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a952a60 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=RdjiNnAT9l7Kg8zf_tkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX8D2AnFWh3enx
 miGfJhf8hGQSB6RMG6HOehrNyc21uVa5ZEzY8MjbP+GvwN5CMTR8n+Yd7tGxrmWte2QQTvqON8s
 WP7QeqozlKVD5oVnPcRiS9eLjjJhKgo=
X-Proofpoint-ORIG-GUID: V2GaiGJHksjPaBe3LJ4AHVuMjX6PU-Uk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310059

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

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 44 ++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 8ca36a933c7a..c2717f0d9cdd 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -52,19 +52,19 @@ asm (
 void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
-	int ool_stub_sz;
+	int stub_sz;
 
 	/*
+	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
 	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
 	 * The alignment NOP must appear before OOL stub, to make
 	 * ool_stub_idx & long_branch_stub_idx constant from end.
 	 *
 	 * The fimage can be non 8-byte aligned, so final alignment depends
-	 * on start of fimage and the stub's instruction count offset. The
-	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
-	 * or 3 instructions (without) before dummy_tramp_addr.
-	 *
-	 * Emit a NOP here if address is not SZL aligned.
+	 * on start of fimage and the stub's instruction count. The
+	 * stubs block has 11 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
+	 * or 10 instructions (without) before dummy_tramp_addr field. Emit a
+	 * NOP if the address of dummy_tramp_addr is non aligned.
 	 *
 	 * In pass=0 when image==NULL, conservatively account for space
 	 * required to accommodate alignment NOP. In case final pass skips
@@ -72,8 +72,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * jited_len signifies correct program size.
 	 */
 
-	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
-	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
+	stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 44 : 40;
+	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stub_sz, SZL))
 		EMIT(PPC_RAW_NOP());
 
 	/*
@@ -94,28 +94,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 
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
@@ -1309,6 +1310,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1316,14 +1318,14 @@ static void do_isync(void *info __maybe_unused)
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
@@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
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


