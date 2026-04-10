Return-Path: <linuxppc-dev+bounces-19603-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43E9F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:22:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbWG6B0Lz2ytJ;
	Fri, 10 Apr 2026 22:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823674;
	cv=none; b=PafERFDGqAJYe5GO5rDEVcqdopy6KIOg1kdUjY9d2iAoFJ3yjCScRs3FArjsaBAwolAUG/4fQ4uCLRVMyhYd18zSNWEYwWGToZIlUyKWOh6Wnf1qeSCC2P193QvX8Pt2gDNFgdHFsCz6XNOPe2RsVuQBickW5QWis6391UhZ5F3mYgWLtB4sD64IfPgOVLQ3VZicjOTEPn3g2hgyNsA8JBXlnKVrCotJHd+RI+i8R6S1q9hpg+ULqUxH4Ib+xtTvMxA9Xm2yiofKhBIwP9S12P0tysMrUjYHAzdVpRQSyjCm5wBh+O6qDkQKyWs0WgRzlV9OB2u89KzOTOgxZEropg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823674; c=relaxed/relaxed;
	bh=2HK2S+YO7fB4ujSzajjkO7eLLa83jA73mkIKAqkhMZw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zo8yOnsXTV4QuPEWhYB1ht1c23CrOf/t68vx0MT9WM+kdfbRC6hjRcG4DcKxxc2KsTK+2XYWmVRJz8+E8d8a+jFt9O2PjzBWbE+kjQKGs310zhlu8orohijZopXZXel26fOSEaKqYJKpn722K6TPx5G335Sk1D7lhH0gsHLQCWgI+E6tZ0hG6Lg4yJt0KK72nVTSi2YQMrRDx0uWWPb3iI/12BnJsmyDk/Y/oSBDqvEbmcl7MOqKYp3t6CNtbYOEkI6D9x+Lbv1FFGJOKUGTw6jUH2GvIDeYY04iu+Bu1acdbVjmbQUM0iA4kNEREjrmOynZtgRMVUObAnhr6LP85g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t+6BdojJ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t+6BdojJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbWG0dlKz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E75043A9E;
	Fri, 10 Apr 2026 12:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4B2C2BC87;
	Fri, 10 Apr 2026 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823672;
	bh=tpcbJjrROej8+Ep0S4yh9w/0viNOJRSIBsQtj9nrduE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=t+6BdojJde/UDdVdrSTxElEId1Y48xNZSVlMYQlGTL0WHNGFs3HWPQxpINyMlW0Tp
	 I6cN87TfGyJy1fhgMX3eHxGWXyIRGEfK+oj+v7ZqgSkuHT9TIqDSO48kfeefrr2R+6
	 RZvls6BOQPsjm5E39PGBUAxS3ybrYUwTjTmhDryNFYGgOGgmcHGql9J5M/vSFS9Dpm
	 Ps3dk0/gjV2/aMyaPlsNujNJN/7qos+7ycvHmAQEpnPn1tOePEJ6rKipC5ku3IQ4UE
	 ud6vC+9M6N71X0VBW7hJfjso4CmI7VrrHXujC0k5eBTPHkHx5czFPyyVnepx/5Zgc1
	 GRj7R63OiiEsA==
Date: Fri, 10 Apr 2026 14:21:09 +0200
Message-ID: <20260410120319.789114053@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
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
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 33/38] powerpc: Select ARCH_HAS_RANDOM_ENTROPY
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

Switch powerpc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/Kconfig              |    1 +
 arch/powerpc/include/asm/random.h |   13 +++++++++++++
 arch/powerpc/include/asm/timex.h  |   21 ---------------------
 3 files changed, 14 insertions(+), 21 deletions(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -150,6 +150,7 @@ config PPC
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
--- /dev/null
+++ b/arch/powerpc/include/asm/random.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_RANDOM_H
+#define _ASM_POWERPC_RANDOM_H
+
+#include <asm/cputable.h>
+#include <asm/vdso/timebase.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	return mftb();
+}
+
+#endif	/* _ASM_POWERPC_RANDOM_H */
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_TIMEX_H
-#define _ASM_POWERPC_TIMEX_H
-
-#ifdef __KERNEL__
-
-/*
- * PowerPC architecture timex specifications
- */
-
-#include <asm/cputable.h>
-#include <asm/vdso/timebase.h>
-
-ostatic inline cycles_t get_cycles(void)
-{
-	return mftb();
-}
-#define get_cycles get_cycles
-
-#endif	/* __KERNEL__ */
-#endif	/* _ASM_POWERPC_TIMEX_H */


