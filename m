Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 933D5DDE9F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 14:59:41 +1100 (EST)
Date: Tue, 8 Jan 2008 14:59:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 5/8] pseries: phyp dump: register dump area.
Message-Id: <20080108145930.b285a408.sfr@canb.auug.org.au>
In-Reply-To: <4782C3AE.8060202@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com> <4782C3AE.8060202@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__8_Jan_2008_14_59_30_+1100_pPaf6Gm1M/fuHV2X"
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	lkessler@us.ibm.com, strosake@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__8_Jan_2008_14_59_30_+1100_pPaf6Gm1M/fuHV2X
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manish,

On Mon, 07 Jan 2008 18:28:30 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrot=
e:
>
> +++ linux-2.6.24-rc3-git1/arch/powerpc/platforms/pseries/phyp_dump.c	2007=
-11-21 16:06:52.000000000 -0600
> +static unsigned long init_dump_header(struct phyp_dump_header *ph)
> +{

> +	/* Get the required dump region sizes */
> +	rtas =3D of_find_node_by_path("/rtas");

You need to of_node_put(rtas) somewhere.

> +	if (sizes[0] =3D=3D 1)
> +		cpu_state_size =3D *((unsigned long *) &sizes[1]);

We normally don't put spaces after casts.

> +	ph->first_offset_section =3D
> +		(u32) &(((struct phyp_dump_header *) 0)->cpu_data);

		(u32)offsetof(struct phyp_dump_header, cpu_data);

> +static void register_dump_area(struct phyp_dump_header *ph, unsigned lon=
g addr)
> +{

> +	if (rc)
> +	{
> +		printk (KERN_ERR "phyp-dump: unexpected error (%d) on register\n", rc);
> +	}

The braces are not needed.

> +
> +	dump_area_length =3D init_dump_header (&phdr);

We don't put spaces after function names.

> +	free_area_length =3D phyp_dump_info->init_reserve_size - dump_area_leng=
th;
> +	dump_area_start =3D phyp_dump_info->init_reserve_start + free_area_leng=
th;
> +	dump_area_start =3D dump_area_start & PAGE_MASK; /* align down */
> +	free_area_length =3D dump_area_start - phyp_dump_info->init_reserve_sta=
rt;
> +
>  	if (dump_header =3D=3D NULL) {
> -		release_all();
> -		return 0;
> +		register_dump_area (&phdr, dump_area_start);

Ditto.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__8_Jan_2008_14_59_30_+1100_pPaf6Gm1M/fuHV2X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHgvUnTgG2atn1QN8RAp5gAJ9M08bl5Zrfp1X9ho94RXos/IRfrACfbpH/
+UzUIlHzhwWGkhgpDtVewaQ=
=82gI
-----END PGP SIGNATURE-----

--Signature=_Tue__8_Jan_2008_14_59_30_+1100_pPaf6Gm1M/fuHV2X--
