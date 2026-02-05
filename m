Return-Path: <linuxppc-dev+bounces-16638-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F461ECD9AF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 22:11:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6Wdl5Fxvz2yFQ;
	Fri, 06 Feb 2026 09:11:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770329483;
	cv=none; b=Xh0o0HA9lz5DgYguwnNxfSuJSRTJWt59V/6kTolpfwihkxps07d+Z+rx1STvzWd2hO0tbLtrjkt8lSx5Gz2ABXrSxJP2D9xXC1RV+AbgpDWFZjPiClAjsJQyFVi1xtpSiw72ZxYH+8SZZKQUUaaPcF/LejpYkw5k7VCsxcGH1LpPewsQwPkXiD+q4NC2uPw8jo9vlN68edUR/wqn4erzgwMmDgUqBuZGv0nsoWIkRY7ZAR7YkzXSM7vndTuPWM4bo+bUeZWTr5ZTIxWjXXfshxolibyBcXwcexfU/LBFbti6HNiCgq0qcWgeHGN9f7FPWetIfMqag9zIRyf5Wxfi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770329483; c=relaxed/relaxed;
	bh=KVVPOYsvirUgX60qz7M1BeinlJUHANpoxNMkRC7rbhM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=QTR59x0oky/7n2d2Vz4PbyW3Lm5HitcEcsOREcz4aFeqC5u/p6epeH6Oj6VmqW2On+a+aaeiimMMYwcItq4cgDWcyJBSK7hNpPRRdnvvnX41hSYjQDOFgY3J1uZfwXD221zrNvfTARZdUG745mvkhjPo7lUQffDiD11JrqXGOaBx0SPCR6LuJB2zElvpm46zujZ08GdEHApHCQj6r3nZ0NWW42JV5Vb7xYrizc9eQ1ck25biQK2LVUT8QLu313gRDGaWF/pZZzLiUAJBeGqS/taHHKPAi8L8oExawSUsFmvVqvkfxUhnCU24PeK3fW99wWtp4qC5ARfyZGz+XB5ehQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MCAmsHXW; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MCAmsHXW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6Wdk3rnXz2xqj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 09:11:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F209E60010;
	Thu,  5 Feb 2026 22:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2902C4CEF7;
	Thu,  5 Feb 2026 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770329477;
	bh=O5BY+2fDILkckJlYVL7ebFJsmdn+yduZ1kv/oO3M2gg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=MCAmsHXWoe5lR7RQu5P7UuEF5LB4RL62vE8gYbxpJPQjDzDoQvBtdR32cgmoJsfnJ
	 gLKSLOfOD05Nl6Mr8bzfzLluch5Hu5AT5mdWx20t+VNJcmS7y7tgUB3xXDnouLSJV0
	 OnmoHVqGCsihSWk7yoCrNbFclQJOKBKKqjpgj24IE2NS6ZyA4XIc9WwR4L6OJ+sMI4
	 ZXOurYAlggozL3rJV4lk5ab/uIp9J+6l669Rs1ZlKX+yCBpXWWFPeZJsqyny93UZZM
	 h+95OKv/zdiaJlVm7yarudSITILz/eFpeJ8Vg2sXOVSl/m6ueuipHrD/Tx8AFH34fc
	 Zs5X8QQHe6UEg==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 23:11:10 +0100
Message-Id: <DG7DF76OVGTS.WMT6W8XPG4LK@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: io: Add big-endian read and write
 functions
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Gary Guo"
 <gary@garyguo.net>, <rust-for-linux@vger.kernel.org>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Srinivas Kandagatla" <srini@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Ard
 Biesheuvel" <ardb@kernel.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, "Eric Biggers" <ebiggers@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Lyude Paul"
 <lyude@redhat.com>, "Asahi Lina" <lina+kernel@asahilina.net>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <officialTechflashYT@gmail.com>, "Ash Logan" <ash@heyquark.com>, "Roberto
 Van Eeden" <rw-r-r-0644@protonmail.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: "Link Mauve" <linkmauve@linkmauve.fr>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-2-linkmauve@linkmauve.fr>
 <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
 <EC479D9E-ADBF-461C-BEA6-06EA2D4FD8A6@collabora.com>
 <DG74LUHX3NPX.3BLARQEIFG1DD@garyguo.net>
 <D6227AA2-A727-4F29-B7CD-BE0AAB0A13F1@collabora.com>
 <DG79GRI3NOLS.3ASMS9RJ80IXM@kernel.org> <aYUJuF8bI7mwD4ON@luna>
In-Reply-To: <aYUJuF8bI7mwD4ON@luna>

(Cc: Rob, Saravana)

On Thu Feb 5, 2026 at 10:20 PM CET, Link Mauve wrote:
> On Thu, Feb 05, 2026 at 08:05:08PM +0100, Danilo Krummrich wrote:
>> On Thu Feb 5, 2026 at 6:28 PM CET, Daniel Almeida wrote:
>> >> On 5 Feb 2026, at 12:16, Gary Guo <gary@garyguo.net> wrote:
>> >> I think we should have everything default to little endian, and have =
wrapper
>> >> types that do big endian which require expicit construction, similar =
to
>> >> RelaxedMmio in Alex's series.
>> >
>> > Ah yes, the RelaxedMmio pattern is definitely a good one. I agree that=
 we
>> > should head in this direction.
>>=20
>> I strongly disagree.
>>=20
>> This is a great pattern for relaxed ordering because:
>>=20
>>   (1) We need both strict and relaxed ordering.
>>=20
>>   (2) Relaxed ordering is rare, hence it doesn't hurt to write e.g.
>>=20
>> 	io.relaxed().write()
>>=20
>>   (3) If you by accident just write
>>=20
>> 	io.write()
>>=20
>>       i.e. forget to call relaxed() it s not a bug, nothing bad happens.
>>=20
>> Whereas for endianness it is a bad pattern because:
>>=20
>>   (1) Devices are either little-endian or big-endian. Hence, having to w=
rite
>>=20
>> 	io.big_endian().write()
>>=20
>>       is excessive, we always want big-endian for a big-endian device.
>>=20
>>   (2) It is error prone, if you forget to call big_endian() first, it is=
 a bug.
>>=20
>>   (3) It is unergonomic in combination with relaxed ordering.
>>=20
>> 	io.big_endian().relaxed().write()
>>=20
>>       (Does the other way around work as well? :)
>>=20
>> It makes much more sense to define once when we request the I/O memory w=
hether
>> the device is litte-endian or big-endian.
>>=20
>> This could be done with different request functions, a const generic or =
a
>> function argument, but it should be done at request time.
>
> Could this ever be done in the device tree?  I understand this would
> mean having to change all drivers and all device trees that do big
> endian, but it seems to be the natural location for this information.  I
> have no idea how to structure that though.

I think that's a good idea, for newly supported devices we could probably d=
o
that. For existing ones that might not work. IIRC, there is an expectation =
that
driver should still work with older device trees.

