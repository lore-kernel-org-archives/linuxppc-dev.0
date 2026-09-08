Return-Path: <linuxppc-dev+bounces-26752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFE8C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 06:50:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfF1V6cWGz2yFK;
	Tue, 08 Sep 2026 16:50:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788850206;
	cv=none; b=VPHnBQvXr8XTcT3IvjnVPowSiYSrs9kV7szmGz3CFq2ZvIfWhSD1uLbtqsF0mnZo1bOCwABi8g5dWH/1rUu/EsWST8l/NcMGDsoEGfr8y0JC+wuJi5zrO5AHJROMOwrpcy9GBm2SaSjVsigek+Mhz7n4+Cfu7vLRZ52CtxxfEuw+or0Mv9exZvrue3V1s2FeYkIflmT/GQ5W+CGAcbmP67rjamFQP9tx4BAhK0XXbfotp42IHWbz83a4M+CANOBFIYT/cqWNyVjbKpV5z8v5CcRYb+ESHQMI8Qn7+amLuRDsUFyZKRcNiiQlcNJ0dkP72i2LRKgyguQVtW8SV8Fg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788850206; c=relaxed/relaxed;
	bh=E0N0giRdggNHYhrEdwLleOIkya5cDy0uT5Ra+zX3SKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jkGb1KvVsRp9YWShgCm8tkU9EXtgQl6Cj1pNDsr9sSgS7m98QXINCAMf+v5pk1aAXFWea/pgVPlulwBtBkLfmhR0jGDW6Xtq19CgbYhFOpmFscsNV4COSe2nuCMdUNKGD9v2l6LJMlzV+FHMad4MYwPUZsl0mIl7WP0hv6kZYmd2U/je7IPkSkzQik0bUqlc8PoykfPMOmukwO827YwgTPwiiveeO4kP3xZ2OdTRyIgWrU5XOlmBZ5v64aVOBk5eN07SGGLgt3xMSdFN571D8GwfysMKlbFYo0Lc1l8qKhmLGnm/qRN83Y9gqIOm79/siB75NMkDqi/0sxrQF1tjXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AFFRRXe8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AFFRRXe8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfF1T0FtQz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 16:50:04 +1000 (AEST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so4994588a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 23:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788850202; x=1789455002; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0N0giRdggNHYhrEdwLleOIkya5cDy0uT5Ra+zX3SKY=;
        b=AFFRRXe8YDqmSleMdyU9eNf+ofv2s9hBNE25FHkbEgxiUcCNbLaa9ngmyACJy/Myo8
         kyMUDbsY+/7naJM+hrlBiU+rgnUdy+e0JNYdZs7Gfp8R5d1iwwlRwxdmNrqCbBF9jrv2
         BnhECpsKsryHzDJKAzdoVH+YGPft35awTZgbFhB22R1GrkR5fecRl/lauU5eOwxRxLWG
         V6tqm068yUTuXvPdZpwmX/H1TpBNRNzCxS+M5Wa/un28sJrw65MlPpvrKSjUbWKQPDdq
         wLY29usmjZpR8lf0lTUYosqGIsaxPI4UMN4/CYvPrYygnko0R60CYQ+HaeSfNhaR8iht
         hzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788850202; x=1789455002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0N0giRdggNHYhrEdwLleOIkya5cDy0uT5Ra+zX3SKY=;
        b=Iixdb2lkN9Seg4RT3JIxC7jtr4bRRHUtS5zUT7jC1E44A7SbO7DAVo5STZ6oCSNygh
         ynSnzxnUzq+UUyTH8PU/USYJYaYMseskwWS0FfeR5KtvhDJc+uT+KtIS0j62m+1xI7u/
         ZnmB8trX/l7VMNeA2NrmQlLQNA30MzPes6j6XS06au2xQ5XIzcK5O2bdz1X+CUEljNJ2
         ljXqecj93B91Q1mUYKWebHOPKwAy1oaAcb8wjMZ/t3c/Wtbs6U7RMmyQoL/A4D1Aup5H
         0Myk6PAnYq3k8e0/7x7Z/hfYq+/wG5TVzYxh2nmsNWXsrghg9MrWg+mvBUwxTdez6EYf
         zbFg==
X-Forwarded-Encrypted: i=1; AKwUvBx+OPRRKnzGIKDtmBpsmz8+jEy0Hqqk77oYuKMIJUcMllexTywYsagWwejlid6A0aioVDRU+X6fI/1NpOQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mNfwEnmwmhqSofn0riKGhjtU0LdGLc7ro+BRzz6W2Skj73bHEQ
	C7LkuMAYbkgoryWcV8w52MuIc3aIxb4+0nyxcPZqiB4LzDO64DpeT71f
X-Gm-Gg: AYBFou2td0q84N8WaSkN5GKJIY/qgqG9ddCWuQOCXhKljpSpUXN/uPbFpWmssKqmomt
	ke6OaOjAaMQsOuedzKRebwcIlcFuyWZCJE9IupuGQdWqr1NKlFQ07o2RkLKdrVOOq2Dqu++vy4f
	Bjj27/9bHg0W0E+YPbhDBfgSd8gEvioT426AIWpGeiinTxIwZFYKJbOfV2V8qir/UBkrtZeIlLq
	llA7YSuwZZdN5AkSe4t4jkiRmMRg52sv/5nG4z+lNJTIfJ/fi1mQD7HhWiVjz0BPviKP9wl7l5j
	5NxWQ1gZQjpNit0d3B3wO5ZaSIwuRKS8Ux7tunal/bwoMhmwV5nRlsctsNW50PEj+vlblu5ZLbI
	n0Ffb0hU4akDCuxu+BTfVRpO7CpMNvH7sB6HrnwzEZMjWyQ1MaLdZrbz1zhWSGR6WelcxfIeKu6
	1RQITQW2hYUpXgmZhRSdnwn1TvWEjb/jHhVn4/aMo1qtY+XdkE4Q/STYT2foi1+FQpvG4oPL/yZ
	NmO6vo1OzmTeLKAp0Cp0JQhQPIawHPWCqyUazNbdE8=
X-Received: by 2002:a17:90b:2b43:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-39b25ed34f3mr47298760a91.0.1788850202170;
        Mon, 07 Sep 2026 23:50:02 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([122.161.53.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fe843sm24493928a91.10.2026.09.07.23.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 23:50:01 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	kees@kernel.org,
	mkchauras@gmail.com,
	amachhiw@linux.ibm.com,
	ritesh.list@gmail.com,
	robh@kernel.org,
	sayalip@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-hardening@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] powerpc/kasan: require memintrinsic prefix support for KASAN
Date: Tue,  8 Sep 2026 12:19:48 +0530
Message-ID: <20260908064948.999530-1-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
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

powerpc unconditionally selects GENERIC_ENTRY. The GENERIC_ENTRY
infrastructure relies on the compiler emitting __asan_mem*() calls at
instrumented mem*() sites rather than plain memset/memcpy/memmove, so
that entry/exit paths calling those functions are not instrumented.

This assumption is encoded in two places:

  mm/kasan/shadow.c:
    #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
        !defined(CONFIG_GENERIC_ENTRY)

  include/linux/fortify-string.h:
    #if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) &&
        !defined(CONFIG_GENERIC_ENTRY)

When GENERIC_ENTRY is set, both guards suppress the C wrappers for
memset/memcpy/memmove and the __underlying_mem*() redirections. This
is only safe when the compiler supports the prefixed __asan_mem*()
intrinsics. On older toolchains (e.g. GCC 9) that lack this support,
plain mem*() calls from instrumented code fall through to the raw
assembly implementations in mem_64.S / copy_32.S, completely bypassing
the KASAN shadow check.

Other arches with GENERIC_ENTRY (x86, s390, loongarch, riscv) do not
hit this because their CI toolchains are always new enough to support
the prefix flag.

Background: the !GENERIC_ENTRY guard was introduced by commit 69d4c0d32186
("entry, kasan, x86: Disallow overriding mem*() functions", Peter Zijlstra,
Jan 2023). The root problem is that the KASAN C wrappers override the
linker symbol memset/memcpy/memmove globally, so any call from noinstr or
__no_sanitize_address code (e.g. irqentry_enter/irqentry_exit) would still
reach the KASAN shadow-check wrapper -- at a point where KASAN invariants
may not hold. The compiler prefix approach (Marco Elver, Feb 2023,
commit 51287dcb00cc) solves this by having the compiler emit __asan_memset
at instrumented call sites and bare memset inside __no_sanitize_address
functions, splitting the decision at code-generation time rather than at
link time.

A manual C-level override cannot replicate this split: a single linker
symbol cannot be made to resolve differently depending on the caller.

x86 also placed its raw memset/memcpy/memmove implementations in
.noinstr.text (same commit, 69d4c0d32186), which is the other half of
the fix: noinstr callers hit the raw assembly directly, safely bypassing
KASAN. PowerPC has not done this. Placing mem_64.S / memcpy_64.S /
copy_32.S implementations in .noinstr.text would be the complementary
long-term fix that could re-enable KASAN on older toolchains, but it
requires care around linker stub overflow on large PPC64 kernels (the
same reason powerpc uses NOKPROBE_SYMBOL rather than noinstr for its
interrupt handlers -- see the comment in asm/interrupt.h). That work
is left as a follow-up.

For now, introduce PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX, an arch-local
compiler probe that mirrors the same check as CC_HAS_KASAN_MEMINTRINSIC_PREFIX
in lib/Kconfig.kasan but lives outside the 'if KASAN' block to avoid a
recursive dependency (CC_HAS_KASAN_MEMINTRINSIC_PREFIX depends on KASAN
which depends on HAVE_ARCH_KASAN). Gate the three HAVE_ARCH_KASAN selects
on this new symbol so that KASAN is not offered as a config option on
toolchains that cannot support it correctly with GENERIC_ENTRY.

Since KASAN on powerpc now unconditionally implies
CC_HAS_KASAN_MEMINTRINSIC_PREFIX, the old !CC_HAS_KASAN_MEMINTRINSIC_PREFIX
code paths in asm/kasan.h and asm/string.h are dead. Clean them up:

- asm/kasan.h: remove the dual-entry-point variant of _GLOBAL_KASAN /
  _GLOBAL_TOC_KASAN / EXPORT_SYMBOL_KASAN that emitted both memset and
  __memset as entry points to the same assembly.  These aliases were only
  needed so the C KASAN wrappers in shadow.c could call __memset() to
  reach raw memory ops; with the compiler prefix approach the wrappers are
  not used at all for mem* on powerpc.

- asm/string.h: remove the separate __memset/__memcpy/__memmove symbol
  declarations and the memset/memcpy/memmove macro redirections for
  uninstrumented files that were needed on old toolchains.  Simplify the
  CONFIG_KASAN block to just the three #define aliases (which are still
  used by shadow.c as raw backends).

- cputable.c, prom_init.c: update stale comments that said GCC replaces
  memcpy() with __memcpy() under KASAN; with the prefix flag it emits
  __asan_memcpy() instead.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/96dae110-f79b-4e54-8a9b-514369019b5d@linux.ibm.com
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig              | 10 +++++++---
 arch/powerpc/include/asm/kasan.h  | 19 ++++++++-----------
 arch/powerpc/include/asm/string.h | 25 +++++--------------------
 arch/powerpc/kernel/cputable.c    |  6 +++---
 arch/powerpc/kernel/prom_init.c   |  4 ++--
 5 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2580e27e4328..b27ed9739eea 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -7,6 +7,10 @@ config CC_HAS_ELFV2
 config CC_HAS_PREFIXED
 	def_bool PPC64 && $(cc-option, -mcpu=power10 -mprefixed)
 
+config PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=kernel-address -mllvm -asan-kernel-mem-intrinsic-prefix=1)) || \
+		 (CC_IS_GCC && $(cc-option,-fsanitize=kernel-address --param asan-kernel-mem-intrinsic-prefix=1))
+
 config CC_HAS_PCREL
 	# Clang has a bug (https://github.com/llvm/llvm-project/issues/62372)
 	# where pcrel code is not generated if -msoft-float, -mno-altivec, or
