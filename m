Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 69701DDDF2
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 00:13:27 +1100 (EST)
Date: Tue, 5 Feb 2008 00:13:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/5] [POWERPC] qe_lib and users: get rid of most
	device_types and model
Message-Id: <20080205001318.5fbc60fa.sfr@canb.auug.org.au>
In-Reply-To: <20080124153959.GA23246@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124153959.GA23246@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Feb_2008_00_13_18_+1100_7uvkjqS8iywucj=9"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Feb_2008_00_13_18_+1100_7uvkjqS8iywucj=9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

I know this is late, but a couple of comments anyway.

On Thu, 24 Jan 2008 18:39:59 +0300 Anton Vorontsov <avorontsov@ru.mvista.co=
m> wrote:
>
> +++ b/arch/powerpc/sysdev/qe_lib/qe.c
> @@ -65,17 +65,22 @@ static phys_addr_t qebase =3D -1;
>  phys_addr_t get_qe_base(void)
>  {
>  	struct device_node *qe;
> +	unsigned int size;
> +	const void *prop;
> =20
>  	if (qebase !=3D -1)
>  		return qebase;
> =20
> -	qe =3D of_find_node_by_type(NULL, "qe");
> -	if (qe) {
> -		unsigned int size;
> -		const void *prop =3D of_get_property(qe, "reg", &size);
> -		qebase =3D of_translate_address(qe, prop);
> -		of_node_put(qe);
> -	};
> +	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> +	if (!qe) {
> +		qe =3D of_find_node_by_type(NULL, "qe");
> +		if (!qe)
> +			return qebase;
> +	}
> +
> +	prop =3D of_get_property(qe, "reg", &size);
> +	qebase =3D of_translate_address(qe, prop);

If you don't care about the returned length (argument three to
of_get_property), you can just pass NULL (and dispense with "size").
Also, what happens if prop is NULL?

> @@ -153,16 +158,26 @@ static unsigned int brg_clk =3D 0;
>  unsigned int get_brg_clk(void)
>  {
>  	struct device_node *qe;
> +	unsigned int size;
> +	const u32 *prop;
> +
>  	if (brg_clk)
>  		return brg_clk;
> =20
> -	qe =3D of_find_node_by_type(NULL, "qe");
> -	if (qe) {
> -		unsigned int size;
> -		const u32 *prop =3D of_get_property(qe, "brg-frequency", &size);
> -		brg_clk =3D *prop;
> -		of_node_put(qe);
> -	};
> +	qe =3D of_find_compatible_node(NULL, NULL, "fsl,qe");
> +	if (!qe) {
> +		qe =3D of_find_node_by_type(NULL, "qe");
> +		if (!qe)
> +			return brg_clk;
> +	}
> +
> +	prop =3D of_get_property(qe, "brg-frequency", &size);
> +	if (!prop || size !=3D sizeof(*prop))
> +		return brg_clk;

You need an of_node_put(qe) before the return ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Feb_2008_00_13_18_+1100_7uvkjqS8iywucj=9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHpw92TgG2atn1QN8RAtowAKCUl18MfOG7dCDE4YU9YI9/G3V5uwCbBN0u
l1xo/3IUJg4tHodGl/KYNuk=
=S5qg
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Feb_2008_00_13_18_+1100_7uvkjqS8iywucj=9--
