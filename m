Return-Path: <linuxppc-dev+bounces-25075-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D217C531D0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:50:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9fwC4HM6z2ylp;
	Thu, 30 Jul 2026 16:50:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785394219;
	cv=none; b=kLeC062l36doJnv7e2utmBo73B0q/0q0xXvJbW2Jn52/IAOooGozupAhiyAQ58AxLgpVQFP6wX32F2KVjhS4dL5GXv8SOQ38UhgrTsJCcCw3QohD2+hIHm/t9Ol7Pss8U4sdYvRSMZXXEaVVBREBMQSeIaDNstl450M33wVa32gG2ptS5/WCaQCAfwyuXaua7k/MEyX/R1nL4+n7/s2XLiKqZPTzMYWWXIqWWQmtVZd68rmCE8VKcO4e11p3t3/eRFR420h47AJq4GVZX5Qi8oe+7E5AMmJKS+WBFfHEet3gy6lWxgutilTCrOX4Xgm/sJSLl5uiPniZBYFSpqEBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785394219; c=relaxed/relaxed;
	bh=Yqo2FsQJw50JfL1TvSA6AR+qYaFcTn7qEQxKtAa2G58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klogiWBmsTgF1hXwTlEQGxyxSnPWn24z66oRuHfvCbj2fG/1ad4YvAQbiqaZ6GqCLiKfUgqpdBAu0X2r5wboUUXusxhIgcPIlVZ2/tyxI9mvPiE2FXuGB7TjWoVKagGKUdbEKAlp2acqRl574G1V89WK+UhiWzehi4gUKIBi77yx4UO/rFV0JklOX++4sKIIOQ9o6Q/kp+OFeeYPbSSx7ehuul4x/TEhxsI+E1fAXZjgc73YGNepeCetNnob9Oq8/F+YDcBCTMZUhBhO75f/+e0UOpvFFygaVlYelB0Q2LnFQycg7TV6fhj79uTwbZlbJ4z+PlLLGiYptKnR1rCFpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9fw95J22z2yjs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:50:17 +1000 (AEST)
Received: by linkmauve.fr (Postfix, from userid 1000)
	id BA645709936B; Thu, 30 Jul 2026 08:50:14 +0200 (CEST)
From: Link Mauve <linkmauve@linkmauve.fr>
To: Christophe Leroy <chleroy@kernel.org>
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	techflashYT <officialTechflashYT@gmail.com>,
	Ash Logan <ash@heyquark.com>,
	=?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] powerpc/sstep: Consistently use one define to check arch bit width
Date: Thu, 30 Jul 2026 08:50:05 +0200
Message-ID: <20260730065007.964703-2-linkmauve@linkmauve.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730065007.964703-1-linkmauve@linkmauve.fr>
References: <20260730065007.964703-1-linkmauve@linkmauve.fr>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously, both CONFIG_PPC64 and __powerpc64__ were being used to check
whether we built a 32-bit or a 64-bit kernel, sometimes in a single
function.

I went with CONFIG_PPC64 because it’s the most used in the kernel, and
the preferred way to check whether we’re building a 64-bit kernel, not
just 64-bit code, as recommended by Christophe Leroy.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
---
 arch/powerpc/lib/sstep.c | 102 +++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index f0d6aa657c1a..fd57b748cd2b 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -47,7 +47,7 @@ extern void conv_sp_to_dp(const float *sp, double *dp);
 extern void conv_dp_to_sp(const double *dp, float *sp);
 #endif
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 /*
  * Functions in quad.S
  */
@@ -134,7 +134,7 @@ static nokprobe_inline unsigned long dform_ea(unsigned int instr,
 	return ea;
 }
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 /*
  * Calculate effective address for a DS-form instruction
  */
@@ -168,7 +168,7 @@ static nokprobe_inline unsigned long dqform_ea(unsigned int instr,
 
 	return ea;
 }
