Return-Path: <linuxppc-dev+bounces-21781-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F79CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:39:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTS7f67cdz2ydQ;
	Mon, 01 Jun 2026 18:39:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780303182;
	cv=none; b=kM6D1/lyqhH+pslk/9ZkAwaw7x/aTQspC9mPTuaQSF7reNCnVYK7hwY3q3AIi2V4/uzpz83t/AS02GbMJVR7lm0sGK278uOG0J3Nai/VGqH77yI/n6UU2GzN3zIQjPLkXQF2ODvaHbk9MzlcaQ3If9FEUYNiyuvaySVWnvNSrHIQn+1sJKQ+znCSwj9+hiq2siWwV5JjEa4W88/w7HIQ/ZoJzRi0fJ2YfMqmvQzYIc4M9wCpTp5+i0gskLqGbxnTVV9Zc5xDu/JhOVcm30vj1HDDf4a/CMMnwPOxSuOO3sgIC3tJ8tvdIFKOgkErS0NlYMnjk/Jjm2c+GSlI62iE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780303182; c=relaxed/relaxed;
	bh=mHwvm0ceQ16bc0KPGoKmLlizlFpB9HdRz+GeUdDPkMs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=DAxwLBcXEeQP/yvZwATEOJqnnN/ZFFY8AJjDhg9fxsBWLhOXoOv845s34rPFEPGozS9Om3ZiF9UGFHKGfLYTFrNb9szYdYo3pkQ2MVyEIACsC9XXr01CWR4WOE2XWWT3453+JGtccxqleQSRwgqu80+S4RlHXdYHywSQntvnVrBEgff0Tu3ExZAsUSdXBYO3Z2bA5MtB/bwCmwhENjjlI04SYO0CpYC8I3F1S+tQGHg+rbOGbfVK1U40bix1yqL6uOZfzHTrSCzqT4Ndo3QM/K0XiKscJCdSigHYA8SdMquQAzEbBbC3M8K7uJsyPk/Z48wuLzX03jB//1xtc8FfZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn/whAcH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vn/whAcH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTS7d56Hvz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 18:39:41 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A9834437F9;
	Mon,  1 Jun 2026 08:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304301F00893;
	Mon,  1 Jun 2026 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780303178;
	bh=mHwvm0ceQ16bc0KPGoKmLlizlFpB9HdRz+GeUdDPkMs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Vn/whAcH/RRQl70RjqcsG9XckYjCIPB9OvrjQJVHgPsg/O0PfRP1wT3JRGI+i6W3G
	 fvtlNQIjUPuONnPFg2aaU8LUDjNdpoRg8jlMfTe4YTxOALQIIbeccjl/6olrIoSbWl
	 5F+5WYUqgcr3ascqjdnn1PHq9hJ1nGada2M3QH0e7s6rzpF4tUd6lZRu5KCt19Cohx
	 6b9pbi33aCn7YOnjNnXB5IfrePP4DWOSJxeGDpHmMYB5aDNKvnN9RpU7uTIhOg/kK9
	 mzz8RrrW1ChoRA/nTbXoghFVSbDy22vQFpzwWY5Co/g7TOeVo7q+OdRP2+8hUGu0rg
	 B9DN5AYhYS8Lg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 50A6FF4007F;
	Mon,  1 Jun 2026 04:39:37 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Mon, 01 Jun 2026 04:39:37 -0400
X-ME-Sender: <xms:SUUdatExvFUiJvS4G-rzO5_b5_EVmBhCXGARrlUlPj68OMh2yNTgcw>
    <xme:SUUdatLPHZy6k7_jINeuCht2x1mIk3Xr7QLvpOruxv1mcZD7GTPOuGWVZwlv6UYag
    OjFQQepcx8WzwRHCk-aGrvn_hm4_qXnHUJ8uPUX6RNK62HXeHqgHAQ>
