Return-Path: <linuxppc-dev+bounces-18916-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F93110BA43D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 08:25:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhty54qjGz2yrD;
	Fri, 27 Mar 2026 19:25:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774599949;
	cv=none; b=ZzKlfdWZb+OVavt9ovKVOfKtn61ZbaxpDe7nWriyP1yBuJUh8PtPResslPPQ2dkDPIB+hMirWx5HVKo01kRZsOjZR5l5fiLhS0Tn7KTNq60wXwJKXNIMT2Zb490MRnEYBdlCaVgbRRmwB0rB87iQZD/OsjMzCInrt4F3UiZONwkON+eyAom0kzvFJaHW+Od+ec86GlwfRXrkVp/gSRGCRbhYj1ECList4yt4O7EAM5KT24iL0KWjWCIyeYlwQfL5HbbW1gwhmrYaduooRwM7Nv5yh090olTocR2Yei6kd0hw/zet1L7dhTPtWe3NZrvK+/WbOY3KEB0M0EeUPvpl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774599949; c=relaxed/relaxed;
	bh=qGOrNjEazvrzVhLMp+K3yNYEg55RN3GLZqMpakgepoM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wx/7mPsexM0bzAznhbVFb2WLFOcnr0RGhCV5E5lhho1on4TpwOTg+Sx+fjFiv2kxi68R+rRkAYX/ggL/V1a04+exQbaALvY/yXYfaAxB4awfiFj+4IBPGx1DrsMv72TZpELokpYjUfoDwuy/E5QE2xyzWrXz+EMBeFsu1fk4kwHpRWefKdvOVHelssY2YTfVqrBvBWCUdjUZPPphfJwhX4nlrBafTJUze7hYupY0BniqWlU+wDu0sWS/kmFRpV/m5BEhouDCmPKzE9pH/z9TRIvpz6s5G3Z9dePGMETVSEHqsd/x5MrmqT+Or0f7xGuitl859IF2nQMAQjzc5Tyk5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=njQORTNY; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=njQORTNY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhty4463cz2yr9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 19:25:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1517C6133C;
	Fri, 27 Mar 2026 08:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F944C4AF0D;
	Fri, 27 Mar 2026 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774599945;
	bh=oGcTlThlcrf/a6X6Pba0yaQBbOhK2gU5HD6vMRqLYbw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=njQORTNYseBfNIOCfwhdeA9ppWJ7maUSfI1m29FCLMsOAc3VLwzoUH5yF8yKr6mea
	 bx+1V7DTQAZd4ojLaeGJ0Cf3haex4YnlcYGkJc6gqWpYVE6NyhljsbVP0BA8rn4ocl
	 th3E+L/MxnnFaA65UP+0OZlA+Vah5cD2+QCQtpMoLgNIFhCA8eqtKOZpCOxJlAkmXg
	 mk+TUk0Rtz4vIo7JSvIUgAmQeWqKyPfMFemVWMOZXJJwErSg1qzGGRRVp3lXzBSaJ8
	 C68setmayjda5hFti2rXgLBBjXsEJfs82WxkzWojyXlsFObrjk5392Uz/bQO/irUHV
	 e65UQpbwEdk/A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6F5B9F4006E;
	Fri, 27 Mar 2026 04:25:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 27 Mar 2026 04:25:43 -0400
X-ME-Sender: <xms:Bz_GaeV3zNaSpHJHySYxTNOI14Bf1EmJgTqGji8Tx6XrdR-ly4fPVA>
    <xme:Bz_GaVaecSFZVaUx_LS_q-dDchW3x2ph_U-FNZZvjkVa-2Cbgvi2qQJJQEWm1pEen
    o2Nmsvazvbril7mJ2bFLAHoL0kR_6ydzStl4XH8vMJ4O7DQEb3zgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehtddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrh
    hinhgrshesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidr
    ohhrghdruhhkpdhrtghpthhtoheprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhope
    grnhhtohhnrdhivhgrnhhovhestggrmhgsrhhiughgvghgrhgvhihsrdgtohhmpdhrtghp
    thhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhk
    vghlvgihrdgvughupdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghu
X-ME-Proxy: <xmx:Bz_GadcJkX20GupXEUp-1Bp1i56g4LWcqwmuAAUTXMfU5fJkgo7Tdw>
    <xmx:Bz_Gae4Ua-AeB83mS_pFrGVbAUqLQoAnmgxrDbHOol1S2B-duVR5XQ>
    <xmx:Bz_GaRnLH2iPqmlmio84hLTWA0CS_wnMOI2-h11M3d92fo7SmGfrqA>
    <xmx:Bz_GaUbPhoo7c5hIYcd0gM0CfIgT0rg3SwoJSuxv9v4EumISMkIDVQ>
    <xmx:Bz_GafNBX4aAxc6vxqjfi2htd4zy-WLnaQnlHHZvUG3bWFOqd9K8W1h7>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3B247700065; Fri, 27 Mar 2026 04:25:43 -0400 (EDT)
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
X-ThreadId: ALG_cRBuf6HF
Date: Fri, 27 Mar 2026 09:25:22 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christoph Hellwig" <hch@lst.de>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Magnus Lindholm" <linmag7@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>,
 "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Dan Williams" <dan.j.williams@intel.com>, "Chris Mason" <clm@fb.com>,
 "David Sterba" <dsterba@suse.com>, "Arnd Bergmann" <arnd@arndb.de>,
 "Song Liu" <song@kernel.org>, "Yu Kuai" <yukuai@fnnas.com>,
 "Li Nan" <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Message-Id: <e7979928-b33a-4132-b08b-d95b91b14295@app.fastmail.com>
In-Reply-To: <20260327061704.3707577-4-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
 <20260327061704.3707577-4-hch@lst.de>
Subject: Re: [PATCH 03/28] arm64/xor: fix conflicting attributes for xor_block_template
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 27 Mar 2026, at 07:16, Christoph Hellwig wrote:
> Commit 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
> changes the definition to __ro_after_init instead of const, but failed to
> update the external declaration in xor.h.  This was not found because
> xor-neon.c doesn't include <asm/xor.h>, and can't easily do that due to
> current architecture of the XOR code.
>

Even if it did, it wouldn't matter - __ro_after_init has no effect on declarations, only on definitions - it only controls the placement of the object in the .data..ro_after_init section (and declarations don't generate any code)

> Fixes: 2c54b423cf85 ("arm64/xor: use EOR3 instructions when available")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm64/include/asm/xor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