-#endif /* __powerpc64 */
+#endif /* CONFIG_PPC64 */
 
 /*
  * Calculate effective address for an X-form instruction
@@ -250,7 +250,7 @@ static nokprobe_inline unsigned long byterev_4(unsigned long x)
 		((x & 0xff00) << 8) | ((x & 0xff) << 24);
 }
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 static nokprobe_inline unsigned long byterev_8(unsigned long x)
 {
 	return (byterev_4(x) << 32) | byterev_4(x >> 32);
@@ -266,7 +266,7 @@ static nokprobe_inline void do_byte_reverse(void *ptr, int nb)
 	case 4:
 		*(u32 *)ptr = byterev_4(*(u32 *)ptr);
 		break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 8:
 		*(unsigned long *)ptr = byterev_8(*(unsigned long *)ptr);
 		break;
@@ -312,7 +312,7 @@ __read_mem_aligned(unsigned long *dest, unsigned long ea, int nb, struct pt_regs
 	case 4:
 		unsafe_get_user(x, (unsigned int __user *)ea, Efault);
 		break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 8:
 		unsafe_get_user(x, (unsigned long __user *)ea, Efault);
 		break;
@@ -364,7 +364,7 @@ static __always_inline int __copy_mem_in(u8 *dest, unsigned long ea, int nb, str
 		case 4:
 			unsafe_get_user(*(u32 *)dest, (u32 __user *)ea, Efault);
 			break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 8:
 			unsafe_get_user(*(u64 *)dest, (u64 __user *)ea, Efault);
 			break;
@@ -443,7 +443,7 @@ __write_mem_aligned(unsigned long val, unsigned long ea, int nb, struct pt_regs
 	case 4:
 		unsafe_put_user(val, (unsigned int __user *)ea, Efault);
 		break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 8:
 		unsafe_put_user(val, (unsigned long __user *)ea, Efault);
 		break;
@@ -494,7 +494,7 @@ static __always_inline int __copy_mem_out(u8 *dest, unsigned long ea, int nb, st
 		case 4:
 			unsafe_put_user(*(u32 *)dest, (u32 __user *)ea, Efault);
 			break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 8:
 			unsafe_put_user(*(u64 *)dest, (u64 __user *)ea, Efault);
 			break;
@@ -722,7 +722,7 @@ static nokprobe_inline int do_vec_store(int rn, unsigned long ea,
 }
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 static nokprobe_inline int emulate_lq(struct pt_regs *regs, unsigned long ea,
 				      int reg, bool cross_endian)
 {
@@ -765,7 +765,7 @@ static nokprobe_inline int emulate_stq(struct pt_regs *regs, unsigned long ea,
 		err = write_mem(vals[IS_BE], ea + 8, 8, regs);
 	return err;
 }
-#endif /* __powerpc64 */
+#endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_VSX
 static nokprobe_inline void emulate_vsx_load(struct instruction_op *op, union vsx_reg *reg,
@@ -1316,7 +1316,7 @@ static nokprobe_inline int trap_compare(long v1, long v2)
  */
 #define MASK32(mb, me)	((0xffffffffUL >> (mb)) + \
 			 ((signed long)-0x80000000L >> (me)) + ((me) >= (mb)))
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 #define MASK64_L(mb)	(~0UL >> (mb))
 #define MASK64_R(me)	((signed long)-0x8000000000000000L >> (me))
 #define MASK64(mb, me)	(MASK64_L(mb) + MASK64_R(me) + ((me) >= (mb)))
@@ -1447,7 +1447,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		switch ((word >> 1) & 0x3ff) {
 		case 598:	/* sync */
 			op->type = BARRIER + BARRIER_SYNC;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 			switch ((word >> 21) & 3) {
 			case 1:		/* lwsync */
 				op->type = BARRIER + BARRIER_LWSYNC;
@@ -1472,7 +1472,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rc = (word >> 6) & 0x1f;
 
 	switch (opcode) {
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 1:
 		if (!cpu_has_feature(CPU_FTR_ARCH_31))
 			goto unknown_opcode;
@@ -1506,7 +1506,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			goto trap;
 		return 1;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 4:
 		/*
 		 * There are very many instructions with this primary opcode
@@ -1555,7 +1555,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	case 10:	/* cmpli */
 		imm = (unsigned short) word;
 		val = regs->gpr[ra];
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		if ((rd & 1) == 0)
 			val = (unsigned int) val;
 #endif
@@ -1565,7 +1565,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	case 11:	/* cmpi */
 		imm = (short) word;
 		val = regs->gpr[ra];
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		if ((rd & 1) == 0)
 			val = (int) val;
 #endif
@@ -1662,7 +1662,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		set_cr0(regs, op);
 		goto logical_done_nocc;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 30:	/* rld* */
 		mb = ((word >> 6) & 0x1f) | (word & 0x20);
 		val = regs->gpr[rd];
@@ -1720,7 +1720,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 					       (int)regs->gpr[rb])))
 				goto trap;
 			return 1;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 68:	/* td */
 			if (rd & trap_compare(regs->gpr[ra], regs->gpr[rb]))
 				goto trap;
