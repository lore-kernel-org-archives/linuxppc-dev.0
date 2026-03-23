Return-Path: <linuxppc-dev+bounces-18628-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EE1F46122
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 14:14:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffZth02Fqz2yWK;
	Tue, 24 Mar 2026 01:14:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774275291;
	cv=none; b=gSOiiOuXZAecqfBuQq8cCZ+UQ8ogSHSf8TNSrRODfrZ+5/wztuvLAnXDabwmukK9cnou4DC7MlnKOpUWTyD2J24bHD/aoU2xoadYW8ttW4WiYFaY16OfnuHp9Ftc8mWKYsPznrJ5HOJgiqPPF83r0HlCIJL7wJBKSGZMGU94rEDTYssq1RRO+rJDlMPyFlz8GBlfGPZ0d/sgWWkZ9jMwJUq3U0t14rsnz+8J2UVsiXgJMTx6tCtuzF2T7WmhYk4+VEj8CEoAAIk7p8DOncSQ1CnyPLdSfXDzc9HWRvvt6+IB4rotpW+py/jhF0B7B910lX/3mdiXocBBq5BJPG/Icg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774275291; c=relaxed/relaxed;
	bh=tXmXkGc2UfSuiquqOfo5ybhebuLRXvMJLqNoqYni+Ds=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gcNh9dRFmBOjsVfC1tisNLltLq5DXSanWQEmsGI8SoBn+qPSEtCnZICJuhsOikv0NPAXCPy6y8mgGzTHjT1U2XEA6X5CAjoceAKhCbwGZfb7lD7w14/Ej131BirOwFKX4PJ1J9R/3F6ahX5EZ8pWSo3LRFMZacQOMqzRPwhDw2N19JAtbKDvkNu1xl24A1WYzIT8vSpoL6s08qG/jhW+wnKS8IXyLRSSJW6MZ2RpB2JQdihmyEPOPQRBGCxkjH3M1hTHG0WEnqkLS+tjV0Zq/CokGAEiIKUsdayI92RzLMFG8VAeNvIQMFdbcZLhzm0UlXXy6D/jxfs2piLCX7EoBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VD+7uq5U; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VD+7uq5U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffZtf6xcNz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 01:14:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BFA8D43E2F;
	Mon, 23 Mar 2026 14:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2726FC4CEF7;
	Mon, 23 Mar 2026 14:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774275288;
	bh=zGq00IgPWGqL77FNM/dQDXciY/ZegFndCC/oogZLb50=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VD+7uq5UXsEy8tNVFYT36WoWcxC5JMBFOnJ+L9HEkEnM0z6S/HfXSoZQVD//wu9Ie
	 f9sJ4gTawj6Ah/1+hUkmtsWF9R2zkXz3eJ71prGWrSzKGd1O/NT7QjgujxXCWPKCqh
	 zVKBmyBrtUvIU9Ln6txHl9rDaFI1p5ToCPN5eYpgXaRNiLW8n4bfYqXdKZbuHzE5O2
	 14dZcjAHUXQ+gJdclGr+UcXsTvOk42J5nCljFdQlPIvi44WozTrh8BUE1OZdWLPvSq
	 27WrtBpqSzgdOGnPbIoWyIdItrUaOZpje09PI14YTFKuHK09i7qPuueeqaDogRoeJb
	 A1hQ40hS6LSbQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3F978F40072;
	Mon, 23 Mar 2026 10:14:47 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 23 Mar 2026 10:14:47 -0400