X-ME-Proxy-Cause: dmFkZTFDC9Qzla6YzRXCvg4qTqKRR/eKrKImym43jg5ea5Q5vrrQ+EjGg3N8fUKPpOxQR7
    TVq7XrIvj0z7DAz3z9X/juKhZVusgVnRCAtCCeFytlNFAPMtvvDQ4+dCYC6Q160toXzz4S
    XcVkttubPD2UxW685/k+uwu828S96nFll5al0jdDPfemCpkea8rdrbikQF2sFrnI6Lx04Q
    ONcYXSZ7HopdtHuW9piPefNoaIy7sVQliTdskqwc8awOiZFnU9Huwjva5c/7y1USlJ5DUY
    k6FOaBFlQ2WNslwPaZEZYp/rw/tHbsVDON310YOAcdFHjy7Nk82hy9tZEWwE6x8YVDQlsz
    Er9z8/znGDaObvUGVeBIVOThm1t//PeZFcWtIXC0I8cmehM+jGn2DjoVIYSv9Bmez6tW/2
    lKEfzUiJm3ZQGRDPcgLG+ZMhTLydaOy+jpqN+Hnf2ZdB/T1FYFwgfkHnjgZvpC5CuiX6I2
    pIW+EqzFuec7aoIebcI5qyLXKhUbZEinA2uMEBOaMiyZVdD8y+gienLjiqOTf5L1gLH7gf
    t0NN2Fa2xUvmh4ar3+IiUQfv23rHvlzmcKEdNU4pTV3DTTP+Q8FlIOlCllFOZLg9GdTvDV
    f3mzdtyp9oqq0X+BVt1UaL10E9dRrpHGrvPsGXG9iqiktxH1IMmSepCxh98A
X-ME-Proxy: <xmx:SUUdaksQVW8_jeB3xtl55BBVE34hsX-8-aoaNg-2HQRD8qka9ZCW2g>
    <xmx:SUUdaojoWqOJ6zjg3Jg09dGqN7viRHsj2OkvQbp3YK0wAlvQJAV0nQ>
    <xmx:SUUdandTyZF7vDk-2CIxFnV8hVemnNQPBzQP3G9OX0GQCEEev5E94w>
    <xmx:SUUdatkneOE7eIzV7ZeRu8vDWuDJM4tccORPy20Qvw2xd6aPNz7ZQA>
    <xmx:SUUdahr7u1yNhqmOzp1lyByGwuiaShMyl1FtwhEyBnqzzuX7kRi1Uf9R>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1EE0A182007A; Mon,  1 Jun 2026 04:39:37 -0400 (EDT)
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
Date: Mon, 01 Jun 2026 10:39:16 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <a371089f-0d01-45d6-84bc-1fe0d78ebd85@app.fastmail.com>
In-Reply-To: <69488547-cf2a-4aa0-bca7-0cb65aa01914@arm.com>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
 <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
 <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
 <69488547-cf2a-4aa0-bca7-0cb65aa01914@arm.com>
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of kernel
 image
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, 1 Jun 2026, at 10:37, Kevin Brodsky wrote:
> On 29/05/2026 16:47, Ard Biesheuvel wrote:
>>>>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from =
the linear map */
>>>>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>>>>> Do we actually need the NOLOAD type here?
>>>> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS t=
o be
>>>> emitted into Image.
>>> That's rather strange, aren't the .pgdir.bss input sections already
>>> NOBITS since __pgtbl_bss is only used on default-initialised globals?
>> Not sure why, but the section was PROGBITS not NOBITS before I added =
the (NOLOAD)
>
> I've had a closer look into this. Similar sections in other
> architectures are all named .bss..<something>. If I rename this section
> to .bss..pgdir, then indeed the compiler does emit an object file with
> that section marked NOBITS:
>
> $ readelf -e out/arch/arm64/mm/fixmap.o | grep bss
> =C2=A0 [ 4] .bss=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NOBIT=
S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000000000000000 0002ac 000000
> 00=C2=A0 WA=C2=A0 0=C2=A0 =C2=A00=C2=A0 1
> =C2=A0 [18] .bss..pgdir=C2=A0 =C2=A0 =C2=A0 =C2=A0NOBITS=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0000000000000000 000750 005000
> 00=C2=A0 WA=C2=A0 0=C2=A0 =C2=A00 4096
>
> And then the linker does the right thing without having to use NOLOAD.
>
> I was concerned that .bss..pgdir might get caught by BSS_SECTION(), but
> it seems that the double dots are meant to prevent exactly that.
>

Thanks for this. As Sashiko appears to be making me do a v8 anyway, I'll
rename the section to .bss..pgdir too.


