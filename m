Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Mark prop unused in early_init_dt_scan_chosen().
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
References: <20070508171451.GA8893@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-k8i5j+aoJg83FJ0Sozg6"
Date: Wed, 09 May 2007 09:56:34 +1000
Message-Id: <1178668594.3696.5.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-k8i5j+aoJg83FJ0Sozg6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-08 at 12:14 -0500, Scott Wood wrote:
> The prop variable is only referenced when initrd support is
> turned on.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/kernel/prom.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index caef555..6705459 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -720,7 +720,7 @@ static int __init early_init_dt_scan_chosen(unsigned =
long node,
>  					    const char *uname, int depth, void *data)
>  {
>  	unsigned long *lprop;
> -	u32 *prop;
> +	u32 __attribute__((unused)) *prop;
>  	unsigned long l;
>  	char *p;

Hi Scott,

Let's be honest, this is a hack. I think it'd be cleaner to pull the
initrd logic out into a separate function.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-k8i5j+aoJg83FJ0Sozg6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGQQ4ydSjSd0sB4dIRAhbeAJ0Vr56AnH68bBjy5uE2p1dYp+n84gCgnkC2
a4VFpJu6/08acBLknyXfVKo=
=kl9w
-----END PGP SIGNATURE-----

--=-k8i5j+aoJg83FJ0Sozg6--
