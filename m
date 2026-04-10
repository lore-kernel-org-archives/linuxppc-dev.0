Return-Path: <linuxppc-dev+bounces-19606-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A2AF4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:22:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbWY1z2gz2ytx;
	Fri, 10 Apr 2026 22:21:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823689;
	cv=none; b=nJ1m8NyAwE2vE0ZUSveEkz4BwW/c9UdvjQOF0nvM8L2SmqqBLP1Ltgro0SzbXhiFsBs7mMht8Nj+OxjXu3wZCJsEfbFp6Nhxezb4f61W+0wYIOrVSSQKmG3MSnzDgo6GGsTuHOV6zyKNZHkZIEhXspn9Zag5L1hcZcMFxs89xYXV9CxEMxf1sAijcHiiXcsVtK5+dCsD46uxoWXP6ARAayBlVx8YN9tMMD2Rj5fsbSN0iLOtiqApVygJZ5wYEPHPJ2D2fGsdvL2SJN7V80P8XcEy7BFPL7HRPZRk4Xa4BskF2w6IcN0JhywKWobrqt4oMgmiNlDifUfqDPjJx5Xkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823689; c=relaxed/relaxed;
	bh=CZnLdubUssxhQoUeG+xENhtvOMtrmC4aQUSEvuRJUnc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T4sqfV1j5IUGKyoWOSZzV8fh1k+T0OeSCyBtr71aFSk+RhjlrIZJI1pllUXFFRlcMIjYFpGUqUX6rw7Llosj4z1imPRxXg2G3brjzL3OG1ph4HxOVx7ZWoJvy/VLefJn3e6VY49udyn69RynhGAHwwPfu9XqBbraGGNWOd2qKyQqXF/BFfAeQg4fjXs2w6AgilGtvBJKUqWqmVtimtamIRVWoZjMMDzPqGBlCi/jEOlNZxepHKvUDlOLfZ1GmWn9Wg/U5kztBwpyEC3cJkhnAw7CJYMF7LRWd/BRc6Yh4qSkOuHC+nqoONtDAqO6OLoVr/xNDC7ES4jeIIaNtixdKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z5xk9L5P; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Z5xk9L5P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbWX4FsZz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:28 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C75564366F;
	Fri, 10 Apr 2026 12:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EE3C19425;
	Fri, 10 Apr 2026 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823686;
	bh=506UQ2xUMl1Z9eAzOmzEcIl1RJxUk5Zj30ohtcXoKMY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Z5xk9L5P21mRx0MY/8DBEFXub59mdEbOhszRMhCXrj2F4yR3gtSSMVH5Ys886C70h
	 ecuez10MlaZM3qSzOJIlSqs3GQHIX7r46PbtHbTSey1wj2Xf5OquvDCTW6/Y/BwsaZ
	 HOnECp9mbfgHCsi29AhbrdwXxEeghdlmA/P/QGWQbNRq0XZzEiWDbqYK6jtMl2Fqel
	 J/j1quCkWsAMuIIV68vkZDLkhw3pICkV08QoM7gE4lID3deNtskLbUzyP0Y6rIWxr9
	 E+31Ou3bfkNfr/XyUr2BTZMkGgo/VhX2L0FM/Xl0m04u+cc79US3jzI6GNXqNN3Dgi
	 kUVIHjYrNe9Wg==
Date: Fri, 10 Apr 2026 14:21:23 +0200
Message-ID: <20260410120320.011762129@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
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
 linux-s390@vger.kernel.org
Subject: [patch 36/38] sparc: Select ARCH_HAS_RANDOM_ENTROPY for SPARC64
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

The only remaining usage of get_cycles() is to provide random_get_entropy().

Switch sparc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

Remove asm/timex*.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig                |    1 +
 arch/sparc/include/asm/random.h   |   15 +++++++++++++++
 arch/sparc/include/asm/timex.h    |    9 ---------
 arch/sparc/include/asm/timex_64.h |   15 ---------------
 arch/sparc/kernel/pcic.c          |    1 -
 arch/sparc/kernel/time_32.c       |    1 -
 arch/sparc/vdso/vclock_gettime.c  |    1 -
 7 files changed, 16 insertions(+), 27 deletions(-)

--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -71,6 +71,7 @@ config SPARC64
 	def_bool 64BIT
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_HAS_DELAY_TIMER
+	select ARCH_HAS_RANDOM_ENTROPY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
--- /dev/null
+++ b/arch/sparc/include/asm/random.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASMsparc_RANDOM_H
+#define _ASMsparc_RANDOM_H
+
+#if defined(__sparc__) && defined(__arch64__)
+
+#include <asm/timer.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	return tick_ops->get_tick();
+}
+
+#endif
+#endif
--- a/arch/sparc/include/asm/timex.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ___ASM_SPARC_TIMEX_H
-#define ___ASM_SPARC_TIMEX_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/timex_64.h>
-#else
-#include <asm-generic/timex.h>
-#endif
-#endif
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm/timex.h
- *
- * sparc64 architecture timex specifications
- */
-#ifndef _ASMsparc64_TIMEX_H
-#define _ASMsparc64_TIMEX_H
-
-#include <asm/timer.h>
-
-/* Getting on the cycle counter on sparc64. */
-#define get_cycles()	tick_ops->get_tick()
-
-#endif
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -33,7 +33,6 @@
 #include <asm/oplib.h>
 #include <asm/prom.h>
 #include <asm/pcic.h>
-#include <asm/timex.h>
 #include <asm/timer.h>
 #include <linux/uaccess.h>
 #include <asm/irq_regs.h>
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -37,7 +37,6 @@
 
 #include <asm/mc146818rtc.h>
 #include <asm/oplib.h>
-#include <asm/timex.h>
 #include <asm/timer.h>
 #include <asm/irq.h>
 #include <asm/io.h>
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -17,7 +17,6 @@
 #include <linux/string.h>
 #include <asm/io.h>
 #include <asm/unistd.h>
-#include <asm/timex.h>
 #include <asm/clocksource.h>
 #include <asm/vvar.h>
 


