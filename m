Return-Path: <linuxppc-dev+bounces-19573-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE7EF44847
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:18:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbSS5FQ7z2xLt;
	Fri, 10 Apr 2026 22:18:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823528;
	cv=none; b=KjS6Dk5ga7VADUK8tXAXgD7mXxYnnOjp493EIOAtvIhABqm6qALzrmZdhIYbRavKGIe7JsJfohpF7lew+KwHyEpXq+rGeQ874ND3/R9SNy7oMPER9KHSRhxZObFVUWjHh+WjOIZSKai3+YDkPJ3sAJ+Bujj7Ll2G5b3ZjybDsAjvXfc+ze6rrr0UlRKXbqPxS99rM2famXvvljsPkaJxNO1iT6ljrGxyDHPpy3UeN1peDke62wT4sSzRz/7NzsBPGpmYeb02RZMTEeMWjK30uqjeVqRyrcf5QLKI1l6H347zRY+47f5KADHA4XwqmpkthSlmbXhJnl3bVZWP2EHl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823528; c=relaxed/relaxed;
	bh=QNbKEqaPolXnyDtyb0N89kzCxyVMHVZnkdKQSB7ziQU=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=bEVFBgg0oRuxINyLaCEXIxNIZkJp48GZsh2c9B3GMplSipgBZACXewK9R5Thik0YYAVIOaTcTt4GYnO+07AItsyeQ5HyMoLK1Y0yt3RNgDcBmwKqJsPTG8+9fKylLlaITSyH95BByHpiu7HBNauJ0Y1GcBz3ccl4zCPa7Dr4y6Qhi00yOq7n2GLTFfjfzsVh3yyv2NGvy7YoJkk6aq8ukcMHJx4mtz6UAZACVK3TiVHZW89UVOUGTE2X1d6FWY3cP8+Lta0LAGmI4J/wHHD1xiF4LC+S5BzUyj+EwM03qHmwjcOV38nhXLsJrRplyNlvNwa9DBbElDQk4ZA6Q+xMwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gYJITPmd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gYJITPmd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbSR6jKxz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:18:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 562114415B;
	Fri, 10 Apr 2026 12:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EC1C2BCB0;
	Fri, 10 Apr 2026 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823526;
	bh=OWF9pG0hQ95RygMnh7+vDhgeHyKnJRYOWEj0GBEdTEY=;
	h=Date:From:To:Subject:References:cc:From;
	b=gYJITPmdy2GNPsbI6AD2iZ7zhMgePGS+gqPbXQCs7WsAhhu/qyX8hH+Xi69K/urPl
	 BoSeBlt4BbqU4ZnISQ8slAdj5VCjiDRcN9bfEzsBBE9dj/wWUHwDFECfvHb21gTPQ5
	 cvjmyUKF+jJ25R6iZ5vAzO3xaA8XXwp+1aea+F9V1esc/zHHX5PN7paJBTByHcDBl2
	 auQKRV9dXMsXdujNzqathwxe2n8RWyCswG/DXqH2EllhOxm/ndPsrTIJX4WzacriA/
	 t/DalYn89VnEQy6E+ROiviOqorgI/E12LPFkiSGiJSdwmaaiky6k8Wx7OG7Y+w6GUr
	 Ni5ruNMG7XCYg==
Date: Fri, 10 Apr 2026 14:18:42 +0200
Message-ID: <20260410120317.776571540@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 03/38] x86/apm: Remove last LATCH usage
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

LATCH is a historical leftover and has been replaced with PIT_LATCH in all
other places a decade ago. Replace the last holdout and remove the
definition from jiffies.h.

This allows to remove the otherwise unused CLOCK_TICK_RATE define in the
next step.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/x86/kernel/apm_32.c |    4 ++--
 include/linux/jiffies.h  |    3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1196,9 +1196,9 @@ static void reinit_timer(void)
 	/* set the clock to HZ */
 	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
-	outb_p(LATCH & 0xff, PIT_CH0);	/* LSB */
+	outb_p(PIT_LATCH & 0xff, PIT_CH0);	/* LSB */
 	udelay(10);
-	outb_p(LATCH >> 8, PIT_CH0);	/* MSB */
+	outb_p(PIT_LATCH >> 8, PIT_CH0);	/* MSB */
 	udelay(10);
 	raw_spin_unlock_irqrestore(&i8253_lock, flags);
 #endif
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -56,9 +56,6 @@
 #define SH_DIV(NOM,DEN,LSH) (   (((NOM) / (DEN)) << (LSH))              \
                              + ((((NOM) % (DEN)) << (LSH)) + (DEN) / 2) / (DEN))
 
-/* LATCH is used in the interval timer and ftape setup. */
-#define LATCH ((CLOCK_TICK_RATE + HZ/2) / HZ)	/* For divider */
-
 extern void register_refined_jiffies(long clock_tick_rate);
 
 /* TICK_USEC is the time between ticks in usec */


