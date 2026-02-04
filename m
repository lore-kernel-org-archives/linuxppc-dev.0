Return-Path: <linuxppc-dev+bounces-16588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A877E9D3FF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 15:22:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5kcM738Hz2xm3;
	Thu, 05 Feb 2026 02:22:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770218547;
	cv=none; b=ArZZab+yLx54shgPFahK1y1/KSZyoPrYJFf+KR0OGNBdIfm/nH4PXp9eU1k7C1zvnmGQzR+TFYnkPu6DbvqQRL29hCK1PRUSGxwNiuhI/36QW6YeSn58m33b45SQUmH+kPRCGG6+l1KoESoUtcgx4PQJcoe11m7DL7HCLmjtiCj+rknqs9NDo3IaafVbPNOv6Sq9CiXD4Z/tkA9hqKVx95UOJghMLCGUdsx1anasUSOEJq2117EsMfzKJL8U6mtQkuXVb+R/f+/Qng1sp1c11b7Rm3ckfTYiFtnt0ZcJXBnQWnO1KIPoX6ffTVdhOK0o5cpR8on8KQrmXeu8S0Z+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770218547; c=relaxed/relaxed;
	bh=2AeUjjckE6ckbEbtZhA2yK/5rvZ03cd2hDiS+we+mO8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=B5na9GDscYpMLR1qbUnn/gl3w1AsPrDDeyGrKAW0TSMPJGX3weim4zOiXvocxUXOYvFgesKQHMv0t/U2GDqEmuRczVlV+mnlKm68Qt1KIolwnBMJyHGmWPhksCSrC5bCWw9YdbTQPBdR9HiN/mHBVrjLe+yamHao2PSWWmDJmya2vnwwJ1TWAbYykeGFZlvZ4fjd4W+Plo8YFuUwDGqdhgDUl0D0Ic/v5lkH6MK1M/levU0mqUMinFl4T85U5apSejhL5HNY4PYbkw7LWBqi/XJzKtKi6ZI1uIES9Xi2OoLfwuHfu85YTsgh+jjbJdSaL0QCXnpUrEF3yHyd+LuluQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TTfSlDeb; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TTfSlDeb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5kcM1P95z2xJ5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Feb 2026 02:22:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 829F040622;
	Wed,  4 Feb 2026 15:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7DBC4CEF7;
	Wed,  4 Feb 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770218544;
	bh=QKVVD+VED38HnrXr/JITeGWgjURaXPWa1Xedn84btf4=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=TTfSlDebQAJqui1BgHSLQCpxmS1XraC4tCysTQlx/7N2g5rtB+tlpXXC0ldh9xiGD
	 OT8seMStZDGN8ZHn4zPekngkKI8Kvzghah8MwYXK7gHzIkPw8cT8Zj7K2ylotwmyyS
	 5bVn3aetLQXvUA5Hs4YZmtbHYz9r1UyD26f12s1cpSqTj6NaT3R8XUt5zAnjhjVuOe
	 s/9baVrvWxyOP6X+0aeCGahyFh/hVJDzPmYHNW5P/ri9bGycBC0GpaLlBJE3BU95XC
	 5Avy4MUetp//pSBPcuLXYM3oWMorFMHTYePXG6RB/exwpOEYhPKicSOTfJOVBWXyHq
	 Z/mUgO6aOJ6Ug==
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
Date: Wed, 04 Feb 2026 16:22:16 +0100
Message-Id: <DG6A3L2W1YC0.YOB6BUMGG38F@kernel.org>
To: "Link Mauve" <linkmauve@linkmauve.fr>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-3-linkmauve@linkmauve.fr>
In-Reply-To: <20260204040505.8447-3-linkmauve@linkmauve.fr>

On Wed Feb 4, 2026 at 5:04 AM CET, Link Mauve wrote:
> +impl Device {
> +    /// Register a managed nvmem provider on the given device.
> +    pub fn nvmem_register<T>(&self, mut config: NvmemConfig<T>, priv_: &=
T::Priv)
> +    where
> +        T: NvmemProvider + Default,
> +    {
> +        // FIXME: The last cast to mut indicates some unsoundness here.
> +        config.inner.priv_ =3D core::ptr::from_ref(priv_).cast::<c_void>=
().cast_mut();
> +        config.inner.dev =3D self.as_raw();
> +        config.inner.reg_read =3D Some(NvmemConfig::<T>::reg_read);
> +        config.inner.reg_write =3D Some(NvmemConfig::<T>::reg_write);
> +        // SAFETY: Both self and config can=E2=80=99t be null here, and =
should have the correct type.
> +        unsafe { bindings::devm_nvmem_register(self.as_raw(), &config.in=
ner) };
> +    }
> +}

This should not be a method on the generic device type. Typically we use a
Registration struct for this, i.e. this would become
nvmem::Registration::register().

