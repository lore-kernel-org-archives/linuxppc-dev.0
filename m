Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611460A3804
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Nov 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QW0De9hp
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jS3Z31TrHz2xGr;
	Sun, 15 Nov 2026 19:09:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794730187;
	cv=none; b=VEW2dOPihiniZCAsdtc9i1x9Vi9Q9uL0W5P/rrDdWQMroDF0R/B6+WBxozhIc9iqQQRxyLwWjgtTCfS8K42DH1a/4pIOsn1QGnMerHGCXEZGzVZRNLJQLsHOGi1mdgFaFjY6GXG3+oZ5TCZxsCsjVZK1yTmU/jQeg9PQrR+PoYMrNeYPadyxBni1m8MOGUxN61D+Z8Qp3iBQRaHqCuuht8Te8roVkUVCNUm+VGNGBd0rAHrUvC+NsOty6RBYFPN7IGMRpGYMC6gAos5wtS1ZUZ/23RlMIZ1oqViG577xHwy5jF5jQDxekCYWdnSGjoKQikJ4gHgfTIYyLzxijJTq7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794730187; c=relaxed/relaxed;
	bh=PVABOfS1cEurhkzfPgNW7y/m51HDn6cHLPvuC8JTSz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bto4cgUlBsFcdDy/uKQGOn9r7G6wCSNvrNozP3YPH1Ji2lPuh9uBCjUZTAUQzqhUeY2o8I57S+doaAS9Sr+j1/ERBU8RSQxiMYEXfehS9WVlcm87A4nfhsEZIzVg80zbARdY7OWVeP5P8UkYg2PUocTE7BoUjwUUveJgqgycoH4a0Afik1MiU3VfcIaEi95VIYRz6esawRccfqV5GYKrH46kkC8tHpnIYfIMQoIa3Z6sOcdYp+TKH+/iwC0QA/o0dkf5X8tlmDqJ3qxEt4TAk765iqD50Kix7PszwzUetXPwE9bM8/zOi4S/am30pfwHPEDE+r3j/+ROQ4hK5nk1sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QW0De9hp; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=alx+linux-hardening@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QW0De9hp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=alx+linux-hardening@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jS3Z168Mxz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Nov 2026 19:09:45 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D28761153;
	Sun, 15 Nov 2026 08:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407B71F000CB;
	Sun, 15 Nov 2026 08:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794730182;
	bh=PVABOfS1cEurhkzfPgNW7y/m51HDn6cHLPvuC8JTSz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QW0De9hptRjy2KZNabzhVfAHPwOkxjEeSliCim/i93Y3NDLIDeP14qCa9DdzlpqUN
	 zmDB37zlSxtnqXhlHuRBsYIeMT8izcsL1Q1ogX8eDw8d56IV8v6EAQ1K8A18Dz9+Se
	 UrcQjgxq5oO64Q9oVPCvgLGZAZWAuCugGufIWUNue8BCV6qUue5nHaI5vxUlzyqVQ6
	 CkBfKHzgMEmJZ3jKqixj9RW1vIXt+2lDHWlcjDjtx7e7lRcv+7aqhqCXozDYGRcpjz
	 XVA4gHNBjwBH3+2q06vD2Zr0Ix14icSdyZSz7oYBvJl8yfGhX1GKchRHxWVDIdzgte
	 Pd+WZIExrfYUQ==
Date: Sun, 15 Nov 2026 09:09:37 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <avloOrDZrYtSsQUN@devuan>
References: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
 <5wxy8x3a.ritesh.list@gmail.com>
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
	protocol="application/pgp-signature"; boundary="veg2gn75rklmo5ow"
Content-Disposition: inline
In-Reply-To: <5wxy8x3a.ritesh.list@gmail.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--veg2gn75rklmo5ow
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Alejandro Colomar <alx@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] powerpc: Fix off-by-one bug
Message-ID: <avloOrDZrYtSsQUN@devuan>
References: <1f7d29cebba5823400ad0bc5d95610f05f55e2d0.1794686962.git.alx@kernel.org>
 <5wxy8x3a.ritesh.list@gmail.com>
