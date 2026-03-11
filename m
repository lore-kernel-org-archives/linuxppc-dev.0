Return-Path: <linuxppc-dev+bounces-18066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D996F112583A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 15:16:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWDqb2FMVz3bf8;
	Thu, 12 Mar 2026 02:16:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773242203;
	cv=none; b=b1l8RsoASfRZhGMkc9TVaCUY9VQotgtpb+VfrfxYTRtnCw6n4C8YxjoFaRZto+XdPKxSa5iO3v6QIpl99Hz0K1r/j8B6IlA7IpbotH98J8fVUlZdqWh+/wrPdK+NB8uS52gFnFVgboZ3/4wx2SzoMm0IlCHTKqDO3xi559SnpywpnDEVMQwPGgmHeJb4tR/qKJ+0EDj0zyfpZAUC3vI+1krVkz81J1Ye4rQ449gUs32oEJF70Ll8yM+ZjDorxBBBJ0ERtBTxZLJQ12y7a7ASj1RL09bfrZS93dyELWVWcDQfky18QfVQOH46fOpeUcfy1KZsnqqcbXj+CzTbyJIW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773242203; c=relaxed/relaxed;
	bh=F00Y1VOXMkGh5fI+xpEZJV+zT5hVxwEfpxSmPV9tdhA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jUWqzJPPRvCNfuPQNAj4re9MwWDVqIuJb5veAabreM7R6Lkd3EtYaK8BxSGZLdr+3YHAdaOcNSAUBLM4MPrYhNAqz9WGVIQfbG3zLUnqmdqWTkbjpjMBuj8degx9sbYn7sUGs9zI46mVK6U6WHY/zucGRu/pNXhscu01mRjFibscFsAVHfDHwOimksCS/QH9ir4a70+N22RTVVjPIjwl82Am00aC0y35u8W7W+jTjHuiu1zHRl7rTKNBmMVai4xCegBKE/cbs4tp4nYmMDAnmHZYg2YZ+XnOdbroRoJx1kzR757WQBGZR8Uut36x7UCnZ6R3R6UtFQ/ZU7tOfWMHew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c77hS1at; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=c77hS1at;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWDqZ2H4Xz30hP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 02:16:42 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3FAE76013F;
	Wed, 11 Mar 2026 15:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D7C19421;
	Wed, 11 Mar 2026 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773242198;
	bh=F00Y1VOXMkGh5fI+xpEZJV+zT5hVxwEfpxSmPV9tdhA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c77hS1at/JZblP0fVHkdgqdxmbNk0m29v/+B9SqPsQ0OJEPe7IYswS03++eyeezhM
	 1E5riyLZFGcHmsM2vknxf2FMbFwpwu2/IUx0Bc89GpVwxoFcX+M5BUtCF/dN2364kZ
	 eTYbgtTHSI8W7kTfRc5o8unvXlVBEWrKPo5B/DKOJUr7ZZig7fzrZgEhhDd2Lnp0B0
	 yjJPrfWhLMn060FOAgegTeUSHeC8WvsBEW8YAx7t0Kag4FcNCp2iRvlLjZrwalMQ0c
	 fVerqa3ahYYrA25+60L81YEzjrL/qTeyCza8Tq0AO6cCzkOheuY1Xi5j0tUpMSNlkG
	 IpVe59ZgiZfSQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 527FFF40068;
	Wed, 11 Mar 2026 11:16:37 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 11 Mar 2026 11:16:37 -0400
X-ME-Sender: <xms:VYexadI4kNrjs5As7xl3i7OxQxe8g963MATQjSe2AhXM2Bc5Lp9i2Q>
    <xme:VYexaT-xm_sBM_b5I6B2D0qfphLF9dGrxOS90Ah-Imot3bQ8VisbN2wVi3hojApem
    YwnMqfOZvomSY6D6VbTPUHhQKL8Hx06HS3_uyGiOiVrmiZm-qEK1AY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehmphgvse
    gvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorh
    hgrdgruhdprhgtphhtthhopeguughsthhrvggvthesihgvvggvrdhorhhgpdhrtghpthht
    oheptghhlhgvrhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhrshhtvg
    hnrdgslhhumheslhhinhhugidruggvvhdprhgtphhtthhopehmrgguugihsehlihhnuhig
    rdhisghmrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrd
    hoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:VYexaTa3KyQNAKenEWbm-legEnEE-14ZJ4WIf3sUpH219oAoRymVyQ>
    <xmx:VYexaTD24scrPaIp175ec8rwsHiGUjiQEl8WN7bIYXFinXP73xIyog>
    <xmx:VYexaRHCo-_iPPz20mcu1_t6aDW9mn_-ePP09NKn74psZdEVYaCEuw>
    <xmx:VYexaePxa-niW0sg38AOI014nJbCsxBBAT_xGxXwK3v4P2EahmII-g>
    <xmx:VYexaShPP-mq6-G7rZdHmFZ_TFtiXDTV8IcwvSqhGtNo3f1qqm1ZNngX>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2D7F6700065; Wed, 11 Mar 2026 11:16:37 -0400 (EDT)
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
X-ThreadId: AZ_gtfwdS8bs
Date: Wed, 11 Mar 2026 16:16:16 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Thorsten Blum" <thorsten.blum@linux.dev>,
 "Haren Myneni" <haren@us.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, "Dan Streetman" <ddstreet@ieee.org>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <47dd8932-7347-4744-be8d-79106bc76f4b@app.fastmail.com>
In-Reply-To: <20260311150922.382941-3-thorsten.blum@linux.dev>
References: <20260311150922.382941-3-thorsten.blum@linux.dev>
Subject: Re: [PATCH] crypto: nx - fix memory leaks in nx842_crypto_{alloc,free}_ctx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Thorsten,

On Wed, 11 Mar 2026, at 16:09, Thorsten Blum wrote:
> The bounce buffers are allocated with __get_free_pages() using
> BOUNCE_BUFFER_ORDER (order 2 = 4 pages), but both the allocation error
> path and nx842_crypto_free_ctx() release the buffers with free_page().
> Use free_pages() with the matching order instead.
>
> Also, since the scomp conversion, nx842_crypto_alloc_ctx() allocates the
> context separately, but nx842_crypto_free_ctx() never releases it. Add
> the missing kfree(ctx) in nx842_crypto_free_ctx(), and reuse
> nx842_crypto_free_ctx() in the allocation error path.
>
> Fixes: ed70b479c2c0 ("crypto: nx - add hardware 842 crypto comp alg")
> Fixes: 980b5705f4e7 ("crypto: nx - Migrate to scomp API")

Thanks for the fixes.

Given that you are fixing two separate issues that were introduced ~10 years apart, I think it would be better to split this up.


