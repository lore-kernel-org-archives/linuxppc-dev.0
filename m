Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED7F71A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 15:54:01 +1000 (AEST)
Date: Fri, 31 Jul 2015 07:53:57 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
Message-ID: <20150731055357.GW30895@pengutronix.de>
References: <55BA35EB.6020901@maciej.szmigiero.name>
 <20150731052719.GU30895@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H5pgEA8DvTwLpheO"
In-Reply-To: <20150731052719.GU30895@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--H5pgEA8DvTwLpheO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 07:27:19AM +0200, Markus Pargmann wrote:
> Hi,
>=20
> On Thu, Jul 30, 2015 at 04:34:19PM +0200, Maciej S. Szmigiero wrote:
> > AC'97 bus can support asymmetric playback/capture rates
> > so enable them in this case in fsl_ssi driver.
> >=20
> > Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> > ---
> >  sound/soc/fsl/fsl_ssi.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index a83b900..7f4f0b9 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> > @@ -1377,7 +1377,9 @@ static int fsl_ssi_probe(struct platform_device *=
pdev)
> > =20
> >  	/* Are the RX and the TX clocks locked? */
> >  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> > -		ssi_private->cpu_dai_drv.symmetric_rates =3D 1;
> > +		if (!fsl_ssi_is_ac97(ssi_private))
> > +			ssi_private->cpu_dai_drv.symmetric_rates =3D 1;
> > +
>=20
> Why don't you use the DT property that is parsed here to enable
> asymmetric rates?

Just found the last version of this series. Please use v2 and describe
changes for a new iteration of a series.

There is also a different setup with AC97 which does not use DMA. See
the long comment at the top of the file about how ac97 is already used.

Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--H5pgEA8DvTwLpheO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuw10AAoJEEpcgKtcEGQQZfkP/jnu7MNjJkaHHFs7tYMuyVAD
JtSHxTz5sn9eAXaLazQje3v9BZNrOkZH0wUeJ5hsUo9MybLxrxnPvPa3aQ69HFIV
UiYNjFl+KBW4yFn0wpH3z5bu7ENZxe0Wq5I+265FxxdnqajEXPJsek6ZVWTOZjeB
wFgK/16DpGOtfp3pUuMVp+hcEwfdXsVkCSobRz8TS8gREu7ACImb/gujep2XYg+W
tqgJ0IsKuyKJkj4vs7H+7Bs9iM8DsWbqZLXL2A29GBZxQd0F8aACaj33SV/OBu4P
+Qbyg7cbPUdBUTM0UV7h1oXFiSY3ShwnedO1ja2fBGcBNs6GAq9yHIWDX5/cswUC
A/CGxZmGX3LPCFcQTPsJq2ko0Pl+iHd13Lol27KDC5G5U7CxzOSGeNSgmYnfjWRO
DyuCfPm6Cn+UmnL6sq9M1GZYXfOu3aw06UGakjOEZwScAUiQf03KCbb1m/HXXw3A
qvnKho2BFz9oUwR2DmOmmlOebmP1T4U/2M3THJV1OfH30d7Fmx3G4I/BNRQaLY2g
RWH8DefDs7PfdFAacB1q72BmUmI7+J8SmTt5LV5WszYyxOGYDU643c2lYHCGgJhr
MfX8aD+qVvGeL7kJ1eCjdROXiPrWINQUEYODJTFwKNy9eJxz58MNbWt/HFxtMxmc
k/T7qeqlNKqqOnIXd7IF
=TcmV
-----END PGP SIGNATURE-----

--H5pgEA8DvTwLpheO--
