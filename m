Return-Path: <linuxppc-dev+bounces-10365-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F56FC83F1A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jul 2025 23:22:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmtbX6Fxzz30Vb;
	Wed, 23 Jul 2025 09:22:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2404:9400:2221:ea00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753226568;
	cv=none; b=RuRjFH1YVDB5sDeDRerWSMpUmiYJLDWsWKiq16RtT9mCmLMfvGWKw9ML57TUqzAU6oLk6QIWtDK/7/0fa0PvS2iO9VKBxrxxQloztGc02bLYLUwtWXzoMaZoQztBsubc3WWyWRJfQ2lQl5nOUrqCxc31Iqb1fwJ49GYhu/Ia7mVtuG/Ywp7/zEk2XiO2MWM75yuIsurC5qsnlALuMZIEWVdMiGH4fCTnWean1xBU4sZoklwTCDsaf4+M8O7bML9+tU8ob0xNYajptCvnGVScS7oPpKxKD14JEXbsjLSD2socs31oliNJ8E0k/O9aZnjL5zZMPVdZHDel6ngU8Cpk7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753226568; c=relaxed/relaxed;
	bh=I6+4AojL6apT7pBl3Dr61QWpp9cicoMY/IflLlo6moE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRoUPEeGqhmu4LO2dCE8ONSw2ZeYZVFs6EIO/9hEFN8j/SIGfuIC0O1Y7xoK1iqN61qUVf1s8FtHBRfhzIECCNQy6E0sgK1vZRSTaWvOLzGTrS/bCjRDD0W4si9poC8xpFY+aTjZCMM8rxQhnRbMkGollmzmQLWbge0QD9j4hahlnDUSkZiW+Na3Qvkb6s3CGSMB3kI0zQDoStaKUzsDtY+PyOwXsr9C5U91IpO7n4hasyY3y1epTY7+cjxjD2km7KstFCThaa6mdMXCy87iabvLO/Gt9fKAhAayR7XDqalF62HMhJsZGhH2+blZxN7u2OmJ/ih6avOhyZ4VLGL61g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=hkgaunPK; dkim-atps=neutral; spf=pass (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org) smtp.mailfrom=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=202503 header.b=hkgaunPK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canb.auug.org.au (client-ip=2404:9400:2221:ea00::3; helo=mail.ozlabs.org; envelope-from=sfr@canb.auug.org.au; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmtbV70Z7z306d
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2025 09:22:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1753226401;
	bh=I6+4AojL6apT7pBl3Dr61QWpp9cicoMY/IflLlo6moE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hkgaunPKJMQq2e81bD74L0ZesWHNIWj3oIX6Bv4f/kbTzCQoDCg7Vm7fYB6QAzCQb
	 9vtweeaccFrirKsdWEkwzuShzOCWmFgFDKS9osEDVzxaMPoUTRDXmHfiBAdOKGlM6j
	 i6oh4uukm7fR+PqWH8yEAGEpOYnxDoYyIn7fsXrhtD/oLz71BrZJg1pAdBViY8eceA
	 ZNP3wy84/LCW9Fpl8j3hnWZFnyopFy+6tzJpb7f2vYxh7JGFgPt9PBji/xSg14LgZp
	 0woJAJnrEG6RdW6I3LdX5R28sD14DB9Fk3nhaC0McfAMUhXDDg8C5f0xXxDdzdAB5f
	 olPixOFMQT3aw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4bmtXJ358rz4x7F;
	Wed, 23 Jul 2025 09:20:00 +1000 (AEST)
Date: Wed, 23 Jul 2025 09:22:43 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:powerpc:tools This file was missing shebang line,
 so added it
Message-ID: <20250723092243.7056fda4@canb.auug.org.au>
In-Reply-To: <20250722220043.14862-1-unixbhaskar@gmail.com>
References: <20250722220043.14862-1-unixbhaskar@gmail.com>
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
Content-Type: multipart/signed; boundary="Sig_/jF+OHy2nqh20Km65bZTZda+";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/jF+OHy2nqh20Km65bZTZda+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bhaskar,

On Wed, 23 Jul 2025 03:29:36 +0530 Bhaskar Chowdhury <unixbhaskar@gmail.com=
> wrote:
>
> This file was missing the shebang line, so added it.
>=20
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/powerpc/tools/head_check.sh | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_c=
heck.sh
> index 689907cda996..a9cd06958921 100644
> --- a/arch/powerpc/tools/head_check.sh
> +++ b/arch/powerpc/tools/head_check.sh
> @@ -1,3 +1,4 @@
> +#!/bin/sh
>  # Copyright =C2=A9 2016 IBM Corporation
>=20
>  # This program is free software; you can redistribute it and/or

Reviewed-by: Stephen Rothwell <sfr@canb.auug.org.au>

I used "shellcheck -s sh" to double check that it is in fact a bourne
shell script and it is invoked with $(CONFIG_SHELL), so it had better
be :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/jF+OHy2nqh20Km65bZTZda+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmiAHUMACgkQAVBC80lX
0GxLhQgAoWwpJ+cqayclBRh58CAfTt4q8zaZwKDB6vTZTUPvoqVa/OOLw4a7wJHs
2T3rRx1Muq7gz5qjLFf7aaiQirIUMLk1mYCWiQ1QsVFWJ+8Nmy0zonEPP0m1Z7dN
22E7BQGke1R4C5r0rmEi5hoCUWLAitQrN2CFQglvx1IQs3DP+2lexirD0pdfBjdF
ttza1JCotNaWHjM0m6jByGlmc6dmUFjIttr8JULzYgO475QDvj/IjQm/nIRWJx5g
MWRhCk+Waz4fyT75dlQaDX8P3BfVLJldjtcu6HljwA5eSsMYYG7WKpi7mrqx+OaG
fSvKyKRhDfuRiP1KpflprETAcrkMtg==
=w66r
-----END PGP SIGNATURE-----

--Sig_/jF+OHy2nqh20Km65bZTZda+--

