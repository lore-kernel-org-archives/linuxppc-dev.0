Return-Path: <linuxppc-dev+bounces-19575-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2BBF4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:19:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbSg3S59z2ytw;
	Fri, 10 Apr 2026 22:18:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823539;
	cv=none; b=XCyG31i4RSVK1E24VJQVbX07AX9sE55N62SOT1abjsNXONslWorI+R2xEFH+PL92flKub+LdOhfzwLD5xJao/BwhI4Ewg4xixFBxgWWGJGV+f04vWX22UgF8zRpqU8CUPDG1v6o1J7MPV9+5GmJtsNBvmkYuIAbnYCPhOTNMHIkoicZu0BPQKzO5sVNxlsyckcL13V3+1DdL06FAesQfArfiNKyBcwdwEKBR46LGpyFBO5Kfob6/dOVfKHqmin4OxRfpXEs0/Q8qMjuCim4sM88e2KePV0hDrvhuwKuj6xaAcat/BNzf3jSbjTu6hshuYP42XgEAsiDQ3qgcnyNqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823539; c=relaxed/relaxed;
	bh=PxjGpSuH6k0aliX5vEQgtYlYC1MRnJEQUQbbGFxwl7s=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=JNmVDhINGCDFnGdAr8vxi8A2gqqMKyQ2yjjECeP/WmCf2Sazy4ptFhvDAcs3Dvbi2XoW6gidSA89Dp0QTcQs0s/jwOabCCR3d8VjWiMV2hF2VzYBQm9+WfbhRMW1ayGS3UB4mGJpKmIV7ZVc6Qe3n9PVGQFuNNvguxgoE4KjDjWlO/f7xU7TYq8hKJppPklUnru0SxK9WqGIzDJqDhfdGNeZfBep0mQp6hcbpFcW+4/rvQZy+7kA+W4jpsTsmwKQklKaSKN5VNgskZ9wOjhbHdM3lCxUpUNLK/KrNJ0lR3JCq45kun6ktakjoAsHdfSC66F3wcN0scFG7rFjPlloPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LfuXj06c; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LfuXj06c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbSf0N8dz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:18:58 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 65B6B401DD;
	Fri, 10 Apr 2026 12:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABB2C2BCB0;
	Fri, 10 Apr 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823536;
	bh=5QVlF6IfS2lfQjmpis0ghbno4R+SPdTSC+UKXWlrbwM=;
	h=Date:From:To:Subject:References:cc:From;
	b=LfuXj06c5pJdrLIRQZOGGUnvC0/7H7T958xB88dpTHpJCnzTPWKuOvuVXAdy6Ak37
	 q3NsmsuJzmcCS4AtrQC6BBqMKLBV6i7NYvY31kVUwAJ1fUk5DiH1UvcZhqx6Zvfgxu
	 CGnnZL59E7B5pPEKoSA2vv7lFrz68ryBNvlt7/he9gTUf+7cGk/WAoXUpUjNZe0UmE
	 dP1W1cGxClFkhCm5BU3vACeJkyoHuX3oJ0uOmck90IwaQnQkpQKPURmYasy2VBvUvQ
	 oOQV5XFs6UHn87rkBmH0n2LYh6YtwROpX/B/rCdI1TFAoh7Z5miPuEptvyhsFFD5GH
	 nRoQ9tRI1uYXg==
Date: Fri, 10 Apr 2026 14:18:52 +0200
Message-ID: <20260410120317.910770161@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
References: <20260410120044.031381086@kernel.org>
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
cc: Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org

This has been scheduled for removal more than a decade ago and the comments
related to it have been dutifully ignored. The last dependencies are gone.

Remove it along with various now empty asm/timex.h files.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/alpha/include/asm/timex.h      |    4 ----
 arch/arc/include/asm/timex.h        |   15 ---------------
 arch/arm/mach-omap1/Kconfig         |    2 +-
 arch/hexagon/include/asm/timex.h    |    3 ---
 arch/m68k/include/asm/timex.h       |   15 ---------------
 arch/microblaze/include/asm/timex.h |   13 -------------
 arch/mips/include/asm/timex.h       |    8 --------
 arch/openrisc/include/asm/timex.h   |    3 ---
 arch/parisc/include/asm/timex.h     |    2 --
 arch/powerpc/include/asm/timex.h    |    2 --
 arch/s390/include/asm/timex.h       |    2 --
 arch/sh/include/asm/timex.h         |   24 ------------------------
 arch/sparc/include/asm/timex.h      |    2 +-
 arch/sparc/include/asm/timex_32.h   |   14 --------------
 arch/sparc/include/asm/timex_64.h   |    2 --
 arch/um/include/asm/timex.h         |    9 ---------
 arch/x86/include/asm/timex.h        |    3 ---
 17 files changed, 2 insertions(+), 121 deletions(-)

--- a/arch/alpha/include/asm/timex.h
+++ b/arch/alpha/include/asm/timex.h
@@ -7,10 +7,6 @@
 #ifndef _ASMALPHA_TIMEX_H
 #define _ASMALPHA_TIMEX_H
 