@@ -220,9 +224,9 @@ config PPC
 	select HAVE_ARCH_HUGE_VMAP		if PPC_RADIX_MMU || PPC_8xx
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
-	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14
-	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU
-	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64
+	select HAVE_ARCH_KASAN			if PPC32 && PAGE_SHIFT <= 14 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	select HAVE_ARCH_KASAN			if PPC_RADIX_MMU && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+	select HAVE_ARCH_KASAN			if PPC_BOOK3E_64 && PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
 	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN
 	select HAVE_ARCH_KCSAN
 	select HAVE_ARCH_KFENCE			if ARCH_SUPPORTS_DEBUG_PAGEALLOC
diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
index a690e7da53c2..ffada5f51b2b 100644
--- a/arch/powerpc/include/asm/kasan.h
+++ b/arch/powerpc/include/asm/kasan.h
@@ -2,20 +2,17 @@
 #ifndef __ASM_KASAN_H
 #define __ASM_KASAN_H
 
-#if defined(CONFIG_KASAN) && !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX)
-#define _GLOBAL_KASAN(fn)			\
-	_GLOBAL(fn);				\
-	_GLOBAL(__##fn)
-#define _GLOBAL_TOC_KASAN(fn)			\
-	_GLOBAL_TOC(fn);			\
-	_GLOBAL_TOC(__##fn)
-#define EXPORT_SYMBOL_KASAN(fn)			\
-	EXPORT_SYMBOL(__##fn)
-#else /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
+/*
+ * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
+ * enabled (see PPC_CC_HAS_KASAN_MEMINTRINSIC_PREFIX in arch/powerpc/Kconfig),
+ * so the compiler always emits __asan_mem*() at instrumented call sites and
+ * bare mem*() inside __no_sanitize_address / noinstr code.  The old dual
+ * entry-point trick (_GLOBAL_KASAN emitting both memset and __memset) is
+ * therefore never needed.
+ */
 #define _GLOBAL_KASAN(fn)	_GLOBAL(fn)
 #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(fn)
 #define EXPORT_SYMBOL_KASAN(fn)
-#endif /* CONFIG_KASAN && !CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
index 1981bd4036b5..743126e3dcc1 100644
--- a/arch/powerpc/include/asm/string.h
+++ b/arch/powerpc/include/asm/string.h
@@ -29,29 +29,14 @@ extern void * memchr(const void *,int,__kernel_size_t);
 void memcpy_flushcache(void *dest, const void *src, size_t size);
 
 #ifdef CONFIG_KASAN
-/* __mem variants are used by KASAN to implement instrumented meminstrinsics. */
-#ifdef CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX
+/*
+ * powerpc requires CC_HAS_KASAN_MEMINTRINSIC_PREFIX whenever KASAN is
+ * enabled, so the compiler emits __asan_mem*() at instrumented sites.
+ * The raw mem* symbols are always safe to call directly.
+ */
 #define __memset memset
 #define __memcpy memcpy
 #define __memmove memmove
-#else /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
-void *__memset(void *s, int c, __kernel_size_t count);
-void *__memcpy(void *to, const void *from, __kernel_size_t n);
-void *__memmove(void *to, const void *from, __kernel_size_t n);
-#ifndef __SANITIZE_ADDRESS__
-/*
- * For files that are not instrumented (e.g. mm/slub.c) we
- * should use not instrumented version of mem* functions.
- */
-#define memcpy(dst, src, len) __memcpy(dst, src, len)
-#define memmove(dst, src, len) __memmove(dst, src, len)
-#define memset(s, c, n) __memset(s, c, n)
-
-#ifndef __NO_FORTIFY
-#define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
-#endif
-#endif /* !__SANITIZE_ADDRESS__ */
-#endif /* CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX */
 #endif /* CONFIG_KASAN */
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6f6801da9dc1..44115f904c2c 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -36,8 +36,8 @@ void __init set_cur_cpu_spec(struct cpu_spec *s)
 
 	t = PTRRELOC(t);
 	/*
-	 * use memcpy() instead of *t = *s so that GCC replaces it
-	 * by __memcpy() when KASAN is active
+	 * use memcpy() instead of *t = *s so that the compiler replaces it
+	 * by __asan_memcpy() when KASAN is active
 	 */
 	memcpy(t, s, sizeof(*t));
 
@@ -55,7 +55,7 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 
 	/*
 	 * Copy everything, then do fixups. Use memcpy() instead of *t = *s
-	 * so that GCC replaces it by __memcpy() when KASAN is active
+	 * so that the compiler replaces it by __asan_memcpy() when KASAN is active
 	 */
 	memcpy(t, s, sizeof(*t));
 
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index eb9f556b0937..b763720c68b6 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1365,8 +1365,8 @@ static void __init prom_check_platform_support(void)
 	/*
 	 * First copy the architecture vec template
 	 *
-	 * use memcpy() instead of *vec = *vec_template so that GCC replaces it
-	 * by __memcpy() when KASAN is active
+	 * use memcpy() instead of *vec = *vec_template so that the compiler
+	 * replaces it by __asan_memcpy() when KASAN is active
 	 */
 	memcpy(&ibm_architecture_vec, &ibm_architecture_vec_template,
 	       sizeof(ibm_architecture_vec));
-- 
2.55.0


