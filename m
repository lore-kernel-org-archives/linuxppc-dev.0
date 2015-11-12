Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 018911A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 14:30:46 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so52390258pas.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2015 19:30:44 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 11/50] powerpc/powernv: IO and M32 mapping based on PCI
 device resources
In-Reply-To: <1446642770-4681-12-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-12-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2015 14:30:27 +1100
Message-ID: <87lha3j3n0.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Gavin,

Sorry to have taken so long to resume these reviews!

> Currently, the IO and M32 segments are mapped to the corresponding
> PE based on the windows of the parent bridge of PE's primary bus.
> It's not going to work when the windows of root port or upstream
> port of the PCIe switch behind root port are extended to PHB's
> aperatuses in order to support hotplug in subsequent patch.
I'm not _entirely_ sure I understand this.

I *think* you mean PHB's apertures (i.e. s/aperatuses/apertures/)?

> This fixes the issue by mapping IO and M32 segments based on the
> resources of the PCI devices included in the PE, instead of the
> windows of the parent bridge of the PE's primary bus.

This solution seems to make a lot of sense, but I don't have a very good
understanding of PCI yet: why was it done that way and not this way
originally? Looking at the code, it looks like the old way was simple
but didn't support SR-IOV?

There are a few comments inline as well.

> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 553d3f3..4ab93f8 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2741,71 +2741,90 @@ truncate_iov:
>  }
>  #endif /* CONFIG_PCI_IOV */
>=20=20
> -/*
> - * This function is supposed to be called on basis of PE from top
> - * to bottom style. So the the I/O or MMIO segment assigned to
> - * parent PE could be overrided by its child PEs if necessary.
> - */
> -static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
> -				  struct pnv_ioda_pe *pe)
> +static int pnv_ioda_setup_one_res(struct pnv_ioda_pe *pe,
> +				  struct resource *res)
>  {
> -	struct pnv_phb *phb =3D hose->private_data;
> +	struct pnv_phb *phb =3D pe->phb;
>  	struct pci_bus_region region;
> -	struct resource *res;
> -	unsigned int segsize;
> -	int *segmap, index, i;
> +	unsigned int index, segsize;
> +	int *segmap;
>  	uint16_t win;
>  	int64_t rc;

s/int64_t/s64/;
I think we might also want to change the uint16_t as well.

> -	/*
> -	 * NOTE: We only care PCI bus based PE for now. For PCI
> -	 * device based PE, for example SRIOV sensitive VF should
> -	 * be figured out later.
> -	 */
> -	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
> +	if (!res->parent || !res->flags || res->start > res->end)
> +		return 0;
>=20=20
> -	pci_bus_for_each_resource(pe->pbus, res, i) {
> -		if (!res || !res->flags ||
> -		    res->start > res->end)
> -			continue;
> +	if (res->flags & IORESOURCE_IO) {
> +		region.start =3D res->start - phb->ioda.io_pci_base;
> +		region.end   =3D res->end - phb->ioda.io_pci_base;
> +		segsize      =3D phb->ioda.io_segsize;
> +		segmap       =3D phb->ioda.io_segmap;
> +		win          =3D OPAL_IO_WINDOW_TYPE;
> +	} else if ((res->flags & IORESOURCE_MEM) &&
> +		   !pnv_pci_is_mem_pref_64(res->flags)) {
> +		region.start =3D res->start -
> +			       phb->hose->mem_offset[0] -
> +			       phb->ioda.m32_pci_base;
> +		region.end   =3D res->end -
> +			       phb->hose->mem_offset[0] -
> +			       phb->ioda.m32_pci_base;
> +		segsize      =3D phb->ioda.m32_segsize;
> +		segmap       =3D phb->ioda.m32_segmap;
> +		win          =3D OPAL_M32_WINDOW_TYPE;
> +	} else {
> +		return 0;
The return codes are currently unused, but should this get a more
informative return code? Are there any invalid ones that should be
flagged, or is it just safe to ignore stuff we don't recognise?

> +	}


> +static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
> +{
> +	struct pci_dev *pdev;
> +	struct resource *res;
> +	int i;
> +
> +	/* This function only works for bus dependent PE */
> +	WARN_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
> +
> +	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
> +		for (i =3D 0; i <=3D PCI_ROM_RESOURCE; i++) {
> +			res =3D &pdev->resource[i];
> +			if (pnv_ioda_setup_one_res(pe, res))
> +				return;
As I mentioned earlier, setup_one_res can potentially return -EIO:
should we be trying to propagate that up?
> +		}
> +
> +		/*
> +		 * If the PE contains all subordinate PCI buses, the
> +		 * windows of the child bridges should be mapped to
> +		 * the PE as well.
> +		 */
> +		if (!(pe->flags & PNV_IODA_PE_BUS_ALL && pci_is_bridge(pdev)))
> +			continue;
>=20=20
> -			region.start +=3D segsize;
> -			index++;
> +		for (i =3D 0; i <=3D PCI_BRIDGE_RESOURCE_NUM; i++) {
> +			res =3D &pdev->resource[PCI_BRIDGE_RESOURCES + i];
> +			if (pnv_ioda_setup_one_res(pe, res))
> +				return;
>  		}
>  	}
>  }

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWRAfTAAoJEPC3R3P2I92FtTYQAJw1vvFNRcSsXcDhZQZYAJ9X
PpE5r9hSEthRHXanCuU4Zj90i/OxHW6OohP5+vjUNGzmyKvynUlc62YzMCKsiNN0
udTFxeGdAzxTI8gdkVIau7mwEa21o8ZvQ0/EiEkWV3coQqm0DbupI2DDxilpNEw5
0+68ruVsyzFuBZoLHMQO0Z7teVteQzSJ2xtmpGOdbIcd7BwHzi8HsFHgJ2qebL7H
PdevaDa0t4O3x8SVKmwTJyePiUIidlK1AIsWVkVtvo2qvTYmva0N16yAFS8U6K21
kPnHq+aJj8kJ36u2pqWNAEStzZq0kFXa3zrBWkkskAYpSNd2SyGcKYtvKfAwzb9p
ITYTty/y+RKWMnBWVD1Z70Q81OHiJB6L//2ROB0NvFq5hGLQgh7e+U/ccfNQlzXP
L37i0Ckmw+kxTQqNQlLeHgsu4D5q+OxMT10e4F+xZgxANgY6Yk3fX8GXefmL0Xu6
SrDRSO21uQj2WSVZORfyYV9Er6BkZ0remgLaMDeDrEjBYYHdE3/qXeJ6qwtL0ytO
Wn3dSRAZr8qg+JVK0kdpUotVFIj0cUsmp4K5k2ElRR/kW+HzBD80fbIL8m91Wx1I
x/AlCjCt5ARF2w6oA49Dl8Jnm3EHketzZEiAn9jXgtPOtPXdODbXAwtU+00CALyo
6uVIXZRMukbEfdBk10yw
=L90z
-----END PGP SIGNATURE-----
--=-=-=--
