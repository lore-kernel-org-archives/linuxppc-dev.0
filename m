Return-Path: <linuxppc-dev+bounces-20416-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C1AFF885A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 11:43:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8KXy3LkYz2yZ3;
	Mon, 04 May 2026 21:43:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777895026;
	cv=none; b=NDm7d3kWQ+P5NVYSGlmPSfOl1VwwAgRiDeNa046gBNXvRV1ZWN3MPDjvqgUC/6VTwjDdA6AhPc3yo2cVmXlPT4c6YS4I9nHY0rSehvcxDNs5JmDyGivbU6s/sAZkXHoRjd82qVjEdDyrtX+yzsLHaQrh63UGftLv+sF+yqNA7y51qC6/cTvugUgqN618/A1VfgaOV0nvuyzIQSMFaBoQAuCxAhxutKSV9++Ke8mB+bBPAHEhIBpGc0z0qcCaKd/6CpVzrxLfIgEjz8hIAOa1s0+Jz6cjKPBLAiRZd6yqRcqMc5fGYchfPqRuVNc/caJtL7bPXlyRUHzKcIBMHl6heQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777895026; c=relaxed/relaxed;
	bh=EdiC7IIzuVZYLWVQHdInuprKiuZBY1RY0PWkBsozWq8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AkBA5GFAd6i0K51nOUr6/O9znGICn5+G8jntnDK2ziLVpAJGm6mBF/G6yhe+ssdq+Ms/kD+CPTgEpUg/YqE9GZrpGhqbSXhcmNKOTqdDafgZi0eQgXItD9MNYv5P8kSOaUdpuGhTxIoMmig84rQYisMVLs/nf8biHISB7lQk/4MF93LEJGc3ZllqxL29mokCTa5qaO4RX1yt8aN/5z2N1r/pbxUx1pIiHS9mfskxIOu8X0KDLRgOaWXkuvqc+SWjl4LLr7vItW5SHJ66PigsmlIkZMMjrebSVd8rDSBMgcTAxqTMl1JWNOoRcVNQVPDN3HlCkOTkfa8FHpqYVUK1yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RpCcKsgX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RpCcKsgX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8KXx0Zh6z2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 May 2026 21:43:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A02560121;
	Mon,  4 May 2026 11:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91923C2BCB8;
	Mon,  4 May 2026 11:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777895022;
	bh=vqtPq34eTX5fZopa1Zag6rnbLG2P5/lfyqob6OhB+EQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RpCcKsgXRawLEKF0W38hxJt664U/27oQZrO9bzXtc7EbE18l1XmXMf+1Xcvh8nvW6
	 7HBx7yEy+lowEWdc9dno1n8mJE2B3CP7nU0Sj38WY0SE328QHEGg4gZHT+It4bDe+h
	 ErWrkzoZfl3mgcsDIMAbaIY1cFsx+XZlU2JBGmsp+4sKDOGXOMHScLJH2yZPDL2Wfq
	 bxqU0aAkDjeGSE27rkMTRuMpSeciqDpT3oibgzmg7VVECGcP9J0qx5Cg+RWgSZoYE5
	 sII+yrnzUyUrtq6oCmS6mNwK4BiI1vh0wIV4U/heU82L2YpuK3CLmTq9o/4m9Bkgey
	 mka5sojY+nFMA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 810D5F40076;
	Mon,  4 May 2026 07:43:40 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Mon, 04 May 2026 07:43:40 -0400
X-ME-Sender: <xms:bIb4aWyG5Uegze_yqOlM-EzjzyFDhC2-5C9ORwUDjrIcyVXxLlQCcw>
    <xme:bIb4adEXnkI6Ft2knI1j7d8i_b248eBkZ5wh-uo96SSHDVcGd5LDa7XrweqhTOJt4
    P_SycdmcBn0vBkm75s6HIlpntyWno3y0D-1Q2RLhWcrsxjcssxAkGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhguuceu
    ihgvshhhvghuvhgvlhdfuceorghruggssehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepkedvffekhffggeevkeeftdeifffhleegteeivdeifffhkeefieekteeugeet
    teetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhguodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduieejtdehtddtjeelqdeffedvudeigeduhedqrghruggspeepkh
    gvrhhnvghlrdhorhhgseifohhrkhhofhgrrhgurdgtohhmpdhnsggprhgtphhtthhopedu
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhpvgesvghllhgvrhhmrghnrd
    hiugdrrghupdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdprhgtphht
    thhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpth
    htoheptghhlhgvrhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsihhgghgv
    rhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrgguugihsehlihhnuhigrdhisg
    hmrdgtohhmpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihl
    rggsshdrohhrghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bIb4abXzzI1UfrhrPlxN9md_Jz-fcbJQUBjcbSj-IYkS7HFjccAqdA>
    <xmx:bIb4aVKfwlYJqT3UyrS2cf8V1ATnVsvKa-V_S_xYMmyAHegfXA1baw>
    <xmx:bIb4aWoYJA5MWKXForks4dPpx0Ax7QOapWp7ep4m8sKkelYtKyUdWg>
    <xmx:bIb4acxyBAwqoVbOzu2RtzjfLsuU_qgLJuoBkSY0e7le6s4NoPLhjQ>
    <xmx:bIb4aas2saJ82QEA7kBUOGWVkc8PHr4fbXPkJ9y5edAHm_o55ehfbmyD>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5F56C700069; Mon,  4 May 2026 07:43:40 -0400 (EDT)
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
Date: Mon, 04 May 2026 13:43:20 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linuxppc-dev@lists.ozlabs.org,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>
Message-Id: <b895db29-e738-4d1e-87fe-d5a569902ebe@app.fastmail.com>
In-Reply-To: <20260504041448.15820-1-ebiggers@kernel.org>
References: <20260504041448.15820-1-ebiggers@kernel.org>
Subject: Re: [PATCH] lib/crypto: powerpc/md5: Drop powerpc optimized MD5 code
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Mon, 4 May 2026, at 06:14, Eric Biggers wrote:
> Earlier the decision was made to keep this code for a while, despite no
> other architectures having optimized MD5 code anymore, because of
> someone using it via AF_ALG via libkcapi-hasher
> (https://lore.kernel.org/r/f0d771d5-ed70-444c-957a-ad4c16f6c115@csgroup.eu/)
>
> However, with AF_ALG itself now being on its way out due to its
> continuous stream of security vulnerabilities
> (https://lore.kernel.org/r/20260430011544.31823-1-ebiggers@kernel.org/),
> it's time to be a bit more forceful with nudging people towards
> userspace crypto code.  It's always been the better solution anyway, and
> it's much more efficient if properly optimized code is used.
>
> Thus, drop the PowerPC optimized MD5 code.  Note that this code contains
> no privileged instructions and could be run in userspace just fine.
>
> MD5 is still supported, just with the generic code only.  I.e., this
> commit only changes performance; it isn't a hard break.
>
> This also has no effect on implementations of md5sum that already just
> use userspace code (as they should), for example the coreutils one.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