MIME-Version: 1.0
In-Reply-To: <5wxy8x3a.ritesh.list@gmail.com>

Hi Ritesh,

> Date: 2026-11-15 11:17:37+0530
> From: Ritesh Harjani <ritesh.list@gmail.com>
>
> Alejandro Colomar <alx@kernel.org> writes:
>=20
> > From the surrounding similar calls, the intention seems obvious: this
> > seems intended to check for a prefix.
> >
>=20
> Could be, however the existing code is not functionally wrong either.
>=20
> I agree it would have been nicer if all three were consistent. However,
> x86 handles the same parameters with exact matches, so if anything "auto"
> is the one doing the right thing here :)
>=20
> But making "on"/"off" exact matches on powerpc now could change
> behaviour for someone passing e.g. "offline" today, so I'd rather leave
> those alone too.
>=20
> > However, I do not understand this code, so take my reading with a grain
> > of salt.
> >
> > Fixes: a048a07d7f453 ("powerpc/64s: Add support for a store forwarding =
barrier at kernel entry/exit")
>=20
> IMHO, I don't think this patch fixes anything functional. So, I don't
> think it will be correct to call this as: "Fix off-by-one bug" or=20
> add fixes tag to it.
> And so, I would suggest, we leave leave today's code as is, based on the
> previous reasoning.
>=20
> > Signed-off-by: Alejandro Colomar <alx@kernel.org>
> > ---
> >
> > I found this while looking into replacing this code with calls to
> > strprefix().
> >
>=20
> For your conversion, I think, we should keep today's behaviour as is.
> Maybe streq() for "auto" and strprefix() for "on" and "off", which means
> there is is nothing to change or fix.

Thanks!  I'll do that.


Have a lovely day!
Alex

>=20
> -ritesh
>=20

--=20
<https://www.alejandro-colomar.es>

--veg2gn75rklmo5ow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr5aLkACgkQ64mZXMKQ
wqniqg/8CutNlENieQ6OMt7rTaU5Ueh09KVjFCccFeN531lxYl6K5HohatSFUlMt
gIvBtcGIufRtv1+coLDMGQl60zD2JnKFSDPio22TZdBpFDSJPz0NE5rtUT5wEqI8
uqB4kESHZ7Q0HfM9fMNXYCWQNhzH9t0Z7BZWOOYcmegNMGadRicX9L7Uzjk54eKm
sOiZghHRUWDapGFe6neCABjMT0Y1rwWrLwOh4cEIKnK9/ZoVdbJNaa3j9xv9Gaw/
pIF/KLkIworTgnBHQ254B1FNLE5oVE7zHO8FBiL9san+r3IKaHvE8gPBCzPnCFFG
WbUrtXhDxb9at02GQhFxiTWPhz1U+Mh/5MLy8F8YUPb+e7BVftmsKiVgC9T1eSKg
zaow5hwdSlEF/6AcpmMRNKjKljFw+jK81LdZz+iZui44J4rB9t0yw0esJ+KgVUxP
WXy80FGBBAkSygDStuz765Rff2ekjSdhaqFoDPheTOUekH9QiooE6yAqPWvTRUOX
t7Ij+RPhsvb/Q34N0Uo78wxpWJ3H49prwRUWKs30UNGco9zWR1AAzBYZGFQ7KM15
L+pGkMggrwQP+T+qIfxYPkKmTzULSllUBrLaTmnNludwihKfxF4ImmnawooiLQu8
XkcIyOkD1oy95spXFeLC+daHWjpwOo+A7/aIM4JhmbHAgdJhEYY=
=9tNy
-----END PGP SIGNATURE-----

--veg2gn75rklmo5ow--

