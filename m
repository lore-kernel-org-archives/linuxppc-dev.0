Return-Path: <linuxppc-dev+bounces-19225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578E5D6AAEC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 16:11:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmn0R64Cwz2xls;
	Fri, 03 Apr 2026 03:11:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775146279;
	cv=none; b=mPk1if+htWFOWR5/TerF/ZxHviVBJZXNm/hUlbOgCsm7Ioyf+lzBjiUMSwev6RokZykr2OZ7q7+LmJvlTxMOzwI52Z6Vpl4pYbHVQCCKU1KoHPpK4p88p5m103rBYBEG96fJc8nWn0UyiDO6ugWUHiAPchweq0OpMR71czYmptynU/U76QcZnkHe7d7yEs+ac8mn5u4d76OtehPZtGCdoao48ENIqyx4IiGhHffxD0VkzQ1TVHksP/6712gqpQIe5rnQCCWK6ZPRukRrVWMtegau9hTv0KLfF0z19Q5UNEROAQC6mHyQLtWLESJTfRY7YzAzMMNBRsy4xvCJUNxFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775146279; c=relaxed/relaxed;
	bh=n9r5Ppcix6CONLD3jPGx3p9uEwOXiuqnf4e5g2ttXT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdMdNUmCP4o6JeHJNSxvv0O+uB4/Nd1GaNkhCvu38jyYTzhiF6wxFgwtrGrL2Pp1IhHqdDqNz6u99VZ4SgeFb8QwCwZ4gZH/yQVWwM8cTT0H5DHVh5vtaORTbinAd7RbN/uKUXerCUOkV9/biTNfbj94TEWJkmQB3WSE0ZUs8qRICJY1iKym6ea5pY9B9QGYBWZv+VpVVg2V/pIDQVdOun01EvI2CL7QBCF2xCi6vk6gNx4BzuRRNqw/UObbOn/kX8THffK0VNig96RzS6EcCKCO0ne5oxp6iK1Dkjw3tHHvqowpUqXxxqmp2mgwzFRuOCb96B+Qa2bUst217JJj1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TzQdfsV7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TzQdfsV7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmn0Q5qWfz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 03:11:17 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632ATbj63127127;
	Thu, 2 Apr 2026 16:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n9r5Ppcix6CONLD3jPGx3p9uEwOXiuqnf4e5g2ttX
	T8=; b=TzQdfsV7ubEws3BVdm30Lk9qFEIcoEWtTIeitGmi/p1NDtnOfEov++dQ1
	BSo628QLIYM1Q4OBNjU+ah5WTEBfjmR0os+Iq7TvjyXxIsbMIioDjyyugUGahMeE
	4w0jmjIsFv5PponuNYBLPjFh8HDsQlqb5ZfATvdeeIg99s9vneperDbKBvKcEfL6
	/WmnrMLZBobCJXQo4RNQ8XHKa1+r+bxpAgtmynm8E2COO3KkXPWxjKjaXssriMNo
	Q7uXn02whcMXLyyJueX+mJCGGGMBCJA5VvefNIVJYCOwrudtdSvJMxMdj5++VEYp
	FOtwidTkzE6RTrMryz4umdKfTbqdA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dcmnap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 16:10:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 632G8aWb005757;
	Thu, 2 Apr 2026 16:10:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spyasfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 16:10:37 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 632GAXwk46006638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 16:10:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0851D20043;
	Thu,  2 Apr 2026 16:10:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6E1B2004F;
	Thu,  2 Apr 2026 16:10:27 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.211.168])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 16:10:27 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        chleroy@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        adubey@linux.ibm.com
Subject: [PATCH v2] powerpc64/bpf: Add powerpc64 JIT support for timed may_goto
Date: Thu,  2 Apr 2026 21:40:26 +0530
Message-ID: <20260402161026.289827-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69ce94fe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7RCMQfSFa8QzyXN4T_sA:9
X-Proofpoint-GUID: UiAiKqQg_nExyoU79T8MxlTXgUIWuTxW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE0MiBTYWx0ZWRfXynUbWgs6ZODT
 r2YyA4wn7CO6Kqd5NmJv0MRuAz6TTrTPFWDe+3dQdh/io+PnQ+L1J31dX6ZadYMo/t26TEjfVVb
 c1c4jRN4Edo3lwWKKgfYFRuGfAAsRAWiH6SwkM981jLsjeTh7Z9/W95yqmdZnk5VkolBTHnG+p/
 kHveawfz4LSJshDwiZR+8aNOwvTVNzWs9oy/0hnGvuLtZBFYmeeCTjs0v3NCCBUlmib2TtwHQu9
 QSQ09HtIDjN8j1qGE/lihtFM4ltRiBuwNg72Gc84/TPT99LuxnRBBNDQXzt1NFk8adNiPGAl9ey
 eMLEUVpQy5PP1ENgUZgycQ1seezt027WYkwWjEWf852Bvl3KujMh7yQrr+6hAedup6fxCtWHNMe
 2h4RYBaSsneh/hjt3Y8nO1kwmwCOUs8g+l/rAohjKpL4sW+ZQ//bBF1lM0pCMj2yp7v8RfImG/X
 vBloK2KUil2/HdCogXw==
