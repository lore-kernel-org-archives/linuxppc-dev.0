Return-Path: <linuxppc-dev+bounces-16641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A1BECD9B0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 22:46:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6XQB6yypz2yFQ;
	Fri, 06 Feb 2026 09:46:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770331586;
	cv=none; b=YeM3s44Rj0seOQqtbzqPG4gFxwvqG+YV3BvRcK/xbNS5VEWyv7vFttKn8BLUjLOrVzfUf4BRyAwZprS5rMcaLdjns0m4BAZoaRXhdh23Scw4ylKBQBVw2CJzdcRamz/SC6iUEh66BnGH2lCYewxU4At8petGg9oh2Zz03jBcit+yx8DP8WrJJHzFXUsdp3ZClQMZhWVy3V31Ml7ltuTUzkGbs39mr8r8fir3VPuCXRDw5p7xLfaNAK3K+9teMssROI2pAWNFyxrRuhwUHSvzkcT4ce6ivDmfroPgUn5spGNq/2owxVn2MM0hzsTH1Lzut8b+j8WX4i8R4MQoasLvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770331586; c=relaxed/relaxed;
	bh=c8fYKE9+ySvvwxeHCgDhSW7zyQfsh6rfatxRSof4wjY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=hEkckuWZ1YGwsQOdmJI77sp6HJVvLCjQPBnDx5Lrp3rDK7zpdXlSLKzvKn+WfRXV57GX6EmLh01zo5tO9BY99GSw9Dspz9bbmcR4PTaX2I69PkaiW+UKWuXFRgGuRcgHM2ySWYpw71kwx6P1OKJk9VgUs0w3SFC5JoJsDuOMF9/j/68SGYctt7YFhSbsl7rPQTC1AUhAf/Nwo6PxhLcTYF23XLFM/lkuvL2qLTtuwSai1vMb7ABqQ0re5+TuhtrAv/3qY02Rh0HhU8gGTupz3nJwWcAFxaPevt89Xv3Q4IwyQWXgUITGpfKj+QC3vtzrzK5Ery3Vp7rwmGryYvT52g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kQKEJqY/; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kQKEJqY/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6XQB2tZLz2xqj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 09:46:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E952142B23;
	Thu,  5 Feb 2026 22:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F64C4CEF7;
	Thu,  5 Feb 2026 22:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770331583;
	bh=c8fYKE9+ySvvwxeHCgDhSW7zyQfsh6rfatxRSof4wjY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=kQKEJqY/sSJofCBVy05YcB0R4FCbORXgvKp/q/B19cu8EKvBJ0sqe9LDii6MoegmP
	 xZlPV5jlxVR2E05BAV4FqG4gneXmp4YbOaw/k9Ld22vViu1Yh1iZJyAP2EoZPzgdH7
	 UzB8O3sJNpDSbm5zWkFOeeGHcVdulpEWlYKJNy+UF3/HW+gcCEmUkQatjyhhR3jXQp
	 l61f7crCSqlnGfnzW6RvzQ89p7RlSkpamkPAlSnVEHVN/DDsCGZdkXWnfRHAAkVCzh
	 9sFB/1He6ChWkrcFYkkHV4ii0o/VqE3YS+mRIHoljL1SLNR+mXGEJuVOssOR7bcPhG
	 oiFVtyqY+YU9A==
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
Date: Thu, 05 Feb 2026 23:46:15 +0100
Message-Id: <DG7E62FRLFG8.2WLEEY8VX9PRO@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Link Mauve"
 <linkmauve@linkmauve.fr>, <rust-for-linux@vger.kernel.org>, "Madhavan
 Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
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
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: io: Add big-endian read and write
 functions
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-2-linkmauve@linkmauve.fr>
 <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
 <EC479D9E-ADBF-461C-BEA6-06EA2D4FD8A6@collabora.com>
 <DG74LUHX3NPX.3BLARQEIFG1DD@garyguo.net>
 <D6227AA2-A727-4F29-B7CD-BE0AAB0A13F1@collabora.com>
 <DG79GRI3NOLS.3ASMS9RJ80IXM@kernel.org>
 <DG7DUN9M4YIU.KNRN6FM1K687@garyguo.net>
In-Reply-To: <DG7DUN9M4YIU.KNRN6FM1K687@garyguo.net>

On Thu Feb 5, 2026 at 11:31 PM CET, Gary Guo wrote:
> I proposed the wrapper type because majority of devices won't need BE sup=
port,
> so adding complexity to Mmio itself is not ideal. It is also generic, so =
it can
> work with any IO backends, so for example, you can have `BigEndian<Pio>` =
and
> `BigEndian<Mmio>` and you don't need to duplicate your endianness support=
 for
> both backends.

That implies that we swap bytes manually? That would be a waste if the CPU =
and
device are big-endian.

