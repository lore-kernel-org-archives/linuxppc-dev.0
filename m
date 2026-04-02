Return-Path: <linuxppc-dev+bounces-19186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB05CC6B04
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2026 05:43:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmW480mQ7z2ySk;
	Thu, 02 Apr 2026 16:43:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775108616;
	cv=none; b=Yf9kXZ66fedXx/GMSm9dIjclQek8gNuo0dnfP67ryPE8ucuZ/W9AD67oFNOa+Vpbx6RQNUeIqRNx45EKR2bQVGfaL6jEmsOh6J1B1bdQUwcpXRjtuO8T9vnFIR+ON/xDIAmsZrtggu/TEpBi93MpXMOLO8O5Wl2hNFLPgXi5ThFScVbH7KOqHCLLv1gB8FWN9d14Q+KjuU6HunKmP0+6qWh/EoCd73zXBGVagrYs2UVhHy83khevvH6c6S+F49se7R6edIY9thc2Y5aEveZqnYkwUGeFdQle8BG869I8mDHkoW828a+SzKyMkAQ1Sc7LWuZy2Mr+LSrQDz8ceAat2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775108616; c=relaxed/relaxed;
	bh=tn52H1i6z1CA9qnIiVNnl7FG0MDrNUpU8eclFwkV7ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFJWVm1pJHbY3PkY+cpcKkf4PAcu4VHsiTmNVS7IdKPIENJzviUeQrrFbWjpsKPFVUpwm5YysVKxSvngS2iY5QPLoMgl+FdRvds5stjpiA9ZRvkRrjZkVJEJ05Hm6fMQScpgH1yY2x/AF1Q9MKjkb6Yb7BxDI34UWL/zvR/MWEw/I9LnqytlNOGbDbrc4rPK1AWslwT1Guy6V6p+2eqPuz90FaiUo9crKwTXG/euezqPsKhxBdwqw/Xz6LjVlHV99DfS0EZuqghpDcdQqcMdt9R08KZ10jTysq75bg2xLqKpgdaKpXNPDStDAf/24zX8t8Vo5iqYETdNfA/ZbSzfjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B5ObazoV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B5ObazoV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=skb99@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmW471jjWz2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 16:43:35 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631LOK20003273;
	Thu, 2 Apr 2026 05:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tn52H1i6z1CA9qnIiVNnl7FG0MDrNUpU8eclFwkV7
	ko=; b=B5ObazoVaC0JBwYCTQb0umZIISXvZ4en1tALvK5hKYrG4CDJDs/VTC56t
	VlQ9q8zrbjTSwrKcgyMJ9CJgXSh3HxHXUitz4esJ89FRgKnGo0vYq1S1UutFit56
	dr1EGX6zmL5ilfBLIaq3mCZsBzgylJKg9pMMrPvX3fXpcBsL3LoSDHniOUtRe5za
	GkuEy+HnoPl+sVHUA0GH42vrUsmFrc+SUfqfMl7jvEU2nSpXppbVnc5aT168p4w2
	4bGYGng4ZSADcfGuc72D1aufzq64WP4d6OuGl82+GHW/6F4Iir+OV+CXov3iuW1m
	M+4IGpDY8maCFViWrMTjzhmEUm1MQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66msahwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 05:43:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6320Lh5s013936;
	Thu, 2 Apr 2026 05:43:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkrr6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 05:43:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6325gv1i36962668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 05:42:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 786FD20043;
	Thu,  2 Apr 2026 05:42:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C56820040;
	Thu,  2 Apr 2026 05:42:50 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.bl1-in.ibm.com (unknown [9.123.13.162])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 05:42:50 +0000 (GMT)
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
Subject: [PATCH] powerpc64/bpf: Add powerpc64 JIT support for timed may_goto
Date: Thu,  2 Apr 2026 11:12:49 +0530
Message-ID: <20260402054249.28801-1-skb99@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69ce01e7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=7RCMQfSFa8QzyXN4T_sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA0NCBTYWx0ZWRfX5YrZn1txn5V5
 BSkm+dBi8xzeyggIr1Gcv/pjMrwjTo3n8kGM6Xr545nehMctNCfu58mdqKvvpjiJZwl/dOrkCLg
 mrNcgxV+DzhORJRsa2e6kQ8h7cJdXAku0Ni9NZn/iSeu8wfRo9nMoBC7thyZPJg9h+ArpaAASre
 MQRcQEHK4rHJ1vVQlLVxx4EcLw/4Vwe73nthAmJxX7RTAU1kEY/ZfnOIxZrggPKEQ7IuUqMNXDW
 ACCP7xp4skFEx3our4sKm1E5K0qbUyvGNXaDL0dsOKP1Ar85hkNSlbb/tQF29HtrGlIoD7lgx05
 LyOS/XyTcfGacjtV9LFnO+4aOEOOaTIbhI4IEkpo1BlQIRprhmirSHq3tNFGD0pBww44oq+5ghi
 JaeApm7YeIykz5OgH8hjSgrQAU89Y+SWrCDYLXDOS77d0hRseThd5Twyd+ZVny7zEt5EeXZgUCX
 Aeoq86g3A18Oo63vzQw==