-/* With only one or two oddballs, we use the RTC as the ticker, selecting
-   the 32.768kHz reference clock, which nicely divides down to our HZ.  */
-#define CLOCK_TICK_RATE	32768
-
 /*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
--- a/arch/arc/include/asm/timex.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_ARC_TIMEX_H
-#define _ASM_ARC_TIMEX_H
-
-#define CLOCK_TICK_RATE	80000000 /* slated to be removed */
-
-#include <asm-generic/timex.h>
-
-/* XXX: get_cycles() to be implemented with RTSC insn */
-
-#endif /* _ASM_ARC_TIMEX_H */
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -74,7 +74,7 @@ config OMAP_32K_TIMER
 	  currently only available for OMAP16XX, 24XX, 34XX, OMAP4/5 and DRA7XX.
 
 	  On OMAP2PLUS this value is only used for CONFIG_HZ and
-	  CLOCK_TICK_RATE compile time calculation.
+	  timer frequency compile time calculation.
 	  The actual timer selection is done in the board file
 	  through the (DT_)MACHINE_START structure.
 
--- a/arch/hexagon/include/asm/timex.h
+++ b/arch/hexagon/include/asm/timex.h
@@ -9,9 +9,6 @@
 #include <asm-generic/timex.h>
 #include <asm/hexagon_vm.h>
 
-/* Using TCX0 as our clock.  CLOCK_TICK_RATE scheduled to be removed. */
-#define CLOCK_TICK_RATE              19200
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 static inline int read_current_timer(unsigned long *timer_val)
--- a/arch/m68k/include/asm/timex.h
+++ b/arch/m68k/include/asm/timex.h
@@ -7,21 +7,6 @@
 #ifndef _ASMm68K_TIMEX_H
 #define _ASMm68K_TIMEX_H
 
-#ifdef CONFIG_COLDFIRE
-/*
- * CLOCK_TICK_RATE should give the underlying frequency of the tick timer
- * to make ntp work best.  For Coldfires, that's the main clock.
- */
-#include <asm/coldfire.h>
-#define CLOCK_TICK_RATE	MCF_CLK
-#else
-/*
- * This default CLOCK_TICK_RATE is probably wrong for many 68k boards
- * Users of those boards will need to check and modify accordingly
- */
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#endif
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
--- a/arch/microblaze/include/asm/timex.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2006 Atmark Techno, Inc.
- */
-
-#ifndef _ASM_MICROBLAZE_TIMEX_H
-#define _ASM_MICROBLAZE_TIMEX_H
-
-#include <asm-generic/timex.h>
-
-#define CLOCK_TICK_RATE 1000 /* Timer input freq. */
-
-#endif /* _ASM_TIMEX_H */
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -19,14 +19,6 @@
 #include <asm/cpu-type.h>
 
 /*
- * This is the clock rate of the i8253 PIT.  A MIPS system may not have
- * a PIT by the symbol is used all over the kernel including some APIs.
- * So keeping it defined to the number for the PIT is the only sane thing
- * for now.
- */
-#define CLOCK_TICK_RATE 1193182
-
-/*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
  *
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -25,9 +25,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-/* This isn't really used any more */
-#define CLOCK_TICK_RATE 1000
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 #endif
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -9,8 +9,6 @@
 
 #include <asm/special_insns.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -11,8 +11,6 @@
 #include <asm/cputable.h>
 #include <asm/vdso/timebase.h>
 
-#define CLOCK_TICK_RATE	1024000 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -177,8 +177,6 @@ static inline void local_tick_enable(uns
 	set_clock_comparator(get_lowcore()->clock_comparator);
 }
 
-#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static __always_inline unsigned long get_tod_clock(void)
--- a/arch/sh/include/asm/timex.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm-sh/timex.h
- *
- * sh architecture timex specifications
- */
-#ifndef __ASM_SH_TIMEX_H
-#define __ASM_SH_TIMEX_H
-
-/*
- * Only parts using the legacy CPG code for their clock framework
- * implementation need to define their own Pclk value. If provided, this
- * can be used for accurately setting CLOCK_TICK_RATE, otherwise we
- * simply fall back on the i8253 PIT value.
- */
-#ifdef CONFIG_SH_PCLK_FREQ
-#define CLOCK_TICK_RATE		(CONFIG_SH_PCLK_FREQ / 4) /* Underlying HZ */
-#else
-#define CLOCK_TICK_RATE		1193180
-#endif
-
-#include <asm-generic/timex.h>
-
-#endif /* __ASM_SH_TIMEX_H */
--- a/arch/sparc/include/asm/timex.h
+++ b/arch/sparc/include/asm/timex.h
@@ -4,6 +4,6 @@
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/timex_64.h>
 #else
-#include <asm/timex_32.h>
+#include <asm-generic/timex.h>
 #endif
 #endif
--- a/arch/sparc/include/asm/timex_32.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm/timex.h
- *
- * sparc architecture timex specifications
- */
-#ifndef _ASMsparc_TIMEX_H
-#define _ASMsparc_TIMEX_H
-
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
-#include <asm-generic/timex.h>
-
-#endif
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -9,8 +9,6 @@
 
 #include <asm/timer.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 /* Getting on the cycle counter on sparc64. */
 typedef unsigned long cycles_t;
 #define get_cycles()	tick_ops->get_tick()
--- a/arch/um/include/asm/timex.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_TIMEX_H
-#define __UM_TIMEX_H
-
-#define CLOCK_TICK_RATE (HZ)
-
-#include <asm-generic/timex.h>
-
-#endif
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -14,9 +14,6 @@ static inline unsigned long random_get_e
 }
 #define random_get_entropy random_get_entropy
 
-/* Assume we use the PIT time source for the clock tick */
-#define CLOCK_TICK_RATE		PIT_TICK_RATE
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 #endif /* _ASM_X86_TIMEX_H */


