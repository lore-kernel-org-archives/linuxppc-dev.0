Return-Path: <linuxppc-dev+bounces-16712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9761EF06E1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Feb 2026 17:52:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8FlT6hClz2xdL;
	Mon, 09 Feb 2026 04:52:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770573141;
	cv=none; b=JvJ0nZTasJ+aKNVPQ4ZRgLT5z0HxUFkElS0OOvK8dPYSwnTYdd1tGqnJSkoEgz3ER8WA7BxrSaraMcnbfqrTpWLHE8QpGv+K0zWENGOMynx+epMiVizNlOpBJ4gzZ+LU1uqetOIat+DGqX214fPgJ6gTZT7LUGNSUoY7x9qiQnFzNgyhqMgHfDDQjwHMrG67kT0mm9M2H54WXgFg3QUvu486w3iAszlwhzqxptyXVyO4vEdVeirp7fYn52agbp5E2ZdHcsPViaJOtUjeNfhDaY0f/cgFAKwz9nE+jpKSNz+gnkfopJmUc+6jEXhNEibAtk+90Go3rJXdZA72pJla5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770573141; c=relaxed/relaxed;
	bh=nUlXiY/n6D/GzZ31dZtF8Qcp+8BwiySaADU6+/VSGaw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eMf0t2+qbCQZhOjIjj95Y9Rt2gIHKfc0qf7vOFbuSv20NBfaaehprZJoLUpoSIYMOWwRvDSVhRcChMVBoHbVakVUKHLzPVaK0Q5b8e+AiE+eY2IfA/DXESQ9dV1843RvYVDm01SDNeGnPN2lPG48A+iSgzhsygMhOvMkb4E2b0emGdNBIVyK/c/sY8z+K0bd6tUSzF3K1+xRadZYZKXSuoDp1tCkybYhu+5+9JFNWTBzrcpSNG9kApZ5tm2K9iLzffWQB9S4KlDEXqy5xb9vQdVMcYVOqM5oz151G1FDjw1Sq9fpypVomA7BCvX2MpksUNigu9TukDHTjHzJod9/Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jfjDkNha; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jfjDkNha;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8FlS3wGtz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 04:52:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 232CB600C4;
	Sun,  8 Feb 2026 17:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1E0C4CEF7;
	Sun,  8 Feb 2026 17:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770573137;
	bh=oPdtFUjejDRzH1cYdlZ/SspHMlQNl0lDWGnp9KVOKlw=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=jfjDkNhaA0tY7dpdD8w11PZBIMeF2pdLT2y3QGZU2OekOUTT2PTqkdlVWzze1Wnjo
	 naxi4n0sNMbHn+Xrg/u+VuTnieXWqfDYkki6HFOMnwWH7MuNpiMgZC587tlOL+X2ug
	 PxxOhJ3rSTU1lhBDZI0c1gwtOlf2jtNZzh40UU07UTGfsY8Q0UAYhFtTqiXbTDPlzb
	 J0ty7kHiykPdTyc9t+SasruEnheXdumDN6CzK3vFCkmP3959mj3jUq8JCCvLWruaTe
	 a2+b3H6LgZOwoGOVMdB5BTm4c7yUW1NCiTrcu86+ibm52WyUO+JTAlEuLPT8t/FhfF
	 yekH0bxMMEsFQ==
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
Date: Sun, 08 Feb 2026 18:52:09 +0100
Message-Id: <DG9RSIS5VPK1.M72N8UYI6SDC@kernel.org>
Subject: Re: [PATCH v2 1/4] rust: io: Add big-endian read and write
 functions
Cc: "Gary Guo" <gary@garyguo.net>, "Link Mauve" <linkmauve@linkmauve.fr>,
 <rust-for-linux@vger.kernel.org>, "Madhavan Srinivasan"
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
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-2-linkmauve@linkmauve.fr>
 <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
 <EC479D9E-ADBF-461C-BEA6-06EA2D4FD8A6@collabora.com>
 <DG74LUHX3NPX.3BLARQEIFG1DD@garyguo.net>
 <D6227AA2-A727-4F29-B7CD-BE0AAB0A13F1@collabora.com>
 <DG79GRI3NOLS.3ASMS9RJ80IXM@kernel.org>
 <DG7DUN9M4YIU.KNRN6FM1K687@garyguo.net>
 <DG7E46M9VINC.3KTNQ1T7USPVO@kernel.org>
 <45A7698F-6AE9-46DA-8CB2-9E09F7223229@collabora.com>
In-Reply-To: <45A7698F-6AE9-46DA-8CB2-9E09F7223229@collabora.com>

On Sun Feb 8, 2026 at 6:17 PM CET, Daniel Almeida wrote:
>
>
>> On 5 Feb 2026, at 19:43, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Thu Feb 5, 2026 at 11:31 PM CET, Gary Guo wrote:
>>> On Thu Feb 5, 2026 at 7:05 PM GMT, Danilo Krummrich wrote:
>>>>  (1) Devices are either little-endian or big-endian. Hence, having to =
write
>>>>=20
>>>> io.big_endian().write()
>>>>=20
>>>>      is excessive, we always want big-endian for a big-endian device.
>>>=20
>>> You don't need to always write this. You just need to do `big_endian()`=
 once
>>> when you obtain the io, and then keep using `BigEndian<Mmio>` instead o=
f just
>>> `Mmio`, and the rest of code is still `.write()`.
>>=20
>> <snip>
>>=20
>>>>  (2) It is error prone, if you forget to call big_endian() first, it i=
s a bug.
>>>=20
>>> Moot point when `big_endian()` is only done once.
>>=20
>> Well, you need to do it at least once per driver entry point. For DRM IO=
CTLs for
>> instance you also have to consider that it is always Devres<Mmio>.
>>=20
>
> Well, this is also the case for relaxed(). I basically made peace with th=
e fact that
>
> let mmio =3D mmio.relaxed();
> < use mmio >
>
> is going to be a reality per driver entrypoint, unless I misunderstood?

Well, there are two differences: Firstly, relaxed ordering should only be
possible in certain situations, but not always and not for every driver ent=
ry
point. Secondly, if you mistakenly forget it, you may suffer from a pretty
slight performance hit, but it is not going to be a bug.

