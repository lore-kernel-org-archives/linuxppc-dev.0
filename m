Return-Path: <linuxppc-dev+bounces-22769-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0A1CD98E2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2026 09:22:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggwGv5lQqz3bqM;
	Thu, 18 Jun 2026 19:22:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781774535;
	cv=none; b=WyqNTbP9Y9AehjAtE8UsCUgK324sasXmyrxtkiyN41LZk1VQppYkvXCeqzjJce/1wMZuohqprqjw+5fChzvOyU0zNc3KDQw69HLQXhkSMeei4vUB3/SjMpROnkkdNNVa36//BKhkBqtb3ptR1t/yOFzhPPlMcbGwYZGQ3NYQFiXxVOUHs3iU4Ce+LH7jS72sas6AEezcclyDPkM5Ld65AlI9mUebziwfQFc17hftk7Aw4uWeKvg+cmYOoxFDNvelDxBG4lL9QJovKQ2GDCBQrlJJFDOGB++tk9vTAI+UdzsxvwVfbkxNdODxt4KMJueAQ1YzNoqbyiVJeHaKa1Knxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781774535; c=relaxed/relaxed;
	bh=gSg9hURQWwaF6v2rlWIi5aDbWlEdNloKS9CNWqoe2X8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGL+vlZRqdjj3Kqgw1pgcf6Wz7MGSsFPVlL2U0aHVFSO066APqpL5NNX/idVEpC3/Fspsb178d8WMijC3Lhj0GWNAGdEKuEgceA3APpR2SAioREuM/L9wayCAVIJqckNIkS7ZHMRmGN40Do09IgGg+MLz5hMCo/33BAuCYIJJTrtI4+LDBWGg01eh2gI4CZdEY0I8xxosJu2L+iDzh0E7FFav48TzzMyAfB6oNRKH47K0QuZsxxlfCdVvzgSWuohab0S4Wagj55Rt7HbR9SmID3/C6QaJRICFs8A9j/pKMWzjbgA91SGbN976jvhgAIGeHkaSW9HxtWu/TMPsigB/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iKGEIc7G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iKGEIc7G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=tianruidong@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggwGt08wKz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2026 19:22:13 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781774530; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gSg9hURQWwaF6v2rlWIi5aDbWlEdNloKS9CNWqoe2X8=;
	b=iKGEIc7GlFOqDbMbePnDCJrpbX9mQqBEJgeXcSIzasr9uV6RbCOFk4n7RkC/XzVVEuraKknPn5LVtOpdbTHENFnoMl7JSmiCOEpJWiCBiVgpkvie2Ev74Tkkx/qYH+LJrfmdoZxWo7ZAS28wf6ibcFjMf+GLKcT1/Jj3TgvfHKA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0X56TKD2_1781774524;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X56TKD2_1781774524 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:22:07 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	rafael@kernel.org,
	tony.luck@intel.com,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	tongtiangen@huawei.com,
	james.morse@arm.com,
	robin.murphy@arm.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v15 7/9] arm64: introduce copy_mc_to_kernel() implementation
Date: Thu, 18 Jun 2026 17:21:21 +0800
Message-ID: <20260618092124.3901230-8-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
References: <20260618092124.3901230-1-tianruidong@linux.alibaba.com>
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

From: Tong Tiangen <tongtiangen@huawei.com>

The copy_mc_to_kernel() helper is memory copy implementation that handles
source exceptions. It can be used in memory copy scenarios that tolerate
hardware memory errors(e.g: pmem_read/dax_copy_to_iter).

Currently, only x86 and ppc support this helper, Add this for ARM64 as
well, if ARCH_HAS_COPY_MC is defined, by implementing copy_mc_to_kernel()
and memcpy_mc() functions.

Because there is no caller-saved GPR is available for saving "bytes not
copied" in memcpy(), the memcpy_mc() is referenced to the implementation
of copy_from_user(). In addition, the fixup of MOPS insn is not considered
at present.

[Ruidong: refactor memcpy_mc on top of the new memcpy implementation.]

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/arm64/include/asm/string.h  |   5 +
 arch/arm64/include/asm/uaccess.h |  17 +++
 arch/arm64/lib/Makefile          |   2 +-
 arch/arm64/lib/memcpy.S          | 251 +++----------------------------
 arch/arm64/lib/memcpy_mc.S       |  56 +++++++
 arch/arm64/lib/memcpy_template.S | 250 ++++++++++++++++++++++++++++++
 mm/kasan/shadow.c                |  12 ++
 7 files changed, 359 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm64/lib/memcpy_mc.S
 create mode 100644 arch/arm64/lib/memcpy_template.S

diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/string.h
index 3a3264ff47b9..2e81f6c00cdd 100644
--- a/arch/arm64/include/asm/string.h
+++ b/arch/arm64/include/asm/string.h
@@ -35,6 +35,10 @@ extern void *memchr(const void *, int, __kernel_size_t);
 extern void *memcpy(void *, const void *, __kernel_size_t);
 extern void *__memcpy(void *, const void *, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMCPY_MC
+extern unsigned long memcpy_mc(void *, const void *, __kernel_size_t);
+extern unsigned long __memcpy_mc(void *, const void *, __kernel_size_t);
+
 #define __HAVE_ARCH_MEMMOVE
 extern void *memmove(void *, const void *, __kernel_size_t);
 extern void *__memmove(void *, const void *, __kernel_size_t);
@@ -57,6 +61,7 @@ void memcpy_flushcache(void *dst, const void *src, size_t cnt);
  */
 
 #define memcpy(dst, src, len) __memcpy(dst, src, len)
+#define memcpy_mc(dst, src, len) __memcpy_mc(dst, src, len)
 #define memmove(dst, src, len) __memmove(dst, src, len)
 #define memset(s, c, n) __memset(s, c, n)
 
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index b0c83a08dda9..93277eca2268 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -499,5 +499,22 @@ static inline size_t probe_subpage_writeable(const char __user *uaddr,
 }
 
 #endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+/**
+ * copy_mc_to_kernel - memory copy that handles source exceptions
+ *
+ * @to:		destination address
+ * @from:	source address
+ * @size:	number of bytes to copy
+ *
+ * Return 0 for success, or bytes not copied.
+ */
+static inline unsigned long __must_check
+copy_mc_to_kernel(void *to, const void *from, unsigned long size)
+{
+	return memcpy_mc(to, from, size);
+}
+#define copy_mc_to_kernel copy_mc_to_kernel
+#endif
 
 #endif /* __ASM_UACCESS_H */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 1f4c3f743a20..a5820e6c33d4 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -7,7 +7,7 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
-lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc_page.o
+lib-$(CONFIG_ARCH_HAS_COPY_MC) += copy_mc_page.o memcpy_mc.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
diff --git a/arch/arm64/lib/memcpy.S b/arch/arm64/lib/memcpy.S
index 9b99106fb95f..ab48c5c798d1 100644
--- a/arch/arm64/lib/memcpy.S
+++ b/arch/arm64/lib/memcpy.S
@@ -15,247 +15,32 @@
  *
  */
 
-#define L(label) .L ## label
+	.macro ldrb1 reg, addr:vararg
+	ldrb  \reg, \addr
+	.endm
 
-#define dstin	x0
-#define src	x1
-#define count	x2
-#define dst	x3
-#define srcend	x4
-#define dstend	x5
-#define A_l	x6
-#define A_lw	w6
-#define A_h	x7
-#define B_l	x8
-#define B_lw	w8
-#define B_h	x9
-#define C_l	x10
-#define C_lw	w10
-#define C_h	x11
-#define D_l	x12
-#define D_h	x13
-#define E_l	x14
-#define E_h	x15
-#define F_l	x16
-#define F_h	x17
-#define G_l	count
-#define G_h	dst
-#define H_l	src
-#define H_h	srcend
-#define tmp1	x14
+	.macro ldr1 reg, addr:vararg
+	ldr   \reg, \addr
+	.endm
 
-/* This implementation handles overlaps and supports both memcpy and memmove
-   from a single entry point.  It uses unaligned accesses and branchless
-   sequences to keep the code small, simple and improve performance.
+	.macro ldp1 reg1, reg2, addr:vararg
+	ldp   \reg1, \reg2, \addr
+	.endm
 
-   Copies are split into 3 main cases: small copies of up to 32 bytes, medium
-   copies of up to 128 bytes, and large copies.  The overhead of the overlap
-   check is negligible since it is only required for large copies.
-
-   Large copies use a software pipelined loop processing 64 bytes per iteration.
-   The destination pointer is 16-byte aligned to minimize unaligned accesses.
-   The loop tail is handled by always copying 64 bytes from the end.
-*/
-
-SYM_FUNC_START_LOCAL(__pi_memcpy_generic)
-	add	srcend, src, count
-	add	dstend, dstin, count
-	cmp	count, 128
-	b.hi	L(copy_long)
-	cmp	count, 32
-	b.hi	L(copy32_128)
-
-	/* Small copies: 0..32 bytes.  */
-	cmp	count, 16
-	b.lo	L(copy16)
-	ldp	A_l, A_h, [src]
-	ldp	D_l, D_h, [srcend, -16]
-	stp	A_l, A_h, [dstin]
-	stp	D_l, D_h, [dstend, -16]
-	ret
-
-	/* Copy 8-15 bytes.  */
-L(copy16):
-	tbz	count, 3, L(copy8)
-	ldr	A_l, [src]
-	ldr	A_h, [srcend, -8]
-	str	A_l, [dstin]
-	str	A_h, [dstend, -8]
-	ret
-
-	.p2align 3
-	/* Copy 4-7 bytes.  */
-L(copy8):
-	tbz	count, 2, L(copy4)
-	ldr	A_lw, [src]
-	ldr	B_lw, [srcend, -4]
-	str	A_lw, [dstin]
-	str	B_lw, [dstend, -4]
+	.macro ret1
 	ret
+	.endm
 
-	/* Copy 0..3 bytes using a branchless sequence.  */
-L(copy4):
-	cbz	count, L(copy0)
-	lsr	tmp1, count, 1
-	ldrb	A_lw, [src]
-	ldrb	C_lw, [srcend, -1]
-	ldrb	B_lw, [src, tmp1]
-	strb	A_lw, [dstin]
-	strb	B_lw, [dstin, tmp1]
-	strb	C_lw, [dstend, -1]
-L(copy0):
-	ret
-
-	.p2align 4
-	/* Medium copies: 33..128 bytes.  */
-L(copy32_128):
-	ldp	A_l, A_h, [src]
-	ldp	B_l, B_h, [src, 16]
-	ldp	C_l, C_h, [srcend, -32]
-	ldp	D_l, D_h, [srcend, -16]
-	cmp	count, 64
-	b.hi	L(copy128)
-	stp	A_l, A_h, [dstin]
-	stp	B_l, B_h, [dstin, 16]
-	stp	C_l, C_h, [dstend, -32]
-	stp	D_l, D_h, [dstend, -16]
-	ret
-
-	.p2align 4
-	/* Copy 65..128 bytes.  */
-L(copy128):
-	ldp	E_l, E_h, [src, 32]
-	ldp	F_l, F_h, [src, 48]
-	cmp	count, 96
-	b.ls	L(copy96)
-	ldp	G_l, G_h, [srcend, -64]
-	ldp	H_l, H_h, [srcend, -48]
-	stp	G_l, G_h, [dstend, -64]
-	stp	H_l, H_h, [dstend, -48]
-L(copy96):
-	stp	A_l, A_h, [dstin]
-	stp	B_l, B_h, [dstin, 16]
-	stp	E_l, E_h, [dstin, 32]
-	stp	F_l, F_h, [dstin, 48]
-	stp	C_l, C_h, [dstend, -32]
-	stp	D_l, D_h, [dstend, -16]
-	ret
-
-	.p2align 4
-	/* Copy more than 128 bytes.  */
-L(copy_long):
-	/* Use backwards copy if there is an overlap.  */
-	sub	tmp1, dstin, src
-	cbz	tmp1, L(copy0)
-	cmp	tmp1, count
-	b.lo	L(copy_long_backwards)
-
-	/* Copy 16 bytes and then align dst to 16-byte alignment.  */
-
-	ldp	D_l, D_h, [src]
-	and	tmp1, dstin, 15
-	bic	dst, dstin, 15
-	sub	src, src, tmp1
-	add	count, count, tmp1	/* Count is now 16 too large.  */
-	ldp	A_l, A_h, [src, 16]
-	stp	D_l, D_h, [dstin]
-	ldp	B_l, B_h, [src, 32]
-	ldp	C_l, C_h, [src, 48]
-	ldp	D_l, D_h, [src, 64]!
-	subs	count, count, 128 + 16	/* Test and readjust count.  */
-	b.ls	L(copy64_from_end)
-
-L(loop64):
-	stp	A_l, A_h, [dst, 16]
-	ldp	A_l, A_h, [src, 16]
-	stp	B_l, B_h, [dst, 32]
-	ldp	B_l, B_h, [src, 32]
-	stp	C_l, C_h, [dst, 48]
-	ldp	C_l, C_h, [src, 48]
-	stp	D_l, D_h, [dst, 64]!
-	ldp	D_l, D_h, [src, 64]!
-	subs	count, count, 64
-	b.hi	L(loop64)
-
-	/* Write the last iteration and copy 64 bytes from the end.  */
-L(copy64_from_end):
-	ldp	E_l, E_h, [srcend, -64]
-	stp	A_l, A_h, [dst, 16]
-	ldp	A_l, A_h, [srcend, -48]
-	stp	B_l, B_h, [dst, 32]
-	ldp	B_l, B_h, [srcend, -32]
-	stp	C_l, C_h, [dst, 48]
-	ldp	C_l, C_h, [srcend, -16]
-	stp	D_l, D_h, [dst, 64]
-	stp	E_l, E_h, [dstend, -64]
-	stp	A_l, A_h, [dstend, -48]
-	stp	B_l, B_h, [dstend, -32]
-	stp	C_l, C_h, [dstend, -16]
-	ret
-
-	.p2align 4
-
-	/* Large backwards copy for overlapping copies.
-	   Copy 16 bytes and then align dst to 16-byte alignment.  */
-L(copy_long_backwards):
-	ldp	D_l, D_h, [srcend, -16]
-	and	tmp1, dstend, 15
-	sub	srcend, srcend, tmp1
-	sub	count, count, tmp1
-	ldp	A_l, A_h, [srcend, -16]
-	stp	D_l, D_h, [dstend, -16]
-	ldp	B_l, B_h, [srcend, -32]
-	ldp	C_l, C_h, [srcend, -48]
-	ldp	D_l, D_h, [srcend, -64]!
-	sub	dstend, dstend, tmp1
-	subs	count, count, 128
-	b.ls	L(copy64_from_start)
-
-L(loop64_backwards):
-	stp	A_l, A_h, [dstend, -16]
-	ldp	A_l, A_h, [srcend, -16]
-	stp	B_l, B_h, [dstend, -32]
-	ldp	B_l, B_h, [srcend, -32]
-	stp	C_l, C_h, [dstend, -48]
-	ldp	C_l, C_h, [srcend, -48]
-	stp	D_l, D_h, [dstend, -64]!
-	ldp	D_l, D_h, [srcend, -64]!
-	subs	count, count, 64
-	b.hi	L(loop64_backwards)
-
-	/* Write the last iteration and copy 64 bytes from the start.  */
-L(copy64_from_start):
-	ldp	G_l, G_h, [src, 48]
-	stp	A_l, A_h, [dstend, -16]
-	ldp	A_l, A_h, [src, 32]
-	stp	B_l, B_h, [dstend, -32]
-	ldp	B_l, B_h, [src, 16]
-	stp	C_l, C_h, [dstend, -48]
-	ldp	C_l, C_h, [src]
-	stp	D_l, D_h, [dstend, -64]
-	stp	G_l, G_h, [dstin, 48]
-	stp	A_l, A_h, [dstin, 32]
-	stp	B_l, B_h, [dstin, 16]
-	stp	C_l, C_h, [dstin]
-	ret
-SYM_FUNC_END(__pi_memcpy_generic)
-
-#ifdef CONFIG_AS_HAS_MOPS
+	.macro cpy1 dst, src, count
 	.arch_extension mops
-SYM_FUNC_START(__pi_memcpy)
-alternative_if_not ARM64_HAS_MOPS
-	b	__pi_memcpy_generic
-alternative_else_nop_endif
+	cpyp [\dst]!, [\src]!, \count!
+	cpym [\dst]!, [\src]!, \count!
+	cpye [\dst]!, [\src]!, \count!
+	.endm
 
-	mov	dst, dstin
-	cpyp	[dst]!, [src]!, count!
-	cpym	[dst]!, [src]!, count!
-	cpye	[dst]!, [src]!, count!
-	ret
+SYM_FUNC_START(__pi_memcpy)
+#include "memcpy_template.S"
 SYM_FUNC_END(__pi_memcpy)
-#else
-SYM_FUNC_ALIAS(__pi_memcpy, __pi_memcpy_generic)
-#endif
 
 SYM_FUNC_ALIAS(__memcpy, __pi_memcpy)
 EXPORT_SYMBOL(__memcpy)
diff --git a/arch/arm64/lib/memcpy_mc.S b/arch/arm64/lib/memcpy_mc.S
new file mode 100644
index 000000000000..d9ce8279d91f
--- /dev/null
+++ b/arch/arm64/lib/memcpy_mc.S
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2012-2021, Arm Limited.
+ *
+ * Adapted from the original at:
+ * https://github.com/ARM-software/optimized-routines/blob/afd6244a1f8d9229/string/aarch64/memcpy.S
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <asm/asm-uaccess.h>
+
+/* Assumptions:
+ *
+ * ARMv8-a, AArch64, unaligned accesses.
+ *
+ */
+
+	.macro ldrb1 reg, addr:vararg
+	KERNEL_SEA(9998f, ldrb  \reg, \addr)
+	.endm
+
+	.macro ldr1 reg, addr:vararg
+	KERNEL_SEA(9998f, ldr   \reg, \addr)
+	.endm
+
+	.macro ldp1 reg1, reg2, addr:vararg
+	KERNEL_SEA(9998f, ldp   \reg1, \reg2, \addr)
+	.endm
+
+	.macro ret1
+	mov	x0, #0
+	ret
+	.endm
+
+	.macro cpy1 dst, src, count
+	.arch_extension mops
+	KERNEL_SEA(9998f, cpyp [\dst]!, [\src]!, \count!)
+	KERNEL_SEA(9996f, cpym [\dst]!, [\src]!, \count!)
+	KERNEL_SEA(9996f, cpye [\dst]!, [\src]!, \count!)
+	.endm
+
+SYM_FUNC_START(__memcpy_mc)
+#include "memcpy_template.S"
+
+	// Exception fixups
+9996:	b.cs	9998f
+	// Registers are in Option A format
+	add	dst, dst, count
+9998:	sub	x0, dstend, dstin			// bytes not copied
+	ret
+SYM_FUNC_END(__memcpy_mc)
+
+EXPORT_SYMBOL(__memcpy_mc)
+SYM_FUNC_ALIAS_WEAK(memcpy_mc, __memcpy_mc)
+EXPORT_SYMBOL(memcpy_mc)
diff --git a/arch/arm64/lib/memcpy_template.S b/arch/arm64/lib/memcpy_template.S
new file mode 100644
index 000000000000..a8b496f8f651
--- /dev/null
+++ b/arch/arm64/lib/memcpy_template.S
@@ -0,0 +1,250 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2012-2021, Arm Limited.
+ *
+ * Adapted from the original at:
+ * https://github.com/ARM-software/optimized-routines/blob/afd6244a1f8d9229/string/aarch64/memcpy.S
+ */
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+
+/* Assumptions:
+ *
+ * ARMv8-a, AArch64, unaligned accesses.
+ *
+ */
+
+#define L(label) .L ## label
+
+#define dstin	x0
+#define src	x1
+#define count	x2
+#define dst	x3
+#define srcend	x4
+#define dstend	x5
+#define A_l	x6
+#define A_lw	w6
+#define A_h	x7
+#define B_l	x8
+#define B_lw	w8
+#define B_h	x9
+#define C_l	x10
+#define C_lw	w10
+#define C_h	x11
+#define D_l	x12
+#define D_h	x13
+#define E_l	x14
+#define E_h	x15
+#define F_l	x16
+#define F_h	x17
+#define G_l	count
+#define G_h	dst
+#define H_l	src
+#define H_h	srcend
+#define tmp1	x14
+
+/* This implementation handles overlaps and supports both memcpy and memmove
+   from a single entry point.  It uses unaligned accesses and branchless
+   sequences to keep the code small, simple and improve performance.
+
+   Copies are split into 3 main cases: small copies of up to 32 bytes, medium
+   copies of up to 128 bytes, and large copies.  The overhead of the overlap
+   check is negligible since it is only required for large copies.
+
+   Large copies use a software pipelined loop processing 64 bytes per iteration.
+   The destination pointer is 16-byte aligned to minimize unaligned accesses.
+   The loop tail is handled by always copying 64 bytes from the end.
+*/
+
+	add	dstend, dstin, count
+
+#ifdef CONFIG_AS_HAS_MOPS
+alternative_if_not ARM64_HAS_MOPS
+	b	L(no_mops)
+alternative_else_nop_endif
+	mov	dst, dstin
+	cpy1	dst, src, count
+	ret1
+#endif
+
+L(no_mops):
+	add	srcend, src, count
+	cmp	count, 128
+	b.hi	L(copy_long)
+	cmp	count, 32
+	b.hi	L(copy32_128)
+
+	/* Small copies: 0..32 bytes.  */
+	cmp	count, 16
+	b.lo	L(copy16)
+	ldp1	A_l, A_h, [src]
+	ldp1	D_l, D_h, [srcend, -16]
+	stp	A_l, A_h, [dstin]
+	stp	D_l, D_h, [dstend, -16]
+	ret1
+
+	/* Copy 8-15 bytes.  */
+L(copy16):
+	tbz	count, 3, L(copy8)
+	ldr1	A_l, [src]
+	ldr1	A_h, [srcend, -8]
+	str	A_l, [dstin]
+	str	A_h, [dstend, -8]
+	ret1
+
+	.p2align 3
+	/* Copy 4-7 bytes.  */
+L(copy8):
+	tbz	count, 2, L(copy4)
+	ldr1	A_lw, [src]
+	ldr1	B_lw, [srcend, -4]
+	str	A_lw, [dstin]
+	str	B_lw, [dstend, -4]
+	ret1
+
+	/* Copy 0..3 bytes using a branchless sequence.  */
+L(copy4):
+	cbz	count, L(copy0)
+	lsr	tmp1, count, 1
+	ldrb1	A_lw, [src]
+	ldrb1	C_lw, [srcend, -1]
+	ldrb1	B_lw, [src, tmp1]
+	strb	A_lw, [dstin]
+	strb	B_lw, [dstin, tmp1]
+	strb	C_lw, [dstend, -1]
+L(copy0):
+	ret1
+
+	.p2align 4
+	/* Medium copies: 33..128 bytes.  */
+L(copy32_128):
+	ldp1	A_l, A_h, [src]
+	ldp1	B_l, B_h, [src, 16]
+	ldp1	C_l, C_h, [srcend, -32]
+	ldp1	D_l, D_h, [srcend, -16]
+	cmp	count, 64
+	b.hi	L(copy128)
+	stp	A_l, A_h, [dstin]
+	stp	B_l, B_h, [dstin, 16]
+	stp	C_l, C_h, [dstend, -32]
+	stp	D_l, D_h, [dstend, -16]
+	ret1
+
+	.p2align 4
+	/* Copy 65..128 bytes.  */
+L(copy128):
+	ldp1	E_l, E_h, [src, 32]
+	ldp1	F_l, F_h, [src, 48]
+	cmp	count, 96
+	b.ls	L(copy96)
+	ldp1	G_l, G_h, [srcend, -64]
+	ldp1	H_l, H_h, [srcend, -48]
+	stp	G_l, G_h, [dstend, -64]
+	stp	H_l, H_h, [dstend, -48]
+L(copy96):
+	stp	A_l, A_h, [dstin]
+	stp	B_l, B_h, [dstin, 16]
+	stp	E_l, E_h, [dstin, 32]
+	stp	F_l, F_h, [dstin, 48]
+	stp	C_l, C_h, [dstend, -32]
+	stp	D_l, D_h, [dstend, -16]
+	ret1
+
+	.p2align 4
+	/* Copy more than 128 bytes.  */
+L(copy_long):
+	/* Use backwards copy if there is an overlap.  */
+	sub	tmp1, dstin, src
+	cbz	tmp1, L(copy0)
+	cmp	tmp1, count
+	b.lo	L(copy_long_backwards)
+
+	/* Copy 16 bytes and then align dst to 16-byte alignment.  */
+
+	ldp1	D_l, D_h, [src]
+	and	tmp1, dstin, 15
+	bic	dst, dstin, 15
+	sub	src, src, tmp1
+	add	count, count, tmp1	/* Count is now 16 too large.  */
+	ldp1	A_l, A_h, [src, 16]
+	stp	D_l, D_h, [dstin]
+	ldp1	B_l, B_h, [src, 32]
+	ldp1	C_l, C_h, [src, 48]
+	ldp1	D_l, D_h, [src, 64]!
+	subs	count, count, 128 + 16	/* Test and readjust count.  */
+	b.ls	L(copy64_from_end)
+
+L(loop64):
+	stp	A_l, A_h, [dst, 16]
+	ldp1	A_l, A_h, [src, 16]
+	stp	B_l, B_h, [dst, 32]
+	ldp1	B_l, B_h, [src, 32]
+	stp	C_l, C_h, [dst, 48]
+	ldp1	C_l, C_h, [src, 48]
+	stp	D_l, D_h, [dst, 64]!
+	ldp1	D_l, D_h, [src, 64]!
+	subs	count, count, 64
+	b.hi	L(loop64)
+
+	/* Write the last iteration and copy 64 bytes from the end.  */
+L(copy64_from_end):
+	ldp1	E_l, E_h, [srcend, -64]
+	stp	A_l, A_h, [dst, 16]
+	ldp1	A_l, A_h, [srcend, -48]
+	stp	B_l, B_h, [dst, 32]
+	ldp1	B_l, B_h, [srcend, -32]
+	stp	C_l, C_h, [dst, 48]
+	ldp1	C_l, C_h, [srcend, -16]
+	stp	D_l, D_h, [dst, 64]
+	stp	E_l, E_h, [dstend, -64]
+	stp	A_l, A_h, [dstend, -48]
+	stp	B_l, B_h, [dstend, -32]
+	stp	C_l, C_h, [dstend, -16]
+	ret1
+
+	.p2align 4
+
+	/* Large backwards copy for overlapping copies.
+	   Copy 16 bytes and then align dst to 16-byte alignment.  */
+L(copy_long_backwards):
+	ldp1	D_l, D_h, [srcend, -16]
+	and	tmp1, dstend, 15
+	sub	srcend, srcend, tmp1
+	sub	count, count, tmp1
+	ldp1	A_l, A_h, [srcend, -16]
+	stp	D_l, D_h, [dstend, -16]
+	ldp1	B_l, B_h, [srcend, -32]
+	ldp1	C_l, C_h, [srcend, -48]
+	ldp1	D_l, D_h, [srcend, -64]!
+	sub	dstend, dstend, tmp1
+	subs	count, count, 128
+	b.ls	L(copy64_from_start)
+
+L(loop64_backwards):
+	stp	A_l, A_h, [dstend, -16]
+	ldp1	A_l, A_h, [srcend, -16]
+	stp	B_l, B_h, [dstend, -32]
+	ldp1	B_l, B_h, [srcend, -32]
+	stp	C_l, C_h, [dstend, -48]
+	ldp1	C_l, C_h, [srcend, -48]
+	stp	D_l, D_h, [dstend, -64]!
+	ldp1	D_l, D_h, [srcend, -64]!
+	subs	count, count, 64
+	b.hi	L(loop64_backwards)
+
+	/* Write the last iteration and copy 64 bytes from the start.  */
+L(copy64_from_start):
+	ldp1	G_l, G_h, [src, 48]
+	stp	A_l, A_h, [dstend, -16]
+	ldp1	A_l, A_h, [src, 32]
+	stp	B_l, B_h, [dstend, -32]
+	ldp1	B_l, B_h, [src, 16]
+	stp	C_l, C_h, [dstend, -48]
+	ldp1	C_l, C_h, [src]
+	stp	D_l, D_h, [dstend, -64]
+	stp	G_l, G_h, [dstin, 48]
+	stp	A_l, A_h, [dstin, 32]
+	stp	B_l, B_h, [dstin, 16]
+	stp	C_l, C_h, [dstin]
+	ret1
diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d286e0a04543..da21a13151b9 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -79,6 +79,18 @@ void *memcpy(void *dest, const void *src, size_t len)
 }
 #endif
 
+#ifdef __HAVE_ARCH_MEMCPY_MC
+#undef memcpy_mc
+unsigned long memcpy_mc(void *dest, const void *src, size_t len)
+{
+	if (!kasan_check_range(src, len, false, _RET_IP_) ||
+	    !kasan_check_range(dest, len, true, _RET_IP_))
+		return len;
+
+	return __memcpy_mc(dest, src, len);
+}
+#endif
+
 void *__asan_memset(void *addr, int c, ssize_t len)
 {
 	if (!kasan_check_range(addr, len, true, _RET_IP_))
-- 
2.39.3


