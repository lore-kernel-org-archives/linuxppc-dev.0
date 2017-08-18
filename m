Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYcpG60P5zDrJR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 19:13:58 +1000 (AEST)
Date: Fri, 18 Aug 2017 15:57:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 4/8] powerpc/xive: introduce xive_esb_write()
Message-ID: <20170818055706.GT5509@umbus.fritz.box>
References: <20170811142341.22715-1-clg@kaod.org>
 <20170811142341.22715-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9wW3yB/H9ZmnRBtb"
In-Reply-To: <20170811142341.22715-5-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9wW3yB/H9ZmnRBtb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 11, 2017 at 04:23:37PM +0200, C=E9dric Le Goater wrote:

Rationale in the commit message, maybe.

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/sysdev/xive/common.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive=
/common.c
> index 8a58662ed793..ac5f18a66742 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -203,6 +203,15 @@ static u8 xive_esb_read(struct xive_irq_data *xd, u3=
2 offset)
>  	return (u8)val;
>  }
> =20
> +static void xive_esb_write(struct xive_irq_data *xd, u32 offset, u64 dat=
a)
> +{
> +	/* Handle HW errata */
> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> +		offset |=3D offset << 4;
> +
> +	out_be64(xd->eoi_mmio + offset, data);
> +}
> +
>  #ifdef CONFIG_XMON
>  static void xive_dump_eq(const char *name, struct xive_q *q)
>  {
> @@ -297,7 +306,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_d=
ata *xd)
>  {
>  	/* If the XIVE supports the new "store EOI facility, use it */
>  	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> -		out_be64(xd->eoi_mmio + XIVE_ESB_STORE_EOI, 0);
> +		xive_esb_write(xd, XIVE_ESB_STORE_EOI, 0);
>  	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
>  		/*
>  		 * The FW told us to call it. This happens for some

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9wW3yB/H9ZmnRBtb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmWgbIACgkQbDjKyiDZ
s5INIw/+OgqEMH6YgfjgxIVX71NO96T8ehlghu4xxkd4PHvfp4NwXHzBBeul/QFV
cmgfmkxCF+mUiui+KV0jZnSXHe4TKI+8K+JGKxkGj4TG0ieAc8ZzQQSV5S2EBtnW
cqV+VsT6VhMZnYdMsM2zFUfHHD/wWi/Fie5yTy7zbPVk95H8WZAMEqLqpFs9l0pJ
PUOqDl2m2WmVoGhGyi1D6OmfnPq24j9vaeurylLVoDzqhfhsXsUX3X1o8j/MOfmu
Q4qWibyGyU6rizROnrRmSc9r9Tf/77j+Bt01dDbkOSFjD3k21sWKzUfPITuDyirS
8KdNk89EK+90GEZL8n11luRrUFzTX4NokDH00CEGblhtD1dKTuZp5mB1ivfjYEoF
tj12Rm0RYRvDwRJmppTrFXUjLlaXpdejyfnduBzKDsprNny123mNlf3UrSw4Gt/p
Aa/nPIu2piU05H5rGmJQ4OpAKAbOPy8nF+jqRuWc4LSxKhDn9A0xjB/sl1Zso2PZ
3GsoXrqZZ+Me2twe2EKyynN7dAPR0sGmrqxhkHE8tluNnhImrlcKJDdbm59t93hX
FsqU6t4vDWW9Yhx9sdtGXhCvm2bpM5bnMujDHv2wXNs1bysdoe2kyxQPrSNgrrqF
nzEbTs31zRkadwoxCw+zN2AvRWZluBwUX3DogTR1SQOnNDNv+Yo=
=qUcu
-----END PGP SIGNATURE-----

--9wW3yB/H9ZmnRBtb--
