Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8B1DCDDEFA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 10:31:01 +1000 (EST)
Subject: Re: [PATCH] v2: Display processor virtualization resource
	allocations in lparcfg
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4A1D5111.10505@austin.ibm.com>
References: <4A1C2E10.9020109@austin.ibm.com> <4A1D5111.10505@austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-p8FwWL5EoWcfFmnT2YMd"
Date: Thu, 28 May 2009 10:31:00 +1000
Message-Id: <1243470660.4861.1.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-p8FwWL5EoWcfFmnT2YMd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-05-27 at 09:41 -0500, Nathan Fontenot wrote:
> This patch updates the output from /proc/ppc64/lparcfg to display the
> processor virtualization resource allocations for a shared processor
> partition.
>=20
> This information is already gathered via the h_get_ppp call, we just
> have to make sure that the ibm,partition-performance-parameters-level
> property is >=3D 1 to ensure that the information is valid.

> @@ -267,6 +281,28 @@
>  	seq_printf(m, "capped=3D%d\n", ppp_data.capped);
>  	seq_printf(m, "unallocated_capacity=3D%lld\n",
>  		   ppp_data.unallocated_entitlement);
> +
> +	/* The last bits of information returned from h_get_ppp are only
> +	 * valid if the ibm,partition-performance-parameters-level
> +	 * property is >=3D 1.
> +	 */
> +	root =3D of_find_node_by_path("/");
> +	if (root) {
> +		perf_level =3D of_get_property(root,
> +				"ibm,partition-performance-parameters-level",
> +					     NULL);
> +		if (perf_level && (*perf_level >=3D 1)) {

Yep that looks better, thanks.

cheers

--=-p8FwWL5EoWcfFmnT2YMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkod2z8ACgkQdSjSd0sB4dJHpgCgxdVmCWuLwqFGzHTnDNbdXMnL
B/wAniyXvpml3AiDUILQa16T2TYsP6FU
=YqXk
-----END PGP SIGNATURE-----

--=-p8FwWL5EoWcfFmnT2YMd--
