Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A174606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=g4don/vH
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZRLd6XFPz2xqh;
	Thu, 26 Nov 2026 04:22:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::429"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795627321;
	cv=none; b=OCxwxrKlyn7mq9l/NxOOQglDSoyFBj3phLDE5LDHTnuQ9hcsjAGqyW6gvtir4NXYdE5qRjDUDlGQti33qinZQ9UUD9yy75xzGrBtHAS0PGnPW9RL+IU8dRaGf3gOpSrhyRsSdjf7Uzasfoke3PWHoFqnPC/uqhYFnFGMYaqRKDNlSan8/iAI+7hO/MGYALSXTYgmcuxAhw+onLNC2Vf7IQJhgMfVd6oEZw+UB/edF7m3jMKHgUmAdvVOEjV+VRh3YUyehKD7pbnll/a1V+x/MvrSs2YZSfdmiq2r20ZkMQa+edZ5du7KEcf4mKiLbmzPLt25JuqIdqzl1D2O9VHT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795627321; c=relaxed/relaxed;
	bh=ENdJgXbQROCmKdJO5EaJi6MoXgKwvTQsbT7XHtvuy1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krfG4luI9ngXHIfzUFbPVau4Wba4RUaYzd7FqD5cNDLwgnLufiY70huiOmVvOFmYdTmmKRESu/zOb0uq9Vn9qz27+2kFETtN3K2KAgNcRKxxTafOm40mjKV9LzU77USGzlDglENGTQkhXC/MpIZSBgf3HxyqmHIjsgM/nwcuueLELpXCEUFC2wx3TEaM5Wb/X962h3xroM5NV2XCVeNNkkFHlosvRRzkd/U5y2qYTOrnf8prikJua4/Ri9+AZsBa3QBgxDwQIW4sedmQtIgGffZnSSVkMLsV0lhx1P0VVMzDrla/r2jiRspucWJVRmiB22E6HG+iL4A8ay7QuUYy6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=g4don/vH; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=g4don/vH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZRLZ0X9Sz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 04:21:55 +1100 (AEDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-497614c95f0so3466033f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 09:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795627312; x=1796232112; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENdJgXbQROCmKdJO5EaJi6MoXgKwvTQsbT7XHtvuy1s=;
        b=g4don/vH9v/eU3M5KFIgQr0AKOvpKUzdxk+IMhEYDgpG025ABLq9oGF6to3Ybl83+C
         crXWFCr0iocGZAwJMXmsFPg/9E/zOnGhzJmcGa8SierfKhS+zlYQOe6L15bLPM+9JT2Z
         HC2pdJoHRZsIjuyJvr9bLw/q1zuk35H2pnj41qS6FfMLOalZ35SgnTu/quS0GWeAZVv1
         EY405/Yb4yPpziBdhIdiM6JPusc+0yNrILc55X5BYgFhdw7U6djVTjQVbNHztOmTHmWb
         H35ydlDkfR63hScgEKppw/QCtYreYdYb0p+yUxNA603CBiPDU7o7PG0sC20mJi2fx1qv
         q2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795627312; x=1796232112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENdJgXbQROCmKdJO5EaJi6MoXgKwvTQsbT7XHtvuy1s=;
        b=G4sBDK81DFTCDEd6CN0SbNDzG85DiYVL9hgj4ZMOEOn3nj4RZcEjvU9BjoTT89DL6Z
         OjjR7CkxIjc40O7eqaajGhTmDQI9l8C8nL7gSlZTmaQqyNDgV/gC7VQQZ4WqMSEk/+S2
         Dljd0jpSj5g6O+yy1LZPbEdwxO352o43Ijb+cnmvuSNvc+agR5fr+Ilj9Qc2snqjRgkH
         Ni362tpv0f+ZGzhTgLOEMUi17IYRug7K3/CD75a1X90YXNPfml6ICudNvcKTE///b9jR
         +PWUr5O5N41Ru0MgwMVRq58fxR0ekN2fTJYLpeQQl2/k+DoZa+oy+CI70E9zCyscFSLP
         glKg==
X-Forwarded-Encrypted: i=1; AL+hErFswPWK5qE/VsyUg4SbdHgPFtuAGH0sq6zpWp8Nztl1NnubCDe6CEg2tnQKu5roBm7LLh7fcRhzaSE2nBk=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z92i/MlgaFh/gWahjeMTI4caGnBgBziUOtEdrIDZIiaTusO87CD
	WdPpXof9uV1wC+rAWaWYNuG5xnG8RsjOrAxvqorwSiHZlTdHC9wuuiJn0j3ErPeBjAY=
X-Gm-Gg: AZFdTZc6I1ldDU2zQyjZRkOS5lDzirNTossVerZTnD33VjDmFYjMRNQzgkzwozXa5Es
	B4FqtteBQxXX32S71C0ALSxQ7sHqVgpTv9ep7UY2dHU5U6y4sfaLOKQxyaM3gSWIRH+xquwzx9X
	OzcBNnr0QRb/AvIARjZDght+xgmAY9pHpds/GYV35A+XwI4nXFUX2Gcze/qFA+u6bKN0tf6LbWE
	N0/wRYMnAWypss27/ru/pY/DOD/XtvgYFIAqiwqHVSofeR1CZZF80A23yXzQlWq6tL8aI+wJxHU
	ssea2jER/RO01bRCDLlaqDl7m0XEs9NRIUmM2JOYLvmnTZVSZCcF8u/fadiy1D/4rCe1HXBt99D
	epbu+j/fKrssTMUmbgnw67+zbb2fIUs5bslowAK1jrThld5ZyNXAou4wzvgXjl50y75M+RtFg++
	OV3ICWuUfGRaSjASL2wS2VzGw5h9wTXHItDhfGMCrq/W33hquIrwgbGoauvlnH6IBiRmhwjAc1K
	BaLhhagcZI86J4h9MEqGnxVt3vGfdr14DRnqxh0KDV96w80CYi6ps5s2AENPtdKpl4Fmqp4ldcz
	8FJbbQU57yg7DRmYpVhIICkQVfXSRAg/xbPG6m2RRFBTh4ZDE1gsdTrtJzuoZ1ZGIOoKatyV4iF
	ku1ySH09YoJolIV+4
X-Received: by 2002:a05:600c:1547:b0:4a2:397:73f6 with SMTP id 5b1f17b1804b1-4bb8880974amr419686485e9.8.1795627311811;
        Wed, 25 Nov 2026 09:21:51 -0800 (PST)
Received: from localhost (p200300f65f19a904452474b9d670397a.dip0.t-ipconnect.de. [2003:f6:5f19:a904:4524:74b9:d670:397a])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853b216esm590410475e9.12.2026.11.25.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:21:50 -0800 (PST)
Date: Wed, 25 Nov 2026 18:21:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Takahiro Kuwano <takahiro.kuwano@infineon.com>, Vladimir Zapolskiy <vz@mleia.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Joern Engel <joern@lazybastard.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Michal Simek <michal.simek@amd.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Brian Norris <computersforpeace@gmail.com>, 
	Kamal Dasu <kamal.dasu@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, William Zhang <william.zhang@broadcom.com>, 
	Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Han Xu <han.xu@nxp.com>, 
	Paul Cercueil <paul@crapouillou.net>, Harvey Hunt <harveyhuntnexus@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Liang Yang <liang.yang@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, 
	Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Linus Walleij <linusw@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 04/10] mtd: spi-nor: Unify of_device_id list terminator
