Return-Path: <linuxppc-dev+bounces-16786-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A73EB26ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Feb 2026 17:09:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9SjK71T2z2xN5;
	Wed, 11 Feb 2026 04:09:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770743381;
	cv=none; b=o1c3ZnKWyPVaOqhBLT6HUA3Grsj/lGDrEd/Xpj2egIfxvCJHL60OadDXWRvYCFhDLSlb8vtzIUOXZS3cjS24JQm4wdkRhOPPmD31fU2sVB/0vaXQWoj6SL4YdJ20HITVF/Oj3rieoQ1+UlXRWzReh84vo1XMOa4QlbMmGHWQo7fbYZRCIHqekoL/xuhg1O3znZg+gmUYutIcaciJgEIJTSKuLqD83WBA0WOeoxNGoreGtsFjVGDa7+EVWmrr7IPx3Hj302kvZoVLCL7ZJHLGD+pxv+CeRPuSaw5thxmIR8zNbTTHp+HWng03T31DlaL/RmTjTmxIB7vJt2BiM0Dy9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770743381; c=relaxed/relaxed;
	bh=fuVUhQ8IfDRKa7Kh1nLHN9IQfMj+L7RtNDkNPOo0Nwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNYI2xNwYj5x4JWbWt0cgtC93drZ4bQbdD3pGhThAfx/nTh0h/Eqar+01bRf4aGLcpyUVhDva8Tt8eoqK3V5HhhNVsBU5U2fft+LIIV6r3pnGkM38rfprHL/jedOB4ExNKey5fFwlolCBODQe64vr60fBz2UKLvr8BBXCFie3c2SEl2tygVofIaHZTQGJc62XfT+RePYscdHgu9sCSgZrR3/JEXTFHIAlaWsPFuOem3/9tk3o24XPpWjg1AOaWd8hqSGG4lzGGcAceNHP1itvEjQkkzJHVQsSlfBA7biJcfZVa2IySbWEMSDjH+Qn7aRBV/qR6VBPMuwKesEIhBXBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lp9eZGet; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Lp9eZGet;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9SjK0BN2z2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2026 04:09:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2E7F142A4C;
	Tue, 10 Feb 2026 17:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65D0C116C6;
	Tue, 10 Feb 2026 17:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770743378;
	bh=fuVUhQ8IfDRKa7Kh1nLHN9IQfMj+L7RtNDkNPOo0Nwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lp9eZGetaSpXv6Yb9UtiSGvhJ/vjgH2QNJCh9Pegb45xYTKTlH31Nncg4TZbsafJg
	 jPREYYZO0FclZ2zkVTcHnJYZpdgh2BJdu+WXKIYTtEKL6cRYHjgPxMs+idFmShVVKG
	 wu73BFA33qETSKnN42ns2uM7/cMVxeEmdnpwZ1a/47EF4T0X+eTGRUB833z2qNfBxR
	 9hmUOKKhhE+urVWQVmt/x4UfpOP+Iwm4mzpcVHZLkeWzsKb6rrTw6g/5U8IRwUyEpL
	 EcrwSB3hXyj10RcwMyEmbKQuz5SM9OZXaJ7LaKSg0d1LfW6nbP6srb7Lq0vE53SPCv
	 5kybBV+bRnh3g==
Date: Tue, 10 Feb 2026 17:09:32 +0000
From: Mark Brown <broonie@kernel.org>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "ASoC: fsl_xcvr: fix missing lock in
 fsl_xcvr_mode_put()"
Message-ID: <3f9a014e-e668-4d83-a3a4-8cf4583db611@sirena.org.uk>
References: <20260210143809.297565-1-n7l8m4@u.northwestern.edu>
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
	protocol="application/pgp-signature"; boundary="nrIfPBcelc/Oyfjd"
Content-Disposition: inline
In-Reply-To: <20260210143809.297565-1-n7l8m4@u.northwestern.edu>
X-Cookie: Spelling is a lossed art.


--nrIfPBcelc/Oyfjd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 02:38:09PM +0000, Ziyi Guo wrote:
> This reverts commit f514248727606b9087bc38a284ff686e0093abf1.
>=20
> The original patch attempted to acquire the card->controls_rwsem lock in
> fsl_xcvr_mode_put(). However, this function is called from the upper ALSA
> core function snd_ctl_elem_write(), which already holds the write lock on
> controls_rwsem for the whole put operation. So there is no need to simply
> hold the lock for fsl_xcvr_activate_ctl() again.

This doesn't apply against v6.19:

Applying: ASoC: fsl_xcvr: ASoC revert missing lock change in fsl_xcvr_mode_=
put()
error: sha1 information is lacking or useless (sound/soc/fsl/fsl_xcvr.c).
error: could not build fake ancestor
Patch failed at 0001 ASoC: fsl_xcvr: ASoC revert missing lock change in fsl=
_xcvr_mode_put()

--nrIfPBcelc/Oyfjd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmLZkwACgkQJNaLcl1U
h9B0bgf/YZp6ijko3GUorgpSQu5p2W7kQA4JXn1TgpfctygpM0Nm5y8o7rxQ/9ux
R2kxzOA9mnZ7r7WKViLsxJZH64WhOXbrlrt3cIgUKjyoGhqGg3iK70qyIIGwgWAW
NUCI0rQLMBYqJaIoBDYFZx+dmhr8uKajrghvqpW/U7NDNyUXMSNFksCyV9ZTrZiY
jNVHAVsj/o8PPswBhLE9HoRNgdYt11qDKiR5b+UydECUO4XBeqFvT2s09+amjPtN
ZOvn0azgyFG+BzXVEwhUbB9ddvpw5TS6nnoC8UdaBwfemveHHF9PtZqTB26IqWZd
BD5TfweNluw7xCteGMGplykjhvMSbQ==
=pywT
-----END PGP SIGNATURE-----

--nrIfPBcelc/Oyfjd--

