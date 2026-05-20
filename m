Return-Path: <linuxppc-dev+bounces-21224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E44CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 09:40:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL63T2Mmgz2xqv;
	Wed, 20 May 2026 19:40:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779270037;
	cv=none; b=g2Dt8tLBPEPLEYSU6V4y1cPRm2s6vL7MyfEauPbwfp0l2zwU48V3U2j43sHIJmU6W4hyZXjg1+g9nS1HCJihaO1b998vSc3zwISUXtxdiQweV3LlS/2W7o+2Hw8LF9vPLJUM1juW2cIiXGdlkxYswOjw6DdBS21nw4HNn1TXOUiXTESdPPv2Hft0NN9+pSKQHI7DdcMDjILozeoj0rF5WpVSzbvlbTNBm5/VOwD9BJyV7Ow+73zPHnS4JqsU0zjSB5kYNVKFvAdeTmXB/D2zuOuE+Q6mjXyZnPU4PW3ybD/GqsJXBtT0A/vJ1LzUdp3RUXi/Vt3VDjcolNoYlF2dcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779270037; c=relaxed/relaxed;
	bh=O/TEx4FDc/EtlNCU5OdX56vjPLrz6XpixMikUKfrvxM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GbXdabOOxhiZ4XGX1Yrh6QHID7sJIQEC8eDa+qJICd0dYfHYUIh9asaVCc7wvMactEr07xAEUt8KCWHGPNIrqdj02lyT3EOj3tb0YBoFdEEmNXsmqQyVCxFhSzbHEVSlpiWqUZLHDkt2hXKx3czNP9BKw/0jAcliVdcZCaRGtIi1FVE+kchtkeWE1tALeeJKGLJEE4oHIFOTYvkXdjPyCVKNlStmvo4tZIlGxH/slHFEHDVmclBf96TP9xkq1CWxzpiEeH8vFcXrjimDEa4pNJYaAbx/8aOf1O7fNytycITQDUnEq6igyfAi4l7vqtMupROia5I0OZ3aYVb/T/QytQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XU6bBNmz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XU6bBNmz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL63S2B41z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 19:40:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C9057444D8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 09:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840511F00896;
	Wed, 20 May 2026 09:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779270033;
	bh=O/TEx4FDc/EtlNCU5OdX56vjPLrz6XpixMikUKfrvxM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=XU6bBNmzeY4C8OKQ+1UzT55ZvZtTG8CeX/UdS1IiVTEpWXJFWZ9Jm0+KUo/XbKBsW
	 ZYDKgbyzVhsKpzTTC1ANzEOw/xh2VwE+3fUbVndf81VctqIoJitPfP2vkjtPKcXKO3
	 UMVeQCCvtD9YBmZ0CEpfjyEsIu9hO/Cy/DXqOWUfW423blNYM/vmhgV58lISRywS6Z
	 cVrj6Oe9hDhcqJRiDBhclX8pcQODMMjzQNCrN+aw1ihNH4uKDqVdRXdyk9aOzwXf9z
	 mYw08B2AXR8Esfx+2wLiXZVqm+bCn/9tRRBGDnP7EVcjFYk+pWKmt7me6nqwPt0PSu
	 8t2OyKPg/aFQw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A6D41F4007C;
	Wed, 20 May 2026 05:40:32 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Wed, 20 May 2026 05:40:32 -0400
