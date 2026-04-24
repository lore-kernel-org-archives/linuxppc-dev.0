Return-Path: <linuxppc-dev+bounces-20055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B431FE51ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:59:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g26NX4P5Nz2xZK;
	Fri, 24 Apr 2026 18:59:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777021196;
	cv=none; b=U1x5OcAn4qzYs5hvyUOPBVlhvG9mZC4OiPfasnnGF0CrHNG9fJoAR6wYsloFZyqBV+xKDkwLeoLs8qxpv3j3k1FPTMmahMLVdivJutk4c4+zEqGhgdotrIguuihzFLXr7e42DFF0Dp8FAD27ltG5ECoOM535X9nZsHtiyI3GMvP/ZN2DUmDnHrEyu/rGB+gy2NtthcXBXe9cVrEMYvO4bUhiusWXyOnGhMvwmvxVVdYPsH3MteBndPdDcdpa/bhAYnp6bEKl5zIN32dTzueeOHoDGOxjynK+f/4CyZbpJweiOUyb9lECAJKqLBK/8zhJVpW3T7LLln92KuBXcgN1oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777021196; c=relaxed/relaxed;
	bh=mlomHPrruE4T+ys87B/weKxrB+OMcheSKA7ybwHe8Os=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QRvqGVPD67holxw2DHZlIXqS0akItt5pylZymUHpmPg/zVhmaXfwUzyQabbTfOKPMk0N3DedbsGwB2z9KnA2fcKre46/4mep4RyrIJ7OSuHpzE7zPsFNiD38ayir8/yxCsFJKLNYfxiUUPFeIIQ6tfYp5VwYtzghJM+Z4Gmd30gzqTgnE3FgmHygLxQdijewdJiKJ5sNPSp3oofsddK3LPJPpurKI2kHuUC/jPR7BmKDZZbL7kIPLR6/8xRYyi7BNuyOgSSQjwmBjoE4eE/KsFFCRx28QVvAbMChc7pTsCfsv4xDmsrOSIKp77GSpYU6L8/czcfUFDGJ1GUgeXTeSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VAwtGBDd; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DQKHbfZw; dkim-atps=neutral; spf=pass (client-ip=202.12.124.154; helo=fhigh-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=VAwtGBDd;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DQKHbfZw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.154; helo=fhigh-b3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g26NT610Vz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:59:53 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92E997A025F;
	Fri, 24 Apr 2026 04:59:49 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777021189;
	 x=1777107589; bh=mlomHPrruE4T+ys87B/weKxrB+OMcheSKA7ybwHe8Os=; b=
	VAwtGBDdupJVNcGs4MDYlHN/jcjRLczK3kvxLgWoQdqSNpidCbOM34UZdtC47lPI
	3mzLU0zrlTFvKZ4ByH4LX9Kc74D/yZouVzPWdHMwcRR2I1feKTWewWA7tTWI+ZJn
	PrCivp8NoY5n6WX3mrTswbFq4VmW/SNE7TH8ixsNpRyhFWyWMFTL1KmtdlIq+YV4
	Kqd5RjvlVW8dM6YHO4uaay2H+g3/Hiwvkb+D9ydasIbOygdMJBl45LE1dQLMPNks
	e6uubMuXLbwSb53dOAF6N0Z68dFgeLj6Sr8wJEC5GhRXlY6SxMikVtgDQeLDHKcT
	a6xtaaVwbYWaDHF/GgPeYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777021189; x=
	1777107589; bh=mlomHPrruE4T+ys87B/weKxrB+OMcheSKA7ybwHe8Os=; b=D
	QKHbfZw7Q2sK5fyHnbXqxbgWESxL1nXYGxwluPhFn04CPG0ZBoNwIGyTlE2bmVOx
	AdU+JrNbqccmxNUNuf1Unuo3Y9MufNOoEOQUHzy/Dt0Fd1EUMAWkUy8g7wYkzTZk
	tHj6S0blQgtMsWFUzUXtS4X7Zb/ocS8a8QF/iF4O4Ff1YZL5wyy6+pWnRWUMD/qt
	6RslSA1fTW4t8AVYcxkj3Q1GOVC79Od4yVRo3O1HtUx0w7zq8/HWNi0pcd1fSOhr
	zPwSZ8Jr8MoCjwPosyG48F3HQ7x+w8nWRA6wOb4l1R5vVbrgunuKZd/1BLg5Y/O/
	PAZfYZ88A0es7wYw41N1w==
X-ME-Sender: <xms:AzHraaywWnncYS8tNhxu63w-pdBByhF1khzcFj2QqdnD_7zXkakFWg>
    <xme:AzHraRGVdgiwkNe1nvTP1k6zaX_wJ8ZkyqgdKXya6mgkEbVD7yti8eiOP4J83Qde8
    hva1xiaUorg-yfUdfieO-6I8coGh6k11H7kKx3As8c6Wb13HojPbxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehmphgvsegv
    lhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehsihhmohhnrgdrvhgvthhtvghrse
    hffhiflhhlrdgthhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgt
    phhtthhopehmkhgthhgruhhrrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhitg
    hkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtthho
    pehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesgh
    hoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:AzHraU8PAM-pOR819TPN7Sy12OwyJa_bV3rrivQ1T8WeNaru67PLBQ>
    <xmx:AzHraYGd2u2SgOhQCAvkyX46Rn0Y5ChJvYTIHhv9DEn4DxxVWJHpyg>
    <xmx:AzHraTb8M-1Ggg45Cjrw2tGk-khaiCVKwHOQcW9e1jDzIcTeHgAb5w>
    <xmx:AzHracMu7nyMcdKc_oWpxYP_L21uEHKH1knniB8yVyBMOxpxXlfuYg>
    <xmx:BTHrafRJhrCm9AgwqxWvjH44g0NYZQpqxnlIVz9LfEM3RmBfYtPHuybK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE908700065; Fri, 24 Apr 2026 04:59:47 -0400 (EDT)
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
X-ThreadId: ADiin7Vigcc3
Date: Fri, 24 Apr 2026 10:59:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Josh Poimboeuf" <jpoimboe@kernel.org>,
 "Jason Baron" <jbaron@akamai.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, boqun@kernel.org,
 "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, tamird@kernel.org,
 "Nicolas Schier" <nsc@kernel.org>, simona.vetter@ffwll.ch,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
Cc: "Link Mauve" <linkmauve@linkmauve.fr>
Message-Id: <b5e7c099-3a5a-44dc-bc7b-42429abe3aec@app.fastmail.com>
In-Reply-To: <20260424054742.45832-6-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026, at 07:47, Mukesh Kumar Chaurasiya (IBM) wrote:
>
> This doesn=E2=80=99t yet fix drm_panic_qr.rs, which also uses __udivdi=
3 when
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy, but at least makes the rest of the ke=
rnel
> build on PPC32.

It looks like the problem is commit 9af8f2b469c0 ("drm/panic: Add a
u64 divide by 10 for arm32") describing this as an arm32 specific
issue rather than something common for any 32-bit architecture.

You can probably add a rust version of div_u64() and use that
there.

     Arnd

