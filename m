Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 233871A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 04:51:08 +1000 (AEST)
Date: Sun, 2 Aug 2015 20:51:03 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 6/6] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode
Message-ID: <20150802185103.GD19600@pengutronix.de>
References: <55BA364E.1000803@maciej.szmigiero.name>
 <20150731055843.GX30895@pengutronix.de>
 <55BB9082.4030206@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
In-Reply-To: <55BB9082.4030206@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 05:13:06PM +0200, Maciej S. Szmigiero wrote:
> On 31.07.2015 07:58, Markus Pargmann wrote:
> > On Thu, Jul 30, 2015 at 04:35:58PM +0200, Maciej S. Szmigiero wrote:
> >> Adjust set DAI format function in fsl_ssi driver so it
> >> doesn't fail and clears RXDIR in AC'97 mode.
> >>
> >> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> >> ---
> >>  sound/soc/fsl/fsl_ssi.c |    8 +++++---
> >>  1 files changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> >> index 8e5ff5e..37aabe3 100644
> >> --- a/sound/soc/fsl/fsl_ssi.c
> >> +++ b/sound/soc/fsl/fsl_ssi.c
> >> @@ -900,14 +900,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *d=
ev,
> >>  		scr &=3D ~CCSR_SSI_SCR_SYS_CLK_EN;
> >>  		break;
> >>  	default:
> >> -		return -EINVAL;
> >> +		if (!fsl_ssi_is_ac97(ssi_private))
> >> +			return -EINVAL;
> >=20
> > I think it would be better to add another case for the other mode which
> > is supported (AC97) instead of using the default case.
>=20
> This is a switch of DAI clock masters and AC'97 is none of them:
> while "case 0:" can be added this would be very similar to the current co=
de.
>=20
> Alternatively, the whole switch statement could be wrapped inside
> "if (!fsl_ssi_is_ac97(ssi_private))" if that would be better
> with regards to code style.

I looked at the wrong switch/case the DAIFMT_AC97 is actually used
but this patch is about the master clocks. It's fine then.

Thanks,

Markus

>=20
> >>  	}
> >> =20
> >>  	stcr |=3D strcr;
> >>  	srcr |=3D strcr;
> >> =20
> >> -	if (ssi_private->cpu_dai_drv.symmetric_rates) {
> >> -		/* Need to clear RXDIR when using SYNC mode */
> >> +	if (ssi_private->cpu_dai_drv.symmetric_rates
> >> +		|| fsl_ssi_is_ac97(ssi_private)) {
> >=20
> > Please fix this indention. Most of the driver is written with 2 tab
> > indention after a line break and the new policy seems to be to indent on
> > the opening bracket.
>=20
> Will reindent this.
>=20
> >=20
> > Regards,
> >=20
> > Markus
>=20
> Best regards,
> Maciej Szmigiero
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvmaXAAoJEEpcgKtcEGQQySQP/R+yiEmCjIOep3DBS1V6Tx2a
MI5kqd2N1FT5DVcZpoMkKuDGUBmiddDfjbKzE7bSNrWM/6URxKhw83JPjLB2VXdW
I2lk4MhwcFwTPPDoB7hHLQUljzuujmCPeNcSKttlEsO2qePX1H9fEGM9k8I56qm1
9lBFwSxH3aQybT4WIJMX1Z5bU6nBxAZ9yrRqO8CsM2OETnbaEMqdPWaP5/gNObfP
UsCzppPIR9TJvmRrjs4v3TSK9PTaDZRHPFjBY+pqpC/PIhJriWDWprgvUxlQ5YPz
SPWYuBlu0T/Xh/cSPLiimkMj1LOhV1QXtD+h5Tyzeunag+fvTVvhomeLgGK2qKar
u50NnTO8KUaAr+M/0ioZqI0IoeFM4pZxuU3VVE7+XpwezZQQGz9InlAgEUrjJn7U
RT2pRafvyTm1FDE79rQB9z22GbZXXqxUf0+j/1Pm/BW6/L7eZxIthNJtdtsc/fh0
i4jw8OVpCQo7s11g12MqDlAAXnMuMWedtyYSXre9lX6AYmfCtOCFfO1MEIDx3oBQ
7G0Y6+kfqsG5ObCR79zy6c7iWqvo5f/WA6GG7xzJeoW9WW6R8aYlToFbDYlIwcwU
AZeCpTVw5KP2WCjlz7S0HNsYv+5hFKTGo6wKUX9bTnQF/628VVkiffnYSqVS7ip7
cH8nAE+X53u/LhaLFGid
=qATl
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
