Return-Path: <linuxppc-dev+bounces-16631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2F7ECD992
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Feb 2026 19:05:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6RW52rtrz2yF1;
	Fri, 06 Feb 2026 06:05:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770318321;
	cv=none; b=ocjIUAF/77NP0QhP4kb4P5EJ9L8hCtSLM6/20nTv1v2MxTwrhGGVmipP1tH2s1Nu/xAehVJx5CdYqxvsb/eJJkkWw7tCFyvtpyNL7ZYS9vyrOKpITPSAdB8VOWYTYaWEy2xuO27voshc6sEF4j3qmkwERIV883F8f1MmA3vyxPPF1wMNu1A61OBRrF7DjB7KDatjHF9LBTJGdI7InGSthHt/yt4ai2zB4b2nBUgdWMdeCqXZFgA19HiFBBOTMtLHAjkbA4P9C7/lNZ22wUo/BURBFc8TKRAaCMQntDsPbkR7FidrDret/2r68jmNUoeu0kVhF/S1VJZF4BoGw+MXpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770318321; c=relaxed/relaxed;
	bh=R6LcV7WKxwICjcsU9k+9MYf+WRKXtSxP1XvQxV9ASDo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=jUsi0NHhawHs5v5Cl1ytd9D2kO7nOeit7CGeVjUD7WbdYPznQ/4sxx/ZSyuqG//eiIWEdDt4tHpR6wV8Jz8XxIcQc5RdUmTOf+SaSzKSHJuJFzs76wuul5MfDSdm86tNu+MogzbPqWEnc17KQAH/n3EYhpSG4lOHr8tr6dIcOykQFvewcMJqkvLysCgAJMgWouuRRRpREvPSzUMRMRLXnz7NSXtYIPIvqMGLMxrhWKX9TUKB+YTQ6Js5n5P0TWcRbyBpJFbu0UUJJvSkG9Zjk0EQvdnrKdXxyMrHP6iXUVmA0KQo6VCNpxJ8/BtR6pYhM6cOwC7f5BiECwU4mZV7/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=njnq9icf; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=njnq9icf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6RW34YvNz2xQC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 06:05:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B44443220;
	Thu,  5 Feb 2026 19:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D38C4CEF7;
	Thu,  5 Feb 2026 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770318316;
	bh=+lGXg9aKGgu5PYXE6zY8ByxlH1ZZ9v8LToFwBmv61P4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=njnq9icfLpWLGyFLUKKHz/g2QNTILw6j8z+lYIjhL+qZaGzzpZl2YYIjaVrHVDyG5
	 Cvnb1uBsh91jaUR0XB1eXAJyAt5Qbe1DUqrx4yBaSV0YzGqEjsNO1MulCyas3bH5U2
	 85h/ZSo2fzv8b0wglNRiB+fB27EKuPWFRolX1Sp8ikXls0XlSrGtQnuptrXT7glIBX
	 vDLcpbqi/HdZnIt13E5gSs7C+Sk8WSc6h08osKSCUsXYcjlq/E5pcWe2P4z9r1S69W
	 xmJE+zd4JENgz2YwncaWYqb5xdZpRtKotSnJ56y+vie/r4qUaguz7RcifOzAfBv7PK
	 YyNbHkn1AqbPA==
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
Date: Thu, 05 Feb 2026 20:05:08 +0100
Message-Id: <DG79GRI3NOLS.3ASMS9RJ80IXM@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
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
References: <20260204040505.8447-1-linkmauve@linkmauve.fr>
 <20260204040505.8447-2-linkmauve@linkmauve.fr>
 <DG6A0WRA0JZC.SPDT9WEXF92K@kernel.org>
 <EC479D9E-ADBF-461C-BEA6-06EA2D4FD8A6@collabora.com>
 <DG74LUHX3NPX.3BLARQEIFG1DD@garyguo.net>
 <D6227AA2-A727-4F29-B7CD-BE0AAB0A13F1@collabora.com>
In-Reply-To: <D6227AA2-A727-4F29-B7CD-BE0AAB0A13F1@collabora.com>

On Thu Feb 5, 2026 at 6:28 PM CET, Daniel Almeida wrote:
>> On 5 Feb 2026, at 12:16, Gary Guo <gary@garyguo.net> wrote:
>> I think we should have everything default to little endian, and have wra=
pper
>> types that do big endian which require expicit construction, similar to
>> RelaxedMmio in Alex's series.
>
> Ah yes, the RelaxedMmio pattern is definitely a good one. I agree that we
> should head in this direction.

I strongly disagree.

This is a great pattern for relaxed ordering because:

  (1) We need both strict and relaxed ordering.

  (2) Relaxed ordering is rare, hence it doesn't hurt to write e.g.

	io.relaxed().write()

  (3) If you by accident just write

	io.write()

      i.e. forget to call relaxed() it s not a bug, nothing bad happens.

Whereas for endianness it is a bad pattern because:

  (1) Devices are either little-endian or big-endian. Hence, having to writ=
e

	io.big_endian().write()

      is excessive, we always want big-endian for a big-endian device.

  (2) It is error prone, if you forget to call big_endian() first, it is a =
bug.

  (3) It is unergonomic in combination with relaxed ordering.

	io.big_endian().relaxed().write()

      (Does the other way around work as well? :)

It makes much more sense to define once when we request the I/O memory whet=
her
the device is litte-endian or big-endian.

This could be done with different request functions, a const generic or a
function argument, but it should be done at request time.

