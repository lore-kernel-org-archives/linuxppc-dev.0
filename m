Return-Path: <linuxppc-dev+bounces-21228-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9F0CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 10:16:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL6rv36NJz2xrC;
	Wed, 20 May 2026 20:16:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779272191;
	cv=none; b=PZsAQs1TMcUSsgxiKbmYaGsXMykvg7RTdhOgtGdBmHrgJbZ6bKSdCqYL2ZS3QoT/m3/RhHMKCyQEWU2kWCc2qIAxSPnSYBkaUuZ2di4x7Cb/yOtUI6VRLhGHZxjHDr9K4nUYemQLYU8+FrGA+WFvLbpkW0U8oM4L+leru+4liLiyUzRQGqm42LlNn67+nXW3b1OcMuwLY9Zwd6oTWMG2LMfuczwzgYKIHdAa44rdVXKpPkx3V1PIzkJpXTM6K1LpmTOY29kVh5a78m7pJ2h4JXqe/GpcdhUvCGsjy0W5hliOJNw2oao8d6y96QkNLb580zDN9yIvZ8LtHVQIgVcb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779272191; c=relaxed/relaxed;
	bh=ftcrwlUHw5Gy4d+Sc3QnB5ChQd2ypzfHxdZQS9rMyXU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UIw8/f+c8CYNWG1MYiEFMK0ojQGxMOPgtwkeeXx3301QyGgfpfzB1lZZ0J54AsZk+K0KflG+EyIRvUv32roixZwlb1Bj2HDkmKKAsLXT+6KC/sa01f2dyk7XTEHCnL8DjHLoyQPcvGpPiZNaBxVcHTyH9LRWdyTrksWOB+SnnrTJW6p+RNYKRt/4G8vTXShR9Bm6fTGGfmNrJdxubCnW1Kik9cijDb3a53IWhFhrx6A1tnfWi1AHOLNiiCUFyU3oe3pScI9TELQa747OmcTLs//31Ekv9Wl0K2PjA8bZaPvJd/IJbEC+3Zmi+Q1qBryxEEE0//XcZjE47hlusxZFvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aw1MjZl4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Aw1MjZl4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL6rt1hC5z2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 20:16:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F1C3940759;
	Wed, 20 May 2026 10:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6311F000E9;
	Wed, 20 May 2026 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779272187;
	bh=ftcrwlUHw5Gy4d+Sc3QnB5ChQd2ypzfHxdZQS9rMyXU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Aw1MjZl4HEDtYedfmFvnmfH/ZT6XJUYxKoKukBGpAUOR4aImkROnBqguwmxj3vimZ
	 MKIl16Cws4sbz/twYQ1KfnjurBBqSg1z533qztfi+WwEdnX/kE/dj/X1c9POfzzS0X
	 paUhgw1uN/XGMCQ1IfLI7T5bd26tb6zGaT/05oG6UQtVPkYek2VwEi1qmSECPNqmNS
	 pAEnWm3iPdSPQmCUrinqCvFE8jV6mrZAzVDE3V5m//y9OfK0DViUdEJ7CHvkGjHJ3H
	 TNhjYK7xjtK0zuI7Fld7cCDINfybNxf+c8Hf5TVYLT/G8HKBPSe1LX8wGhUjOrpnBb
	 UsD8GtiFAnnJQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2F01F4006D;
	Wed, 20 May 2026 06:16:26 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 06:16:26 -0400
