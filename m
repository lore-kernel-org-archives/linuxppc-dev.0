Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSg021bl9zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 12:34:42 +1100 (AEDT)
Date: Wed, 22 Feb 2017 11:36:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel] powerpc/powernv/npu: Remove dead iommu code
Message-ID: <20170222003621.GA12577@umbus.fritz.box>
References: <20170221024020.47631-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <20170221024020.47631-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 21, 2017 at 01:40:20PM +1100, Alexey Kardashevskiy wrote:
> PNV_IODA_PE_DEV is only used for NPU devices (emulated PCI bridges
> representing NVLink). These are added to IOMMU groups with corresponding
> NVIDIA devices after all non-NPU PEs are setup; a special helper -
> pnv_pci_ioda_setup_iommu_api() - handles this in pnv_pci_ioda_fixup().
>=20
> The pnv_pci_ioda2_setup_dma_pe() helper sets up DMA for a PE. It is called
> for VFs (so it does not handle NPU case) and PCI bridges but only
> IODA1 and IODA2 types. An NPU bridge has its own type id (PNV_PHB_NPU)
> so pnv_pci_ioda2_setup_dma_pe() cannot be called on NPU and therefore
> (pe->flags & PNV_IODA_PE_DEV) is always "false".
>=20
> This removes not used iommu_add_device(). This should not cause any
> behavioral change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 5fcae29107e1..51ec0dc1dfde 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2724,9 +2724,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	if (rc)
>  		return;
> =20
> -	if (pe->flags & PNV_IODA_PE_DEV)
> -		iommu_add_device(&pe->pdev->dev);
> -	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
> +	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrN0DAAoJEGw4ysog2bOSIO0P/0/rEdWYaA5u+HQ+oPSwlrZM
bjWOEzipYZfZt62/2y2hzFpIKDkmRk6Q9QlKFRdgbacvjFKd9hkimYXl7JOb3r2t
uyOll+7QHsmZLVENXKMhxEFEIdmJxS4XG7qJuE9YYqHLq7iQjP9w1XZxRIjae9OC
LQLJUzRdNbzYLBu4neBwjjkj//cuDRVBCqJrVAsSDgEWw44TU9Q0psAo+E0NC/X+
pWneDaXup9j3ENRV7nMhuK09eY9V16gONoY/CZCQQXukLd/WCszpPIOFDOC/cA4v
L0cUKrgO24//7uwgwD2JKYa27gl9pQ0EOg7if7MNAA4EM+HbV1B1H6iEkWEjFTzx
N9nAGFfYFaEzznujFJgdIy1ictHV5touMkB3BR4oPPj9oQ+77bEy1sj9D8Imhxix
H612CfC6PtrVxnJZNunRdlmSKydolFNu/aFtVyVADkoVegBocYSEOVzrKUExQgL3
Kj1mwRzfTy3Oojq65NMhREElvXK7fZor1yJLOfweJ1bVgkJtv0aXxVpXMHSGdJwo
Vnem3V0uaVdQiRnNcKY6qSIJ8bY8rjAAo/PUfi2HCtLyvsiProZpmMWBLDcDswPy
VPj/nvinlHd7CmLGh810VPIADyBHmkgglNQm0yCtuwggOjUqOr3iQwldQX0VOSrO
2yy4Vp7dmwvfZZEdB3ic
=+8/n
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
