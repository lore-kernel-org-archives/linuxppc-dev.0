Return-Path: <linuxppc-dev+bounces-137-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E93AC3DA4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2024 23:04:32 +0000 (UTC)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=127.0.0.1
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Sk4XSiql;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WlyHL5QNvz2xps;
	Sat, 17 Aug 2024 09:04:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Sk4XSiql;
	dkim-atps=neutral
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WlyHL2bhSz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2024 09:04:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723849464;
	bh=Y5/Gimvm3m3uUoIctaiu3fbIOMfcFy+xzSL5XT5v8vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Sk4XSiqlShJxmfMJBLcBNjDi6FeX1il4lfn9nR2l5xLY5N2x4mCzpPVifnP7QDbWF
	 l7Y06pOstzc2Na07dLZiXQBkeXnbsXaLbguhlsenLKyagVT8aWwIrgjnsjysOdVgIy
	 yQCrkq/KOoqePJhaPmmARbESGlBd61UankYAWDZt/G+t88Dv7c+MZzAwexTh6+RA02
	 D1Julpi3xVHnNQ7nV1141llox5u5xRrBg3/ZTi58a0KgRinJIBE7Rk39yUkWzanPjm
	 OoErY8FWNqKbinfVkfLm/qdyr2CNtbdr+IcgMiyZB5BHFiCRRIV2EKD8MJuwXCuGYf
	 0yYPFFZVltLDA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WlyHB5BVhz4wcs;
	Sat, 17 Aug 2024 09:04:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matthew Maurer <mmaurer@google.com>, masahiroy@kernel.org,
 ndesaulniers@google.com, ojeda@kernel.org, gary@garyguo.net,
 mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Matthew Maurer <mmaurer@google.com>, Naveen
 N Rao <naveen@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st,
 j@jannau.net, asahi@lists.linux.dev, Nicholas Piggin <npiggin@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas
 Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v3 14/16] modules: Support extended MODVERSIONS info
In-Reply-To: <20240806212106.617164-15-mmaurer@google.com>
References: <20240806212106.617164-1-mmaurer@google.com>
 <20240806212106.617164-15-mmaurer@google.com>
Date: Sat, 17 Aug 2024 09:04:22 +1000
Message-ID: <87le0w2hop.fsf@mail.lhotse>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthew Maurer <mmaurer@google.com> writes:
> Adds a new format for MODVERSIONS which stores each field in a separate
> ELF section. This initially adds support for variable length names, but
> could later be used to add additional fields to MODVERSIONS in a
> backwards compatible way if needed. Any new fields will be ignored by
> old user tooling, unlike the current format where user tooling cannot
> tolerate adjustments to the format (for example making the name field
> longer).
>
> Since PPC munges its version records to strip leading dots, we reproduce
> the munging for the new format.

AFAICS the existing code only strips a single leading dot, not all
leading dots?

cheers

