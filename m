Return-Path: <linuxppc-dev+bounces-19594-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72035F44847
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:21:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbVS0QGPz2yr6;
	Fri, 10 Apr 2026 22:20:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823632;
	cv=none; b=AlCZtYUubFzxYTV7Ha9++ktousl/Mf0vIjv9SDqiMuj3YuYH4Z5IJ0UUXfdBFXlDMuFd2hG742bztcQlKqYtcj3vBviVC5zLADH6L+Jdr5cZs6tXei9DFenyPtMEwJBQB08IjoIEjThOkiNNq0r/uD3xkgVach/6yVXZr7AK404qxedKA369qcci9Hyl01NStuYCYBoIzM4RPZ3rhlaTVtgL5Xdm/pHwEPhZT0REmHgPiMu9g1a/PF5sTjW+8eWGQLEuVQkljhG7S5Ux/Nk+YTPJ9q6IfVVtSvCUR5s/xQEjODDlGWipgjksbNJSMPMmXBBhM3B6qdFKRZCuVwUSJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823632; c=relaxed/relaxed;
	bh=CLIogZKtxkoQJBct1ivrzjEJ9GwuhZlm0ijU/m5U3Ys=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EhPHTgrnBhNmY4q2c/cy5+79QX6zS0chVu9O2lnxzrH7S+h0HEqa3O8twuTnhUwMXxEeiNfh8OE6vUv773Kb1StjysCcRaKkuYJG9MJFIbGOZxRc4cILGh9yOOz9cgz5xdp3+Nwfys/C4xu4H96JR+3OBbaeBkq7M9t9bq9yM+AvlB0UnW3L8ws9iOJ0AxGU532HXpXWXkZKGC7EX4YNnHi7b/HqtUmaxg8zY7x/yGhtPyGY/mrwMnqe9suhCRn5g2H76ChtudJB0C9qqeeAxLhsX7Tu09xtJbrYdybjtV2/11mJu+BrZpyDmKIy0yKl+j0n6Cq/ML5XVCI3UFdWHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UacNbv5z; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UacNbv5z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbVR1rXJz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:20:31 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A1972441C0;
	Fri, 10 Apr 2026 12:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8258C2BCAF;
	Fri, 10 Apr 2026 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823629;
	bh=Xj914OB0ywB5KtjAdUFbVTIri4m7J0/9GAWloccpVyg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=UacNbv5zzA6AzbAlRM4n4U5NaKejyQd8mANj0iWZ5RQiRAJWixjyMgZjbiDhDTyzO
	 ay62PPnTA47MG/rmdeWa/4KfjNAnW4xtTzJ34RAhThlg0KY8nNByGNrsu9zE469dPQ
	 hWtTJvAZ4ZE2brA8ZCckIrkzYMvi5clv/chlzjJ3PYteh92RUSFzhMNQu3+ZTJTDCI
	 kJ6mPTSZ1AZhD1XvkSSEOtM9nEZR/77fxCsYwUjbpiFSE3ESK6EP7pbE6Ao/WrdTRD
	 AlaT3EdsheI/WmWdaf0zz7rbsJUIcktKioLIztC89PcrEqXmxk39mPCnXjzI5yFh8X
	 xNx6W4PqnkQAQ==
Date: Fri, 10 Apr 2026 14:20:26 +0200
Message-ID: <20260410120319.197793115@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
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
Subject: [patch 24/38] ARM: Select ARCH_HAS_RANDOM_ENTROPY
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

Switch ARM over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
providing random_get_entropy() in asm/random.h.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/Kconfig              |    1 +
 arch/arm/include/asm/random.h |   14 ++++++++++++++
 arch/arm/include/asm/timex.h  |   18 ------------------
 arch/arm/lib/delay.c          |    4 ++--
 4 files changed, 17 insertions(+), 20 deletions(-)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,6 +22,7 @@ config ARM
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_STACKWALK
--- /dev/null
+++ b/arch/arm/include/asm/random.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASMARM_RANDOM_H
+#define _ASMARM_RANDOM_H
+
+bool delay_read_timer(unsigned long *t);
+
+static inline unsigned long random_get_entropy(void)
+{
+	unsigned long t;
+
+	return delay_read_timer(&t) ? t : random_get_entropy_fallback();
+}
+
+#endif
--- a/arch/arm/include/asm/timex.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/include/asm/timex.h
- *
- *  Copyright (C) 1997,1998 Russell King
- *
- *  Architecture Specific TIME specifications
- */
-#ifndef _ASMARM_TIMEX_H
-#define _ASMARM_TIMEX_H
-
-// Temporary workaround
-bool delay_read_timer(unsigned long *t);
-
-#define get_cycles()	({ cycles_t c; delay_read_timer(&c) ? 0 : c; })
-#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
-
-#endif
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -42,9 +42,9 @@ static inline u64 cyc_to_ns(u64 cyc, u32
 
 static void __timer_delay(unsigned long cycles)
 {
-	cycles_t start = get_cycles();
+	cycles_t start = delay_timer->read_current_timer();
 
-	while ((get_cycles() - start) < cycles)
+	while ((delay_timer->read_current_timer() - start) < cycles)
 		cpu_relax();
 }
 