X-ME-Sender: <xms:10rBaTv_Pd_A-6ULzONqAVkXr_4MPD196GJQz7buHXkZltg2elmcnA>
    <xme:10rBafSBpxD0TQpOy3v6fz6LszqG4ATc9EgRBSwWtvJFKnnfSZzivlf_y50klwR7H
    3oxwI_6gxh5kL4_IKY0-9ba_-MkCP2UlYjMfD_Qupk4et9tdTn7pIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekvdffkefhgfegveekfedtieffhfelgeetiedvieffhfekfeeikeetueeg
    teetteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    epudenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnug
    horhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepvggsihhgghgvrhhssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdho
    iihlrggsshdrohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsfeeltdesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:10rBaaGFLpYPkAFfUe8s0LClJL3yg-uQETj-BtW8AqxvXx6wa2LZzg>
    <xmx:10rBaTddSLdwcMNXVRXjM4NOTdJ0Yp4OCdaOBzuRMvdTf4x8LPKDhQ>
    <xmx:10rBaToo3Hfc96ZpYYeSgQ4Ytoz773zh1Qah3jH8yRPdejjOuCDUjw>
    <xmx:10rBaUC7w4iSDgVcJNhWvQ5nPUUZu2cGhbIyUbKyYqGgX6UzBq8tRg>
    <xmx:10rBacdbgrEXFbvY5AtS0DCzs3ou6S5NjToMUix-kf4qn8fY0dEhuwF7>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A234700069; Mon, 23 Mar 2026 10:14:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: Aux1nparIO0F
Date: Mon, 23 Mar 2026 15:14:25 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
Message-Id: <2e95891e-442f-4360-a6b0-7715151a2658@app.fastmail.com>
In-Reply-To: <20260319061723.1140720-1-ebiggers@kernel.org>
References: <20260319061723.1140720-1-ebiggers@kernel.org>
Subject: Re: [PATCH 00/19] GHASH library
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, 19 Mar 2026, at 07:17, Eric Biggers wrote:
> This series is targeting libcrypto-next.  It can also be retrieved from:
>
>     git fetch 
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git 
> ghash-lib-v1
>
> This series migrates the standalone GHASH code to lib/crypto/, then
> converts the "gcm" template and AES-GCM library code to use it.  (GHASH
> is the universal hash function used by GCM mode.)  As was the case with
> POLYVAL and Poly1305 as well, the library is a much better fit for it.
>
> Since GHASH and POLYVAL are closely related and it often makes sense to
> implement one in terms of the other, the existing "polyval" library
> module is renamed to "gf128hash" and the GHASH support is added to it.
>
> The generic implementation of GHASH is also replaced with a better one
> utilizing the existing polyval_mul_generic().
>
> Note that some GHASH implementations, often faster ones using more
> recent CPU features, still exist in arch/*/crypto/ as internal
> components of AES-GCM implementations.  Those are left as-is for now.
> The goal with this GHASH library is just to provide parity with the
> existing standalone GHASH support, which is used when a full
> implementation of AES-GCM (or ${someothercipher}-GCM, if another block
> cipher is being used) is unavailable.  Migrating the
> architecture-optimized AES-GCM code to lib/crypto/ will be a next step.
>
> Eric Biggers (19):
>   lib/crypto: gf128hash: Rename polyval module to gf128hash
>   lib/crypto: gf128hash: Support GF128HASH_ARCH without all POLYVAL
>     functions
>   lib/crypto: gf128hash: Add GHASH support
>   lib/crypto: tests: Add KUnit tests for GHASH
>   crypto: arm/ghash - Make the "ghash" crypto_shash NEON-only
>   crypto: arm/ghash - Move NEON GHASH assembly into its own file
>   lib/crypto: arm/ghash: Migrate optimized code into library
>   crypto: arm64/ghash - Move NEON GHASH assembly into its own file
>   lib/crypto: arm64/ghash: Migrate optimized code into library
>   crypto: arm64/aes-gcm - Rename struct ghash_key and make fixed-sized
>   lib/crypto: powerpc/ghash: Migrate optimized code into library
>   lib/crypto: riscv/ghash: Migrate optimized code into library
>   lib/crypto: s390/ghash: Migrate optimized code into library
>   lib/crypto: x86/ghash: Migrate optimized code into library
>   crypto: gcm - Use GHASH library instead of crypto_ahash
>   crypto: ghash - Remove ghash from crypto_shash API
>   lib/crypto: gf128mul: Remove unused 4k_lle functions
>   lib/crypto: gf128hash: Remove unused content from ghash.h
>   lib/crypto: aesgcm: Use GHASH library API
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

