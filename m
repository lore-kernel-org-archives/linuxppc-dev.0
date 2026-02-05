Return-Path: <linuxppc-dev+bounces-16616-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DFEEC1EB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 12:57:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6HLT42f7z2yF1;
	Thu, 05 Feb 2026 23:57:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770296241;
	cv=none; b=hCHHghQgW4Fb+9gqQiQjM7RmFzaDGrmIwfFy1DzyQwl+s3ZnDjaoQGMON+TBahNOPfQ5T2x1bbmklKByFuTCWCqZWpd4f9haYxXwLAjn1l5kwsgsTajfH8YUGD8IXFfml9Oh3Tt6DG7iNeZKobX/QIxbKTZkiBxWAA6t4su+bTMlJOvN76ZKpFO4EUamQ8LV431TjyteYh/3mDDzFzO+qw/2Ul5nAEZtuGgMJNpS44XBo5jW2QlpnDklEIfs3iP4tXYDKiY5PjBd0MQfsh0qG3JzjVtLaOKpjrwdAEEiNPhy8N1fZnm81+XCMt+LsloTGpgNDarWKMTTMdP/iSuvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770296241; c=relaxed/relaxed;
	bh=10wS+Jvq6fpFDtwzHSKVVC5/ixz1TdzAAtkydgpoN9o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VX/2rTujzcrhz4z/H0iZUJbE7bg9WN9d/1H2fDnugnNtLRrBVlXheKhP2u4wM4dlSq3BTLp6/zfUPgrcbyAJCf7HfSfCaR9rENEy40E1LVLqoqq3Ow1iAAeRXHj+51rJBUhjfkoU7L34HjyhpL4ogBnMZDR5O7CL7anhnis4qgm2KdinH78A3J6/5ViBOStglbmRQZV+v+T6LHamYpwfDk9zHIdyr5+A0ot3AOJOcUGYdHueMGNNgejYSpYBINDmiig3QBrGPwN79zsQ0zPLQY0oQ0l1e3/KmQKKRi3nwV2MEvOnZeqjKhEkg1n/OdIvty7s9iyAolbdQj5B26DLKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Svi9uplu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Svi9uplu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6HLS198rz2xrk
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 23:57:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EFC4C60129;
	Thu,  5 Feb 2026 12:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF57AC4CEF7;
	Thu,  5 Feb 2026 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770296236;
	bh=ad3UUzoF7kT63rt6N1/6SqY6544pIqOC7JY63D75O9o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Svi9uplumRKLHtk5fnRc4y0CfEzZIHdhiiUt/l7xJhu/BRMrPrM4iAvKODIYfjS5E
	 Ysdsipi32ViLUfRwroeovD1/KD+EoldWncCbOaWqGYeSLgG8EcceVfVISo2oeJfXgq
	 luHqw7nOPBShJYwPwfF7YaZyEhxs0DNEYzk45epi+ISs3etAPcLRsyuHVs5A2bGHXF
	 Rno5v5PsflbtbQODO50q4FFm3WbGLO0V2zhV1GyaWJD2TXQhVs3DW8EGTHBh8Gf0fd
	 XRgr2fwDl/iQJEL4efVKi9GTO90804Wc121MpLDbLYKew42tEw+OzHCQEag8qH6fdR
	 GQdz8vXx6TTbg==
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
Date: Thu, 05 Feb 2026 13:57:09 +0100
Message-Id: <DG71N0HV7DQ8.35GWSCA3G4O8Y@kernel.org>
Subject: Re: [PATCH v2 2/4] rust: nvmem: Add an abstraction for nvmem
 providers
Cc: <rust-for-linux@vger.kernel.org>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, "Srinivas Kandagatla" <srini@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, "Eric Biggers"
 <ebiggers@google.com>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Lyude Paul" <lyude@redhat.com>, "Asahi Lina" <lina+kernel@asahilina.net>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <officialTechflashYT@gmail.com>, "Ash Logan" <ash@heyquark.com>, "Roberto
 Van Eeden" <rw-r-r-0644@protonmail.com>,
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: "Link Mauve" <linkmauve@linkmauve.fr>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-3-linkmauve@linkmauve.fr>
 <DG6A3L2W1YC0.YOB6BUMGG38F@kernel.org> <aYSRoIvhx5FAygDe@luna>
In-Reply-To: <aYSRoIvhx5FAygDe@luna>

On Thu Feb 5, 2026 at 1:48 PM CET, Link Mauve wrote:
> On Wed, Feb 04, 2026 at 04:22:16PM +0100, Danilo Krummrich wrote:
>> On Wed Feb 4, 2026 at 5:04 AM CET, Link Mauve wrote:
>> > +impl Device {
>> > +    /// Register a managed nvmem provider on the given device.
>> > +    pub fn nvmem_register<T>(&self, mut config: NvmemConfig<T>, priv_=
: &T::Priv)
>> > +    where
>> > +        T: NvmemProvider + Default,
>> > +    {
>> > +        // FIXME: The last cast to mut indicates some unsoundness her=
e.
>> > +        config.inner.priv_ =3D core::ptr::from_ref(priv_).cast::<c_vo=
id>().cast_mut();
>> > +        config.inner.dev =3D self.as_raw();
>> > +        config.inner.reg_read =3D Some(NvmemConfig::<T>::reg_read);
>> > +        config.inner.reg_write =3D Some(NvmemConfig::<T>::reg_write);
>> > +        // SAFETY: Both self and config can=E2=80=99t be null here, a=
nd should have the correct type.
>> > +        unsafe { bindings::devm_nvmem_register(self.as_raw(), &config=
.inner) };
>> > +    }
>> > +}
>>=20
>> This should not be a method on the generic device type. Typically we use=
 a
>> Registration struct for this, i.e. this would become
>> nvmem::Registration::register().
>
> Should I also switch to the nvmem_register()/nvmem_unregister() API
> instead of the devm_nvmem_register() API, so that the unregister can
> happen in the Drop impl instead of being managed by the kernel?

No, ensuring unregistration when the bus device is unbound is the correct t=
hing
to do.

We typically support two patterns:

	impl Registration {
		fn new(dev: &Device<Bound>) -> Result<Devres<Registration>>;
		fn register(dev: &Device<Bound>) -> Result;
	}

Registration::new() still ensures unregistration when the bus device is unb=
ound,
but also allows you to unregister before that happens.

Registration::register() is eqivalent to devm_nvmem_register().

You don't have to implement both, you can just pick the one you need for yo=
ur
driver. I think in the case of nvmem you probably only every need register(=
).

