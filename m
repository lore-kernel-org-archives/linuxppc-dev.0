Return-Path: <linuxppc-dev+bounces-19894-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588A4F8FA71
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 13:01:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Mt85YT0z2xd6;
	Tue, 21 Apr 2026 23:01:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776776464;
	cv=none; b=CBpL272oOIuthDtbayt+kdGGBDzbv2Jfap8cnXgxFKcEOe9+XbXkYHIbR4sQ7NsvW3Xv8aGBKwHGj5L0XRW/54kANP5IS0wvfZqAqJqQJtgUlwa3Bd0TTZJGnvgHUSweDnW61X5Hu/VLLZwRu9+bHIgsI5GV7SwU13xhvmfIuTdQLM2S1QAZWp059dP3eFRwTJVW/00Rh6wHMmeBocoVppsDLJ0NfLqvmrG6AAPYRgcSqGtRYB6JANMnoN1rd6E1Myb68+J4o8SVYo93Wp6HTPxrGc7hKkYMm7+TeTG9kB3W9oI1WN2+21bET/3XsH1DTeU/opRWjtE0HROFmApOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776776464; c=relaxed/relaxed;
	bh=lo0QBxTRUKOpgkoiN58ag+HBWtyMn+FDfg54Nuvii/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AomelLnAgIGbfNocUwm52glDJBQamYhOBcfbj8acNqMc2egR5CY4aNkJPUp3Emu4EEPREXOfltFYE0E5buWcVh5yy794G/gaehlaWw5UPAIWGcPIpWIo1tuQZKBhU9oGXMvGqPwVZDqaNpljQGlOe8f+1YPk3jZsR4U4Ez+2jT67qBxy8i7be8uotgWST3OR45CHZgHYgndiROrz3pVIlNJKijfEJL2/X++kMBkWDc21DhCATieE5i6G7yfns1ebbFExdtE9URmbClzVrXuE6eS+Mif/dI9TqKvgWBTJeUaFeknSoyJafmNooTMTKPOMdcpLOXQ6wqPeVcG6jMrYdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b7oDuzYl; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b7oDuzYl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Mt74bXCz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 23:01:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B22BF40B5A;
	Tue, 21 Apr 2026 13:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7484BC2BCB0;
	Tue, 21 Apr 2026 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776776461;
	bh=8r0ZFydET/AAmgi2IM70w+skNgAL6Sai3o0ra7HDchw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b7oDuzYl6g7/X9Rlfy8hCFWbnBxptHemsqSWOeG95T0xf64RZKh9Z9UEFzgX08Ip4
	 yHywN4KWWTFyTTxIpPIpj7JBl1Z0yEY4gXosqekCaLrybxRxwDGAvkS4SLJaC0xO17
	 KsOIamAcNUuKj9HkUv8gGejSO1Ld30u3GjVKtgO3TxVCje36oKnePnzgoVYV/0GGtL
	 xm7d2moJt31XHKwNxeb+bySQnJQHuLTclcvrr+Qd1cFCTuPK4gYcLscLs7MIAGhKVX
	 f0RXacEl7JcMcI1uRNvK+j4QfSW5LJN42SX1X/htMYxByewVtDkPPVIcO7RkazKsKG
	 p79g+a0dj25Sw==
Date: Tue, 21 Apr 2026 14:00:56 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com,
	festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_micfil: Add DC output remover control
Message-ID: <2b26c51c-d90b-4a47-99ca-652edd7f1f4e@sirena.org.uk>
References: <20260420085344.2081805-1-shengjiu.wang@nxp.com>
 <6c6f94b1-a4fa-418a-b471-8e3c82305233@sirena.org.uk>
 <CAA+D8AN3kmU-FDHF-kb47=ayXbypka+Q0vO-i2Bpzq1GSABuQQ@mail.gmail.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+1FrIIXGICkEe5jg"
Content-Disposition: inline
In-Reply-To: <CAA+D8AN3kmU-FDHF-kb47=ayXbypka+Q0vO-i2Bpzq1GSABuQQ@mail.gmail.com>
X-Cookie: Jenkinson's Law:


--+1FrIIXGICkEe5jg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 03:40:12PM +0800, Shengjiu Wang wrote:
> On Mon, Apr 20, 2026 at 8:50=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > > +     /* Update DC Remover mode for all channels */
> > > +     ret =3D snd_soc_component_update_bits(comp, REG_MICFIL_DC_OUT_C=
TRL,
> > > +                                         MICFIL_DC_CTRL_CONFIG, reg_=
val);

> > This will return 0 not 1 when the value changes, meaning event
> > generation is missed.  The mixer-test selftest should report this.

> snd_soc_component_update_bits() will return 1 if the value is changed.
> and the mixer-test pass

Ah, so it will - I'm used to the regmap one which doesn't do that and
instead has a separate function to get a bool back for changes.  The
code is fine

--+1FrIIXGICkEe5jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnndQgACgkQJNaLcl1U
h9BfXwf9EIHXZF45DCvVvzP1/vi1cTYydgcXJNFJM5eaWCZmqDo0/VRdYQsvs+ol
oEESYdommHtdvNwixhbsuNFKo9lD9Ogl5/zjpbc8a+jMyDDEoEMjp6u5/MELoIR9
jzbAZwgp/0Zty8QVtJO7ekoqgdUrboK+SrQMubUWKkDbaDN2UxtdBBLmZOIcn6Y7
TCW6XItCTcCmjE8vE+T2qtVlZl+4L426lc3W+57SBTgN7eNQ+B3LVF/LFXgeFrcO
gX0CGRa1KQzsmM31yxYqRMuYM2+OMjlw3BpkGDJYlr3UayT5Ymj5AlxKW3YLpakz
CSOVn28QgU7w6DPms4qftxKPhzkBwg==
=8E3z
-----END PGP SIGNATURE-----

--+1FrIIXGICkEe5jg--