X-Proofpoint-ORIG-GUID: WD3zAGWoBtPZKyVEvIcr9tVsOI4Y-V6K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020142

When verifier sees a timed may_goto instruction, it emits a call to
arch_bpf_timed_may_goto() with a stack offset in BPF_REG_AX
(powerpc64 R12) and expects the refreshed count value to be returned
in the same register. The verifier doesn't save or restore any registers
before emitting this call.

arch_bpf_timed_may_goto() should act as a trampoline to call
bpf_check_timed_may_goto() with powerpc64 ELF ABI calling convention.

To support this custom calling convention, implement
arch_bpf_timed_may_goto() in assembly and make sure BPF caller saved
registers are preserved, then call bpf_check_timed_may_goto with
the powerpc64 ABI calling convention where first argument and return
value both are in R3. Finally, move the result back into BPF_REG_AX(R12)
before returning.

Also, introduce bpf_jit_emit_func_call() that computes the offset from
kernel_toc_addr(), validates that the target and emits the ADDIS/ADDI
sequence to load the function address before performing the indirect
branch via MTCTR/BCTRL. The existing code in bpf_jit_emit_func_call_rel()
is refactored to use this function.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
This patch has been rebased on top of these 3 patches on powerpc-next in
the following sequence:
1. https://lore.kernel.org/bpf/20260401103215.104438-1-adubey@linux.ibm.com/
2. https://lore.kernel.org/bpf/20260401141043.41513-1-adubey@linux.ibm.com/
3. https://lore.kernel.org/bpf/20260401152133.42544-1-adubey@linux.ibm.com/

Changes since v1:
- Compile bpf_timed_may_goto.o conditionally for PPC64. (Hari)
- Moved reladdr at the beginning of the function. (Hari)
- Added error check for bpf_jit_emit_func_call() in
  bpf_jit_build_body(). (Hari)
- Save registers after 32 bytes as MIN_FRAME_SIZE is 32 bytes for
  powerpc ABIv2. (Hari)
---
 arch/powerpc/net/Makefile             |  4 ++
 arch/powerpc/net/bpf_jit_comp.c       |  5 +++
 arch/powerpc/net/bpf_jit_comp64.c     | 62 ++++++++++++++++++++++-----
 arch/powerpc/net/bpf_timed_may_goto.S | 57 ++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/net/bpf_timed_may_goto.S

diff --git a/arch/powerpc/net/Makefile b/arch/powerpc/net/Makefile
index 8e60af32e51e..87395d7e2672 100644
--- a/arch/powerpc/net/Makefile
+++ b/arch/powerpc/net/Makefile
@@ -3,3 +3,7 @@
 # Arch-specific network modules
 #
 obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp$(BITS).o
+
+ifdef CONFIG_PPC64
++obj-$(CONFIG_BPF_JIT) += bpf_timed_may_goto.o
+endif
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 50103b3794fb..9b2b456b0765 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -537,6 +537,11 @@ bool bpf_jit_supports_subprog_tailcalls(void)
 	return IS_ENABLED(CONFIG_PPC64);
 }
 
+bool bpf_jit_supports_timed_may_goto(void)
+{
+	return IS_ENABLED(CONFIG_PPC64);
+}
+
 bool bpf_jit_supports_kfunc_call(void)
 {
 	return IS_ENABLED(CONFIG_PPC64);
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index db364d9083e7..dab106cae22b 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -451,10 +451,28 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie
 	}
 }
 
