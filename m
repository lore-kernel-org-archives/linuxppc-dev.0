Return-Path: <mpa@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 304311A01EB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 16:17:29 +1000 (EST)
Date: Fri, 12 Sep 2014 08:17:06 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V2] ASoC: fsl_ssi: refine ipg clock usage in this module
Message-ID: <20140912061706.GA10680@pengutronix.de>
References: <27584da8e3ab291ab8dbcbb411579613f8384a59.1410413734.git.shengjiu.wang@freescale.com>
 <20140911225737.GA13926@Alpha> <20140912020110.GA414@audiosh1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
In-Reply-To: <20140912020110.GA414@audiosh1>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de,
 Li.Xiubo@freescale.com, timur@tabi.org, perex@perex.cz,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 12, 2014 at 10:01:12AM +0800, Shengjiu Wang wrote:
> On Thu, Sep 11, 2014 at 03:57:37PM -0700, Nicolin Chen wrote:
> > On Thu, Sep 11, 2014 at 01:38:29PM +0800, Shengjiu Wang wrote:
> > > Move the ipg clock enable and disable operation to startup and shutdo=
wn,
> > > that is only enable ipg clock when ssi is working. Keep clock is disa=
bled
> > > when ssi is in idle.
> > > otherwise, _fsl_ssi_set_dai_fmt function need to be called in probe,
> > > so add ipg clock control for it.
> >=20
> > It seems to be no objection so far against my last suggestion to
> > use regmap's mmio_clk() for named ipg clk only. So you may still
> > consider about that.
> >
> I think mmio_clk() can be put to another patch. and this patch only for c=
lk_enable()
> and clk_disable() operation.

I would also prefer Nicolin's suggestion using regmap's mmio clk. I
think it may be better to not add this particular patch at all and just
go with the mmio_clk patch. It should be easy enough to just add the
clock names to the devicetrees. That way we can avoid all those clock
enable/disable function calls.

> =20
> > Anyway, I'd like to do thing in parallel. So I just simply tested
> > it on my side and its works fine, it may still need to be tested
> > by others though.
> >=20
> > Nicolina
>=20
> Hi Markus
>=20
> could you please review it, and share your comments?

I think the clock enabling for AC97 is missing in your patch.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUEo/iAAoJEEpcgKtcEGQQ9EAQAI8QPk+6GrxqGiWq1JkFELy1
vSKeevANsKNcenndtMpC1uVe4wrQpcNNCE8g8pmDypyFfJ3x1d3kFDutNH9Go3kC
CkL8jffg75rNJ7izCnLeC4A/hqXm6uotl1KBWS58K8Uybv0+18b0rEWaBH5gVXX+
wWTg0ZfLQzep1YyGaobf8Hm3WWrmtRQKsIxstDmV/jVU4tk+tkEq6X0nuALNFPIz
5Cm6nurAVzgzcpvnPjiUvWZZyDN2Qp1ErxR9YBDpQJeDJjIf7waGCsqeLrgaj8Nn
76JaYMbBW55D96+FuHSpLaJw3wH5fHMOxme6HGYJ0NcIHML883aM1OElplFnn6c3
Sxht1V0Y1yb9Dmhpm3GuAq6BuwBi+YSdS8+c7sMeo2MJ0BUbj0DhzAIA37h4SS5u
QQFQQrIutOg60vEXM/onhhcl2e/BMXLUqgfDiyno2Cnfte3uMTeqNksOqE54LPm1
WNFcXGoObgsAIWfeFx95GncmvX00kpLRHw9uUbrFmTnnaU4QOxQXxL9rgYtMcUT7
IvYAXSl0RmVzrVo/kZR4SidoUCylPPzkxPnS1c4rwezgosICwJ637WEzU1p77tDS
C8Z+iGiLQTHyAnsYF9c9JB9yMnTWWJXQM9Z+iZlKpN2vqtomSaMXHpjPFurp8aFO
UJ3by+WPZZapAU6JpF3W
=I7o2
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
