Return-Path: <linuxppc-dev+bounces-25087-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2BFC54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 10:06:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9lH51SH3z2yYd;
	Thu, 30 Jul 2026 20:06:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785406017;
	cv=none; b=dWAD1+SmSKIXO93TS6DUgsnMbjL75uDHlevSj1GtGRhZydm03cZYTWfD2CjgFXkObfCcrjuJ4hR2+mhuc8URSaPBqc+Q+nEfEFm46k5MC2/sVjN3EjteA6AdIi88HN4C3kZcWObYXf7f+y/lEtPLllq0U1L2E69riWZjvudBTdYe/wQ6waGM9XUkl4cpq2Laeo6ZGeR70B/RTuPFaIxoQBD5TYu4/JcxcE8rql2JUf32dbjSe1zwx769Uq4dl1mQV6mw+o6jI0w2RO0S2GQKzqDoRx1OJRApCIbL+Mde/fSmTIwefRZxGKBnRmtpmtnGqxRpFln/hTB/yaw6lfn11w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785406017; c=relaxed/relaxed;
	bh=yhLHDuip0+zsI5OkKYEBPrTn301Ecuq/RWeiHoR3Dpc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=DceDWc5K2HqpDTuPND/HmFB4dFC7c1KTprgdrG/42wuCVHinM3dR7N8+DqdAzsUqmyxePtCU/HKQVysn07TXKaBVB7q7TTWGE7++Qw+KudLH7BX5jEnyb7VFbUdfP/f5pRMjdd+OWZogRdNOGzS9xlS7Y5UQQB1X+Ky3F0qBFgR7QKj8CiZ9+3On3reJXOsLqoxPQvZwyZov7nabHyqbqWsgI3FC0H5LK+r5JB+2InkrlMBAjiRvojFjwPQs350ZDPWOGPnQen5U4RrN5G8IUJL86BtgSIsTF6q5s6LPiZ5DT9h2zBYBOxGrHpmg4cZV0gQWn6PNGphYJMSC08RuvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp5Gt13V; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp5Gt13V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mwalle@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4h9lH42TCGz2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 20:06:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id DEAC743536;
	Thu, 30 Jul 2026 10:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4A83D1F00A3A;
	Thu, 30 Jul 2026 10:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785406013;
	bh=yhLHDuip0+zsI5OkKYEBPrTn301Ecuq/RWeiHoR3Dpc=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To;
	b=bp5Gt13V0gxHIJJENcyY7zNAxctxaxAzauFwSzlQfZkgEY3jPeZCL8OK/i6iIAoAF
	 7PJeQz7bmECZdxkB+3vGDDZ3rqEr8YgPLD9zqNjJu38cZxiphlohm8RzJXCWB4L3Lj
	 9E1b0JjBgz/ddrzIDQ2cumaQ378rm83c7Fe9I7e7CjFyuUbTmEC3kp8bpBeTMFZu4w
	 KtuuemP7G7SzO42aQ/Istf4oxlitv0RUvc2ZjlzKup1f8WUq3sRJ+2Qo7qK26JqyAz
	 B2Ld4kylkkEYo+Jz6/PP3U0IkF8hOHVhUGCoDyF1kSU9XwUsIeeQM8XnqKcG1nhr3i
	 fi6QPvA41w2Yw==
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
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=401f54128caebe484a2efe5c68e340e7f3ab1aad6e80211f87c84925d5e5;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 30 Jul 2026 12:06:49 +0200
Message-Id: <DKBTLXSZPBSV.2ER6IB1B83LP3@kernel.org>
Subject: Re: [PATCH] powerpc/configs: enable CONFIG_RAS to fix EDAC support
Cc: "Borislav Petkov" <bp@suse.de>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
 "Takashi Iwai" <tiwai@suse.de>, "David Heidelberg" <david@ixit.cz>
From: "Michael Walle" <mwalle@kernel.org>
To: "Michael Walle" <mwalle@kernel.org>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Christophe Leroy" <chleroy@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260708142725.2113684-1-mwalle@kernel.org>
In-Reply-To: <20260708142725.2113684-1-mwalle@kernel.org>

--401f54128caebe484a2efe5c68e340e7f3ab1aad6e80211f87c84925d5e5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Jul 8, 2026 at 4:27 PM CEST, Michael Walle wrote:
> Before commit e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC") EDAC_MM_EDAC
> selected RAS, after that commit, EDAC depends on RAS, but nobody enables
> it. Enable it in the config again.
>
> Fixes: e3c4ff6d8c94 ("EDAC: Remove EDAC_MM_EDAC")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Since there were no replies for now: through which tree is this
patch supposed to go?

I forgot to add Cc: stable, so I'll probably have to resend it
anyway.

-michael

--401f54128caebe484a2efe5c68e340e7f3ab1aad6e80211f87c84925d5e5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCamsiOhIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hC7wF+MgfENdhdTj7OKki2rescadT+wGOHJAi9
PeclTqnMrPxBVa382mkzdvJlRHlPMNVyAX4t3A9BO548bdeFuvZZZF/3vrmORE+r
WGxDr6EfqfGe2rTuommLUNNr9lqRrqqVayk=
=gid+
-----END PGP SIGNATURE-----

--401f54128caebe484a2efe5c68e340e7f3ab1aad6e80211f87c84925d5e5--

