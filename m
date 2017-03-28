Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsvq06lgzzDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 02:25:32 +1100 (AEDT)
Date: Tue, 28 Mar 2017 16:24:57 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="snmk5xbbpahugqfp"
In-Reply-To: <20170328115306.GR6986@localhost.localdomain>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--snmk5xbbpahugqfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 28, 2017 at 12:53:06PM +0100, Charles Keepax wrote:
> On Tue, Mar 28, 2017 at 01:47:04PM +0300, Daniel Baluta wrote:

> > >> -     codec_clk = devm_clk_get(&codec_dev->dev, NULL);
> > >> +     codec_clk = clk_get(&codec_dev->dev, NULL);

> > is different from &codec_dev->dev.

> I get that they are different, I just don't get why changing
> from a devm_clk_get to a clk_get is a better fix than changing
> &codec->dev to &pdev->dev.

This should be clear from the semantics of clk_get(): you're looking up
the clock in the context of the supplied device and the clock is
attached to the CODEC so you need to look up in the CODEC context.  What
would be even better would be to move the allocation of the clock into
the CODEC driver...

--snmk5xbbpahugqfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljagEgACgkQJNaLcl1U
h9AKugf/StJ149lY5qxFIidYO0Ivx0sfdE0kKrP8LJee5gI9llEg3gLIetZ/Zdw8
7aVlTFxfD/l8U2ym9TUbfVVbu4Aj7oruKkw1zGiMlpoHzzTNSYKXvNP7gPA/8UCp
5q8Y+vrW2zAwoprvvPfKZefn2RhZ44ts1F3kDDiX9MMQIOx/xBZFaDcWBg4SuFxR
FA8nKooE/4Fj9H0//eBgoQBePR9wZaMBeYskRy0IJZskTyPaMr6kheLe4aoTmiNC
XWe6oAAkTdx0Vi4hYcu6PLmqyof1TUiuBONt/hANqJLgQTBrN0B5w3HlaFnmGCAd
5FQwg2ng+ONbILs5V4JjunNpcKzx4A==
=c1d6
-----END PGP SIGNATURE-----

--snmk5xbbpahugqfp--
