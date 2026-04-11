Return-Path: <linuxppc-dev+bounces-19645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5824F3ED42
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Apr 2026 10:40:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ft9Dy6qnPz2ynH;
	Sat, 11 Apr 2026 20:40:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775904050;
	cv=none; b=jb9NgkuaJ7XJAT79FpKDbpQvmdIEitkR1V61fFk4L8211JSieXhkG7ZxV1n1nP2frvkJaNIY+cRyJMwzXoLHGRukWHHfSp4gkF1nfC9Z4nOCbE1hi6S6gPzwQDQXZDnVBCtHebh/9okeukpqJIFCRkx9i3s1zG7cZ151uUy+axsUFA8Es+Yr6yxLOa1Ndwfn7R94WE0I1DappCSd4VZTmdyprrSav7/mYPxMoUev8IvdQJyfQQNZRc8dmLSz07EcTp0ForctYTRcJfFu2EPX62dxhTsFy8Duf6dOasbxa+bWQb+tK/DtM2CjeYtYn5dFxx/Uk9Kv0th78zF4i2dV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775904050; c=relaxed/relaxed;
	bh=UgsSydsp5oPLb1P/RjIJwmuiGaqUjUz2j8uHNwmAQes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dALAeRo3iIlmU4toJ04cV9KNZMaNSnOwKfBRfmUtKdUUZZ6reH+UKc4LamvTgmqddET1XzyVwPVTJDgjubRvQoUw7VXCsuphgkHSq351QfKnE2qDgBybHBb+Z2JhnUlTBY86zD7veURfvBQ7wW2GNDmHQy0Alb4PeW8unzXf1gm7KP/BMkB+mmU7lVdkx5Dv8jy/xEmfr97YXPFkaJ3xg+/Se8s/56m/xY3oxe4uxGrFLFovf9TjEH4IsusNJJpWJ+1j62vtxSGiugFr5C52guN4OuOreuU8jlHRlSTCiQGRUyHeSzsLaScEIs34OB/czHvgRKG1F2UAOhI28jtmnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EgWv0wKF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=EgWv0wKF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ft9Dx3z7Bz2yl2
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Apr 2026 20:40:49 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D63A260142;
	Sat, 11 Apr 2026 10:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D47C4CEF7;
	Sat, 11 Apr 2026 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775904046;
	bh=61nevb5U7KmJ6GlJeZz+DxBkLNyhcBVs6JVbc3G0hRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgWv0wKFO9krr6M6Xkfs3b5boJvhz+IUUDY0knPmrLlxJEZBCNqIuOkKZ6lrlwW3i
	 1voGar9s5isgNb59sAJNBA0QLDA7P5P7aCIuRXGkrWxLETW+rhU43ymy1obXU+E4Hu
	 vQ07EBaeeNjo7j4d8wLCqPYNLj3o1HC7jiquV46Ek/wnhCQGp83SIcc15t+JASGQaU
	 AhnMsrN3qenIbfjRucmJxp2NKncOBNWR0rTZF0sRRfRgl95VPp+680nHHFqwslAmIa
	 8HzIV0MPc0a/6MuwY1cmPHOL18xYgHV7X7+KLeG9cpIiToYISm6sbgtMq83EEgEOYF
	 Me/AkfacOtr6w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 6F6A01AC58BA; Sat, 11 Apr 2026 11:40:42 +0100 (BST)
Date: Sat, 11 Apr 2026 11:40:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, Frank.Li@nxp.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: imx-rpmsg: Fix ignore-suspend-widgets only applied
 to codec DAPM
Message-ID: <adolKj26DFqZ-XTi@sirena.co.uk>
References: <20260411072439.1125664-1-chancel.liu@nxp.com>
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
	protocol="application/pgp-signature"; boundary="Wxo/GoZ8NwX6CkGC"
Content-Disposition: inline
In-Reply-To: <20260411072439.1125664-1-chancel.liu@nxp.com>
X-Cookie: You will be divorced within a year.


--Wxo/GoZ8NwX6CkGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2026 at 04:24:39PM +0900, Chancel Liu wrote:
> Currently the property "ignore-suspend-widgets" are applied only to the
> codec's DAPM context. However, some widgets listed in the property
> (e.g. "Headphone Jack") belong to card or CPU DAI DAPM context.

> Extend the handling so that widgets which are marked ignoring suspend
> are looked up across all widgets in the card.

> --- a/sound/soc/fsl/imx-rpmsg.c
> +++ b/sound/soc/fsl/imx-rpmsg.c

> +		num_widgets = of_property_count_strings(data->card.dev->of_node,
> +							"ignore-suspend-widgets");

Don't we get an error code back if the property doesn't exist at all?

> +		for_each_card_widgets(card, w) {
> +			for (i = 0; i < num_widgets; i++) {
> +				of_property_read_string_index(data->card.dev->of_node,
> +							      "ignore-suspend-widgets",
> +							      i, &widgets);
> +				if (!strcmp(w->name, widgets)) {
> +					ret = snd_soc_dapm_ignore_suspend(w->dapm, widgets);
> +					if (ret) {
> +						dev_err(dev, "failed to find ignore suspend widgets\n");
> +						return ret;
> +					}
> +				}
> +			}
> +		}

This seems like the wrong level to implement this search, it should be
in the core.  I'm also not seeing any prefix handling, the widget name
might've been prefixed at runtime.

--Wxo/GoZ8NwX6CkGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnaJPoACgkQJNaLcl1U
h9C79Af9Eww5MqUM4l2uWRZsMS1+DeTVXwJPdg7NgJgCOgzNWNI6hP6w9WE8X1BG
Ulvj0GOSZy7HDwLahBChs8AydyTxc1qaR7qNljsVj0Bb7zJmVIkHa8nuqtGxsDux
nvwnyybQFXambSXYfK4rbsUrF1XZ03NYnV5QroMIa3GsfyFsdK2otKJv5SNmgT82
pG2VFlhxxd/uocwyG5CqWxj0bTija2Qf0mlmbJMb971kafdmhRUWLFuC8FKxKnTr
POxLHJO4V3G5SbdvtZDMYqLLAn3psbWCPIkMXMy5krUPef/qh+wCVAwMapMnpWsV
WOjblDfXWqT7+DwxsSH8yOpoGJ+d9w==
=Y0Br
-----END PGP SIGNATURE-----

--Wxo/GoZ8NwX6CkGC--

