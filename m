Return-Path: <linuxppc-dev+bounces-20061-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CDCFE51FF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:21:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28BL3hPSz2yTQ;
	Fri, 24 Apr 2026 20:21:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026074;
	cv=none; b=b+3NwuRCRDeccqJltGCx/RBMxbatxWlsR33ALsmFPTc7QZCg5U0aRbuiKgKaC5jVFGwePnqSrnhqXyl5/+U2r5nVyO8lM2c1CzSOxBZKCqVT9X9a9LDfJKhR21ddj7Bibw56wHW+z36HARHlulFxEz1OSQ6PuQbwIgke5qA+cqnfeZQYy2tsI4x4z/tMV2IJYnEazG3zg7ezhzElZmLuGTZNDFtA5PQiV/mYGaxjcAWx4HgomwT6XO+KSfoarjftsdsBgAt7l6udbtL2aOLFu4ie9f1+aHNFLrKID0O1FILex8bxEazYZM0r+c3XLENme3l8YUMyv7OO+H7jpc6Cug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026074; c=relaxed/relaxed;
	bh=w2de/s2AwmjIkqgLfGJWj9+HNtcuQscOiCuhi0QGHvI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=QoxnaadkGU/NKK0iKm5elMbzqVJLP6gqTk3q1NtV3KtB5OwhPwcsTUQc9TrIpT9XW+NnF+siQ0zoFAXAdO4lUWihrHie0eGo8/tYnRiqX4KLEZ0Was7D5Np/afcR+ZUge56Ocf1yyYycnOQULWrTzboFTBQJmLemyIlWxaPDz4DRtv135ArmvhTkpMWGJpWbLiXWhO757xAFyP+qk20aQJYiImyHAT4981WCrUjZltl+FUkx1lV8nWNpnuQexj8/LP9+/g9NcnukQszim2ne7xbfrVIGzVXH2G/QFT1HrKqEVENnpcgrU+Vic1d9ofgHU+Y5iPun1Js7StJymeMqpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=B+mbviNm; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EvjUS9vn; dkim-atps=neutral; spf=pass (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=B+mbviNm;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EvjUS9vn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=202.12.124.158; helo=fhigh-b7-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28BG0PNFz2xnl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:21:09 +1000 (AEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6530A7A0202;
	Fri, 24 Apr 2026 06:21:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 24 Apr 2026 06:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777026065;
	 x=1777112465; bh=w2de/s2AwmjIkqgLfGJWj9+HNtcuQscOiCuhi0QGHvI=; b=
	B+mbviNmF9wq74f8/lvFylh2LL/ywyLUaboT2KdejP8+I+M57VP/d1HUt7AwypMq
	qaeOu1Xppm7uHREC6EuqmB4jQy0BchcaxNRJzQSqU8kMxsMxC8zj+FHAaMZd9HXN
	Le0vS+k4ZeVAPRSBwN+SZznIRJFMcYAjVB/HMnXZbvMBSLMvMXVvgnQ7K6jvCB2W
	1Ov4fAbacwhTJl1nFoXWx1UyViKeYs+/Y0XWxYaPjb8IpWHJBX0u6+irQDiNmSjN
	aVE8gd42KYQEw0HVVVFw3YOsBrotrRTZlrMeoW82y1XGRkVchLLJNDuRxAsFrlUI
	UfN/m7UDmtiXo2GiVmYdyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777026065; x=
	1777112465; bh=w2de/s2AwmjIkqgLfGJWj9+HNtcuQscOiCuhi0QGHvI=; b=E
	vjUS9vnPFGVt0akajaJyWtOEP3igkDnGryoMmKtC+4gJcYWCLkBaL5yF1rrOrgwy
	gXOtiWTIxCSKXYS/M3AFOJHDw4Bs421sbwuxJodC4BVzgIof9uAVXn7P+2tYOaOk
	CFxzWP8DCsGv9Kq58wtYzv39IcRC3z5eImSpwX9IWWZjNAiv19xarXqUMTWdP7c4
	Sjv4AHktsSJksuV9KiNSJrA/lJxTAyjND0zIz0Awgrtq1dmZ5CEyxUFkZuN9R+yu
	HVIfP7GP0FEF3XwDJoJcDXjWPPX9qLIqOzZPKAhTJy5OPIyuyAxQP890sPwvmJKY
	blSL+l+DF2KnTekchZDKg==
X-ME-Sender: <xms:D0Trae19MjTG_za4-q6tI3IYukIc3qi3IM-4gsy0ZI7NA0sIlvhZcQ>
    <xme:D0Trab5frQ6BPQUr6fQGYLUjtZxK2x-yKx1MZiA5iKL4ixvKLGbxrdzmcfoIMR8lQ
    U7W2GMHzzu6UP2SV595C6RuMeS1q1NZzSN5pa75raHKng3oJLedNcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeileejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhgsrghrohhnsegrkhgrmhgrihdrtghomhdprhgtphhtthhopegthh
    hrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopehmphgvsegv
    lhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehsihhmohhnrgdrvhgvthhtvghrse
    hffhiflhhlrdgthhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgt
    phhtthhopegurghvihgurdhlrghighhhthdrlhhinhhugiesghhmrghilhdrtghomhdprh
    gtphhtthhopehmkhgthhgruhhrrghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhhi
    tghkrdguvghsrghulhhnihgvrhhsodhlkhhmlhesghhmrghilhdrtghomhdprhgtphhtth
    hopehnphhighhgihhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EETrabWiu3Q4TKvBFiT-sC4gHXQTtatPtyMUsrhrNVGBzlFu-Yb58w>
    <xmx:EETraW4pyJGCDNQiU_FGAV1NORAvBgkhoz31Kuzm7HZA31Wp9TnvJQ>
    <xmx:EETraTNmbHOygZe1GbvWONAPt3n1uBYwe4Ukor476cerA33kURAYpw>
    <xmx:EETraZj_NAivBLsOtToh9Y2ogcA225k_V99MUmvMXWwNQU7wqhLDbQ>
    <xmx:EUTraRI7sgO1747jdWIkY_dPJ1VToHV6U6hOWdjaLuAyw7okPuTQVZnk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE31E700069; Fri, 24 Apr 2026 06:21:03 -0400 (EDT)
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
Date: Fri, 24 Apr 2026 12:20:31 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Link Mauve" <linkmauve@linkmauve.fr>,
 "David Laight" <david.laight.linux@gmail.com>
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
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
Message-Id: <0a81f510-7b49-4879-b0bb-3b24dbfc0788@app.fastmail.com>
In-Reply-To: <aes7L3M1d_LvvGKa@luna>
References: <20260424054742.45832-1-mkchauras@gmail.com>
 <20260424054742.45832-6-mkchauras@gmail.com>
 <20260424101425.6bde0e17@pumpkin> <aes7L3M1d_LvvGKa@luna>
Subject: Re: [PATCH V13 5/7] rust: Make __udivdi3() and __umoddi3() panic
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026, at 11:43, Link Mauve wrote:
> On Fri, Apr 24, 2026 at 10:14:25AM +0100, David Laight wrote:
>> On Fri, 24 Apr 2026 11:17:40 +0530
>> "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
>>=20
>> > From: Link Mauve <linkmauve@linkmauve.fr>
>> >=20
>> > The core crate currently depends on these two functions for i64/u64/
>> > i128/u128/core::time::Duration formatting, but we shouldn=E2=80=99t=
 use that in
>> > the kernel so let=E2=80=99s panic if they are ever called.
>>=20
>> Ugg.
>> Surely you can make it a link-time failure?
>> Or change the underlying code to avoid the divide.
>
> This is currently a link-time failure, which means if any of the core
> crate or drm_panic_qr are linked in, the kernel will fail to link.
>
> And since we rely on core, that means no kernel can be built on PowerPC
> without this patch.
>
> A possible solution would be to change the core crate to not divide
> u64s, but the last time I tried to do that I couldn=E2=80=99t quite fi=
gure out
> how to do formatting without it, maybe I will just open an issue again=
st
> Rust.

How hard would it be to have a private copy of the parts of the core
crate that the kernel actually needs? Since Linux is neither quite
hosted (using a full libc) nor entirely freestanding (still using
some library interfaces), the C implementation on most architectures
has a small subset of the libgcc that we ship with the kernel.

I assume the core crate is larger than libgcc, but I don't know how
much of it is actually needed here.

       Arnd

