Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E031606B369
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 11:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekj3YAJe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQJ971q0xz2ynW;
	Thu, 12 Nov 2026 22:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794483035;
	cv=none; b=CDP/kTzNxTGQ8gET5iGHcboGIkhG7Od5KQaz838qi2GxUPyY8tYHT2XYQtC/mKxDHpj3GaWyIolemLmIr9rMvxOdtV60UoHMBVs0NKIRs/Ve4RlKjfJuEhGqHhh2UBRCB1ohVXjmJcaZgay6Udns/NahY4RuMEfFzD49xMw70LSfc3yHLMopEyJriIabBD3tICw5px11Jy2cz089a+NWBacvAhsRXS/XHNlHvOCCr1/es9+18NcxA1GcHItp/w9vgxN2WQGyjdmqY1J2reDo39DrIg6CnAtCQOWUCLRuVifvmxPdDnUAp6TkkbWwodTdfkQYbHClouUOuRoSdl5fVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794483035; c=relaxed/relaxed;
	bh=F6gU4BmozjxaE/QerEOJXFIss7OYqEoODtcrPRAZu7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6a70TpIvT+KOuk5JMIntfYJ0rcu5Qq6fum3eFJkWYQd0BI8FdEfsrN2YWPSBWgbaLKsKR+5HQAFt/nXQXonrUExYPa7F1gMybhymk+Aewi8OAPno7Ez8y0q3I1Q/LTf/gHvhm0HTR8yowrFI7UCq0z7kOTn9C77TmnoDP25BdWKkkriYJkDllECMSmQqSCj2VFTVE4ZmJt49ckdBPtnsOmoU2SVUVXVWzESK2lZZviMDDHAYVXhj91J7/CysU5Vv1LcVv7J0ag8rQ7bgBQNMONWC4M0vyEPU/sE4WHwnH5OU9AVlVryqgy6TKN2Dm45eywp/r7ZDl4NCUgZG3lmww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekj3YAJe; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ekj3YAJe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQJ964MrHz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 22:30:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C3BE43B4A;
	Thu, 12 Nov 2026 11:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028221F00A05;
	Thu, 12 Nov 2026 11:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483032;
	bh=F6gU4BmozjxaE/QerEOJXFIss7OYqEoODtcrPRAZu7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ekj3YAJea3A+Hvwb14NKlDrVFiwuBOCv13IuASTSE91SXXW4eg3AUjZGTaUk5hZ1D
	 3+J7D8LLu3cLnNWZu42bWDWF38N72zRMSsrywFgVgpqKGVdTNJF0ktCGSHjaJV0tp/
	 H08GqrrCmlHSLDNxyiB0iulZrp1RVg1/4GoidyEXvVeEWy5iOrCmbgEDupnVqBupOf
	 lHU+tyB+qIjFA1JIxkkS6ayf7f0mukcfISHR1EebBHamuEPJS1vMGxo2rUfOe+dzJj
	 MbfYoFCg5YUCY8hUJeeG1kjENRN1Iqi4LiP1dzfC7u1N3j4yDH63RYTadqcC7p1hLk
	 ZnWx3y1BDip4w==
Date: Thu, 12 Nov 2026 11:30:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Stefan Ghetu <stefan.ghetu@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] ASoC: fsl_asrc/fsl_easrc: fix memory safety issues
Message-ID: <df98e456-5f70-4b3a-8881-a4c1e7440632@sirena.org.uk>
References: <20261112100105.123845-1-stefan.ghetu@nxp.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0/NDbg2oErjx5qhd"
Content-Disposition: inline
In-Reply-To: <20261112100105.123845-1-stefan.ghetu@nxp.com>
X-Cookie: Baby On Board.
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--0/NDbg2oErjx5qhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 12, 2026 at 12:01:00PM +0200, Stefan Ghetu wrote:
> This series fixes memory safety issues in the ASRC and EASRC drivers
> that can be triggered by a user with access to their PCM or compress
> devices:

I've got this cover letter but no patches...

--0/NDbg2oErjx5qhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmr1o1IACgkQJNaLcl1U
h9Aiogf/TPF5sHgdyas9ArjKL8tzkEJQmNb6PSOVQQkcP4LverwE7sJK2nYaWjiI
hexouqrJ3voghfk8Sg87fXw9OJq9Q2YJ3GjRg8HRi+zHQFGr3ZREHmC77DkWvtIm
04/mt2TiP1Aa8QJxX7HZZyH3y5CHYe6TdycteZZLphOVoyazmbZcmZAS2fvHaU8f
cOpigk8ufTq/m6c7yRLvDPKeQ3DPcBj0YVb8weyzI/J0pklVyAB3aVnaxaihSKWo
PaKz2YgEgSZlnM8oqaMIG/lCUNth9W4gu8P1p4fu4syFIBdKN2INVMaYq4nvNmie
H5vcCQMupSJuyhQAKSVJ42oIiHeNug==
=/WPG
-----END PGP SIGNATURE-----

--0/NDbg2oErjx5qhd--