@@ -1826,7 +1826,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 0:	/* cmp */
 			val = regs->gpr[ra];
 			val2 = regs->gpr[rb];
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 			if ((rd & 1) == 0) {
 				/* word (32-bit) compare */
 				val = (int) val;
@@ -1839,7 +1839,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 32:	/* cmpl */
 			val = regs->gpr[ra];
 			val2 = regs->gpr[rb];
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 			if ((rd & 1) == 0) {
 				/* word (32-bit) compare */
 				val = (unsigned int) val;
@@ -1860,7 +1860,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			add_with_carry(regs, op, rd, ~regs->gpr[ra],
 				       regs->gpr[rb], 1);
 			goto arith_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 9:	/* mulhdu */
 			asm("mulhdu %0,%1,%2" : "=r" (op->val) :
 			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]));
@@ -1879,7 +1879,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 40:	/* subf */
 			op->val = regs->gpr[rb] - regs->gpr[ra];
 			goto arith_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 73:	/* mulhd */
 			asm("mulhd %0,%1,%2" : "=r" (op->val) :
 			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]));
@@ -1918,7 +1918,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			add_with_carry(regs, op, rd, ~regs->gpr[ra], -1L,
 				       regs->xer & XER_CA);
 			goto arith_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 233:	/* mulld */
 			op->val = regs->gpr[ra] * regs->gpr[rb];
 			goto arith_done;
@@ -1933,7 +1933,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				(int) regs->gpr[rb];
 
 			goto arith_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 265:	/* modud */
 			if (!cpu_has_feature(CPU_FTR_ARCH_300))
 				goto unknown_opcode;
@@ -1950,7 +1950,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->val = (unsigned int) regs->gpr[ra] %
 				(unsigned int) regs->gpr[rb];
 			goto compute_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 457:	/* divdu */
 			op->val = regs->gpr[ra] / regs->gpr[rb];
 			goto arith_done;
@@ -1959,7 +1959,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->val = (unsigned int) regs->gpr[ra] /
 				(unsigned int) regs->gpr[rb];
 			goto arith_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 489:	/* divd */
 			op->val = (long int) regs->gpr[ra] /
 				(long int) regs->gpr[rb];
@@ -1969,7 +1969,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->val = (int) regs->gpr[ra] /
 				(int) regs->gpr[rb];
 			goto arith_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 425:	/* divde[.] */
 			asm volatile(PPC_DIVDE(%0, %1, %2) :
 				"=r" (op->val) : "r" (regs->gpr[ra]),
@@ -2002,7 +2002,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			}
 
 			goto unknown_opcode;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 777:	/* modsd */
 			if (!cpu_has_feature(CPU_FTR_ARCH_300))
 				goto unknown_opcode;
@@ -2025,7 +2025,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			val = (unsigned int) regs->gpr[rd];
 			op->val = ( val ? __builtin_clz(val) : 32 );
 			goto logical_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 58:	/* cntlzd */
 			val = regs->gpr[rd];
 			op->val = ( val ? __builtin_clzl(val) : 64 );
@@ -2093,7 +2093,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			val = (unsigned int) regs->gpr[rd];
 			op->val = (val ? __builtin_ctz(val) : 32);
 			goto logical_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 570:	/* cnttzd */
 			if (!cpu_has_feature(CPU_FTR_ARCH_300))
 				goto unknown_opcode;
@@ -2108,7 +2108,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 954:	/* extsb */
 			op->val = (signed char) regs->gpr[rd];
 			goto logical_done;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 986:	/* extsw */
 			op->val = (signed int) regs->gpr[rd];
 			goto logical_done;
