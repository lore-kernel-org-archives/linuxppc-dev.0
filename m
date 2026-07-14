Return-Path: <linuxppc-dev+bounces-24202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A9CC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 10:21:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzwLq0hG7z2y71;
	Tue, 14 Jul 2026 20:21:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784024467;
	cv=none; b=bRxwbYJvdiFz+GCxQQtop99q9ZRgxcqk9X37hvk/gkJ15i/hT1oi+zcwM793Pi1PMkndx+023gIqIYZybmMASMp9tRgygCo8Z/LdOPNbN4GcUe2U4QrgBVKxbIYFN7gTmdhefIR2SqgXgVhvapT27qmi2iz46bpH0bmhFgvjICi5nyeFJckSVYh0dBScojG2xrfmaNx+3JclBmzzWge4xk2gYsqjXskA9ZqxGXOxVuaXN+wQfF777ef0ZH8yVBxlLXoTjovXOEzNFx2NnuVs/KnVcwu140nTRYopSR4XQxx/FMmWY36oJVdGSCNIkH3Bcx0XyZAubLeCKqv1yBsOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784024467; c=relaxed/relaxed;
	bh=9M/RXC3eOaKhkKYwY07SXTCAM7jjeRRObmHaBug2aUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra6i6b4rurgyWmY/5nWP5Xtn9q4sUdb/6AXMaQD8uitqusujKOxSC8Fu0tDrUE0DIHZSk5qfuV6FAqhZzv8GkNo1sF3xMlWm8oYRP/UxPZOW3Ui0L7MuE1gMFIyH7C2tSnFZSpUoC6TsE5Mp+BM6A9ZNfPDF/coi0Gi9Kj/Mj462g8s4D/yiOTyaf48HlgXSykdUoPGt1/zl9eOOMwNtg8MC0TqTvOKz/Aci+gTbhOopkROCQ0NGOI7GYKg87pBjRsYMxSbQRpTH6A9cN1uikrx5d3H3o5WCbiEq2NL3JI8CWtThVj67vaBS6jeMtmDb8xi3ogIVqidtyulPdCG+Qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCcDLzBU; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCcDLzBU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzwLn56Tvz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 20:21:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FD4741AB4;
	Tue, 14 Jul 2026 10:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7234E1F000E9;
	Tue, 14 Jul 2026 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784024462;
	bh=9M/RXC3eOaKhkKYwY07SXTCAM7jjeRRObmHaBug2aUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCcDLzBUE6xt1OhcIKEHEd50/x43uoCQKKaUNbaeRbTLXui6AITrTUWLbMfK0T+xP
	 mFrAjgiEjrK8E5pMfQS9Af1+Tv+MRMU8VMyQIbhGuqF7jPx5PZkuCA2V/vsJYMtj/I
	 UeoO3uBKOfIK6hEAaPSx4AaI/fd01y3k/tK9LtPKx9mUh+BgqJaB6dJhw960bwWpbM
	 skaRQwI/nSPOzGo45rHJlEAFROmkHZJnxJURie5mo4txo35h3BscYB2+H/jf8SkNK4
	 VAgVQnpf311NaoYFCBNdqFRocJpc2O2yMHDb0ZhaPxF1plARM0UbA/xZOb6y41K3Jv
	 kgyuqa9SIBXKw==
Date: Tue, 14 Jul 2026 11:20:56 +0100
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
Message-ID: <4eddcb03-3c2a-4ef4-8825-e750e8109476@sirena.org.uk>
References: <20260714014445.569992-1-rdunlap@infradead.org>
 <20260714014445.569992-2-rdunlap@infradead.org>
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
	protocol="application/pgp-signature"; boundary="LGa1tIjMTkLV9u70"
Content-Disposition: inline
In-Reply-To: <20260714014445.569992-2-rdunlap@infradead.org>
X-Cookie: Neutrinos have bad breadth.


--LGa1tIjMTkLV9u70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2026 at 06:44:32PM -0700, Randy Dunlap wrote:
> Don't use "/**" for a non-kernel-doc comment.
> Use kernel-doc notation to document the parameters and return value of
> ntpfw_load().

As mentioned in submitting-patches.rst when submitting a patch series
you should supply a cover letter for that patch series which describes
the overall content of the series.  This helps people understand what
they are looking at and how things fit together.

--LGa1tIjMTkLV9u70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpWDYgACgkQJNaLcl1U
h9CVsAf8DYSsoTawAK2saA5CV7XtmqI34Bf8Nt3udzbI78JyZVSFG6QZ6KZMp8uB
OPWQixu2JlJ86SaHr3y4xPWCqDqY95ZrOW645UbdHTvaoHA9FnbnQUuaN/KM5zjF
hoL2KXnw+4WRLiwouO2TwC8OMzHT7TIxzFVv/xCLCma2qhZCHXxvnzwflJAl7mnx
yG5Nv7AVj8goa1ANV9a03TvZ4JSMk3EH5wFRiANYMIimhf6fQ0LX/CGkUr/Ogv6v
xJ5NjE9GQ4QDad2ZNtUuYUqTh8+EyGfRz/63NuqVyMah/2tph3ckFeHa4G1RCNZM
GF7nWmHmheXvdaQTs4xuyi+8yEwo6A==
=bdq4
-----END PGP SIGNATURE-----

--LGa1tIjMTkLV9u70--

