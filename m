Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/4] fsl_msi: fix the conflict of virt_msir's chip_data
From: Michael Ellerman <michael@ellerman.id.au>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <1271403278-30091-1-git-send-email-leoli@freescale.com>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-X82Zn941xQy7c0yjG3HX"
Date: Mon, 19 Apr 2010 12:40:34 +1000
Message-ID: <1271644834.14835.40.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-X82Zn941xQy7c0yjG3HX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
> From: Zhao Chenhui <b26998@freescale.com>
>=20
> In fsl_of_msi_probe(), the virt_msir's chip_data have been stored
> the pointer to struct mpic. We add a struct fsl_msi_cascade_data
> to store the pointer to struct fsl_msi and msir_index.  Otherwise,
> the pointer to struct mpic will be over-written, and will cause
> problem when calling eoi() of the irq.

I don't quite understand. Do you mean someone was overwriting
handler_data somewhere?
=20
> @@ -309,9 +319,19 @@ static int __devinit fsl_of_msi_probe(struct of_devi=
ce *dev,
>  			break;
>  		virt_msir =3D irq_of_parse_and_map(dev->node, i);
>  		if (virt_msir !=3D NO_IRQ) {
> -			set_irq_data(virt_msir, (void *)i);
> +			cascade_data =3D kzalloc(
> +					sizeof(struct fsl_msi_cascade_data),
> +					GFP_KERNEL);
> +			if (!cascade_data) {
> +				dev_err(&dev->dev,
> +					"No memory for MSI cascade data\n");
> +				err =3D -ENOMEM;
> +				goto error_out;

The error handling in this routine is not great, most of the setup is
not torn down properly in the error paths AFAICS, this adds another.

> +			}
> +			cascade_data->index =3D i;
> +			cascade_data->data =3D msi;
> +			set_irq_data(virt_msir, (void *)cascade_data);
>  			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
> -			set_irq_chip_data(virt_msir, msi);
>  		}
>  	}
> =20

cheers

--=-X82Zn941xQy7c0yjG3HX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkvLwqEACgkQdSjSd0sB4dIJXwCgt8SnQFdfMFNa255OycPKDQph
750AnR0DGhtV6pEqwZxP+SdSBWcnRrvX
=4bDA
-----END PGP SIGNATURE-----

--=-X82Zn941xQy7c0yjG3HX--