Message-ID: <awcY_FIcD-Lt0_am@monoceros>
References: <20261125-acpi-mtd-v1-0-42ad2f645bee@thegoodpenguin.co.uk>
 <20261125-acpi-mtd-v1-4-42ad2f645bee@thegoodpenguin.co.uk>
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
	protocol="application/pgp-signature"; boundary="vscxo3nc4bzujlaw"
Content-Disposition: inline
In-Reply-To: <20261125-acpi-mtd-v1-4-42ad2f645bee@thegoodpenguin.co.uk>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--vscxo3nc4bzujlaw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 04/10] mtd: spi-nor: Unify of_device_id list terminator
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 04:28:30PM +0000, Pawel Zalewski wrote:
> Unify the list terminator to have a single space between the brackets and
> no trailing comma. This change doesn't introduce any diffs between
> pre/post to the compiled binaries of the modified drivers and just aligns
> these to the common style with other *_device_id arrays.
>=20
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> ---
>  drivers/mtd/spi-nor/controllers/hisi-sfc.c  | 2 +-
>  drivers/mtd/spi-nor/controllers/nxp-spifi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi=
-nor/controllers/hisi-sfc.c
> index 4f6631950a5b..01048ca46a60 100644
> --- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
> +++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
> @@ -474,7 +474,7 @@ static void hisi_spi_nor_remove(struct platform_devic=
e *pdev)
> =20
>  static const struct of_device_id hisi_spi_nor_dt_ids[] =3D {
>  	{ .compatible =3D "hisilicon,fmc-spi-nor"},
> -	{ /* sentinel */ }
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, hisi_spi_nor_dt_ids);
> =20
> diff --git a/drivers/mtd/spi-nor/controllers/nxp-spifi.c b/drivers/mtd/sp=
i-nor/controllers/nxp-spifi.c
> index 30fe2d414f07..71ee50eb1a71 100644
> --- a/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> +++ b/drivers/mtd/spi-nor/controllers/nxp-spifi.c
> @@ -440,7 +440,7 @@ static void nxp_spifi_remove(struct platform_device *=
pdev)
> =20
>  static const struct of_device_id nxp_spifi_match[] =3D {
>  	{.compatible =3D "nxp,lpc1773-spifi"},

If you touch this struct you can also add spaces after { and before }.
But that's a nitpick, ignore at will.

> -	{ /* sentinel */ }
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(of, nxp_spifi_match);

Best regards
Uwe

--vscxo3nc4bzujlaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsHGSsACgkQj4D7WH0S
/k73ogf7BALXlCQ8r5M8ZULyZTCXZBckvup39sfY/19fBNNwXXunI63allBA3oeS
J2HDGz0wNdZ2/y1iggGBavEtOaE6mVsBVcm3jdJ97l/vwZ/DzZ18bG17D+lOa6o0
Kukj1hQ5Q2qvFM8u49aHT99Zp8isHlf3GpEqLzOnphUzqGPj4/9xiIWC887HPgq0
Nfab1Mu6GBOwgze0VnJbpJfJ4rOA6Bz+tZOVjrFqShym3ZSG1ADwwM4HkOixY93y
2Z/oy3nqZHXEeEEg9uml7t299pECJEma5xTr5gSqY9g8tcQXvO8QVWh+dTUSYLTO
i5jse6iRjG93iBKa+gKKv3oEi8y83Q==
=PjDZ
-----END PGP SIGNATURE-----

--vscxo3nc4bzujlaw--

