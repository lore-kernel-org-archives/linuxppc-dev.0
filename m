Return-Path: <linuxppc-dev+bounces-19022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD6210D14B0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 13:23:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fksQY0L4bz2xpt;
	Tue, 31 Mar 2026 00:23:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774877028;
	cv=none; b=EpE9dsZc1ZRy2AU5DvPBt9XfKNWT+l5YNPRbsaMfnM8cZyTPZU1gIRJeBjlqZ3+LSItN+CAVozGwYMQADG2jdDb/lBLOOXe7bY2aBwrW8NqG3ShwD3xysB/BN/UoYv1VQmsLr7aUNQ8nfB8dEG4sc/LCck8GEy2xJv2FpraMNFC1Gz37GJ5r2va5+4llmTutJSovd1N14NgOZdrgvoUDHvZUmNboao4fW2tH9mugEBYpYmViz4yUxl2HYbZvpCnuk8tx4vVjVNsal7jmRLjnSVOab4H9bpmfmQFEr+4XF1jcr1nHwbvKZPLhwVvGIFgSsM2+61nlTEVsJcG/lXlZpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774877028; c=relaxed/relaxed;
	bh=8GtZo1PcgDHpjn8Gqllfk6QKq7GFuasaPSEZ4MJrTa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dEfvnhqns3czUqrHZ8sTZDN31zT2pROew4nW3Os4aBBQODTkIUlAc+s/hHv/JQY4pcXkVrjBfeoA2jUHnfNHzuuYa1WgM0q0J0qDasO+7JrLFRuTLzSaWP+0F6ydakbFr2zuIk/AL8ytjLV0nK8M4SvaRVTU5t4SyBSyi2JQdrtRJKXImaDSdrVZplic7KIMghR2OCffN9EHNrJQ/HuCgnR60ZOuwCavHbIJl5cb+6yZjNq5wYgr1Nia85CSBZuQSXieVCql3wsj95gqSTx+Xu4EKL2Z1U+g0YKo9y9usB+QdNTp3gHM20T2UqGOyFXpxtDDdaZsbJxVhSMVuO47Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MR2vrXID; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MR2vrXID;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fksQX1GHbz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 00:23:48 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E61C86011F;
	Mon, 30 Mar 2026 13:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725C6C4CEF7;
	Mon, 30 Mar 2026 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877025;
	bh=X1+YBhc/ZSUl9M7/HqQfBOi/B766QZ/5KReMpWzPq5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MR2vrXIDzjGj6xwXFk1oY54tzC7aa9qaYVEVYseVortnRvD03zDWkHOU7pmUAu1iw
	 m1+r0sOqlIpRZ07+Q/wYzH/xU3+QUJNB/kJ8uNP2iq+MLgGD4s5+KSy38W8dGWQF40
	 inTgz4HP/CadRQ6ZxTCtd4cWH218eXY/oojqMBYmlvLCgztYcDPnsdH7iHsBd/lYZX
	 iu2s112tidE5DG0koJHRsQn4DQ5+O1HCva2As2nuUhu2utNBt3sLxi99exoUUtnR3Z
	 hy3oRSQaJeQjtsVyXS7ORszN/NR3OIT4ViUhlBjIctkCEbREM5j5+pwgGRax4VyMDg
	 kQPMZalbvpKKQ==
Date: Mon, 30 Mar 2026 14:23:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] ASoC: fsl_easrc: Change the type for iec958
 channel status controls
Message-ID: <be591d2b-9429-43de-8d5b-357a503607d0@sirena.org.uk>
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
 <20260330112555.3637002-12-shengjiu.wang@nxp.com>
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
	protocol="application/pgp-signature"; boundary="/8vzq1AnR7+A91Mx"
Content-Disposition: inline
In-Reply-To: <20260330112555.3637002-12-shengjiu.wang@nxp.com>
X-Cookie: HUGH BEAUMONT died in 1982!!


--/8vzq1AnR7+A91Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 07:25:55PM +0800, Shengjiu Wang wrote:
> Use the type SNDRV_CTL_ELEM_TYPE_IEC958 for iec958 channel status
> controls, the original type will cause mixer-test to iterate all 32bit
> values, which costs a lot of time. And using IEC958 type can reduce the
> control numbers.

> Also enable pm runtime before updating registers to make the regmap cache
> data align with the value in hardware.

> @@ -100,22 +130,52 @@ static int fsl_easrc_set_reg(struct snd_kcontrol *k=
control,

> -	ret =3D regmap_update_bits_check(easrc->regmap, mc->regbase,
> -				       GENMASK(31, 0), regval, &changed);
> -	if (ret !=3D 0)
> +	ret =3D pm_runtime_resume_and_get(component->dev);
> +	if (ret)
>  		return ret;
> =20
> -	return changed;
> +	ret =3D regmap_update_bits(easrc->regmap, REG_EASRC_CS0(mc->regbase),
> +				 GENMASK(31, 0), regval[0]);
> +	if (ret !=3D 0)
> +		goto err;

This drops all the checking for changed values that we used to do so we
won't generate notifications to userspace.

--/8vzq1AnR7+A91Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnKeVsACgkQJNaLcl1U
h9AQpQf/Wwg0d6wy7+tbE0cV56MY0BWOsiAJfNAdGi5hQfMf9SE+Vj31fy/26gup
/KfPd3I+TVmNUhdvQu21rMFsu1zzN9TapmOn6HcWVmFX90sqjE8WnoOVO9v+MKwt
awK6l4vuVU9ZaQkowma/RECz1RHN/4q1c2f7oRmigkxN360nqjJsOrj6b5AW1j30
fNiofpWfFFTjYdOa6ArtWMQEJhQqptnCa2EgXzZDQStWH4D5CuKgLzG38CTOywCl
siM70hegXV44VYSo+DaGvXhhxFjV6pjtA6MvMGh1G23OzWf0EXc+03MOG5QVF0ej
AocKsmJgOl7HxvhLz4BEx4/quWT4Tw==
=5BGx
-----END PGP SIGNATURE-----

--/8vzq1AnR7+A91Mx--

