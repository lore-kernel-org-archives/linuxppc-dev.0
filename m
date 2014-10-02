Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56C961A0975
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 07:02:30 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 93A37140180
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Oct 2014 07:02:26 +1000 (EST)
Message-ID: <1412283716.28143.22.camel@pasglop>
Subject: Re: [PATCH v2 1/4] pci/msi: Move "no_64bit_msi" flag from powerpc
 to generic pci_dev
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 03 Oct 2014 07:01:56 +1000
In-Reply-To: <20141002153101.GB18056@google.com>
References: <1412048401.4285.128.camel@pasglop>
 <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
 <CADnq5_PT+dX=KA4epGNRaoraco2z1pe5K7UgqLmTUhWMnvtWkw@mail.gmail.com>
 <1412108504.4285.155.camel@pasglop>
 <CADnq5_O_iLAZUKLL4nph8VwuP2NOkWXhBZC2XTSkFm5P42WZ+g@mail.gmail.com>
 <1412110946.4285.158.camel@pasglop>
 <CADnq5_OXBax1+TKPsR2RDYTWijQKDVw34ECfWzcwN2SibCGYTg@mail.gmail.com>
 <1412112324.4285.160.camel@pasglop> <1412210052.10667.0.camel@pasglop>
 <20141002153101.GB18056@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-02 at 09:31 -0600, Bjorn Helgaas wrote:

> > So this moves the flag to struct pci_dev instead and adjusts the
> > corresponding arch/powerpc code to look for it there. At this point,
> > there is no attempt at making other architectures honor it just yet,
> > though it appears that x86 doesn't care and always generates 32-bit
> > MSI addresses.
> 
> I thought you were going to add something in drivers/pci to make this more
> generic?

I don't see how. The only thing I can add is the check which I still
plan to do. But the decision on the address is in the arch.

> Is it feasible to structure this series as follows?
> 
>   - add generic stuff (struct pci_dev bit, msi.c checks)
>   - add quirks to drivers to set the pci_dev bit
>   - change powerpc to check pci_dev bit instead of pdn bit
>   - remove powerpc-specific quirks since nobody looks as the pdn bit
> 
> I think it would be easier to follow if the powerpc-specific parts weren't
> intertwined with the rest.

Well, in that case the first patch just adds one bit to pci_dev and
maybe one check for address to msi.c. Unfortunately there isn't more
I can do generically. But ok, I'll do it that way.

> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: <stable@vger.kernel.org>
> > ---
> > 
> > v2: Rename flag to "no_64bit_msi" as suggested by Bjorn
> > 
> >  arch/powerpc/include/asm/pci-bridge.h     | 2 --
> >  arch/powerpc/kernel/pci_64.c              | 5 +----
> >  arch/powerpc/platforms/powernv/pci-ioda.c | 3 +--
> >  arch/powerpc/platforms/powernv/pci.c      | 3 +--
> >  arch/powerpc/platforms/pseries/msi.c      | 2 +-
> >  include/linux/pci.h                       | 1 +
> >  6 files changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> > index 4ca90a3..725247b 100644
> > --- a/arch/powerpc/include/asm/pci-bridge.h
> > +++ b/arch/powerpc/include/asm/pci-bridge.h
> > @@ -159,8 +159,6 @@ struct pci_dn {
> >  
> >  	int	pci_ext_config_space;	/* for pci devices */
> >  
> > -	bool	force_32bit_msi;
> > -
> >  	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
> >  #ifdef CONFIG_EEH
> >  	struct eeh_dev *edev;		/* eeh device */
> > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> > index 155013d..d41a831 100644
> > --- a/arch/powerpc/kernel/pci_64.c
> > +++ b/arch/powerpc/kernel/pci_64.c
> > @@ -269,10 +269,7 @@ EXPORT_SYMBOL(pcibus_to_node);
> >  
> >  static void quirk_radeon_32bit_msi(struct pci_dev *dev)
> >  {
> > -	struct pci_dn *pdn = pci_get_pdn(dev);
> > -
> > -	if (pdn)
> > -		pdn->force_32bit_msi = true;
> > +	dev->no_64bit_msi = true;
> >  }
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> > index df241b1..a188bb8 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> > @@ -1311,7 +1311,6 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
> >  				  unsigned int is_64, struct msi_msg *msg)
> >  {
> >  	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
> > -	struct pci_dn *pdn = pci_get_pdn(dev);
> >  	struct irq_data *idata;
> >  	struct irq_chip *ichip;
> >  	unsigned int xive_num = hwirq - phb->msi_base;
> > @@ -1327,7 +1326,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
> >  		return -ENXIO;
> >  
> >  	/* Force 32-bit MSI on some broken devices */
> > -	if (pdn && pdn->force_32bit_msi)
> > +	if (dev->no_64bit_msi)
> >  		is_64 = 0;
> >  
> >  	/* Assign XIVE to PE */
> > diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> > index b854b57..89c6608 100644
> > --- a/arch/powerpc/platforms/powernv/pci.c
> > +++ b/arch/powerpc/platforms/powernv/pci.c
> > @@ -50,9 +50,8 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
> >  {
> >  	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
> >  	struct pnv_phb *phb = hose->private_data;
> > -	struct pci_dn *pdn = pci_get_pdn(pdev);
> >  
> > -	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
> > +	if (pdev->no_64bit_msi && !phb->msi32_support)
> >  		return -ENODEV;
> >  
> >  	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
> > diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> > index 18ff462..6fd96d8 100644
> > --- a/arch/powerpc/platforms/pseries/msi.c
> > +++ b/arch/powerpc/platforms/pseries/msi.c
> > @@ -429,7 +429,7 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
> >  	 */
> >  again:
> >  	if (type == PCI_CAP_ID_MSI) {
> > -		if (pdn->force_32bit_msi) {
> > +		if (pdev->no_64bit_msi) {
> >  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
> >  			if (rc < 0) {
> >  				/*
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 96453f9..fc938003 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -331,6 +331,7 @@ struct pci_dev {
> >  	unsigned int	is_added:1;
> >  	unsigned int	is_busmaster:1; /* device is busmaster */
> >  	unsigned int	no_msi:1;	/* device may not use msi */
> > +	unsigned int    no_64bit_msi:1;	/* Device has broken 64-bit MSIs */
> >  	unsigned int	block_cfg_access:1;	/* config space access is blocked */
> >  	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
> >  	unsigned int	irq_reroute_variant:2;	/* device needs IRQ rerouting variant */
> > 
> > 
> > 