@@ -2159,7 +2159,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			set_ca32(op, op->xerval & XER_CA);
 			goto logical_done;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 27:	/* sld */
 			sh = regs->gpr[rb] & 0x7f;
 			if (sh < 64)
@@ -2216,7 +2216,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 				op->val = val;
 			goto logical_done;
 
-#endif /* __powerpc64__ */
+#endif /* CONFIG_PPC64 */
 
 /*
  * Cache instructions
@@ -2296,7 +2296,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = MKOP(STCX, 0, 2);
 			break;
 #endif
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 84:	/* ldarx */
 			op->type = MKOP(LARX, 0, 8);
 			break;
@@ -2373,7 +2373,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			break;
 #endif /* CONFIG_ALTIVEC */
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 21:	/* ldx */
 		case 53:	/* ldux */
 			op->type = MKOP(LOAD, u, 8);
@@ -2400,7 +2400,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = MKOP(LOAD, u, 2);
 			break;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 341:	/* lwax */
 		case 373:	/* lwaux */
 			op->type = MKOP(LOAD, SIGNEXT | u, 4);
@@ -2417,7 +2417,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = MKOP(STORE, u, 2);
 			break;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 532:	/* ldbrx */
 			op->type = MKOP(LOAD, BYTEREV, 8);
 			break;
@@ -2459,7 +2459,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 			op->type = MKOP(STORE_FP, u, 8);
 			break;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 791:	/* lfdpx */
 			op->type = MKOP(LOAD_FP, 0, 16);
 			break;
@@ -2479,10 +2479,10 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 983:	/* stfiwx */
 			op->type = MKOP(STORE_FP, 0, 4);
 			break;
-#endif /* __powerpc64 */
+#endif /* CONFIG_PPC64 */
 #endif /* CONFIG_PPC_FPU */
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 660:	/* stdbrx */
 			op->type = MKOP(STORE, BYTEREV, 8);
 			op->val = byterev_8(regs->gpr[rd]);
@@ -2820,7 +2820,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		break;
 #endif
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 56:	/* lq */
 		if (!((rd & 1) || (rd == ra)))
 			op->type = MKOP(LOAD, 0, 16);
@@ -2857,7 +2857,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		break;
 #endif /* CONFIG_VSX */
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 58:	/* ld[u], lwa */
 		op->ea = dsform_ea(word, regs);
 		switch (word & 3) {
@@ -2946,7 +2946,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		break;
 #endif /* CONFIG_VSX */
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 62:	/* std[u] */
 		op->ea = dsform_ea(word, regs);
 		switch (word & 3) {
@@ -3099,7 +3099,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 		case 3: /* Type 11 Modified Register-to-Register */
 			break;
 		}
-#endif /* __powerpc64__ */
+#endif /* CONFIG_PPC64 */
 
 	}
 
@@ -3200,7 +3200,7 @@ static nokprobe_inline void do_byterev(unsigned long *valp, int size)
 	case 4:
 		*valp = byterev_4(*valp);
 		break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	case 8:
 		*valp = byterev_8(*valp);
 		break;
@@ -3341,7 +3341,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		case 4:
 			__get_user_asmx(val, ea, err, "lwarx");
 			break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 8:
 			__get_user_asmx(val, ea, err, "ldarx");
 			break;
@@ -3367,7 +3367,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 			return -EFAULT;
 		err = 0;
 		switch (size) {
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 1:
 			__put_user_asmx(op->val, ea, err, "stbcx.", cr);
 			break;
@@ -3378,7 +3378,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		case 4:
 			__put_user_asmx(op->val, ea, err, "stwcx.", cr);
 			break;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		case 8:
 			__put_user_asmx(op->val, ea, err, "stdcx.", cr);
 			break;
@@ -3399,7 +3399,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		break;
 
 	case LOAD:
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		if (size == 16) {
 			err = emulate_lq(regs, ea, op->reg, cross_endian);
 			break;
@@ -3473,7 +3473,7 @@ int emulate_loadstore(struct pt_regs *regs, struct instruction_op *op)
 		break;
 
 	case STORE:
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 		if (size == 16) {
 			err = emulate_stq(regs, ea, op->reg, cross_endian);
 			break;
-- 
2.55.0


