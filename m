Return-Path: <linuxppc-dev+bounces-29595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BA8CCA464
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 10:27:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5h3733t9z2yql;
	Fri, 16 Oct 2026 21:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792146467;
	cv=none; b=kJL1wvLB154uzvH92PYSFhqfCFp/nhJ2CCAiwj7hllm6jUoGulz9sAP9VTdULCXXyWaRtCdvmg486o9e4rAVf2Qpez/vBanNbOkl1fBk24U976GE6R+koQTF6AKsdNYJTVSjKI/C5chdJ6Az0lYYsmbZ1Oq2wfzSqsay6zwB5O7f9ihY3z/uuN10w00BY/CgWJi/uRRCNMjRWELJ9lctgmkzImWActQu3hgsKQd8HAewsDQKQEXAWBZkRtwAsnLxnTLk1MPZVUrggbJbo1mZm/iqYCuYbx6wWnrW6buN/irgwCTDMKeVIHv1JCz066kYd14HaVEi9hFZg3JWaUMT3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792146467; c=relaxed/relaxed;
	bh=U0J00jo5OiHeBPxzEIa6F1DcCXv2U6x9A+gpdOvbR5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmsFzoVz2rRGuZnm2uOly6BaFaRlVAXzCrBBAxIeV7jW+3yV/v8zmKf6td8I9BQnexZydHMcl3+UbdmaPKxceWhu/hATExyyISpZJq0JWzDG+QZJt+pWcJQG2RDflavqLOv5WkFMKgTIXw6efOJz3DVPv5j3q6fq+VKtlLEi9GaVPxduVRTu9r91mwENRkKrkgrp0IsM2cEHWx/aVfUsqQHonL6zf+/zavoCewjjNadAWsmscov1MeToE4LDvEcAilx6YQR0nDIzjaaPbobPU4GTMQE3FCkAOdlEiyPjkFBh2bqn/6WoIj1Eeas7NSmV+QwGDms51BSQuSnfb25ZQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHEL6kP6; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHEL6kP6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5h3639GPz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 21:27:46 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2C42F60008;
	Fri, 16 Oct 2026 10:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AE71F000C4;
	Fri, 16 Oct 2026 10:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792146462;
	bh=U0J00jo5OiHeBPxzEIa6F1DcCXv2U6x9A+gpdOvbR5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fHEL6kP6IS5s8belsewK7AeFU5zIrffBszsKo3//zeOY4pQ+UIumG35dxnULGf/3d
	 EGt29felUqNf9Ch2QvIQZsnCqtVy/W+u/st4lU4MN3C/Dcl/dTc7W/ZbbvESn7cHBc
	 eqi6D1ok1vbZ5mqfq+W0prdxLrbNmI58Lp7Jtrx5vsHRjUFxpjvTNcwCLCMNZlw8vx
	 dAmhzmT4L+uzQJ81JqVTU1ciXGN2fNgY0dXoFx6rvI5v5OP64DuDhSesR7W4ptJl6o
	 pR2pL8DNGR8LlR9297+A5XzUqMTod1ALxmn/eUISmu/nTdZ7t3YKh25BYzSomJDpfx
	 LCuJ//VjMWTGA==
Date: Fri, 16 Oct 2026 11:27:29 +0100
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	povik+lin@cutebit.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>, Kees Cook <kees@kernel.org>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	u.kleine-koenig@baylibre.com, Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Bo Shen <voice.shen@atmel.com>, Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 25/25] ASoC: rockchip: rockchip_max98090: Mark the
 link as started on success
Message-ID: <46a96bc8-2ee7-4c6f-ad8e-94321f8b9630@sirena.org.uk>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
 <20261016040048.506531-1-phucduc.bui@gmail.com>
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
	protocol="application/pgp-signature"; boundary="tqlzx0giHWNwlE1k"
Content-Disposition: inline
In-Reply-To: <20261016040048.506531-1-phucduc.bui@gmail.com>
X-Cookie: <<<<< EVACUATION ROUTE <<<<<


--tqlzx0giHWNwlE1k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 11:00:48AM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
>=20
> snd_pcm_hw_constraint_minmax() may return 1, which is then returned
> from rk_aif1_startup(). ASoC only marks the DAI link as started
> when .startup() returns 0.

Can you please resubmit this as a separate patch as a new thread without
the series numbering?  This is really going to mess with the tooling :(

Please don't send new patches in reply to old patches or serieses, this
makes it harder for both people and tools to understand what is going
on - it can bury things in mailboxes and make it difficult to keep track
of what current patches are, both for the new patches and the old ones.

Series numbering only makes sense within a series for ordering, if
you're sending something separately to a series or a new series then
preserving the ordering of the series just causes confusion.

--tqlzx0giHWNwlE1k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrR/BAACgkQJNaLcl1U
h9AosQf/VknJyrGXrKz1JvZbJBxS2f4nWntI49PwwvAzQ6a4SD3xfvD3bg/M7LAZ
J5+AHHz3VAcAYPq1gkxEy4pCm8MVao9XTc3Ujwu5jluXqeXIubKVaZnzHh+J84Ux
cjBkHDIed/T5gVNU5Q+CpctZcDl1jrOFs3dUiUzMw9T3JTDLH3NN8u10CbKzFsaO
n7SWoLoUuganF2oSbR0LpA9qfDv+AVTwzA0kxeNZA0Uu75kwlJ7nmFxDmpw857/8
BHCXxOUkS3ASKZ05NU5uuVGM2XAfSRzRAS/AY1SCT45ujPw9O9lhufB70UDqLW7a
SnN5ueA4U9Y+tWt2D0rrEe/M9oXKtw==
=No3u
-----END PGP SIGNATURE-----

--tqlzx0giHWNwlE1k--

