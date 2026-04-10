Return-Path: <linuxppc-dev+bounces-19600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A299F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:22:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbW066fsz2yhV;
	Fri, 10 Apr 2026 22:21:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823660;
	cv=none; b=Q73HpFxEUbZv+JedAgTAqTfUposw/+Y51Af/rJjDyGVSfzk9RhVxvAJcESZxQCmGo0qP7AaUUG9Q7wSk606oP+4yvljioB0B5Da9xtB/f/tQr+uAaBiWpH3Gbg6G22Ft7AK0EuAiE7CPzh8UpjzcijU88a2GsAjPcYdSFrxQYOZ1loHU2bty/O8TWOABmcQrfFXyHOb3sXSH3In7vK/PYeM/u/M2gC6lS1FWzb2cHtd2lwy0wcWXYWBgNrIYFIn30+OC0HTTS6ZshiZbj9VDSehh62m9OqETy80ewhaq7tT4/btknh5uWhzH1VkuAT3Zw6D24Nge8lqY2snx9PBCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823660; c=relaxed/relaxed;
	bh=55BqTpopgqyhosJe2byyDZjQwi/7tJCuwd4CS33Nh0I=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RQFXFkBYi001tUgpbSXntfbUAvORdXcZCmc/K5Cjc8lXg9E9BsZDUL8KUY2LfnvTESOoeHkyXBxfq2GIuwSAPKdjPDO2/MEwV0jKRW2/Ih6DuSDGrOkYTmXW9x6E1rlcC1TkWbBfAtE1BeyNplFEVA3S1QMRGDrHYAV/OWi6sn8xQsYob9U2k19mZntb58a2oEeo1NHTSw9mnARpHlpRm11l/pTK+8nnJnkJa2PQpW0F/OUA4is7ESI0a27DwXTJvk7YO9NaZwzTqF6yvgLO3XlUEK5TbXkcEaT9T3MgmBJU1TRdKVEfykwBfm4+/TYTI3NVOxLzocEl0u6/Cg/nlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RmyBeAjX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RmyBeAjX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbW00MZvz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:21:00 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6B18E409C7;
	Fri, 10 Apr 2026 12:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82685C19421;
	Fri, 10 Apr 2026 12:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823658;
	bh=Hb2dziS1cUz3f0ZYnY6mq4QP/VKrKM0StdHMUX+1BaE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=RmyBeAjX6h1L2rIRLcz+AgNEdpyqYQZZkX4kYkgxpR9ZJA0/rvdow263wov/8PVOr
	 hb2QUP5GwQZouavgtAcs0bwbkCd8TxgfCVh6LWoo2a7HWknstglzPKB+9aabXFzH1J
	 rP1F6gK8dqeRn0JBTKdTohI1oCqed+5PigWBVmbAA5ah3505CMSHrUL7HPCCN4sGiu
	 NHT4954Kmifvfva6Jx9l4xaRzDUJEaSzZYxXiP8aChKSe2ykT1tpUU6RYxqauW7DoH
	 p3wDa9fQGCdDGL4OtStOnSEjWIThdsFEIiYqSYDvCq0zlNoVlLTrCjuWlgc/BYNO1M
	 jFsY3AL2zO6GQ==
Date: Fri, 10 Apr 2026 14:20:55 +0200
Message-ID: <20260410120319.593798781@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
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
Subject: [patch 30/38] openrisc: Select ARCH_HAS_RANDOM_ENTROPY
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

Switch openrisc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

Add 'asm/timex.h' includes to the relevant files, so the global include can
be removed once all architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: linux-openrisc@vger.kernel.org
---
 arch/openrisc/Kconfig              |    1 +
 arch/openrisc/include/asm/random.h |   12 ++++++++++++
 arch/openrisc/include/asm/timex.h  |    5 -----
 arch/openrisc/lib/delay.c          |    1 +
 4 files changed, 14 insertions(+), 5 deletions(-)

--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -10,6 +10,7 @@ config OPENRISC
 	select ARCH_HAS_DELAY_TIMER
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select GENERIC_BUILTIN_DTB
 	select COMMON_CLK
--- /dev/null
+++ b/arch/openrisc/include/asm/random.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef __ASM_OPENRISC_RANDOM_H
+#define __ASM_OPENRISC_RANDOM_H
+
+#include <asm/timex.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	return get_cycles();
+}
+
+#endif
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -9,13 +9,9 @@
  * OpenRISC implementation:
  * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
  */
-
 #ifndef __ASM_OPENRISC_TIMEX_H
 #define __ASM_OPENRISC_TIMEX_H
 
-#define get_cycles get_cycles
-
-#include <asm-generic/timex.h>
 #include <asm/spr.h>
 #include <asm/spr_defs.h>
 
@@ -23,6 +19,5 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
-#define get_cycles get_cycles
 
 #endif
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 
 #include <asm/param.h>
+#include <asm/timex.h>
 #include <asm/processor.h>
 
 bool delay_read_timer(unsigned long *timer_value)


