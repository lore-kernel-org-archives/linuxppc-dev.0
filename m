Return-Path: <linuxppc-dev+bounces-8169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DDAC369DC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Apr 2025 00:23:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZnHwL22hKz30Tc;
	Wed, 30 Apr 2025 10:23:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745972610;
	cv=none; b=lFqvB7eNM/DwPti52P2cP7HaTcNlBDLDmIoPjV1PNyaPjdX2OMKwNDet53cRAdFYSWq7Mnqd8R2l1Ytms8rdyxfVFzrzdLa0ZGwkOaM7K50AF6VOXV//kifBLMXKaG7TQqTTUJm+nRGWiIIdqJdqRrckSZC/3V3CRRZRtJfAWtbge8RuCV3Iy9a8ZlZxEA8cMj6A8+Pe69fSublZRAQyRWgWVxtIIOa2gG2yWM1YztcP59yy+tZeVMII/ciYdos+CWVabYDzMBsI0yfB3NpX8naLuIH5yHm8SCf3JWXolsXOKTyCe2s4icek72EE3u8GGktK/U7kgqoomZE5v89Ftg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745972610; c=relaxed/relaxed;
	bh=GT5TxOXhiRjIO9K+mHvIClNmf9oIbrxWKTdD5+XkjLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULHqU6xfBfMevhawyFbo2UPimTJ2DSjhyfFPhkFtkydYAlBAfUOZUIDMnl5FnHSrxGVu9prSOqHvoFAaxx7flN3CPq2T4urGHjkdxWX6wbns7UZ13gPSCMefD87Ygk6FpH+3S6QiGMN7LZriBIXdoGLkkvIetlwLrsNrtC6B8ErDTSwEOClfBZVg9R1nxNzSltv7F74kcsr+YmaVuLLVrjYwfqDAhDwd0FTAw1zEw/QeL2hQDeSj7yjHetE49tymek68hQGdXuKS0DYCk/1A/eCO/g/KaV5uDQh/icKMG9lcJ6oWTh5+pjNag8wT2GUZ/C10Zf/7Rcs8ALOpdNPxFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MO7pbjeD; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MO7pbjeD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZnHwK3CP4z2ygD
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2025 10:23:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ED8784A3F2;
	Wed, 30 Apr 2025 00:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC9CC4CEE3;
	Wed, 30 Apr 2025 00:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745972607;
	bh=LnbXxn6cfAZ1LTNdbY6B1qJi8/AVpoR91fSjqgmQQ4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MO7pbjeDbnVXE/n/z9HbdDKaUWn0AE0FB0fjHQyAYO1pQvqZCOc1DnAsTTIagOjGE
	 IinOPJPJJWCyGDxl4eZVw+9ZisCnZuCGR0RDCICa5c0Qp27mO8eM6zXM+kai6kTqDr
	 zru468uguQzT2sXdbOaS9G3o/zsTYAO29n5RYy48Y0Ymr2XTrJtK3cEQLGA24Qr8Nl
	 8ndy/tLrUPN6sQRzWd/qODJ7a+y7u24BwmddSbWH4Lt78uFJ8irq4YF3rBsTFWndwL
	 Ou75B4JZWtJxDo7X3FUAPNbwlHf1Dctk+kJqOQUkjTe5MtL8/MI7avQP0PiA9COqGR
	 H4tJtPJbu+qAQ==
Date: Wed, 30 Apr 2025 09:23:22 +0900
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Herve Codina <herve.codina@bootlin.com>,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl: fsl_qmc_audio: Reset audio data pointers on
 TRIGGER_START event
Message-ID: <aBFtesqln2Xeab-d@finisterre.sirena.org.uk>
References: <20250410091643.535627-1-herve.codina@bootlin.com>
 <174429282080.80887.6648935549042489213.b4-ty@kernel.org>
 <4b42c00a-0ef5-4121-9e40-9214bf9a1197@csgroup.eu>
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
	protocol="application/pgp-signature"; boundary="+n29DJNat32DEv6U"
Content-Disposition: inline
In-Reply-To: <4b42c00a-0ef5-4121-9e40-9214bf9a1197@csgroup.eu>
X-Cookie: Well begun is half done.


--+n29DJNat32DEv6U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 11:20:42AM +0200, Christophe Leroy wrote:
> Le 10/04/2025 =E0 15:47, Mark Brown a =E9crit=A0:

> Would it be possible to get this patch into one of the v6.15 rc as it is a
> bug fix ?

It appears to be queued as a fix, could you be more specific please?

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--+n29DJNat32DEv6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgRbXoACgkQJNaLcl1U
h9D2igf+IcSLAyyqPyCkgkxObz6ejq16mYpRMVXdZgtsyHGwuf21NEktBbBgp3Wb
sxMIFXayPEfzTqCLLcjojYObuIU3gK6zFBOIx73YRxysA6dtMV4EIm41985xKvNd
aYY/rxmR5HrZI1zZyqz7zkxM1AxmzFeKpD/PzJTmq0c4uM/ZbrmiihxtH7fg5e0/
hQ8OeyYviqP0IRVrxq5DvirNF207T1vwhXXlkB5WQqkxUqjAD9EsE4mkDc0TUDx9
SxljcDisxCz3w0DC+Ej9awxAm1Px35jb4UJxmPYX5ALjc9p8VcOhsre+sPWhHoGZ
6Ihvu7uJBQgr5wMQCcOJZifShXbGzA==
=K3dG
-----END PGP SIGNATURE-----

--+n29DJNat32DEv6U--

