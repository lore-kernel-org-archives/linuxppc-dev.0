Return-Path: <linuxppc-dev+bounces-19589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C172F4484F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:20:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbV00N4Nz2yqc;
	Fri, 10 Apr 2026 22:20:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823607;
	cv=none; b=IOYqyzAfFFWCI45LGfi2dGb0m2HMPVY1JUP0ZW9S7zH57vjxo9EUOO6Gs4cXpDwk8g5zC2XhPSQgukbD7nboEUBmuDHuD+9tPrdlAQ/4a7tRhu3Lf3eMSxOJdKJyemXCFa81eirZRdilSjjkYvZhAMxTPB/3Wz3pgMLnsUO1+or4D4WEK2ae2VrreJkYsJ/6g4aRjvrZ+Hcke1MEdRairHFXvbRdP5HwheGSiLYtwfGX5aLu90XujkLhO6KgUkahQlUop6jYdHtVADAjZT0CDKbw8/YzpsHhNR5tWHiC2qGDh3UcCDaAmIqQdGqNVM0gB5XoIvqXXU3I4jqFjZKE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823607; c=relaxed/relaxed;
	bh=SzqmkoHD6RR/VnMu1Lp5RPrviQ3U1+g7qyWPaG+gRfs=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Im4Cc9gn7eUS+8/CD0YZfTvdaOL+a96P9lTFSUww8bwklzNoDEvC789zea6nVQ/zYPgesB280Wn/erKN94c5ZSEqq/N8IcvgUkKwZKa2gzlIH1omZ9dtQLlu96ZX3VeRPO6I5lLT8a1KL/jhldRphGDVSiqDHzOTe96v7HnHOlElOHXyZT25vswqKNPTwFi+vdA0BAtGeMZD89LLuZG2BG0C7deF252BLZ8+ifavcfZWGMibS4AZN96qgd2TSqB88a7b+/PJFTZVlGbcUbwFmguXpvcfDVomemLaxtCw7RYJSZQ4BW8eeQ3/Elm5wpEaWeAk87+ft4cDaCPp6EsJKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SQFHopbF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SQFHopbF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbTy6ssbz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:20:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0D8F661332;
	Fri, 10 Apr 2026 12:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1939C19425;
	Fri, 10 Apr 2026 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823604;
	bh=OJyrwmrX6lIri0LIdsFu5GdqSG8VG/nHQeslgTl5R4k=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SQFHopbFA4avzkQltPCDvONKOyWmV73pxkcg27G4tKW1mNfy7PYVk0h6FRJhlowhk
	 TQQGbFN8xcNa+loyfTw/Ao/LMW9fb2z9STU9hSKk0Q9e4TyhUmpic8YPBLcUkWvS5H
	 AbfS/R5YsMQyaoKc/WDlm6lhBx4bXYBfs3B4LA3Z/Y/SjzAwbFrEIx6rz/PfITLKPl
	 d1tT7WhENbDQpyhAelqaE4x97qqSWFBpW6gFyL/Wzy4bWcES9cochVgZgvdNMg3UtL
	 W9F79+f3Gx3pjpImzUkKb/YiEF7KogJM+PPf5Wjs2H8jaVYTBcG1Ittd3E5H9zOpng
	 +M493bQX3+83g==
Date: Fri, 10 Apr 2026 14:20:01 +0200
Message-ID: <20260410120318.862164111@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
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
Subject: [patch 19/38] kcsan: Replace get_cycles() usage
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

KCSAN uses get_cycles() for two purposes:

  1) Seeding the random state with get_cycles() is a historical leftover.

  2) The microbenchmark uses get_cycles(), which provides an unit less
     counter value and is not guaranteed to be functional on all
     systems/platforms.

Use random_get_entropy() for seeding the random state and ktime_get() which
is universaly functional and provides at least a comprehensible unit.

This is part of a larger effort to remove get_cycles() usage from
non-architecture code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
---
 kernel/kcsan/core.c    |    2 +-
 kernel/kcsan/debugfs.c |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -798,7 +798,7 @@ void __init kcsan_init(void)
 	BUG_ON(!in_task());
 
 	for_each_possible_cpu(cpu)
-		per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
+		per_cpu(kcsan_rand_state, cpu) = (u32)random_get_entropy();
 
 	/*
 	 * We are in the init task, and no other tasks should be running;
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -58,7 +58,7 @@ static noinline void microbenchmark(unsi
 {
 	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
 	const bool was_enabled = READ_ONCE(kcsan_enabled);
-	u64 cycles;
+	ktime_t nsecs;
 
 	/* We may have been called from an atomic region; reset context. */
 	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
@@ -70,16 +70,16 @@ static noinline void microbenchmark(unsi
 
 	pr_info("%s begin | iters: %lu\n", __func__, iters);
 
-	cycles = get_cycles();
+	nsecs = ktime_get();
 	while (iters--) {
 		unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
 		int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
 				(!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
 		__kcsan_check_access((void *)addr, sizeof(long), type);
 	}
-	cycles = get_cycles() - cycles;
+	nsecs = ktime_get() - nsecs;
 
-	pr_info("%s end   | cycles: %llu\n", __func__, cycles);
+	pr_info("%s end   | nsecs: %llu\n", __func__, nsecs);
 
 	WRITE_ONCE(kcsan_enabled, was_enabled);
 	/* restore context */


