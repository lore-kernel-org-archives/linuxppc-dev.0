Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD78606A32E
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0iRscL1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMLNm1VSRz2xrC;
	Sun, 08 Nov 2026 03:00:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794067224;
	cv=none; b=XkgXortOsDRd1CoJbLjZ9b8qs1jm9qOKsQHulBMgizHSJwwh8jijie9RrioGLcDfSHTtyPIp9xyDJ3Pu+tdwgQgw3lDTzjB58lCK+rpkBSpw7sMLw4gYcU8VmorOy59H346V3uqubu+K2aUjkqVcuycCJEmWvb1JKO+7JaG1TL1k1Y52ksnr2FLatVvoSTtS9K5WO9YjxL3EgCsi1D69hgfQNEliOLTw2YHJbJeQbcrm7T8CgmTd7kgJwjGsM/392WIlKT3ZUL2rLm+Re0BKx8PKzXUjV4sXhNWDp+NXLPD0B1f2BUJl2kA+/5ha1ukI0doan02LfafghmHjiHxI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794067224; c=relaxed/relaxed;
	bh=ArOxjA9/kNed9+49iETydsddSuLzELHsS2ZSf7G4VZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRR2zwh4n6qBnjzxhabxlekkCvunuCVr2fKDLkQfyAQotUHJgE+7nx6xxiu65kjWFXIGcssjmwkPIcEJ4QbeoxBTd2VZ2NFkdHAqF7+637s/yWKka/UJnLeJFxL+/6wi+nSBWl0jI20ToVfnOoAUdsjCGNpRi0YS4puaAt3HuCJAsC3dFys6uOXGxRM1oGV6o+dM8N75xi07Hv8E53/5HzBpro/JnRDsrzgbbvH3RuvEv7Acl021zK65V0G3s50LDT/9+PdzbGc7MzsnMu6eOBvlJ9JDFkZsACBdGeCTI/DXNw9jT8eQL8P5w3r0WIRi7o0SXe8ujBa0G1S67iJkiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0iRscL1; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m0iRscL1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMLNl2KKSz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 03:00:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 504CE409F2;
	Sat,  7 Nov 2026 16:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCB71F0089F;
	Sat,  7 Nov 2026 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794067221;
	bh=ArOxjA9/kNed9+49iETydsddSuLzELHsS2ZSf7G4VZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m0iRscL1Nf8EfRCl/yA11zT79f5EHr+rAOw79/Ks6ImTlLGyTQSUFugaZlcT8yNj3
	 9cvfc2TvrORa0cccyrlEOObHXRzeHQ4kiG1F94M7wIPPrYoSp2Ct65yHqMNHAcb7tz
	 7lYPcoP6Rv5fO8RkLCnFNdoWcT4LuvfPPgP1W/fsBst9OoYpWwoOkM+iUsGI8p/yE8
	 PdYGCat4cK8OtSq6w1Fi+km5PQSkehP9DBGrPt0/W+sg9dveKMeY9zGUDcZdygF3Vo
	 a5Fw1/Ps2PRfXgfYNI9j6FtW5gr+sdGvBx1TyD9s2i1JQsuRG0DxFtSbIDcND/sHW4
	 /tMm+7a4adPEA==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 0E5842B35F00; Sat, 07 Nov 2026 16:00:18 +0000 (GMT)
Date: Sat, 7 Nov 2026 16:00:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Chancel Liu <chancel.liu@oss.nxp.com>
Cc: shengjiu.wang@oss.nxp.com, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: fix error handling for DMA channel
 retrieval
Message-ID: <7a9ae82c-838a-4543-91f6-e4f6397c4e91@sirena.org.uk>
References: <20261028025921.4155551-1-shengjiu.wang@oss.nxp.com>
 <11ef44f7-e268-438f-8a42-c3bb89e42cfc@oss.nxp.com>
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
	protocol="application/pgp-signature"; boundary="0T4D+cL7iXVxGEVX"
Content-Disposition: inline
In-Reply-To: <11ef44f7-e268-438f-8a42-c3bb89e42cfc@oss.nxp.com>
X-Cookie: Whoever dies with the most toys wins.
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--0T4D+cL7iXVxGEVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 01:50:46PM +0800, Chancel Liu wrote:
> On 10/28/2026 10:59 AM, shengjiu.wang@oss.nxp.com wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >=20
> > The original check used `if (!tmp_chan)`, which only catches NULL point=
ers.
> > However `asrc->get_dma_channel()` returns an error pointer. The NULL ch=
eck
> > will always succeed, so replace it with `IS_ERR(tmp_chan)` to correctly
> > detect errors.
> >=20
> > Fixes: b4136c0d69ea ("ASoC: fsl_asrc: check the second front-end DMA ch=
annel")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> Reviewed-by: Chancel Liu <chancel.liu@gmail.com>

Note that if you send from an address other than the one you're using
for your R-b it'll be ignored by the tooling.

--0T4D+cL7iXVxGEVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCau9LEQAKCRAv73Ows9A4
id2uAQCPedGJPX4573rTGqBo52iWaNHcKDS6Cnz2BWtcJ4ZmVQEA5EwLlQBDtobL
U9++hIw2RYpFKi+l4LjOjVTs6aecsQs=
=1zZq
-----END PGP SIGNATURE-----

--0T4D+cL7iXVxGEVX--

