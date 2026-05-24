Return-Path: <linuxppc-dev+bounces-21442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7311CCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 May 2026 22:07:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gNtRQ508hz2xRs;
	Mon, 25 May 2026 08:07:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779660450;
	cv=none; b=C4EsNCXIa6nL9sA19Nr6AE/kzWf1o6jD7f1c8x0bu8WcgfqfIJikCkwMglXjgx0+D5b48flILcx1HmsB4qBPrzB1iX33ayKe8bc6Q3pRwkVy94cHtE+/3zBxFR53QnBkL4DveIPnai1wypxSdO+HD860mtaJJYXCLnZHA0NFKhBvkDKW6UHGDxLPsy7guBkRCwwyfaS3iSVv4hg8av6P29h6HiiI5Y1fjoQwBXT1kf5pjVlaoFPr+a4dK5AwPF3TKq0Y7xP1zgIJdaaVawrO1uQCyeO5duKfl//33jAlYKWxqdzLz7WsCclC43GKFInadnUX7yS2BPTBpcle2qApUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779660450; c=relaxed/relaxed;
	bh=rKvMurOqzcM6jN1JCFrw63qcuZKBoJLc4a5ZyGbaPZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzLpc9HNbwUBqilCqPWimvDPG3Or3Z2cSySO+3hovptrGZbflyUT+oL8UU47HSGeJL9KUXyPmHXbc87JtP/CQD9RdSvIxguaYRfhfGjZcM7vGnK1l6TeUtzUeXDeAGyggo6vuYiLJFLcfrIjeDQ9H82zVAjrUer5W0HH/eBJ90HTKk4B1KFxnXFQRXENMPhdp9xasyrtW6aTx83iF36uetYpJ4mqQDIvIdmv7rIMCWcm5oDjBUpDvQ/8IpjTPgBeWMmP4svYFrXrGmN2hAIJHc7Nx5V4kBoAcSsGOhGpWpllABhGR/caFFHy+x7LP5/2KTV84Im4wg2hDmOZ0yARbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtnZfh8/; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WtnZfh8/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gNtRP5qmjz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2026 08:07:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9D12840974;
	Sun, 24 May 2026 22:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A4A1F000E9;
	Sun, 24 May 2026 22:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779660446;
	bh=rKvMurOqzcM6jN1JCFrw63qcuZKBoJLc4a5ZyGbaPZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WtnZfh8/+B63C4ETRE4EtdchHICjLmLltzrI8n19dKyemPW0MZ+N4dIMhKamvx2Z0
	 4Jn3fngpCM91ORwYdNPeo1C1cHBvIrnWqXM+yle4keCED0K0yhxxVCBjlp6L5QxHZY
	 3621YXuDTg0nHRt6KWmhHUs2/cJ4uwa29aurYOyrblGnW1WPzqEFptUn9BBLq0pDlE
	 SnEIN+3IOwY/wZeMOA/27YtKrH9NTd7+7jY4PWGF7gO2I9geUP6/sPdqeqU+nuSbwL
	 4q86Wnp0kEJ4vB4lpP7rVYJQhtTNuZaybnJIyFolIv/Ncz5HuxD1w2rqKtslbi0GTJ
	 3x3YnvSiFFXvg==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id 54AA8B5B196; Sun, 24 May 2026 23:07:23 +0100 (BST)
Date: Sun, 24 May 2026 23:07:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: eeprom: at24: Make VCC supply description
 requirement optional
Message-ID: <ahN2m3kCbyTUNXzZ@sirena.org.uk>
References: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
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
	protocol="application/pgp-signature"; boundary="KeG/eBaaLLasNpSH"
Content-Disposition: inline
In-Reply-To: <20260524080533.8749-2-pmenzel@molgen.mpg.de>
X-Cookie: If it heals good, say it.


--KeG/eBaaLLasNpSH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2026 at 10:05:33AM +0200, Paul Menzel wrote:

> Some platforms (e.g. IBM Power System S822LC (8335-GCA POWER8)) do not
> describe the EEPROM=E2=80=99s VCC supply in firmware-provided device tree=
s.
> Using `devm_regulator_get()` on such systems falls back to a dummy
> regulator with a kernel warning:

> Switch to `devm_regulator_get_optional()` and treat -ENODEV as =E2=80=9Cno
> supply described=E2=80=9D. When `vcc_reg` is NULL, skip all
> regulator_enable/disable calls; the hardware is assumed to be always
> powered. Linux now logs:

This is not appropriate unless the device can actually operate without
power, any driver could be used in a system where the firmware does not
describe the regultors and it'd obviously be pointless and error prone
to scatter bodges like this on every single call to a regulator API
function.

--KeG/eBaaLLasNpSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoTdpoACgkQJNaLcl1U
h9AQ+gf/U5E4/c2Zku9iNJSh3o/PFohljPgzjkghjbNZ5QVK1QDF28o8gMTU4LLv
mSj6i2bYMA/wiFrCdy8sO5iLMgnzgD8KGe9evXbxxbI2vrnsr4Hn8F2/EvKtW1wA
rF0h/DBVoBdOYAuwSYInDgS+Nih6sOeCr5yvBQT0sGAHiwz52wRkTCSCKVVuA3Cj
h+99OB69R67wvTETIZyQ7hgCSPEX+wu/4KeHv2S8aa3krQt9fNedXH5YsXe7/zIF
wZCONiRFuQ4i7UEAwpWz/iOK5PGO9Wu3daY7JxGrJNI5q/61gdrkK3aGqqrrcA/x
VZ4nFfSHEzS1tejk5ehf0A8ofSOKFg==
=yWr/
-----END PGP SIGNATURE-----

--KeG/eBaaLLasNpSH--

