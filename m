Return-Path: <linuxppc-dev+bounces-19587-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F998F44850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 12:20:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsbTn4zZwz2yps;
	Fri, 10 Apr 2026 22:19:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775823597;
	cv=none; b=OeFoHNBNW1+LcH8TCJTiAJDvK4L82xVUp12Q8qc8VGG1qds5IG14Y9EgSbpn7ywSfIhJu+X2tyMxEa5imDag6JC0VV5kDWhI3cz56oExnok5E8ExHA6RUJJz4ZxyTqOYDyUrO1J6ovjh7igkX1CBS4Qi7ghCtDMKjpgbYgVKarFufOBzc9BMF0eBmEzqIzTn3ySttO70TbMOxMGRdEFlwbn82SdwnZlmmvba3qAqcQNibr/T3MNTK3AMydzxcMfvtjT5GjRV1jkd/BVJDNSSdm3vS/g5QisQtHHr9kt9e0cG2q9CsOq/4kXIFlUmDWRUaaoC7Ll/j7UjP1nZ7nyE2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775823597; c=relaxed/relaxed;
	bh=UDyKTHGnMCmYbgJ8T4kKNARn1fh97FJoB2dW0qVXMMM=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d0Lp+BRGyqtBsxCH4AG16zfsY39LmMzokRCvQABm6FnaICA0Yl8lsSyOSmv/gDQklXq+NIVNj/UANwmJm5AECOlMUgCF89N+LayXxe1fp12vxF45tmKi51LDLYGt9tRxYDw11qDxYK/d9oKbA9nHuRdrIkFCXmn7JHegiog6sDBJ9+Iq/Jiz23+vQEfwJTzA8XzpBZ65zD4c2rSYeqVSP5fOhqzFrHfTafzwB1NzrNaig5AUdpnYaJdSZj17tRi1iA6LrutqZ953HkDBAAoiI5+rj9bCeFUAFR8dQL33MRQU9r/ALbaVuABH9Zs5B+zLmB0RE+D21Y6hESzI5ImzQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jdPhw8GN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jdPhw8GN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsbTm6S1Jz2yZ6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 22:19:56 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3B39F41A7C;
	Fri, 10 Apr 2026 12:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B407C2BC87;
	Fri, 10 Apr 2026 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823595;
	bh=QF8xu2w1ekYQn9h8hXu1i+73iAYxDniq8hK08qkXVok=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jdPhw8GNcCbidbYQHfvNnynlBMQ6C8yak4JEVkjtLiGZL97Y3Kg6hDMEq3+pAZn9l
	 eebAKa8zdYjNIUhQRVD9BnFcdpgh+r9+oY8nCOOBP3TXDWg59J0yEe49bjDh/j5GY1
	 J/+Mrsj5Z9JlM/AmirqGD8HvbUDB7O2+WSvwYb2Dt2w8mdLS3mlRSvEUCA//cm+I50
	 T3lnhTwlF7Ll8vkIeV4joWfasbaLJDpe8kQqwYnenbDJtbX6i3a/y8coaGgKPKMk+y
	 /Al4CmKTrbd6SuhGXm70yx904ODj2E0CWQ5/8mFozaTW1DKtHUVqiCNDO1sI7Gfirg
	 PX6BMdDjfEFyw==
Date: Fri, 10 Apr 2026 14:19:52 +0200
Message-ID: <20260410120318.727211419@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
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
Subject: [patch 17/38] ext4: Replace get_cycles() usage with ktime_get()
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

get_cycles() is not guaranteed to be functional on all systems/platforms
and the values returned are unitless and not easy to map to something
useful.

Use ktime_get() instead, which provides nanosecond timestamps and is
functional everywhere.

This is part of a larger effort to limit get_cycles() usage to low level
architecture code.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
---
 fs/ext4/mballoc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1289,7 +1289,7 @@ void ext4_mb_generate_buddy(struct super
 	ext4_grpblk_t len;
 	unsigned free = 0;
 	unsigned fragments = 0;
-	unsigned long long period = get_cycles();
+	ktime_t period = ktime_get();
 
 	/* initialize buddy from bitmap which is aggregation
 	 * of on-disk bitmap and preallocations */
@@ -1328,7 +1328,7 @@ void ext4_mb_generate_buddy(struct super
 
 	clear_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &(grp->bb_state));
 
-	period = get_cycles() - period;
+	period = ktime_get() - period;
 	atomic_inc(&sbi->s_mb_buddies_generated);
 	atomic64_add(period, &sbi->s_mb_generation_time);
 }


