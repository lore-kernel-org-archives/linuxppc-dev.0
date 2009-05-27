Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 171E3DDFED
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 11:14:22 +1000 (EST)
Subject: Re: [PATCH] Display processor virtualization resource allocations
	in lparcfg
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Fontenot <nfont@austin.ibm.com>
In-Reply-To: <4A1C2E10.9020109@austin.ibm.com>
References: <4A1C2E10.9020109@austin.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-vD0qXCiw+v/S568Aop6z"
Date: Wed, 27 May 2009 11:14:22 +1000
Message-Id: <1243386862.18971.41.camel@concordia>
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


--=-vD0qXCiw+v/S568Aop6z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-05-26 at 12:59 -0500, Nathan Fontenot wrote:
> This patch updates the output from /proc/ppc64/lparcfg to display the
> processor virtualization resource allocations for a shared processor
> partition.

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

What if there is no such property?

> +		if (*perf_level >=3D 1) {
> +			seq_printf(m,
> +			    "physical_procs_allocated_to_virtualization=3D%d\n",
> +				   ppp_data.phys_platform_procs);
> +			seq_printf(m, "max_proc_capacity_available=3D%d\n",
> +				   ppp_data.max_proc_cap_avail);
> +			seq_printf(m, "entitled_proc_capacity_available=3D%d\n",
> +				   ppp_data.entitled_proc_cap_avail);
> +		}
> +
> +		of_node_put(root);
> +	}

cheers

--=-vD0qXCiw+v/S568Aop6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkock+UACgkQdSjSd0sB4dKCkACgu0uB/mxP4VRcWb/rB2u7vOSO
SAAAoKjt3OiC3O57wG1r7Fwpz6ocOqE6
=hYoJ
-----END PGP SIGNATURE-----

--=-vD0qXCiw+v/S568Aop6z--