X-Proofpoint-GUID: vs3isL1flFXw2oYtIyLClA-AVni--OYZ
X-Proofpoint-ORIG-GUID: E1PDOn4jGweE507C_YSJg1ufIXh5XJ8u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020044

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
 arch/powerpc/net/Makefile             |  2 +-
 arch/powerpc/net/bpf_jit_comp.c       |  5 +++
 arch/powerpc/net/bpf_jit_comp64.c     | 59 ++++++++++++++++++++++-----
 arch/powerpc/net/bpf_timed_may_goto.S | 57 ++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 12 deletions(-)
 create mode 100644 arch/powerpc/net/bpf_timed_may_goto.S

diff --git a/arch/powerpc/net/Makefile b/arch/powerpc/net/Makefile
index 8e60af32e51e..204fc57ac56e 100644
--- a/arch/powerpc/net/Makefile
+++ b/arch/powerpc/net/Makefile
@@ -2,4 +2,4 @@
 #
 # Arch-specific network modules
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp$(BITS).o
+obj-$(CONFIG_BPF_JIT) += bpf_jit_comp.o bpf_jit_comp$(BITS).o bpf_timed_may_goto.o
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
index db364d9083e7..d39241444cd9 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -451,10 +451,28 @@ void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie
 	}
 }
 
+static int bpf_jit_emit_func_call(u32 *image, struct codegen_context *ctx, u64 func_addr, int reg)
+{
+	long reladdr;
+
+	reladdr = func_addr - kernel_toc_addr();
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
+	int ret;
 
 	/* bpf to bpf call, func is not known in the initial pass. Emit 5 nops as a placeholder */
 	if (!func) {
@@ -469,6 +487,7 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
 	}
 
 #ifdef CONFIG_PPC_KERNEL_PCREL
+	long reladdr;
 	reladdr = func_addr - local_paca->kernelbase;
 
 	/*
@@ -507,16 +526,9 @@ int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *
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
@@ -1755,6 +1767,31 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
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
+#ifdef CONFIG_PPC_KERNEL_PCREL
+				PPC_LI_ADDR(tmp1_reg, func_addr);
+				EMIT(PPC_RAW_MTCTR(tmp1_reg));
+				EMIT(PPC_RAW_BCTRL());
+#else
+				bpf_jit_emit_func_call(image, ctx, func_addr, tmp1_reg);
+#endif
+				break;
+			}
+
 			/* Take care of powerpc ABI requirements before kfunc call */
 			if (insn[i].src_reg == BPF_PSEUDO_KFUNC_CALL) {
 				if (prepare_for_kfunc_call(fp, image, ctx, &insn[i]))
diff --git a/arch/powerpc/net/bpf_timed_may_goto.S b/arch/powerpc/net/bpf_timed_may_goto.S
new file mode 100644
index 000000000000..0b9afe3cfa1f
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
+	std     r3, 24(r1)
+	std     r4, 32(r1)
+	std     r5, 40(r1)
+	std     r6, 48(r1)
+	std     r7, 56(r1)
+	std     r8, 64(r1)
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
+	ld      r3, 24(r1)
+	ld      r4, 32(r1)
+	ld      r5, 40(r1)
+	ld      r6, 48(r1)
+	ld      r7, 56(r1)
+	ld      r8, 64(r1)
+
+	/* Epilogue: pop frame, restore LR, return */
+	addi    r1, r1, 112
+	ld      r0, 16(r1)
+	mtlr    r0
+	blr
+SYM_FUNC_END(arch_bpf_timed_may_goto)
-- 
2.52.0