X-ME-Sender: <xms:-okNagQgbzqsFGD1S_WxLDJaReP0cSaUnRpIpmuwWFOE9jDIcPaxFg>
    <xme:-okNaokNU4-XI_bECoR772hXlJBgYcFzRNKflqEWv5ta0ELWUGNjoCKk0wvdUJL9O
    z0mDr-0Yt7Q8ZfshLPoggOtmxV4aZsf1xcTFMaMXLVvjwJ0b8B_omA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmphgvsegvlhhlvghrmhgrnhdrihgurdgruhdprhgtphhtthhopehnphhighhgih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhlhgvrhhohieskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepmhgrugguhieslhhinhhugidrihgsmhdrtghomhdprhgtphhtth
    hopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgrsghsrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-okNavI01JXD8fVYnYbvltF3_hrVrcgu0PXIvY1uJ91_Srljb4YfaA>
    <xmx:-okNaj1ls6yzi-hpcMzXsQStw3RldZ0VJTahX8UGg7CMBohxX7kNLQ>
    <xmx:-okNal69Rzfbj_ZyAdDBXU476R7vwJYjonNyNCGxGS_nqgt6gCC3Ag>
    <xmx:-okNas90o2Zq-bzA7TQDu7Vy2iCv2sD99HNXBapFxbDyZgwG7Gnq_Q>
    <xmx:-okNasUROTOlpW55eacbdkjbIKwgPZNAXba27SlsmyIpO2brZ8HQN8h1>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D398B182007A; Wed, 20 May 2026 06:16:26 -0400 (EDT)
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
Date: Wed, 20 May 2026 12:16:06 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>
Message-Id: <bc13fc3e-96eb-4aa9-a8d8-f7cf0c4cd505@app.fastmail.com>
In-Reply-To: <757318e3-91df-4e39-ba44-5130626d38b8@kernel.org>
References: <20260520085423.485402-1-ardb@kernel.org>
 <d4690d12-77d5-4575-9a79-484a919d3203@kernel.org>
 <3e63e2eb-30b3-4377-9331-41445d9c8720@app.fastmail.com>
 <757318e3-91df-4e39-ba44-5130626d38b8@kernel.org>
Subject: Re: [PATCH resend] powerpc/code-patching: Avoid r/w mapping of the zero page
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed, 20 May 2026, at 11:59, Christophe Leroy (CS GROUP) wrote:
> Le 20/05/2026 =C3=A0 11:40, Ard Biesheuvel a =C3=A9crit=C2=A0:
>>=20
>> On Wed, 20 May 2026, at 11:36, Christophe Leroy (CS GROUP) wrote:
>>> Le 20/05/2026 =C3=A0 10:54, Ard Biesheuvel a =C3=A9crit=C2=A0:
>>>> The only remaining use of map_patch_area() is mapping the zero page=
, and
>>>> immediately unmapping it again so that the intermediate page table
>>>> levels are all guaranteed to be populated.
>>>>
>>>> The use of the zero page here is completely arbitrary, and not harm=
ful
>>>> per se, but currently, it creates a writable mapping, and does so i=
n a
>>>> manner that requires that the empty_zero_page[] symbol is not
>>>> const-qualified.
>>>>
>>>> Given that this is about to change, and that map_patch_area() now n=
ever
>>>> maps anything other than the zero page, let's simplify the code and
>>>> - take the PA of empty_zero_page directly
>>>> - create a read-only temporary mapping.
>>>>
>>>> This allows empty_zero_page[] to be repainted as const u8[] in a
>>>> subsequent patch, without making substantial changes to this code
>>>> patching logic.
>>>>
>>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>>> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>> Build tested only (Clang)
>>>>
>>>> Resending from my non-Google email. Apologies if you are receiving =
this
>>>> twice.
>>>>
>>>>    arch/powerpc/lib/code-patching.c | 11 +++++------
>>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/co=
de-patching.c
>>>> index f84e0337cc02..13a8acf851f1 100644
>>>> --- a/arch/powerpc/lib/code-patching.c
>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>> @@ -60,7 +60,7 @@ struct patch_context {
>>>>   =20
>>>>    static DEFINE_PER_CPU(struct patch_context, cpu_patching_context=
);
>>>>   =20
>>>> -static int map_patch_area(void *addr, unsigned long text_poke_addr=
);
>>>> +static int map_patch_area(unsigned long text_poke_addr);
>>>>    static void unmap_patch_area(unsigned long addr);
>>>>   =20
>>>>    static bool mm_patch_enabled(void)
>>>> @@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
>>>>   =20
>>>>    	// Map/unmap the area to ensure all page tables are pre-allocat=
ed
>>>>    	addr =3D (unsigned long)area->addr;
>>>> -	err =3D map_patch_area(empty_zero_page, addr);
>>>> +	err =3D map_patch_area(addr);
>>>
>>> I would get rid of map_patch_area() completely and just do:
>>>
>>> 	err =3D map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KE=
RNEL_RO);
>>>
>>=20
>> I think retaining the symmetry of map_patch_area() and unmap_patch_ar=
ea()
>> makes sense too.
>
> Could also drop unmap_patch_area() and use unmap_kernel_page() instead.
>

Good point. That way, we'll end up with

 arch/powerpc/lib/code-patching.c | 52 ++-------------------------------=
-------
 1 file changed, 2 insertions(+), 50 deletions(-

I'll spin a v2 with those changes once everyone on cc has had the opport=
unity
to chime in.


