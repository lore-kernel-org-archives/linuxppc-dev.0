Return-Path: <linuxppc-dev+bounces-19597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B887F4484F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:21:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbVk3hdGz2yrS;
	Fri, 10 Apr 2026 22:20:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823646;
	cv=none; b=GGsIsK8LluOlirQGuQMB8uE2IU5AxnIjMY9IZxSS1vLj27OxgMxUlv14WSnAPU53kbr254wGIfSo36DudDn0hS9syZiB/n+6XZYuc9QIDdEGwHmYut1+gi6ztPtlK87mSf3jtq1pa5/FuxHtGe1jCupsHHM5m4tcq1MNhovMGvVaVV1nisOIPOtXZfgPuLrQ1JCqEx+ZQF93XQLMyr/10PdmkAibucZvEMSD0FT/pg3Xm+w7ceF06HplmeXnGg+BwTY9/Eiwq7Snw4tXTHVOQ2cVe/iqZopZVZXQ4xqhzi05AdwAN3f2T8J2xEXG+EjsW/47I1UjvbQ6bjAvRu7RLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823646; c=relaxed/relaxed;
	bh=vKymtlo11yiDU4TLKycOojSP+rmgc8Jkf+2yejheXps=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=X5S6iDzSk74GNOH28al64VvOIGJK3OucmyDh+qftzo7dAfvx7fUnMysh+gPaNhqvCIChn7MGZjOmBLXUnpAXHGYrPoH4oc2sR6O6rnNV2NfZUdb/AJi+igUumLqlsooJOsk7+kI7QXgl9cCy+ftEcxv63hLjL85QJyiPSgYvwDUAqYDrt+80zmUD6TwbRXPPYavKH53zek7t2w5ig8D8hZxFQIVhSbHxyIjhPEjW4Z87n7KUEvNrO+kyvSB4t58xPZ8q5/KBwi2G0jpoIvu/RO0bDvaTxGNCOconbhexNK92X9ve2ovsWJG0VW9NKAP6Zf2vh/GXoq+kLAp6hIXQdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aKc8BIj0; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aKc8BIj0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbVj55jvz2yrQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:20:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D2A206111B;
	Fri, 10 Apr 2026 12:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04A4C19425;
	Fri, 10 Apr 2026 12:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823643;
	bh=ZI1DuZTKY+73ZiUZu5YDxjD9E28Vsj2HJPMLgb9lTAs=;
	h=Date:From:To:Cc:Subject:References:From;
	b=aKc8BIj04xl8fMPMfIdxvFnc9Be7sg+HcqnW4NP8XAVA8CoHWWZUH1TGoEDd3vKKD
	 FNpRo6Iom4qBRwumLXapTj7hfgRDejsC7j6E+L/Vx4C85D2LE1/deOAcMcctONxvIo
	 HMR5AMjZPk8wC2GcrGQEDXlt0rYZP0bNeTIqA2wyhnF5OK38Pv/q09G+oh4E6MeUyG
	 /IRrdxDk2wKuJ9eIif/wOJjQhHy2AsumkYu8PWY0TnTc6wXQmoLW+lJrShxrt0E6Gb
	 m+nyDRqFv+r0pZBlp7wkM/XjcKkMGym/WCszxlys26yMLXsGUqt11/GgfHwii1mXtv
	 FSYiSRKkHgM1Q==
Date: Fri, 10 Apr 2026 14:20:40 +0200
Message-ID: <20260410120319.397219631@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
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
Subject: [patch 27/38] m68k: Select ARCH_HAS_RANDOM_ENTROPY
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

The only remaining usage of get_cycles() is to provide
random_get_entropy().

Switch m68k over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
providing random_get_entropy() in asm/random.h.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/Kconfig              |    1 +
 arch/m68k/amiga/config.c       |    1 +
 arch/m68k/include/asm/random.h |   14 ++++++++++++++
 arch/m68k/include/asm/timex.h  |   25 -------------------------
 arch/m68k/kernel/time.c        |    2 +-
 5 files changed, 17 insertions(+), 26 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -8,6 +8,7 @@ config M68K
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -36,6 +36,7 @@
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/config.h>
+#include <asm/random.h>
 
 #include "amiga.h"
 
--- /dev/null
+++ b/arch/m68k/include/asm/random.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASMm68K_RANDOM_H
+#define _ASMm68K_RANDOM_H
+
+extern unsigned long (*mach_random_get_entropy)(void);
+
+static inline unsigned long random_get_entropy(void)
+{
+	if (mach_random_get_entropy)
+		return mach_random_get_entropy();
+	return random_get_entropy_fallback();
+}
+
+#endif
--- a/arch/m68k/include/asm/timex.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm-m68k/timex.h
- *
- * m68k architecture timex specifications
- */
-#ifndef _ASMm68K_TIMEX_H
-#define _ASMm68K_TIMEX_H
-
-static inline cycles_t get_cycles(void)
-{
-	return 0;
-}
-
-extern unsigned long (*mach_random_get_entropy)(void);
-
-static inline unsigned long random_get_entropy(void)
-{
-	if (mach_random_get_entropy)
-		return mach_random_get_entropy();
-	return random_get_entropy_fallback();
-}
-#define random_get_entropy	random_get_entropy
-
-#endif
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -26,12 +26,12 @@
 #include <asm/machdep.h>
 #include <asm/io.h>
 #include <asm/irq_regs.h>
+#include <asm/random.h>
 
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/profile.h>
 
-
 unsigned long (*mach_random_get_entropy)(void);
 EXPORT_SYMBOL_GPL(mach_random_get_entropy);
 


