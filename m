Return-Path: <linuxppc-dev+bounces-17935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1655FCA19D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 22:42:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVBq94Hqqz3c8W;
	Tue, 10 Mar 2026 09:42:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773096165;
	cv=none; b=ecdVkxJ1nqbec0dyGcb+aNHRXYs3wh4MSlD62I7F3utZtIB7hT5LaC8CuBIpZvm1PmLJfC7Jh4mOOu6ujsBDtQR01lm3Oe2fZjF27UEd1l3tcec+5IntU/5xh7mJsxpeag2ybklWqzrwNP4q+UsnPN9ZNW42ePKazKVX5sYMV1nR890iMfVZfNxfnAbLyzcUvKx89Xf1NbUI6G643gbmRZG2mJHHz9i5SDeP7yL+OhGeNLMZ1hK5VeDyVG8oP+4FO6CvnKaq4oMQkvpWJaxmbS/wW22JscCrbn0t6TPr2y9MC1zQlG9ObjuzGQsfixY3+k/rZWVWrIQSAVJoNSjYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773096165; c=relaxed/relaxed;
	bh=KZ6hWZccqOpVpFhzDJu8zs9y+DW7Vy5Ovj+QAnvjZXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9iSVeLgPAzqLXUp04OsgVD0w2XHxE06nJtSVAulT2z8yDdUCsAlTOuW1siLtatbqYffYDpc4Ca3VpFG9q9WPblQUv6D2XaTGUqDRE6oRkXLTiIKANqkBubozGbPDsQldc0BmH8Mdf/JAhasR16Xs9gVdEY94FH4dmAFhpJe6IcJOkv7u2ligBZR+V8trwvSxI7T6eFybtB8oE+4eX/fQqScPYLHIzCFEpSZfochryRaYdGyak15TC3q5Qfc8INK+2wSXs1UALjaIBgc3sYv9OFFUurHcedffgDeMjPb3XmcOwj1uhDTHtQV08QJN2k2+bjC/zmyH/Ozb41OIpfHAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KrcOhUeY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KrcOhUeY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVBq86PqHz30hP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 09:42:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE42660097;
	Mon,  9 Mar 2026 22:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730E7C4CEF7;
	Mon,  9 Mar 2026 22:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773096161;
	bh=Bi9d4BIltjknxiuJZWqQAFnQ+2ZabYGuk5I/WsLd24g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KrcOhUeYULkAa3PBQjSSHs58v7Hcn94H7x3qQR4MndDKmYbW8w0B6yl7bfc2N6Luf
	 nf9WZuCNteU3QefcaFMgPQZSRB4T0YBp+sS3UfCyw72cTzbiH2lLegpKhPgjmiDica
	 cVa6Wdxzq4MD1j/y8DAZ0XbpaamOjY0t9BcXuDMAALpD1lkn2JXNWda+Zvg3ILqart
	 XdArarED5DiPpFqeOeHnRQj3Nm77e0H13cz+y6ocON/fBXuzWyQ3a1XVbt75f3I56h
	 dxSbXRT6e0jR1EWtL1PTuy1mHGUpF2n9KX81EVCARAQwyNydWB3Nf+aLlJVejkhvbE
	 iiLur/UcslNZg==
Date: Mon, 9 Mar 2026 22:42:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] ASoC: fsl_sai: add bitcount and timestamp controls
Message-ID: <9c7c407e-ced4-455a-a8a8-54b42f706130@sirena.org.uk>
References: <20260309083530.2977163-1-shengjiu.wang@nxp.com>
 <20260309083530.2977163-3-shengjiu.wang@nxp.com>
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
	protocol="application/pgp-signature"; boundary="Plf1lSLyaQKV9jG+"
Content-Disposition: inline
In-Reply-To: <20260309083530.2977163-3-shengjiu.wang@nxp.com>
X-Cookie: Nobody knows the trouble I've been.


--Plf1lSLyaQKV9jG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2026 at 04:35:29PM +0800, Shengjiu Wang wrote:

> +	SOC_SINGLE_EXT("Transmit Timestamp Reset", FSL_SAI_TTCTL, FSL_SAI_xTCTL_RTSC_SHIFT, 1, 0,
> +		       fsl_asoc_get_volsw, fsl_asoc_put_volsw),
> +	SOC_SINGLE_EXT("Transmit Bit Counter Reset", FSL_SAI_TTCTL, FSL_SAI_xTCTL_RBC_SHIFT, 1, 0,
> +		       fsl_asoc_get_volsw, fsl_asoc_put_volsw),

Sorry, I should've spotted this on earlier review (though surely you
will have seen this on running mixer-test?) but these fail:

# # verdinwm8904.2 Transmit Timestamp Reset
# # 0.2 Transmit Timestamp Reset is a writeable boolean but not a Switch
# not ok 366 name.verdinwm8904.2
# ok 367 write_default.verdinwm8904.2
# # Spurious event generated for Transmit Timestamp Reset

The reset controls should be volatile, always read zero and not generate
events as a result.  The name needs fixing as well.

--Plf1lSLyaQKV9jG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmvTNwACgkQJNaLcl1U
h9DhTgf/b6Fq0WRx0MvwkjrEGAXyqN6CpfUfSa1kTG7G5mb6TJq38H1+Q3HrX8cw
qmAB8PI48rrS27plaXDnc6FVk7aB36jwwiPE4dAB5rPButctaNZ4PoTNAzWkHgNk
JL0kBy+gXsHDr4XdxdyYBocdV4szw6a6YCodA26NlOlxQAwTx/YBbb/q7MBYW3lz
BYQG/XpqICeGP5Cbf5trDgvGUgoZw5zm5IfNADgZpW2MaVDfM3fvsaXNU3aYq/oG
LNFfrXg9VGDE4cVEkb7uXz30tUpF06l/m2p7RQVDYMxlx5JhH9pg9wjJs2CPga3r
LSsxE9jFO8IkadpZEzy8kw4DBOlioQ==
=iFMt
-----END PGP SIGNATURE-----

--Plf1lSLyaQKV9jG+--

