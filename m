Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 13185B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:33:51 +1000 (EST)
Received: by yxj4 with SMTP id 4so183181yxj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 15 Sep 2010 11:33:50 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1284573958-8397-10-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-10-git-send-email-nacc@us.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 15 Sep 2010 12:33:30 -0600
Message-ID: <AANLkTim2Sie0Hop7Akn2CsSgEMPOdq5kDRcfcnAFtghS@mail.gmail.com>
Subject: Re: [PATCH 09/15] ppc/vio: use dma ops helpers
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wro=
te:
> Use the set_dma_ops helper. Instead of modifying vio_dma_mapping_ops,
> just create a trivial wrapper for dma_supported.
>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Looks right to me.

> ---
> =A0arch/powerpc/kernel/vio.c | =A0 11 ++++++++---
> =A01 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> index d692989..3c3083f 100644
> --- a/arch/powerpc/kernel/vio.c
> +++ b/arch/powerpc/kernel/vio.c
> @@ -602,6 +602,11 @@ static void vio_dma_iommu_unmap_sg(struct device *de=
v,
> =A0 =A0 =A0 =A0vio_cmo_dealloc(viodev, alloc_size);
> =A0}
>
> +static int vio_dma_iommu_dma_supported(struct device *dev, u64 mask)
> +{
> + =A0 =A0 =A0 =A0return dma_iommu_ops.dma_supported(dev, mask);
> +}
> +
> =A0struct dma_map_ops vio_dma_mapping_ops =3D {
> =A0 =A0 =A0 =A0.alloc_coherent =3D vio_dma_iommu_alloc_coherent,
> =A0 =A0 =A0 =A0.free_coherent =A0=3D vio_dma_iommu_free_coherent,
> @@ -609,6 +614,7 @@ struct dma_map_ops vio_dma_mapping_ops =3D {
> =A0 =A0 =A0 =A0.unmap_sg =A0 =A0 =A0 =3D vio_dma_iommu_unmap_sg,
> =A0 =A0 =A0 =A0.map_page =A0 =A0 =A0 =3D vio_dma_iommu_map_page,
> =A0 =A0 =A0 =A0.unmap_page =A0 =A0 =3D vio_dma_iommu_unmap_page,
> + =A0 =A0 =A0 .dma_supported =A0=3D vio_dma_iommu_dma_supported,
>
> =A0};
>
> @@ -860,8 +866,7 @@ static void vio_cmo_bus_remove(struct vio_dev *viodev=
)
>
> =A0static void vio_cmo_set_dma_ops(struct vio_dev *viodev)
> =A0{
> - =A0 =A0 =A0 vio_dma_mapping_ops.dma_supported =3D dma_iommu_ops.dma_sup=
ported;
> - =A0 =A0 =A0 viodev->dev.archdata.dma_ops =3D &vio_dma_mapping_ops;
> + =A0 =A0 =A0 set_dma_ops(&viodev->dev, &vio_dma_mapping_ops);
> =A0}
>
> =A0/**
> @@ -1246,7 +1251,7 @@ struct vio_dev *vio_register_device_node(struct dev=
ice_node *of_node)
> =A0 =A0 =A0 =A0if (firmware_has_feature(FW_FEATURE_CMO))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vio_cmo_set_dma_ops(viodev);
> =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 viodev->dev.archdata.dma_ops =3D &dma_iommu=
_ops;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_dma_ops(&viodev->dev, &dma_iommu_ops);
> =A0 =A0 =A0 =A0set_iommu_table_base(&viodev->dev, vio_build_iommu_table(v=
iodev));
> =A0 =A0 =A0 =A0set_dev_node(&viodev->dev, of_node_to_nid(of_node));
>
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
