Return-Path: <linuxppc-dev+bounces-24259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CAFC44508
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 17:10:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h05Ql46x2z2y8p;
	Wed, 15 Jul 2026 03:10:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784049007;
	cv=none; b=DuSLVcduhzg3UluTc4D2hrS/7tS/Y1ORtHAv3j9YbHy0lhC9GNezEb1wLRWbza+pgRxDXzyZYE3gqMrQHsLizTERiL6j0yFRbxwTTvlxb/q75dHrkCbMo6EL/AOVAcqu0U1BhuiEHAqvmDG52GNSK1QPkUL0hZN0NA+BM+pe4lHtrdSTtuR1pxlfes4UHiOb/AG72dS4srEDlG0gwZk9MG6Rf5+lNbLBDu/3CUQGjn8XO8WNEjb8ql0MfvaBmGSXAE1JUdkBWuItyjiakn7bvBW2QaxH6+W10GQkDo4oOyfvCJNFDZ6qtyxsxwthQmI/4svedTEFywKhVQsDD9qDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784049007; c=relaxed/relaxed;
	bh=p8krTh6h1D0xl3+E4ar9pBMXTTFfLOvTztKmJu8UNmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKE7tdY2ev6W4STSpPAD2nGp2gc+ccRu16WGRFLiDOSEYbNBjElm5mNATHsH2C3uSxy8ZxAVHGijyjsbB8gGCDdI5suBz7AmX7YQ603+RCCuxd/mn9qnaE+fFwieWDvuujd+yn0FhVxzgXJwfLT16soezV+eyCZpz4x+++AZ0J6Iyhr369sFoUDCmN6EqHGFbAAUBo0wiaGPgVrRv67IKU+I/pZYFi9xmyNUwVqfGo5o3uYPGvRXNF/Dxvi4ff0ikYIwgdsdKQwPXDyhYOCqOevyzp1QuZV8N8VjswgxBjgeSRXA5J4b4+qZNr248eX8JdY9H8yYOFobqazPXmwyCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=br019/Gv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=br019/Gv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h05Qk4W0Cz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 03:10:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1B73240881;
	Tue, 14 Jul 2026 17:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47821F000E9;
	Tue, 14 Jul 2026 17:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784049004;
	bh=p8krTh6h1D0xl3+E4ar9pBMXTTFfLOvTztKmJu8UNmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=br019/Gv7LNagHxZ2TIUhQ4Ui5YbEMu3tScUpmLLNlYU1e5p2/qHGPryfUlTtHSMe
	 6NQfssgg/7VGDNRv5r/hiimT5P84JdzlKPvIcAXAiUuUReJNHIc0nFtDEd40VZ4tQ9
	 SoKpQpwlBYaIZ+eQpZ7PhBVrreY0e+JcPZd8QnM9mEBmr16OzwOuXKu+H83w12UZdR
	 l8zrwQmxbad2KQ01+juChQPg12QjQkz+kLL43RW1pP4++XSEWDLtU+BSoWw7M+ENGB
	 oDSTVowI27xZVOvFQLHKe3X1cNAUyFJLPpiXIySQG64YSI0YbANJgla7dj/Syw1B88
	 j1Z6y1GlVjZuA==
Date: Tue, 14 Jul 2026 18:09:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 01/14] ASoC: codecs: NeoFidelity: repair the kernel-doc
 format
Message-ID: <134b7d6e-979b-4b73-a99b-98e98a9696d6@sirena.org.uk>
References: <20260714014445.569992-1-rdunlap@infradead.org>
 <20260714014445.569992-2-rdunlap@infradead.org>
 <4eddcb03-3c2a-4ef4-8825-e750e8109476@sirena.org.uk>
 <1a885ccd-77bb-4537-89c9-6b031c2f3812@infradead.org>
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
	protocol="application/pgp-signature"; boundary="ICQm/UaAuCcRnyGo"
Content-Disposition: inline
In-Reply-To: <1a885ccd-77bb-4537-89c9-6b031c2f3812@infradead.org>
X-Cookie: C for yourself.


--ICQm/UaAuCcRnyGo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2026 at 08:57:06AM -0700, Randy Dunlap wrote:
> On 7/14/26 3:20 AM, Mark Brown wrote:

> > As mentioned in submitting-patches.rst when submitting a patch series
> > you should supply a cover letter for that patch series which describes
> > the overall content of the series.  This helps people understand what
> > they are looking at and how things fit together.

> Are you saying that my cover letter was insufficient?

> https://lore.kernel.org/all/20260714014445.569992-1-rdunlap@infradead.org/

Well, quite apart from anything else you didn't send to to me so as far
as my inbox is concerned it doesn't exist.

--ICQm/UaAuCcRnyGo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpWbWUACgkQJNaLcl1U
h9ABwQf/eHvS+UV1AYoZe6DwnsnW8Tgd6rs2VG84fELITR7/eEy+Q5m43Tn8RKt4
xEDWcuDNbzcbk8Rv22XtI7SwSmWTstlpeYGlKRSDczjaKodKI4YL0IF1fpJ9gJ1E
sPowWRSaO/eE41MuhRUHhqbVNjmqbeSBfz44ZaB43wStzbR7ikUfWjFZRVqTukgZ
Rm85kdwy2rRRJBM6fNTINkBSeMbcH5lwr+nRgYOei6rQl+Qq599hzpptldSBFt8P
GzGnRYN+OAWaH1Wkcp6Ty6G3QZf61JeroYWXQh2SIvIZDqDCtA70kyw3fy+0qFc0
VqBIwc8XXtqwIoXBb9lv3C1qK5SnXA==
=4vX+
-----END PGP SIGNATURE-----

--ICQm/UaAuCcRnyGo--