+static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 func_addr, int reg)
+{
+	long reladdr = func_addr - kernel_toc_addr();
+
+	if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
+		pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func_addr);
+		return -ERANGE;
+	}
+
+	EMIT(PPC_RAW_ADDIS(reg, _R2, PPC_HA(reladdr)));
+	EMIT(PPC_RAW_ADDI(reg, reg, PPC_LO(reladdr)));
+	EMIT(PPC_RAW_MTCTR(reg));
+	EMIT(PPC_RAW_BCTRL());
+
+	return 0;
+}
+
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-	long reladdr;
+	long __maybe_unused reladdr;
+	int ret;
 
 	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
 	if (!func) {
@@ -507,16 +525,9 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	EMIT(PPC_RAW_BCTRL());
 #else
 	if (core_kernel_text(func_addr)) {
-		reladdr = func_addr - kernel_toc_addr();
-		if (reladdr > 0x7FFFFFFF || reladdr < -(0x80000000L)) {
-			pr_err("eBPF: address of %ps out of range of kernel_toc.\n", (void *)func);
-			return -ERANGE;
-		}
-
-		EMIT(PPC_RAW_ADDIS(_R12, _R2, PPC_HA(reladdr)));
-		EMIT(PPC_RAW_ADDI(_R12, _R12, PPC_LO(reladdr)));
-		EMIT(PPC_RAW_MTCTR(_R12));
-		EMIT(PPC_RAW_BCTRL());
+		ret = bpf_jit_emit_func_call(image, ctx, func_addr, _R12);
+		if (ret)
+			return ret;
 	} else {
 		if (IS_ENABLED(CONFIG_PPC64_ELF_ABI_V1)) {
 			/* func points to the function descriptor */
@@ -1755,6 +1766,35 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (ret < 0)
 				return ret;
 
+			/*
+			 * Call to arch_bpf_timed_may_goto() is emitted by the
+			 * verifier and called with custom calling convention with
+			 * first argument and return value in BPF_REG_AX (_R12).
+			 *
+			 * The generic helper or bpf function call emission path
+			 * may use the same scratch register as BPF_REG_AX to
+			 * materialize the target address. This would clobber AX
+			 * and break timed may_goto semantics.
+			 *
+			 * Emit a minimal indirect call sequence here using a temp
+			 * register and skip the normal post-call return-value move.
+			 */
+
+			if (func_addr == (u64)arch_bpf_timed_may_goto) {
+				ret = 0;
+				if (!IS_ENABLED(CONFIG_PPC_KERNEL_PCREL))
+					ret = bpf_jit_emit_func_call(image, ctx, func_addr,
+								     tmp1_reg);
+
+				if (ret || IS_ENABLED(CONFIG_PPC_KERNEL_PCREL)) {
+					PPC_LI_ADDR(tmp1_reg, func_addr);
+					EMIT(PPC_RAW_MTCTR(tmp1_reg));
+					EMIT(PPC_RAW_BCTRL());
+				}
+
+				break;
+			}
+
 			/* Take care of powerpc ABI requirements before kfunc call */
 			if (insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				if (prepare_for_kfunc_call(fp, image, ctx, &insn[i]))
diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
new file mode 100644
index 000000000000..6fd8b1c9f4ac
--- /dev/null
+++ b/arch/powerpc/net/bpf_timed_may_goto.S
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 IBM Corporation, Saket Kumar Bhaskar <skb99@linux.ibm.com> */
+
+#include <linux/linkage.h>
+#include <asm/ppc_asm.h>
+
+/*
+ * arch_bpf_timed_may_goto() trampoline for powerpc64
+ *
+ * Custom BPF convention (verifier/JIT):
+ *	- input:  stack offset in BPF_REG_AX (r12)
+ *	- output: updated count in BPF_REG_AX (r12)
+ *
+ * Call bpf_check_timed_may_goto(ptr) with normal powerpc64 ABI:
+ * 	- r3 = ptr, return in r3
+ *
+ * Preserve BPF regs R0-R5 (mapping: r8, r3-r7).
+ */
+
+SYM_FUNC_START(arch_bpf_timed_may_goto)
+	/* Prologue: save LR, allocate frame */
+	mflr    r0
+	std     r0, 16(r1)
+	stdu    r1, -112(r1)
+
+	/* Save BPF registers R0 - R5 (r8, r3-r7) */
+	std     r3, 32(r1)
+	std     r4, 40(r1)
+	std     r5, 48(r1)
+	std     r6, 56(r1)
+	std     r7, 64(r1)
+	std     r8, 72(r1)
+
+	/*
+	 * r3 = BPF_REG_FP + BPF_REG_AX
+	 * BPF_REG_FP is r31; BPF_REG_AX is r12 (stack offset in bytes).
+	 */
+	add     r3, r31, r12
+	bl      bpf_check_timed_may_goto
+
+	/* Put return value back into AX */
+	mr      r12, r3
+
+	/* Restore BPF registers R0 - R5 (r8, r3-r7) */
+	ld      r3, 32(r1)
+	ld      r4, 40(r1)
+	ld      r5, 48(r1)
+	ld      r6, 56(r1)
+	ld      r7, 64(r1)
+	ld      r8, 72(r1)
+
+	/* Epilogue: pop frame, restore LR, return */
+	addi    r1, r1, 112
+	ld      r0, 16(r1)
+	mtlr    r0
+	blr
+SYM_FUNC_END(arch_bpf_timed_may_goto)
-- 
2.52.0


