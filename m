Return-Path: <linuxppc-dev+bounces-19605-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF3F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:22:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbWS4Vfqz3f1h;
	Fri, 10 Apr 2026 22:21:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823684;
	cv=none; b=dgBfu65DMzBj8Warrnd6q/FGcU4J/cxGGREviikaeNvS4vbciLW29DRDOpZAOkfocu4G6nOsamGsZu2h7cUoDmRh3oZAfAoHvbsrE0+AFhg4vTY/UWhL/wY7WhjZZeUQVLc6vjU6Sb8Wx+Kdg8LDF4PqaBIQCkgC34GlIQQYUTUa210JaXIBKfEqVVvpR4VBoe5OGMANp/cf4w30ASw84EmY7N3VOzoQY931KPDk0TG7/amdlvSUHuYDjxbHFBo+DTMqM7nRTgcAjt2RXsFeGcO2GY7RTLSNC6NDGC0N6MVExkM7xSfE9vyaT76V+L/hkQ9w6bbQKfCLjpAsL1nqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823684; c=relaxed/relaxed;
	bh=8zvdRD2p6/HZ8oXsfe5lXlcag4dZNqBBcODU4ow/RYc=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BLZ6mlN556OVt1q5Bm5sBTggAffkZl82tZri5UgFAVG1SUndkJ6+CBHdMjMrfNFhIAZaTWSD/geGGlGsHvn95IjGGvKkgj/M4CGJcqMi7PO0/FfkBBieSrpnYQp5vjrmlSgB6BAmdiqbnQwpf5hWF0vnKwodC4h2PfKIu4pbAHEHrgxGnm52FSUQgNT7dEZdx+Z8YPKNu9jOxwR8YrayYj6unwzzTP8aUWVylK1xGvcZzSwdyDce5UHAbflY9fxUAd4HeNHHMQZRNiPg5kKkTmBViiXKB3s/rZMTDRDInPqBs/ebgnLDkxvhxWS2OEGQ7S/i6JQtzIXLulow68p17Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nXK4IjII; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nXK4IjII;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbWR5jqFz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:23 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0543642A47;
	Fri, 10 Apr 2026 12:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC20C2BCAF;
	Fri, 10 Apr 2026 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823681;
	bh=OPcZi/R5r87GvmWT5SIJxVBbPPoFFtvzuT/73U4xw6M=;
	h=Date:From:To:Cc:Subject:References:From;
	b=nXK4IjIIYC4xFxjX1itXAh56E7vQfZ/FFg1BbCs9BTXZuysjAps9x9bTN1xwZq3nZ
	 nGcIQtUczMHcNVAOXl3hUPdL+RNfqdz89/sEUMpghyMK10SkqIQqjoKkLYlZIDgGQg
	 6k/60XarMgLYO/edAAklc4cY8bckLykp1FNwUtHWQrXz6RHvG4M2KbuAE5KrJ4anwq
	 KM/F3nJU8E8F/VqEi0tPDyEpicMuyuDi9K4xS5dK75o3zu+aRbSw7hWtA0AaEaHPPT
	 N9wVjGhL4hXB+rfUE/x4Qggo67acuAQqBh4RtUYL+MOxGvNcfvlrnmgwbgp5vSVReB
	 QZ733oHdFO0vw==
Date: Fri, 10 Apr 2026 14:21:19 +0200
Message-ID: <20260410120319.924028412@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
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
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 35/38] s390: Select ARCH_HAS_RANDOM_ENTROPY
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

The only remaining non-architecture usage of get_cycles() is to provide
random_get_entropy().

Switch s390 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
providing random_get_entropy() in asm/random.h.

Add 'asm/timex.h' includes to the relevant files, so the global include can
be removed once all architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/Kconfig              |    1 +
 arch/s390/include/asm/random.h |   12 ++++++++++++
 arch/s390/include/asm/timex.h  |    6 ------
 arch/s390/kernel/time.c        |    1 +
 arch/s390/kernel/vtime.c       |    1 +
 5 files changed, 15 insertions(+), 6 deletions(-)

--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -108,6 +108,7 @@ config S390
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SCALED_CPUTIME
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
--- /dev/null
+++ b/arch/s390/include/asm/random.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_RANDOM_H
+#define _ASM_S390_RANDOM_H
+
+#include <asm/timex.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	return (unsigned long)get_tod_clock_monotonic() >> 2;
+}
+
+#endif
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -219,12 +219,6 @@ static inline unsigned long get_tod_cloc
 	return tod;
 }
 
-static inline cycles_t get_cycles(void)
-{
-	return (cycles_t)get_tod_clock_monotonic() >> 2;
-}
-#define get_cycles get_cycles
-
 /**
  * tod_to_ns - convert a TOD format value to nanoseconds
  * @todval: to be converted TOD format value
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -50,6 +50,7 @@
 #include <asm/irq_regs.h>
 #include <asm/vtimer.h>
 #include <asm/stp.h>
+#include <asm/timex.h>
 #include <asm/cio.h>
 #include "entry.h"
 
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -14,6 +14,7 @@
 #include <linux/time.h>
 #include <asm/alternative.h>
 #include <asm/cputime.h>
+#include <asm/timex.h>
 #include <asm/vtimer.h>
 #include <asm/vtime.h>
 #include <asm/cpu_mf.h>


