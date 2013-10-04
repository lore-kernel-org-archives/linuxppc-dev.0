Return-Path: <R65777@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 917E32C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2013 15:19:20 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH 1/7] powerpc: Add interface to get msi region information
Date: Fri, 4 Oct 2013 05:19:10 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0718FA58@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
 <20130924235812.GD9302@google.com>
In-Reply-To: <20130924235812.GD9302@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel=
.org]
> On Behalf Of Bjorn Helgaas
> Sent: Wednesday, September 25, 2013 5:28 AM
> To: Bhushan Bharat-R65777
> Cc: alex.williamson@redhat.com; joro@8bytes.org; benh@kernel.crashing.org=
;
> galak@kernel.crashing.org; linux-kernel@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; linux-pci@vger.kernel.org; agraf@suse.de; Wood Scot=
t-
> B07421; iommu@lists.linux-foundation.org; Bhushan Bharat-R65777
> Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region informa=
tion
>=20
> On Thu, Sep 19, 2013 at 12:59:17PM +0530, Bharat Bhushan wrote:
> > This patch adds interface to get following information
> >   - Number of MSI regions (which is number of MSI banks for powerpc).
> >   - Get the region address range: Physical page which have the
> >      address/addresses used for generating MSI interrupt
> >      and size of the page.
> >
> > These are required to create IOMMU (Freescale PAMU) mapping for
> > devices which are directly assigned using VFIO.
> >
> > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > ---
> >  arch/powerpc/include/asm/machdep.h |    8 +++++++
> >  arch/powerpc/include/asm/pci.h     |    2 +
> >  arch/powerpc/kernel/msi.c          |   18 ++++++++++++++++
> >  arch/powerpc/sysdev/fsl_msi.c      |   39 ++++++++++++++++++++++++++++=
+++++--
> >  arch/powerpc/sysdev/fsl_msi.h      |   11 ++++++++-
> >  drivers/pci/msi.c                  |   26 ++++++++++++++++++++++++
> >  include/linux/msi.h                |    8 +++++++
> >  include/linux/pci.h                |   13 ++++++++++++
> >  8 files changed, 120 insertions(+), 5 deletions(-)
> >
> > ...
>=20
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c index
> > aca7578..6d85c15 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -30,6 +30,20 @@ static int pci_msi_enable =3D 1;
> >
> >  /* Arch hooks */
> >
> > +#ifndef arch_msi_get_region_count
> > +int arch_msi_get_region_count(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> > +#ifndef arch_msi_get_region
> > +int arch_msi_get_region(int region_num, struct msi_region *region) {
> > +	return 0;
> > +}
> > +#endif
>=20
> This #define strategy is gone; see 4287d824 ("PCI: use weak functions for=
 MSI
> arch-specific functions").  Please use the weak function strategy for you=
r new
> MSI region functions.

ok

>=20
> > +
> >  #ifndef arch_msi_check_device
> >  int arch_msi_check_device(struct pci_dev *dev, int nvec, int type)  {
> > @@ -903,6 +917,18 @@ void pci_disable_msi(struct pci_dev *dev)  }
> > EXPORT_SYMBOL(pci_disable_msi);
> >
> > +int msi_get_region_count(void)
> > +{
> > +	return arch_msi_get_region_count();
> > +}
> > +EXPORT_SYMBOL(msi_get_region_count);
> > +
> > +int msi_get_region(int region_num, struct msi_region *region) {
> > +	return arch_msi_get_region(region_num, region); }
> > +EXPORT_SYMBOL(msi_get_region);
>=20
> Please split these interface additions, i.e., the drivers/pci/msi.c,
> include/linux/msi.h, and include/linux/pci.h changes, into a separate pat=
ch.

ok

>=20
> I don't know enough about VFIO to understand why these new interfaces are
> needed.  Is this the first VFIO IOMMU driver?  I see vfio_iommu_spapr_tce=
.c and
> vfio_iommu_type1.c but I don't know if they're comparable to the Freescal=
e PAMU.
> Do other VFIO IOMMU implementations support MSI?  If so, do they handle t=
he
> problem of mapping the MSI regions in a different way?

PAMU is an aperture type of IOMMU while other are paging type, So they are =
completely different from what PAMU is and handle that differently.

>=20
> >  /**
> >   * pci_msix_table_size - return the number of device's MSI-X table ent=
ries
> >   * @dev: pointer to the pci_dev data structure of MSI-X device
> > function diff --git a/include/linux/msi.h b/include/linux/msi.h index
> > ee66f3a..ae32601 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -50,6 +50,12 @@ struct msi_desc {
> >  	struct kobject kobj;
> >  };
> >
> > +struct msi_region {
> > +	int region_num;
> > +	dma_addr_t addr;
> > +	size_t size;
> > +};
>=20
> This needs some sort of explanatory comment.

Ok

-Bharat

>=20
> >  /*
> >   * The arch hook for setup up msi irqs
> >   */
> > @@ -58,5 +64,7 @@ void arch_teardown_msi_irq(unsigned int irq);  int
> > arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);  void
> > arch_teardown_msi_irqs(struct pci_dev *dev);  int
> > arch_msi_check_device(struct pci_dev* dev, int nvec, int type);
> > +int arch_msi_get_region_count(void);
> > +int arch_msi_get_region(int region_num, struct msi_region *region);
> >
> >  #endif /* LINUX_MSI_H */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h index
> > 186540d..2b26a59 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1126,6 +1126,7 @@ struct msix_entry {
> >  	u16	entry;	/* driver uses to specify entry, OS writes */
> >  };
> >
> > +struct msi_region;
> >
> >  #ifndef CONFIG_PCI_MSI
> >  static inline int pci_enable_msi_block(struct pci_dev *dev, unsigned
> > int nvec) @@ -1168,6 +1169,16 @@ static inline int
> > pci_msi_enabled(void)  {
> >  	return 0;
> >  }
> > +
> > +static inline int msi_get_region_count(void) {
> > +	return 0;
> > +}
> > +
> > +static inline int msi_get_region(int region_num, struct msi_region
> > +*region) {
> > +	return 0;
> > +}
> >  #else
> >  int pci_enable_msi_block(struct pci_dev *dev, unsigned int nvec);
> > int pci_enable_msi_block_auto(struct pci_dev *dev, unsigned int
> > *maxvec); @@ -1180,6 +1191,8 @@ void pci_disable_msix(struct pci_dev
> > *dev);  void msi_remove_pci_irq_vectors(struct pci_dev *dev);  void
> > pci_restore_msi_state(struct pci_dev *dev);  int
> > pci_msi_enabled(void);
> > +int msi_get_region_count(void);
> > +int msi_get_region(int region_num, struct msi_region *region);
> >  #endif
> >
> >  #ifdef CONFIG_PCIEPORTBUS
> > --
> > 1.7.0.4
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in t=
he body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
