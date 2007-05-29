Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] fix compile warning in pseries xics
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <27973.1180417829@neuling.org>
References: <27973.1180417829@neuling.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8VPsqBM3smQdSu6OCi61"
Date: Tue, 29 May 2007 15:52:17 +1000
Message-Id: <1180417937.5313.6.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8VPsqBM3smQdSu6OCi61
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-29 at 15:50 +1000, Michael Neuling wrote:
> In 616883df78bd4b3fcdb6ddc39bd3d4cb902bfa32 request_irq was marked as
> __must_check so we must... er... check it.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> This is the only request_irq which is not checked in arch/powerpc
>=20
>  arch/powerpc/platforms/pseries/xics.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/xics.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/xics.c
> @@ -752,6 +752,7 @@ skip_gserver_check:
>  void xics_request_IPIs(void)
>  {
>  	unsigned int ipi;
> +	int t;
> =20
>  	ipi =3D irq_create_mapping(xics_host, XICS_IPI);
>  	BUG_ON(ipi =3D=3D NO_IRQ);
> @@ -762,11 +763,15 @@ void xics_request_IPIs(void)
>  	 */
>  	set_irq_handler(ipi, handle_percpu_irq);
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
> -		request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
> -			    "IPI", NULL);
> +		t =3D request_irq(ipi, xics_ipi_action_lpar, IRQF_DISABLED,
> +				"IPI", NULL);
>  	else
> -		request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
> -			    "IPI", NULL);
> +		t =3D request_irq(ipi, xics_ipi_action_direct, IRQF_DISABLED,
> +				"IPI", NULL);
> +	if (t)
> +		printk(KERN_ERR "Unable to request interrupt %d for IPI\n",
> +		       ipi);

or BUG() ?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8VPsqBM3smQdSu6OCi61
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGW7+RdSjSd0sB4dIRAvPpAJ9H5l4KjTUkLZP6BCzuhOPX+411nQCfTVN/
0aVyCnj1zfwrE0rdP1vNe1c=
=Losx
-----END PGP SIGNATURE-----

--=-8VPsqBM3smQdSu6OCi61--
