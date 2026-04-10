Return-Path: <linuxppc-dev+bounces-19607-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E734EF4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:23:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbWf2LMMz3f41;
	Fri, 10 Apr 2026 22:21:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823694;
	cv=none; b=HhLNY4ujaHCtTIQUbOd+ZVoYMheh+gLGKUUO/mubUVoLXoznTtu7QSNdjW0APJeJ8qQp8SHeA1dg/zmVLZkQNEvm6OdVYKHwalk8RuspL0XFyp6UWLKkxlGTUmnJF2r4viFEzi/D66fj/xYl0kAqToC3SmMvV90k24BrT3N0GPpQDal0MKWA5+vV39qmtbqhfCmq29yInB8F5X+2C3lUUsNUtQf0LCfy3XgVqmnyZkL+lH7pf0/qN4rByPfL6Ki6AXGgcfHlGY8j5vkTUXKxwP7QH6aZ9epktsvpsDxOV9eNoUVsgXVXdDBt3JwGK7iKc4Sno3O8R7G7CHotNRC6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823694; c=relaxed/relaxed;
	bh=g9ALE2yJnCpZX5YqdQYfLWAUyNKeE/FQChcdbmzeb0E=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jTKpOS1RIehLf+OaOJrp/fyrFvO8fm95exwz8E7PTsHfV7r2Jv35vI3XfnsG9dgNGRUH+lkaiuaJVRKuZYggl8UMUCPoi1IdJ7NkIJ0bHNkJhCRY7YSCaCMld6G9cRfwzOVQzMTB04BmQmr7X+3Q4wB9V6DGxxQJeZ0eNgyY9Qs1j5F4iWPd7HHzl4K1rDgygdWI3CmPHXayaJmA/3vmT0Ltq2zFfpkaZ7dgbc5e3IKKQ/3wYZJyd1xTU/V4Qq8qeSLxDRkh3i+TGAe6rVDWIPmon7HkM1oSe+Kh3xA5XFECXACaytr99CzYfQMgEVahR4NLXBBZPmPqu+SCIQ6CvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jCHje7Cb; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jCHje7Cb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbWd2r8dz2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5D91761119;
	Fri, 10 Apr 2026 12:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A92C19421;
	Fri, 10 Apr 2026 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823691;
	bh=Q+IGONPkRqfayguG6Txkx/mXXA1oIi3CJxpKCndboyw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jCHje7Cbtua5yolIUEErxzzrufBxMW0LYt1Kl8DVF/tR3HVJLQOi/32jC1MsFj4sU
	 FuxQN5MUq6aUGx6W7VIPg9yzFSdqaZMbr1tHN5zCNxM830u3a1p54HzWCg2l8d0SzU
	 xyIH4nNx8yib1hODU1iz6RiEcKM7mp5gg40/5f4Y1z++7yY40Cew7vRxlBQZnDz2BW
	 SRGp9xUTNtuoCzThvYns7ndknYQX1oh8mSimdrkytbEv0fT97jYIikQFCA2/G5YDNs
	 jkUQfDUfGpJwZkehI6Gounl+WGkLz5eknKnsUFvTrSUQCfxc7Qg1pWGasV1G+9O2Ak
	 9A3OklGLFCHng==
Date: Fri, 10 Apr 2026 14:21:28 +0200
Message-ID: <20260410120320.081003009@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
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
Subject: [patch 37/38] x86: Select ARCH_HAS_RANDOM_ENTROPY
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

Switch x86 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
providing random_get_entropy() in asm/random.h.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/Kconfig              |    1 +
 arch/x86/include/asm/random.h |   16 ++++++++++++++++
 arch/x86/include/asm/timex.h  |   17 -----------------
 arch/x86/include/asm/tsc.h    |    9 ---------
 4 files changed, 17 insertions(+), 26 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -101,6 +101,7 @@ config X86
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
--- /dev/null
+++ b/arch/x86/include/asm/random.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_RANDOM_H
+#define _ASM_X86_RANDOM_H
+
+#include <asm/processor.h>
+#include <asm/tsc.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_TSC) &&
+	    !cpu_feature_enabled(X86_FEATURE_TSC))
+		return random_get_entropy_fallback();
+	return rdtsc();
+}
+
+#endif /* _ASM_X86_RANDOM_H */
--- a/arch/x86/include/asm/timex.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_TIMEX_H
-#define _ASM_X86_TIMEX_H
-
-#include <asm/processor.h>
-#include <asm/tsc.h>
-
-static inline unsigned long random_get_entropy(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return random_get_entropy_fallback();
-	return rdtsc();
-}
-#define random_get_entropy random_get_entropy
-
-#endif /* _ASM_X86_TIMEX_H */
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -72,15 +72,6 @@ extern unsigned int tsc_khz;
 
 extern void disable_TSC(void);
 
-static inline cycles_t get_cycles(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return 0;
-	return rdtsc();
-}
-#define get_cycles get_cycles
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);


