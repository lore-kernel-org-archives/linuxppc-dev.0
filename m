Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CD151A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 04:46:45 +1000 (AEST)
Date: Sun, 2 Aug 2015 20:46:37 +0200
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
Message-ID: <20150802184637.GC19600@pengutronix.de>
References: <55BA35EB.6020901@maciej.szmigiero.name>
 <20150731052719.GU30895@pengutronix.de>
 <20150731055357.GW30895@pengutronix.de>
 <55BB885C.3040305@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
In-Reply-To: <55BB885C.3040305@maciej.szmigiero.name>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 04:38:20PM +0200, Maciej S. Szmigiero wrote:
> Hi Markus,
>=20
> Thanks for looking into the changes.
>=20
> On 31.07.2015 07:53, Markus Pargmann wrote:
> > On Fri, Jul 31, 2015 at 07:27:19AM +0200, Markus Pargmann wrote:
> >> Hi,
> >>
> >> On Thu, Jul 30, 2015 at 04:34:19PM +0200, Maciej S. Szmigiero wrote:
> >>> AC'97 bus can support asymmetric playback/capture rates
> >>> so enable them in this case in fsl_ssi driver.
> >>>
> >>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> >>> ---
> >>>  sound/soc/fsl/fsl_ssi.c |    4 +++-
> >>>  1 files changed, 3 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> >>> index a83b900..7f4f0b9 100644
> >>> --- a/sound/soc/fsl/fsl_ssi.c
> >>> +++ b/sound/soc/fsl/fsl_ssi.c
> >>> @@ -1377,7 +1377,9 @@ static int fsl_ssi_probe(struct platform_device=
 *pdev)
> >>> =20
> >>>  	/* Are the RX and the TX clocks locked? */
> >>>  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> >>> -		ssi_private->cpu_dai_drv.symmetric_rates =3D 1;
> >>> +		if (!fsl_ssi_is_ac97(ssi_private))
> >>> +			ssi_private->cpu_dai_drv.symmetric_rates =3D 1;
> >>> +
> >>
> >> Why don't you use the DT property that is parsed here to enable
> >> asymmetric rates?
>=20
> Because in the AC'97 mode the driver supports only one channel config and=
 one sample format
> anyway the remaining settings controlled by this property don't do anythi=
ng.
>=20
> Since it should be safe to enable asymmetric rates with any AC'97 CODEC I=
 think it is good
> to do it in driver than to add "fsl,ssi-asynchronous" to every AC'97 DT n=
ode.
>=20
> Also the description of this property in fsl,ssi.txt looks like that it o=
nly makes sense in
> non-AC'97 mode.
>=20
> > Just found the last version of this series. Please use v2 and describe
> > changes for a new iteration of a series.
>=20
> This is just a resubmission, there are no functional differences since
> it was originally submitted a month ago.=20

I see, 'RESEND' tag would be helpful then.

>=20
> > There is also a different setup with AC97 which does not use DMA. See
> > the long comment at the top of the file about how ac97 is already used.
>=20
> I understand that the problem with FIQ handler described in comment
> on top of fsl_ssi.c only pertains incoming data, that is capture.
>=20
> This patch effectively does not touch capture rates as they are already
> limited to 48kHz only since this is the only capture rate defined in
> fsl_ssi AC'97 DAI driver capture capabilities.

Ok, great.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJVvmWNAAoJEEpcgKtcEGQQ+xQP+PTRW05BCxuJHDRM6zkXnksA
4CgZ//JHL1M3+JmzWBI0nv14TW3NytUT5wznU6YciFWoBw2SQXqqw5wAYCI+YJ8n
UDTVO3wDdZyNrygr6/g7sX+5ytunOq2mScHaRhN4UgyHjidvzGaUQYyKnG5C74+s
9uDdIH25NTsqhX5OH+gQE47dnaYN/cEMICsLraEbiAkiGxUz21DsRKYiXaKkdhkI
hm3qKwnDtgvai6g3ddYBI16H49Tfgg9BF4oY6Wg3HHtDloVLFCPf7KyM6s+qMrax
EUntJw2DqSzp6PmawVnTL8KeuN9jFIyNAIFLKHMGAu0F3U+8rA2xXpV0JLjyqaMU
2U8MioF/gEynXCtY6OkXcTfobxKeeBtjjemmubFH6J0d/Ueb2SlYEClETZxluEdq
/mCzYcU3X0fZLfleXKw/SHqI8hJ8juSuhbQke++uqrD7YUqlEjMX0kZ2+ZDcVgl+
2dBgO3QD0y3G2itZQF8S69q8H8nyqi5KDnKiOW1MEe79yUnhA23Cs1JlbQVPGZj0
OPXnM2vczZAza7avxZdJI0jrPLMzqbDDllSmNIIoHG33K8ejt5O++oDSAActucvT
o/fYWwpuwLarSH7jjjviPXQXwEKyg5oaJ737FNSgQIbXF7yICdYeBoHZ9BE/YzfE
vxbQgH6KGw7nskhDxhQ=
=9tC+
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
