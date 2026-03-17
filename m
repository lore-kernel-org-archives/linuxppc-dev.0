Return-Path: <linuxppc-dev+bounces-18294-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FE2FD707B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 11:10:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZq505NQtz2yj1;
	Tue, 17 Mar 2026 22:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773745844;
	cv=none; b=ka1nRmwJYwqo/ipuHvhvQ7gVN4wGCnLEcpoZ4w/nxm9TqBGMY91OzkARxHTsUpo3qwAXxj0/JSXa9QZGmd75shLfNxyIDg9+q+gZR4e0HZ1xJqqflHWgJaHDqoTZ3kQPjqwo+NhCXnkA5bej9zEBX1isblVtXzp3o9V06Qj2hRD6DtJLcQf1LmZ+scHnB1kJmgaldQY9Q5p/hxRZBf48VPD4KA2eZwUzOtECXgg88Y4SCF3AO44b4NQi65GxByXMtXU71dWNIwS0sAQ4M4oh30XfT0wZV70QHKgUujnKCKnAMqHCWwtPodnic9JVR4ibL6o2q4RM2i26wPewK2LCJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773745844; c=relaxed/relaxed;
	bh=gQAjaCc01YBV2O/qYjG2UxxcE3o1hQQLGA0805Teh9Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VGLPPdih9Z7j6rh3pNdU1HNEVd6Usur5JGy2y0xKXUalWM0RJkufbCAgemLBOw+TME7HYVs32vFXA8IozZOEPm5SkJXm87LB15+LvveiV5kzgmpr5Bdn3Ug4kI8wspggmr6exbW0u4BRGX+VEUtW60YLG621odFaHg4VEAo3vvH52v2IcJaCU+IC3KENG1vZZ8IioqEClBfC1iqCag5fHcICBbH08WC9Hu897R4LCQggh0TSId09t+ZAupjUB8RE2ERp8q5usXSLHjPtiq1wYrBKwzCWbBPPbp5wE2p1tiVDCDC2KDQSbRtdhTCPhYLVy5PEOPSwFh3t/Y0hivsU7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sv0yuRI4; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sv0yuRI4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZq4z51CDz2yh4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 22:10:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9715660018;
	Tue, 17 Mar 2026 11:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F406DC2BCAF;
	Tue, 17 Mar 2026 11:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773745841;
	bh=3bEvfE0pUL8utFtiZuNftijKZptJwtJvC/QbKkBlwXs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sv0yuRI4zbij3xC7pH9F700V4EzPolTrOdP6boH6srOxTnx81+HGEIPpHELXp2WXn
	 q4W0kZpwopsA+enyjWji1lneiDmCpeq+EyGfbRI5xQDJlO4kb8Sm24DBqpjZ4xc2qe
	 YVx+TIrlTNFzUYCeJBhQNWH0YdwzX7l63xvNp6LO2mZntjFkdU675VibLdNEDkg7I3
	 m2TuRZ0BrDsQ7BRETH9Yb0Mnez1hUNHkAVtXYtSSNoFOwVpzOGZLnoBhstXs/4wwyK
	 dOzpA5rK356/bjXoKWH1S6L9Njb1zQFrhR/+2jXkzE5J/EcOYOlQU2rfgaJFMqIGEu
	 sAMkcUtGrshhg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0508DF40069;
	Tue, 17 Mar 2026 07:10:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Mar 2026 07:10:40 -0400
X-ME-Sender: <xms:rza5aU7vWiy4SKtw3-K_dcso1cFwCUJoRnGyxh7Nx5y6MD7aV0n0xQ>
    <xme:rza5aQvMLrHjqSBB8heGziWd1KEYaLb5NfXFQO9LG8JmEGiEQo1lhWEqsB5fCXUqO
    BIq4cmYofaJnwzC5G38GFHJVirffXSUm_oSphEV7ZLKc243mYxjzAU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpth
    htohepvggsihhgghgvrhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    phhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    grshhonhesiiigvdgtgedrtghomh
X-ME-Proxy: <xmx:rza5aSignthvd7zBT0pYbkHlMT2EeXrTF_RFOpYEIrG_Na8x7gtMFA>
    <xmx:rza5adGAm2YbVeb_z-iCEYhdalcRo2ABxseXOUUgfP0_PNzHdOl_Ow>
    <xmx:rza5aZ_6d9gVCwDSZX4u3e8S9SWimrwKVrarpZGIS5rBfvw2LoDmKw>
    <xmx:rza5acyKPXFPLlCSAJfAl1oJb0BP8V9O_Ja4kuGyf59d-Blqe72Fnw>
    <xmx:sDa5adMehPG5DebFbi0PmTR7LtoWV7MQSSibmr7I7GIXzdq_SR6E74tx>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8E01700065; Tue, 17 Mar 2026 07:10:39 -0400 (EDT)
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
X-ThreadId: Ao4qWWs5d1pR
Date: Tue, 17 Mar 2026 12:10:19 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org
Message-Id: <6956f2d9-dd9a-404a-a6e6-1d5478a1410a@app.fastmail.com>
In-Reply-To: <20260317044925.104184-1-ebiggers@kernel.org>
References: <20260317044925.104184-1-ebiggers@kernel.org>
Subject: Re: [PATCH] lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to clean-files
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 17 Mar 2026, at 05:49, Eric Biggers wrote:
> Make the generated file powerpc/aesp8-ppc.S be removed by 'make clean'.
>
> Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized 
> code into library")
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index 725eef05b758..dc7a56f7287d 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -53,10 +53,13 @@ endif # CONFIG_PPC
>  libaes-$(CONFIG_RISCV) += riscv/aes-riscv64-zvkned.o
>  libaes-$(CONFIG_SPARC) += sparc/aes_asm.o
>  libaes-$(CONFIG_X86) += x86/aes-aesni.o
>  endif # CONFIG_CRYPTO_LIB_AES_ARCH
> 
> +# clean-files must be defined unconditionally
> +clean-files += powerpc/aesp8-ppc.S
> +
>  
> ################################################################################
> 
>  obj-$(CONFIG_CRYPTO_LIB_AESCFB)			+= libaescfb.o
>  libaescfb-y					:= aescfb.o
> 
>
> base-commit: ebba09f198078b7a2565004104ef762d1148e7f0
> -- 
> 2.53.0

