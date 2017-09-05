Return-Path: <broonie@sirena.co.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmrx23rNWzDrH3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 01:58:46 +1000 (AEST)
Date: Tue, 5 Sep 2017 16:15:50 +0100
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Message-ID: <20170905151550.5mhb535p22lsohlh@sirena.org.uk>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
 <20170905075247.GA6112@Asurada>
 <deb40031-9db0-d667-7314-352cf548c295@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3iuz7zolhzcycwef"
In-Reply-To: <deb40031-9db0-d667-7314-352cf548c295@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3iuz7zolhzcycwef
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2017 at 10:19:05AM +0200, =C5=81ukasz Majewski wrote:
> On 09/05/2017 09:52 AM, Nicolin Chen wrote:

> > Can you elaborate why you set ipg clock as bclk? I don't remember SSI c=
ould
> > derive bitclock from ipg clock.

> Just to be clear:

> What clock shall be set with:

> struct snd_soc_dai_ops {
> 	int (*set_sysclk)(struct snd_soc_dai *dai,
> 		int clk_id, unsigned int freq, int dir);
> }

> callback?

> The SSI IP block or BCLK ?

Not the BCLK, probably the IP clock but perhaps nothing.  The bclk is
usually derived from the sample rate and width, the system clock is the
clock rate going into the device.  It doesn't *have* to be configured
(particuarly if it's discoverable by the IP and managable via the clock
API).

--3iuz7zolhzcycwef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmuv6UACgkQJNaLcl1U
h9AtnAf9EKIG4u66WmYu2NBsfi05jokTgDc1bNTu0zLnl/+F8ryoGAMkfvzlrJGX
Mpu73cneyDQuN7H6EVrt57xrlERwnObjioUeBED5gS1z+ViM2j1AEShfIkC3msC5
ug0jgq8gO+IpnJssqag5FfVtToVFvvJNzKP48Y5O9cq2kN0Up81bXom6iLYPKaIF
WNJKezxlmZ1GbvvJ3u+fbi6IR9ECIwgkcxndrU4Z6wIJZSsaynA6JerTsqpcwj+b
ycCppn4IpOqVtd6XmOpj5wxUb+lPbzzJlWl0PpDOCb8Vnk0zbEq2rHBJy1pNQZ1c
ZQts3u2G4Xm+ZXqZn2G1yNyTVwF8fw==
=Kce/
-----END PGP SIGNATURE-----

--3iuz7zolhzcycwef--
