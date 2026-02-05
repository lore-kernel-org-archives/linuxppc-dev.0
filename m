Return-Path: <linuxppc-dev+bounces-16620-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E51E83F1F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 14:57:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6L0c14TYz2yFb;
	Fri, 06 Feb 2026 01:57:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770303424;
	cv=none; b=ay08B+sYvmPi6ixV2gs4IXTzTBSW4Z4/5Nt/mmpVCzp9PJGcroSjZghp0lKJSU7sCZ2YD3nPttAhRraefHHmVA8279EmgM9a17ouT9auiFmTUx0R5VW5MS6QqHMGTF88P2T6a3kjQD5Fop4pGcxV2/5Y6pC9zRwuSK/BFIdpzQib2xS29tKi4cka22h3rucf51OPiFssm6R5Fpa/B/WPir9lUkwbcSM8xhgtCWoKm3QAvKPiFx0aqiOAs/dRSGXzyNniKPeCwwcXd9Ly+TXH7mBqKPMHoYannBiaZ/7R88JxcXoANrLeGknbl/ldG5UK5RTQSWL8rFd20ervJmZAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770303424; c=relaxed/relaxed;
	bh=gMmsQzoS6PLGmI/k3RPElkgBbzOIjikIFD020ivXMLE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=O8LzYBmbSUsAKRdenVXh/agnYTbxgngXAK1cOI+z8xtZi+EdikARmQXAfbWlZyg1UvXrlMJokyiV1pgZvl/roCfpDndzK5V9fMjh2tHfnQMIouENT8nJRLvMZR7RjEywC+x2etzk7sAXPqNCp57Fel4r4G35DH8u2q8E1MK3MQbuUtwHaauVVa7IpjE1wCx8UWa5qIJHWnJOjxQ8SoLePRXj2nM79cLGf6ni6clFlm/9J2GcmD7ZXw6fihtkT9rnpQ86OhWTD7Dn4rJj/mx/GcPZ23wn21cKZzQjMyX+2gkv4QuCPdaVTuSSGRoZX8JHDDEfpGTecFa+TpKvgWTsTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E/58bSTR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=E/58bSTR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6L0b0kZ9z2xrk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 01:57:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 31A6F6001A;
	Thu,  5 Feb 2026 14:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A20C4CEF7;
	Thu,  5 Feb 2026 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770303419;
	bh=gMmsQzoS6PLGmI/k3RPElkgBbzOIjikIFD020ivXMLE=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=E/58bSTRIAF2nMzj3w1phnYwa5sjfbTDc484MGSp0cUDxYfH8kjLuLyzUw0ZnUE+j
	 D8A5WFmrQ4i1E7rGsOpwApJc24jcWQmblYfYRMR7odI8SR0fHDKIR73gq30BDZxuAI
	 5JFk5ex2pdJWaTFjurJUZVE6X09Sa+OV+bbIXxMvidYn5gAami7E9USVEt6gG8ctm+
	 YKnvpo/r7z5pP1GHhdHOJ0NkPvUsTsMHZbzHrK0VUYGf6BB/rvIQqZMrY6w/64+5On
	 UJ5UlV+gIX1dlsDipGrKlfzXu0iOjR2DdnMAURdGYp8vnpRHGTJ7MGd/9B7GPoKIrS
	 NYFkT20GbQvKQ==
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
Date: Thu, 05 Feb 2026 15:56:51 +0100
Message-Id: <DG746O6SKUQ0.H2A7OAVXTFZB@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: io: Add big-endian read and write
 functions
Cc: "Link Mauve" <linkmauve@linkmauve.fr>, <rust-for-linux@vger.kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman"
 <mpe@ellerman.id.au>, "Nicholas Piggin" <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, "Srinivas Kandagatla"
 <srini@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
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
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-2-linkmauve@linkmauve.fr>
 <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
 <EC479D9E-ADBF-461C-BEA6-06EA2D4FD8A6@collabora.com>
In-Reply-To: <EC479D9E-ADBF-461C-BEA6-06EA2D4FD8A6@collabora.com>

On Thu Feb 5, 2026 at 3:28 PM CET, Daniel Almeida wrote:
>
>
>> On 4 Feb 2026, at 12:18, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Wed Feb 4, 2026 at 5:04 AM CET, Link Mauve wrote:
>>> Another option would be to call u32::swap_bytes() on the data being
>>> read/written, but these helpers make the Rust code as ergonomic as the =
C
>>> code.
>>>=20
>>> Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
>>=20
>> The I/O stuff recently changed quite significantly, please have a look a=
t the
>> driver-core-next branch [1] in the driver-core tree.
>>=20
>> Also, instead of providing additional *be() methods, we should just crea=
te a new
>> type io::Endianness and use it to indicate the device endianness when re=
questing
>> the I/O resource.
>>=20
>> For instance, for your driver we could have
>>=20
>> request.iomap_exclusive_sized::<8>(Endianness::Big)?
>
> Can we please structure this in a way that LittleEndian is the default?
> Perhaps using a const generic that is defaulted, or something along these=
 lines.

Yes, little-endian should absolutely be the default. Please don't take the =
above
as specific suggestion. :)

>>=20
>> and then let the I/O backend choose the correct accessors based on this.
>>=20
>> I.e. the device is either big or little endian, hence we don't need to p=
rovide
>> both accessors at the same time.
>>=20
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-c=
ore.git/log/?h=3Ddriver-core-next
>>=20


