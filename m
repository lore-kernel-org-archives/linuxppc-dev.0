Return-Path: <bhelgaas@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19D491A0961
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 06:33:29 +1000 (EST)
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com
 [IPv6:2607:f8b0:4001:c03::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 632AD1400AB
 for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2014 06:33:27 +1000 (EST)
Received: by mail-ie0-f171.google.com with SMTP id tr6so1195335ieb.16
 for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2014 13:33:25 -0700 (PDT)
Date: Wed, 1 Oct 2014 14:33:22 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/4] pci/msi: Move "force_32bit_msi" flag from powerpc to
 generic pci_dev
Message-ID: <20141001203322.GE4171@google.com>
References: <1412048401.4285.128.camel@pasglop>
 <CAErSpo4B6kuZJcKwreNvW1qC5sZ=1Ko71vbzNz7T8-_pjf7mww@mail.gmail.com>
 <CADnq5_PT+dX=KA4epGNRaoraco2z1pe5K7UgqLmTUhWMnvtWkw@mail.gmail.com>
 <1412108504.4285.155.camel@pasglop>
 <CADnq5_O_iLAZUKLL4nph8VwuP2NOkWXhBZC2XTSkFm5P42WZ+g@mail.gmail.com>
 <1412110946.4285.158.camel@pasglop>
 <CADnq5_OXBax1+TKPsR2RDYTWijQKDVw34ECfWzcwN2SibCGYTg@mail.gmail.com>
 <1412112324.4285.160.camel@pasglop>
 <1412129363.4285.190.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412129363.4285.190.camel@pasglop>
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

On Wed, Oct 01, 2014 at 12:09:23PM +1000, Benjamin Herrenschmidt wrote:
> 
> Some devices have broken 64-bit MSI support which only support some
> address bits (40 to 48 typically). This doesn't work on some platforms
> such as POWER servers, so we need a quirk.
> 
> Currently we keep a flag in a powerpc specific data structure which we
> have per PCI device. However this is impractical as we really want the
> driver to set that flag appropriately (and the driver shouldn't touch
> that arch specific data structure).
> 
> It's also not unlikely that this limitation will affect other architectures
> in the long run so may as well be prepared for it.
> 
> So this moves the flag to struct pci_dev instead and adjusts the
> corresponding arch/powerpc code to look for it there. At this point,
> there is no attempt at making other architectures honor it just yet
> though from what I can tell, x86 seems to always use 32-bit addresses
> for MSIs.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: <stable@vger.kernel.org>
> ---
> 
> Note: CC'ing stable as I really want this to hit distros, without that
> (and the three subsequent patches), we crash during boot with a number
> of radeon cards on power machines.
> 
> Note2: Alex, we can wait for the response of the HW guys for which revisions
> actually need the quirk in hda_intel but I don't see a big risk or issue in
> just doing it for all AMD/ATI for now and fix that up later
> 
>  arch/powerpc/include/asm/pci-bridge.h     | 2 --
>  arch/powerpc/kernel/pci_64.c              | 5 +----
>  arch/powerpc/platforms/powernv/pci-ioda.c | 3 +--
>  arch/powerpc/platforms/powernv/pci.c      | 3 +--
>  arch/powerpc/platforms/pseries/msi.c      | 2 +-
>  include/linux/pci.h                       | 1 +
>  6 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 4ca90a3..725247b 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -159,8 +159,6 @@ struct pci_dn {
>  
>  	int	pci_ext_config_space;	/* for pci devices */
>  
> -	bool	force_32bit_msi;
> -
>  	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
>  #ifdef CONFIG_EEH
>  	struct eeh_dev *edev;		/* eeh device */
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 155013d..a6ce5fe 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -269,10 +269,7 @@ EXPORT_SYMBOL(pcibus_to_node);
>  
>  static void quirk_radeon_32bit_msi(struct pci_dev *dev)
>  {
> -	struct pci_dn *pdn = pci_get_pdn(dev);
> -
> -	if (pdn)
> -		pdn->force_32bit_msi = true;
> +	dev->force_32bit_msi = true;
>  }
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x68f2, quirk_radeon_32bit_msi);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0xaa68, quirk_radeon_32bit_msi);
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index df241b1..9d98475 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1311,7 +1311,6 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
>  				  unsigned int is_64, struct msi_msg *msg)
>  {
>  	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
> -	struct pci_dn *pdn = pci_get_pdn(dev);
>  	struct irq_data *idata;
>  	struct irq_chip *ichip;
>  	unsigned int xive_num = hwirq - phb->msi_base;
> @@ -1327,7 +1326,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
>  		return -ENXIO;
>  
>  	/* Force 32-bit MSI on some broken devices */
> -	if (pdn && pdn->force_32bit_msi)
> +	if (dev->force_32bit_msi)
>  		is_64 = 0;
>  
>  	/* Assign XIVE to PE */
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index b854b57..4e43a6f 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -50,9 +50,8 @@ static int pnv_msi_check_device(struct pci_dev* pdev, int nvec, int type)
>  {
>  	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>  	struct pnv_phb *phb = hose->private_data;
> -	struct pci_dn *pdn = pci_get_pdn(pdev);
>  
> -	if (pdn && pdn->force_32bit_msi && !phb->msi32_support)
> +	if (pdev->force_32bit_msi && !phb->msi32_support)
>  		return -ENODEV;
>  
>  	return (phb && phb->msi_bmp.bitmap) ? 0 : -ENODEV;
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 18ff462..b3f2c1a 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -429,7 +429,7 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  	 */
>  again:
>  	if (type == PCI_CAP_ID_MSI) {
> -		if (pdn->force_32bit_msi) {
> +		if (pdev->force_32bit_msi) {
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_32MSI_FN, nvec);
>  			if (rc < 0) {
>  				/*
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 96453f9..740cadd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -331,6 +331,7 @@ struct pci_dev {
>  	unsigned int	is_added:1;
>  	unsigned int	is_busmaster:1; /* device is busmaster */
>  	unsigned int	no_msi:1;	/* device may not use msi */
> +	unsigned int    force_32bit_msi:1;	/* Device has broken 64-bit MSIs */

I like the idea of handling this more generically, e.g., with a bit like
this in struct pci_dev (I'd probably name it something like "no_64bit_msi"
along the lines of your driver #defines).

What I don't like is that we haven't done anything to help other
architectures, because the only code that *looks* at this bit is in
arch/powerpc.  The next arch that tries to use 64-bit MSI addresses for
these devices will trip over the same problem.

Can we check in pci_enable_msi_range() and pci_enable_msix_range() whether
the MSI addresses allocated by the arch are too big, and fail the call if
they are?

Bjorn

>  	unsigned int	block_cfg_access:1;	/* config space access is blocked */
>  	unsigned int	broken_parity_status:1;	/* Device generates false positive parity */
>  	unsigned int	irq_reroute_variant:2;	/* device needs IRQ rerouting variant */
> 
> 
> 
