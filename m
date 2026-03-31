Return-Path: <linuxppc-dev+bounces-19095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DCC109B468
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 13:19:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flTHW4S8qz2ybR;
	Wed, 01 Apr 2026 00:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774963191;
	cv=none; b=YrQb1s2qdFZN5Cs6O6oKDo/q9+I/Q9H59xD2LX08IiH3wDuRy+OARJoKCUiYldGeK6CW29SlBHfd8CsKuheU1eH9u87dZNCEGR1hUHbIo37w1MEBc39hlbMDCBOAWsOXoU1rQ0rhKkNjX6SB7ji4VWQYa9SajFxUMluLomolGxAkxF1PYkWXo5qDvyVurXMgiRkjNpZT0vzzD2ueeWxZEsq6oYd9qvbGjuv6LgSKljWAk6GG1pCP0Je89cnyBxGogCLW5Qog9hu54aUe5BFNQ8UkivQTA+xl30TMh5bpPQbLsj+cxEZopGxnPYME1vguaEXjG3ehD5h1eKQbngjNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774963191; c=relaxed/relaxed;
	bh=22KiDzamP5/JJ4fkByP292JhpMOwmIzC6E4Cs1nxRpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEC9k96s+QLLgoZDFIMVPcXOOPqUKS8JqeGw4dgu/d14lA6rZgOnEKQvrNw7+f43l6Xt9KJXb0uZNhVtO++jdBr994XW3E5kpDHG6lwzx8UsReKX4DWDtI4EwPJfirlnkqwDJX7SepigSZwFStZtbLJMx5J4YBJzIBvUq0wjUodZ2QN34Q1Mn7AcMjitAJeaiJWGB8niivHCnVlweczHRtl+PRcVfVgDZ2GDELOfhPyB4niaXQo/b8k8077RjLXD43mrWoJr+dHlpL497KeE4gqauFDr4qRIgUabbsiOO6fr5pqps9eE/zSzgbItISjgxQx1HCNcMpLLBlC42+ex/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P8tQsHyN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P8tQsHyN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flTHW0LJhz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 00:19:51 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 791F3416B1;
	Tue, 31 Mar 2026 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D837C2BC9E;
	Tue, 31 Mar 2026 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774963189;
	bh=sIID+jaUsIfUWRX3hs9dHmev488+DUCMHepk6xUBk0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P8tQsHyNHdb54EayU3ym9ZU6cHAdWi8ww+6PDsPhmdjvLcyxT6nu0+lKWb22lZ7oz
	 Y0I1FKng5Yd4AhxJwAGykuCjzoiWAH7c3MLsgoOKBh8sE4ax5Gt4UyfgizDASHCaeC
	 IUk0Wrb3h1eprQnLfuiYtyVCEadCrcpJKqXQYyOP1rDTjnXiFnbGb9fIdwwhc1uu7c
	 khsgz3lAV51BRU0mxdvC8V8qNI2pk6r8JLZeExTekL1FvgwGQmB9q1tWso0woqp12B
	 YwawlgVJG/s1ImnMZ8Z6SgAZUMwc+BXLOp5HWYvPZrt4EfNiV/OjBn8BEltgZipOH9
	 qr2OhaAphVayg==
Date: Tue, 31 Mar 2026 14:19:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com,
	festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
	perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] ASoC: fsl_easrc: Change the type for iec958
 channel status controls
Message-ID: <317fc80e-ec80-477d-80f6-53c395de4b4a@sirena.org.uk>
References: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
 <20260330112555.3637002-12-shengjiu.wang@nxp.com>
 <be591d2b-9429-43de-8d5b-357a503607d0@sirena.org.uk>
 <CAA+D8AOsCg9ZO0f974Ds3Vev8uSVj52mano=vG+Rvrw7dJ8faQ@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="LOpMmFd7XkDIqfWp"
Content-Disposition: inline
In-Reply-To: <CAA+D8AOsCg9ZO0f974Ds3Vev8uSVj52mano=vG+Rvrw7dJ8faQ@mail.gmail.com>
X-Cookie: I just had a NOSE JOB!!


--LOpMmFd7XkDIqfWp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 09:58:22AM +0800, Shengjiu Wang wrote:
> On Mon, Mar 30, 2026 at 9:23=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > This drops all the checking for changed values that we used to do so we
> > won't generate notifications to userspace.

> Yes,  as the type is changed to IEC958, the notification is not
> acquired by the mixer-test.

> Do we still need to add the notification?

Yes, it should be there for all controls - it's just that mixer-test
doesn't have support for the IEC958 controls wired up so it's mostly
skipping them.  Someone should add that!  :P

--LOpMmFd7XkDIqfWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnLye8ACgkQJNaLcl1U
h9CLHgf9H6BCGswe9bKAG8Mglax5K/kwoFNSVlPMHoaxjD2XXCtXRT4vuCmA1HlT
4F0m+YN8T3TcYmmjhr9IUL9+zS0UZi6XHfMmz1gQdoGHX+FCc3F684SGCGsf+LkZ
ikgldtta++E4DZHoekd0bSx9tQzr77V6lIZqQHEg6+/aDYdUeco0dHfVFh5OAbHz
pZm1Lh//0A8LHz6oJYAyOh5lSZn6zT1DvT0gpcyriRCk6y2Y0m4F7Testz1qanxN
QUrzr7Y0XZPXMs62UqI5MbNEcG+cCPlfGwL4hdqM0bNh71lsTc8d1ujbp3eHYp3Z
MKDGPTbKoZfbfuFY9u5djB8OvjYBug==
=cskb
-----END PGP SIGNATURE-----

--LOpMmFd7XkDIqfWp--

