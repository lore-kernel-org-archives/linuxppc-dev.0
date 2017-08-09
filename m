Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS2Fv2r9xzDqvG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:00:03 +1000 (AEST)
Date: Wed, 9 Aug 2017 16:59:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 5/5] vfio-pci: Allow to expose MSI-X table to
 userspace when safe
Message-ID: <20170809065955.GL13670@umbus.fritz.box>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <20170807072548.3023-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UUBKWyapWpFAak7q"
In-Reply-To: <20170807072548.3023-6-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--UUBKWyapWpFAak7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 05:25:48PM +1000, Alexey Kardashevskiy wrote:
1;4803;0c> Some devices have a MSIX BAR not aligned to the system page size
> greater than 4K (like 64k for ppc64) which at the moment prevents
> such MMIO pages from being mapped to the userspace for the sake of
> the MSIX BAR content protection. If such page happens to share
> the same system page with some frequently accessed registers,
> the entire system page will be emulated which can seriously affect
> performance.
>=20
> This allows mapping of MSI-X tables to userspace if hardware provides
> MSIX isolation via interrupt remapping or filtering; in other words
> allowing direct access to the MSIX BAR won't do any harm to other devices
> or cause spurious interrupts visible to the kernel.
>=20
> This adds a wrapping helper to check if a capability is supported by
> an IOMMU group.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/linux/vfio.h             |  1 +
>  drivers/vfio/pci/vfio_pci.c      | 20 +++++++++++++++++---
>  drivers/vfio/pci/vfio_pci_rdwr.c |  5 ++++-
>  drivers/vfio/vfio.c              | 15 +++++++++++++++
>  4 files changed, 37 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 586809abb273..7110bca2fb60 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -46,6 +46,7 @@ struct vfio_device_ops {
> =20
>  extern struct iommu_group *vfio_iommu_group_get(struct device *dev);
>  extern void vfio_iommu_group_put(struct iommu_group *group, struct devic=
e *dev);
> +extern bool vfio_iommu_group_is_capable(struct device *dev, unsigned lon=
g cap);

This diff probably belongs in the earlier patch adding the function,
rather than here where it's first used.  Not worth respinning just for
that, though.

>  extern int vfio_add_group_dev(struct device *dev,
>  			      const struct vfio_device_ops *ops,
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index d87a0a3cda14..c4c39ed64b1e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -561,11 +561,17 @@ static int msix_sparse_mmap_cap(struct vfio_pci_dev=
ice *vdev,
>  	struct vfio_region_info_cap_sparse_mmap *sparse;
>  	size_t end, size;
>  	int nr_areas =3D 2, i =3D 0, ret;
> +	bool is_msix_isolated =3D vfio_iommu_group_is_capable(&vdev->pdev->dev,
> +			IOMMU_GROUP_CAP_ISOLATE_MSIX);
> =20
>  	end =3D pci_resource_len(vdev->pdev, vdev->msix_bar);
> =20
> -	/* If MSI-X table is aligned to the start or end, only one area */
> -	if (((vdev->msix_offset & PAGE_MASK) =3D=3D 0) ||
> +	/*
> +	 * If MSI-X table is allowed to mmap because of the capability
> +	 * of IRQ remapping or aligned to the start or end, only one area
> +	 */
> +	if (is_msix_isolated ||
> +	    ((vdev->msix_offset & PAGE_MASK) =3D=3D 0) ||
>  	    (PAGE_ALIGN(vdev->msix_offset + vdev->msix_size) >=3D end))
>  		nr_areas =3D 1;
> =20
> @@ -577,6 +583,12 @@ static int msix_sparse_mmap_cap(struct vfio_pci_devi=
ce *vdev,
> =20
>  	sparse->nr_areas =3D nr_areas;
> =20
> +	if (is_msix_isolated) {
> +		sparse->areas[i].offset =3D 0;
> +		sparse->areas[i].size =3D end;
> +		return 0;
> +	}
> +
>  	if (vdev->msix_offset & PAGE_MASK) {
>  		sparse->areas[i].offset =3D 0;
>  		sparse->areas[i].size =3D vdev->msix_offset & PAGE_MASK;
> @@ -1094,6 +1106,8 @@ static int vfio_pci_mmap(void *device_data, struct =
vm_area_struct *vma)
>  	unsigned int index;
>  	u64 phys_len, req_len, pgoff, req_start;
>  	int ret;
> +	bool is_msix_isolated =3D vfio_iommu_group_is_capable(&vdev->pdev->dev,
> +			IOMMU_GROUP_CAP_ISOLATE_MSIX);
> =20
>  	index =3D vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
> =20
> @@ -1115,7 +1129,7 @@ static int vfio_pci_mmap(void *device_data, struct =
vm_area_struct *vma)
>  	if (req_start + req_len > phys_len)
>  		return -EINVAL;
> =20
> -	if (index =3D=3D vdev->msix_bar) {
> +	if (index =3D=3D vdev->msix_bar && !is_msix_isolated) {
>  		/*
>  		 * Disallow mmaps overlapping the MSI-X table; users don't
>  		 * get to touch this directly.  We could find somewhere
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci=
_rdwr.c
> index 357243d76f10..7514206a5ea7 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -18,6 +18,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
>  #include <linux/vgaarb.h>
> +#include <linux/vfio.h>
> =20
>  #include "vfio_pci_private.h"
> =20
> @@ -123,6 +124,8 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev,=
 char __user *buf,
>  	resource_size_t end;
>  	void __iomem *io;
>  	ssize_t done;
> +	bool is_msix_isolated =3D vfio_iommu_group_is_capable(&vdev->pdev->dev,
> +			IOMMU_GROUP_CAP_ISOLATE_MSIX);
> =20
>  	if (pci_resource_start(pdev, bar))
>  		end =3D pci_resource_len(pdev, bar);
> @@ -164,7 +167,7 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_device *vdev,=
 char __user *buf,
>  	} else
>  		io =3D vdev->barmap[bar];
> =20
> -	if (bar =3D=3D vdev->msix_bar) {
> +	if (bar =3D=3D vdev->msix_bar && !is_msix_isolated) {
>  		x_start =3D vdev->msix_offset;
>  		x_end =3D vdev->msix_offset + vdev->msix_size;
>  	}
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 330d50582f40..5292c4a5ae8f 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -169,6 +169,21 @@ void vfio_iommu_group_put(struct iommu_group *group,=
 struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(vfio_iommu_group_put);
> =20
> +bool vfio_iommu_group_is_capable(struct device *dev, unsigned long cap)
> +{
> +	bool ret =3D false;
> +	struct iommu_group *group =3D vfio_iommu_group_get(dev);
> +
> +	if (group) {
> +		ret =3D iommu_group_is_capable(group, cap);
> +
> +		vfio_iommu_group_put(group, dev);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vfio_iommu_group_is_capable);
> +
>  #ifdef CONFIG_VFIO_NOIOMMU
>  static void *vfio_noiommu_open(unsigned long arg)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UUBKWyapWpFAak7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKsukACgkQbDjKyiDZ
s5K+xhAApKQABfyNWe9y/xjrCNibbHa6WBTyNix2cca6qN86b//+LwByM40Lk7Di
5VnZcK3oZCYrHi5alI2Wmar6LoLW9zfJIdxfrS8VjMo1H1EGtlkrlpmjdd5ttKe2
tacCYW7EN4n1/W4JJbJrfTwIVvL+CvhrE5xp1L6LDFyXOCXckObNB677ku1MNy1U
mMV6InwSK5I3WQe6TyZRjOv/fC++FKO9bWb9gATixj0DuCoM1EpfERsgYbEdp5X3
1dLzjo51na0oEdj9RZKSPPJeafg+buDiynPiTGUEzAK/9du0BxD3q7yl6/lCEEBS
j9vukaevolLscoNLXkBHo7vkqdRC4giFm0WEVi6zUgEfu/PXXllPfN6o5W1HkE8V
XY1+YL6yYXFes+BFfW4834jb5+i4N78Wc20TMWwHhI/U8E2CSjnMIYLdHwZ9e2TB
u4gEVfbSJdtiVbMznu+6JUW0rKobyA4CuBENujRxj+FMlVdCKgNo4gLnELQ49o9Q
/6GHMKQaN8fCdDnbwHo/QuJpEOrvlG6FkIer4o+3Z9P1gjl11rRawizWnnjzX1Rt
OpsneNU133RI1f6HcK+fMO8s83KYTZRzDsD5haktns2UDKAuVGX/YD2M6qScX661
OF7BAZoVp7u4ircwf+a9lpIBL7BAG3wLHuK8395V6/cLgrX4vF8=
=NhNC
-----END PGP SIGNATURE-----

--UUBKWyapWpFAak7q--
