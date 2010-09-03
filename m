Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FB32B714E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 02:02:14 +1000 (EST)
Date: Fri, 3 Sep 2010 18:02:09 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH] powerpc/5200: tighten up ac97 reset timing
Message-ID: <20100903160209.GE4813@pengutronix.de>
References: <1283528722-15644-1-git-send-email-emillbrandt@dekaresearch.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
In-Reply-To: <1283528722-15644-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 03, 2010 at 11:45:22AM -0400, Eric Millbrandt wrote:
> Tighten up time timing around the gpio reset functionality.  Add a 200ns
> delay before remuxing the pins back to ac97 to comply with the ac97 spec.
> This delay ensures that sync and sdata_out are held low while reset
> transitions to high.
>=20
> Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
> ---
>=20
> Scope shots are availible upon request.
>=20
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/=
platforms/52xx/mpc52xx_common.c
> index 6e90531..79adfe7 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -326,11 +326,14 @@ int mpc5200_psc_ac97_gpio_reset(int psc_number)
>         clrbits8(&wkup_gpio->wkup_dvo, reset);
>=20
>         /* wait at lease 1 us */

Maybe you could fix this typo as well while you are here?

> -       udelay(2);
> +       udelay(1);
>=20
>         /* Deassert reset */
>         setbits8(&wkup_gpio->wkup_dvo, reset);
>=20
> +       /* wait at least 200ns */
> +       __delay(7);

ndelay(200)?

> +
>         /* Restore pin-muxing */
>         out_be32(&simple_gpio->port_config, mux);
>=20
> --
> 1.6.3.1
>=20
> -DISCLAIMER: an automatically appended disclaimer may follow. By posting-
> -to a public e-mail mailing list I hereby grant permission to distribute-
> -and copy this message.-
>=20
> This e-mail and the information, including any attachments, it contains a=
re intended to be a confidential communication only to the person or entity=
 to whom it is addressed and may contain information that is privileged. If=
 the reader of this message is not the intended recipient, you are hereby n=
otified that any dissemination, distribution or copying of this communicati=
on is strictly prohibited. If you have received this communication in error=
, please immediately notify the sender and destroy the original message.
>=20
> Thank you.
>=20
> Please consider the environment before printing this email.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyBHAEACgkQD27XaX1/VRtIuQCeIpRBKb5c70zvmIL9lnUzcS/s
YIEAni8BSTNo9lP57hIC0ke9ytlWebiJ
=7ept
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
