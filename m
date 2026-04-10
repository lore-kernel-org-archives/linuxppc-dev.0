Return-Path: <linuxppc-dev+bounces-19590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332A8F4484C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:21:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbV41zBXz2yft;
	Fri, 10 Apr 2026 22:20:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823612;
	cv=none; b=QuHHUXaiZoxxbIOS5gjeSQXlTJ+rUtNEi0ysPYvaSmJE09sUFEB9TVqOkPyvhZgkkbVqF51uM9qIfKzhwjW17zd9gwBv9SwKefZKEHghsZlXdGKdD5KkTuxkEEILmbf44Ywh6FgElWRUUnsWoPRGpSkZq6oYB8QAkslya9gZoR3cIl9Kcglj4rEXtcnNinwnyp16xj4nP6lgJfkcCePubWl7c5FF2pWlHum8+Dp7mgJOTECr680lYWaTJ6FSINmIYeuRIK/rqp9NJuv6ZCL3biTl0ps0Pmdyf/OBzfKQe8804FWv92Qvqzrxg403IXOa1ZekvRC1vF2XpeOdxeo/KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823612; c=relaxed/relaxed;
	bh=7Lj1aNml9xNTs4vJYi74RnqcLcp2m2BsrRjTAYhHjrw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=aoAFPN+cu/3FHsOnBBEG5jdxXkYRJrE5QR2Q+Tfk+Nmwsg7y0V93D318VYsSOG1QVAUHfhcZPeBWtMb8tnxXTCSz3A2N2Tec18XzldXjpcMJt91iANvWIiTLfLQe2hoQcK1Pf84Y0FV1+vFObhd8By3LLYP0UQsZd18phOdPjFNeI0GbGq4jsHv+RADO5S+zzfO9zhoQbwVhSyUXpMbBxf20w/lo2ivVgX6KaFgKfEklDk7UViHajzHHjyCLOf/CZmgNPeOliGj0MkF5xxLQCpX1b6rX9FwGzY7FD1R/g1dmLX6PpG7HpYRYOw+RaPgArn+unbc/U7XdDaY4NAECgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SEmycwX5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SEmycwX5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbV35jbWz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:20:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BC2056132F;
	Fri, 10 Apr 2026 12:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CA3C19425;
	Fri, 10 Apr 2026 12:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823609;
	bh=UKj6WoZFsTQfNpLsa4hK9AJwWp/c6TyAgfAmmgBM2Aw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=SEmycwX5s0//+gtSPktg47GJS+8sJlwAPsv65Bq7Wv5tg7uQL3Gpghd9FaOczcWIN
	 ZQaCuA/qh+jNH/riNYpmVLmwYhqyjM2JbqnNtt1yhbGBg3HT7iCiqP6g94wS0wTPIA
	 99ougHo5Nu9h67SjSnTNqyHC+/lIAAGR6p7tHCAck6aAnXmlbTDue5R1sT+DZ/waOZ
	 GXIvFpg3p1ueseORBf9eozHpgJ3jpkMWN+atB0UvtcxRk8vKXhCteFgdwrDai6rThh
	 FHU0CtO/nkzQnAaFOlH62oLpy9zcH9gwc0II0cebCdnPQhGplJ3L9nz1drcdz9bKdB
	 3Oc5+96qoKgtw==
Date: Fri, 10 Apr 2026 14:20:06 +0200
Message-ID: <20260410120318.929806643@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
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
Subject: [patch 20/38] kasan: sw_tags: Replace get_cycles() by
 random_get_entropy()
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

Seeding the random state with get_cycles() is functionally equivalent on
the architectures which provide get_cycles(), but it does not make sense
semantically.

Use random_get_entropy() instead, which is the proper interface.

This is part of a larger effort to remove get_cycles() usage from
non-architecture code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: kasan-dev@googlegroups.com
---
 mm/kasan/sw_tags.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/kasan/sw_tags.c
+++ b/mm/kasan/sw_tags.c
@@ -41,7 +41,7 @@ void __init kasan_init_sw_tags(void)
 	int cpu;
 
 	for_each_possible_cpu(cpu)
-		per_cpu(prng_state, cpu) = (u32)get_cycles();
+		per_cpu(prng_state, cpu) = (u32)random_get_entropy();
 
 	kasan_init_tags();
 	kasan_enable();