X-ME-Sender: <xms:kIENaj_Bn04y7dqZoWQnVe7lFtWibdmMGG1g_7W06WzDvhP4Z8J_JQ>
    <xme:kIENaqi1RqU9n5AK4VLlNP9JGtJvo1yeBW0EEtyNBXB9dtpsoDMLkF8IApAvUdx_F
    FLmEfEOp9eaT12ifN1Pk-K3yE74MSEFUnFg6gyVbvKkjrtduxJen44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeegvdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:kIENajWLu1B6-zHpQPiXzIBXihHkudTA4T6hXZEOl6CcAD-H5jPHVg>
    <xmx:kIENasRRd7g0s0HqrjAu77BEs5K7N3NGYMFE3rwSl2eP3cIwh6HjyQ>
    <xmx:kIENatm8qF5zpQ-p4utxe4E6YHEaNRRn1Z5BHDrY6tnXK4v11FO_1g>
    <xmx:kIENai6-3H8R32tM2Xqg2KbjeHbMqnRfThDde486fJut_yriPRlM1w>
    <xmx:kIENajipHG7I4Imqcpkdp-EMCUC2lVewxuvhQCXxdZrMEKtP7ndXEOXu>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84095182007A; Wed, 20 May 2026 05:40:32 -0400 (EDT)
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
Date: Wed, 20 May 2026 11:40:12 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>
Message-Id: <3e63e2eb-30b3-4377-9331-41445d9c8720@app.fastmail.com>
In-Reply-To: <d4690d12-77d5-4575-9a79-484a919d3203@kernel.org>
References: <20260520085423.485402-1-ardb@kernel.org>
 <d4690d12-77d5-4575-9a79-484a919d3203@kernel.org>
Subject: Re: [PATCH resend] powerpc/code-patching: Avoid r/w mapping of the zero page
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Wed, 20 May 2026, at 11:36, Christophe Leroy (CS GROUP) wrote:
> Le 20/05/2026 =C3=A0 10:54, Ard Biesheuvel a =C3=A9crit=C2=A0:
>> The only remaining use of map_patch_area() is mapping the zero page, =
and
>> immediately unmapping it again so that the intermediate page table
>> levels are all guaranteed to be populated.
>>=20
>> The use of the zero page here is completely arbitrary, and not harmful
>> per se, but currently, it creates a writable mapping, and does so in a
>> manner that requires that the empty_zero_page[] symbol is not
>> const-qualified.
>>=20
>> Given that this is about to change, and that map_patch_area() now nev=
er
>> maps anything other than the zero page, let's simplify the code and
>> - take the PA of empty_zero_page directly
>> - create a read-only temporary mapping.
>>=20
>> This allows empty_zero_page[] to be repainted as const u8[] in a
>> subsequent patch, without making substantial changes to this code
>> patching logic.
>>=20
>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Nicholas Piggin <npiggin@gmail.com>
>> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>> Build tested only (Clang)
>>=20
>> Resending from my non-Google email. Apologies if you are receiving th=
is
>> twice.
>>=20
>>   arch/powerpc/lib/code-patching.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code=
-patching.c
>> index f84e0337cc02..13a8acf851f1 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -60,7 +60,7 @@ struct patch_context {
>>  =20
>>   static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>>  =20
>> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
>> +static int map_patch_area(unsigned long text_poke_addr);
>>   static void unmap_patch_area(unsigned long addr);
>>  =20
>>   static bool mm_patch_enabled(void)
>> @@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
>>  =20
>>   	// Map/unmap the area to ensure all page tables are pre-allocated
>>   	addr =3D (unsigned long)area->addr;
>> -	err =3D map_patch_area(empty_zero_page, addr);
>> +	err =3D map_patch_area(addr);
>
> I would get rid of map_patch_area() completely and just do:
>
> 	err =3D map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERN=
EL_RO);
>

I think retaining the symmetry of map_patch_area() and unmap_patch_area()
makes sense too.

>
> By the way I don't know how vital it is to map in read-only but in cas=
e=20
> it is see commit da3a3b0a0e38 ("powerpc/32s: map kasan zero shadow wit=
h=20
> PAGE_READONLY instead of PAGE_KERNEL_RO")
>

In the end, it doesn't make any difference, given that the mapping is re=
moved
again immediately. It is just neater to use _RO to map a const object, r=
ather
than explicitly creating a read-write mapping of something that should r=
eally
never be written to.


