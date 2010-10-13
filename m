Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 085C5B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Oct 2010 16:13:35 +1100 (EST)
Subject: Re: [PATCH 09/15] ppc/vio: use dma ops helpers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
In-Reply-To: <AANLkTim2Sie0Hop7Akn2CsSgEMPOdq5kDRcfcnAFtghS@mail.gmail.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-10-git-send-email-nacc@us.ibm.com>
	<AANLkTim2Sie0Hop7Akn2CsSgEMPOdq5kDRcfcnAFtghS@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Oct 2010 15:56:00 +1100
Message-ID: <1286945760.2205.0.camel@pasglop>
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-15 at 12:33 -0600, Grant Likely wrote:
> On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > Use the set_dma_ops helper. Instead of modifying vio_dma_mapping_ops,
> > just create a trivial wrapper for dma_supported.
> >
> > Signed-off-by: Milton Miller <miltonm@bga.com>
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> 
> Looks right to me.

I never saw 8/15 btw ... I'm applying up to 7, please resend the rest.

Cheers,
Ben.

> > ---
> >  arch/powerpc/kernel/vio.c |   11 ++++++++---
> >  1 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
> > index d692989..3c3083f 100644
> > --- a/arch/powerpc/kernel/vio.c
> > +++ b/arch/powerpc/kernel/vio.c
> > @@ -602,6 +602,11 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
> >        vio_cmo_dealloc(viodev, alloc_size);
> >  }
> >
> > +static int vio_dma_iommu_dma_supported(struct device *dev, u64 mask)
> > +{
> > +        return dma_iommu_ops.dma_supported(dev, mask);
> > +}
> > +
> >  struct dma_map_ops vio_dma_mapping_ops = {
> >        .alloc_coherent = vio_dma_iommu_alloc_coherent,
> >        .free_coherent  = vio_dma_iommu_free_coherent,
> > @@ -609,6 +614,7 @@ struct dma_map_ops vio_dma_mapping_ops = {
> >        .unmap_sg       = vio_dma_iommu_unmap_sg,
> >        .map_page       = vio_dma_iommu_map_page,
> >        .unmap_page     = vio_dma_iommu_unmap_page,
> > +       .dma_supported  = vio_dma_iommu_dma_supported,
> >
> >  };
> >
> > @@ -860,8 +866,7 @@ static void vio_cmo_bus_remove(struct vio_dev *viodev)
> >
> >  static void vio_cmo_set_dma_ops(struct vio_dev *viodev)
> >  {
> > -       vio_dma_mapping_ops.dma_supported = dma_iommu_ops.dma_supported;
> > -       viodev->dev.archdata.dma_ops = &vio_dma_mapping_ops;
> > +       set_dma_ops(&viodev->dev, &vio_dma_mapping_ops);
> >  }
> >
> >  /**
> > @@ -1246,7 +1251,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
> >        if (firmware_has_feature(FW_FEATURE_CMO))
> >                vio_cmo_set_dma_ops(viodev);
> >        else
> > -               viodev->dev.archdata.dma_ops = &dma_iommu_ops;
> > +               set_dma_ops(&viodev->dev, &dma_iommu_ops);
> >        set_iommu_table_base(&viodev->dev, vio_build_iommu_table(viodev));
> >        set_dev_node(&viodev->dev, of_node_to_nid(of_node));
> >
> > --
> > 1.7.0.4
> >
> >
> 
> 
> 
