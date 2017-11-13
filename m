Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ybV7T5yySzDqkQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 12:20:37 +1100 (AEDT)
Date: Tue, 14 Nov 2017 10:52:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
 Jonas Pfefferle1 <JPF@zurich.ibm.com>
Subject: Re: [PATCH kernel v2] powerpc/powernv/ioda: Remove explicit max
 window size check
Message-ID: <20171113235217.GB32308@umbus.fritz.box>
References: <20171107034301.35120-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
In-Reply-To: <20171107034301.35120-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 02:43:01PM +1100, Alexey Kardashevskiy wrote:
> DMA windows can only have a size of power of two on IODA2 hardware and
> using memory_hotplug_max() to determine the upper limit won't work
> correcly if it returns not power of two value.
>=20
> This removes the check as the platform code does this check in
> pnv_pci_ioda2_setup_default_config() anyway; the other client is VFIO
> and that thing checks against locked_vm limit which prevents the userspace
> from locking too much memory.
>=20
> It is expected to impact DPDK on machines with non-power-of-two RAM size,
> mostly. KVM guests are less likely to be affected as usually guests get
> less than half of hosts RAM.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This _can_ be called with essentially arbitrary window_size via the
VFIO code.  However, that should be constrained by the locked memory
limit, which is checked before this gets called.

> ---
> Changes:
> v2:
> * instead of relaxing the check, this simply removes it
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 1de94fb..433cf84 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2776,7 +2776,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid=
, __u64 bus_offset,
>  	if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
>  		return -EINVAL;
> =20
> -	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
> +	if (!is_power_of_2(window_size))
>  		return -EINVAL;
> =20
>  	/* Adjust direct table size from window_size and levels */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloKMC8ACgkQbDjKyiDZ
s5LfsA//Zy18ZAxF3l0+ixF6wStCenZD4GeB71kfxE/aoJqM/hjAg5WQuF89gfD9
KgGVAX28TmB2IEzOwNpKOgAEUh4ti05Om0mOHXa9PbW+JCLwbH/RecGDjT3fp1uO
+zX/eYhaj2YBDZEnqZ+WEQgD4J1zges/4+mi6mnqdRZqbVlgceVknOdHE6G7x78j
49HimTMzpCPLWpSawTnDTiNEEHiFulrMk3BmvyJAexsFbzbBeRxxriFYmTBR4RUO
CLV5p3PbLPEsxnXFBQkTWpUizCd177Yw4w6Qkd4oHdV+1PsWf0lNEK5Rg7JF/f9D
QZcQP3S9C6wZ/OES9tzC6WYTrfpM/iUU95YvW/aOgB06MtMSLUUroqYP8Vm5XiCI
l6E0j83fEQuu4rUdYZDZwQMU34oXEgg416TpbCEUs3ncEHMU37CKfymwUZjOFPbS
AteUugWQqwpq4qFvSAn2Wu2ZlIyt409/V3le6hLzYbB0zleParrz2DDGv4AeMWH9
4vE27gh8cQg3hgJxxqgE2ru+6yOYX6X/H1tlrniWkIESh6qFsMv4izW+mfDeANdm
7nMeM/ZCZCwajooWJuw1kH7JoeSHRAG++7Zm6jmbmAVCCGNMtz+fWa7OtPweYIks
BUIfJM+JeNDb67mq4TI3S/BpmU0qXvaKOdGrVQ9oLzgX2JZ9KWo=
=VGnC
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
