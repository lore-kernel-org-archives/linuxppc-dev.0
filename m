Return-Path: <linuxppc-dev+bounces-29551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A9ACC6B3A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:12:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j555J4j1Xz2xNk;
	Thu, 15 Oct 2026 22:12:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792062756;
	cv=none; b=JkyNNyhcXBWHtepEpHuQpqnTQnhWnqPMWX/5KaMw1W/S9xY9Qweyooq3p7HtXXaX9C4NGq0P6VLGoyVQVFW6IsSeClz2EsAE327W9acpgoDm/X8Jefum5zhFbTQiRWA9JMy/MBGWOLF+TlksoOFa9Y9q/4zcycPa10SDns9/4/C1gtt0GXwoQLiGTINYTl/6B8jDIH7Il+Ok784TRJ7B8gyT9IeKPTYacCFv0Y3EALyno+DQm5NotjgD+M164n/qVGHO7CtfObQqediFhp9tqM13ClsyLkp1SN77tQ/kuhoH1EvRHGe9RGLav4xAP5mQ7iwSdy9NolQKX/eQlwAGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792062756; c=relaxed/relaxed;
	bh=Hd6BBnEO5pGpbCON7Q87RSeR9u1q3VXpiWY+WMKFASs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezPa4E3rOvh/uRI3pQ7Oq8nN587QNKJRZ3TG08DDP28KMyGrpHqhJlJaGGFAl1mlZrGOgsBPpRapkRLDvKbQ3/EkA5NV0v0iCnMcfbexVfTudWizjxHTIyZYuRJTdEvvdioYr4UOeH0GEl+lzrvTlSVCdG3cINWUO3cVzaven9yu1ljGkI2zS1fsHAdSOnpPyN2a5UD9wGGu6Gexl7WIph3tcHDy+k7jWZ2PAl8td/kmjcmhUk+drve4RN8SGQAOkWbXLKe3gEnW8wo2AgSPMRoJ2NXifgEUg8SqcrVqZUsjjohLpEqdTjBaU65n9UFxn0UALWpHvSjY219D2Ps8/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+8xOXUk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+8xOXUk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j555H5s6jz2xNg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 22:12:35 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CFC5443277;
	Thu, 15 Oct 2026 11:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727F1F000C4;
	Thu, 15 Oct 2026 11:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062751;
	bh=Hd6BBnEO5pGpbCON7Q87RSeR9u1q3VXpiWY+WMKFASs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R+8xOXUkDkZ9pKZHBmcNtj8NyuP6cR0oqQgoZ8UCc+tB3DzT4QCvEJXW8Nh+PAHLO
	 l4qO7p4Clap8JJBD57iJA17dF9oaApVDpvp9NMyxi2p9zza3C5/jxCXVuqp97P3kH/
	 6RncdVn38CsHW39zcgI8DIfqy4X+t2GhIU9JFMzzboPBxl+hGJOmX6ojQV+MHKJjzv
	 keBaU7H/dW4cHXdRTPAOoj3PXUzd0obz4/xGRkI4yhpdkI4hjeNJmNTCIIZMIQGcGL
	 wUvK5fhMpbxaZqaxQQpRrEEA+IDFwqvTiLrkNMorRjRdP64wUDyKUMoYHX3QYp6pVZ
	 cc0SD3e32mliw==
Date: Thu, 15 Oct 2026 12:12:17 +0100
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
Subject: Re: [PATCH v2 00/25] ASoC: Fix constraint return value handling
Message-ID: <ad722297-5ca5-42c5-a07e-59fa958387c1@sirena.org.uk>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
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
	protocol="application/pgp-signature"; boundary="syrl3Afg657kytt3"
Content-Disposition: inline
In-Reply-To: <20261015014324.5569-1-phucduc.bui@gmail.com>
X-Cookie: Tax and title extra.


--syrl3Afg657kytt3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 08:42:59AM +0700, phucduc.bui@gmail.com wrote:

> Changes in v2:=20
>  - Add Reviewed-by tags from Vijendar Mukunda and Chancel Liu.
>  - Remove redundant integer constraints already applied by=20
>    snd_dmaengine_pcm_open().

v1 was applied, please send incremental changes for the differences.

--syrl3Afg657kytt3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrQtRAACgkQJNaLcl1U
h9DzAQf/WcguhgqKmLmBlSGrfAmohZap9b+qyUgyk3gBcdL4pfDRN2N0m/jg80sq
EGu7yBR6LzgAalcEkMLnjACfVsi4kZuopa6nijef9rrYX/cJcxUrOSjK3l2G+rD8
U6h20fO6YVWgAkmtLtV9G7PU+gy+06ZO8snDL9dTODv9DYyWZvQ4mTgJvAK7rYQP
mBKi2rhlpXe2rMyRIvXW4FQtX1kqOzt+gtSHjApzltjchxaDuM6/jThE4a8+o4Ms
XpUeCo9/Bg4u29Zt4okIN1S1up/cOjyNcEQwgf+5Lf0qlZXbV4Dyk43TNms3vuED
ZSE26kZ6DpaP/lgPoejNuYeJrPX9Pw==
=HbjQ
-----END PGP SIGNATURE-----

--syrl3Afg657kytt3--

