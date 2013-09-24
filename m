Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78F092C00C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 09:40:52 +1000 (EST)
Message-ID: <1380066039.24959.155.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2][RFC][v3] pci: fsl: rework PCI driver compatible
 with Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Lian Minghuan-b31939 <B31939@freescale.com>
Date: Tue, 24 Sep 2013 18:40:39 -0500
In-Reply-To: <52381F9C.200@freescale.com>
References: <1378980438-29888-1-git-send-email-Minghuan.Lian@freescale.com>
 <1378980438-29888-2-git-send-email-Minghuan.Lian@freescale.com>
 <1379376308.2536.217.camel@snotra.buserror.net>
 <52381F9C.200@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-09-17 at 17:23 +0800, Lian Minghuan-b31939 wrote:
> >> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> >> index a189ff0..4cb12e8 100644
> >> --- a/arch/powerpc/sysdev/fsl_pci.c
> >> +++ b/arch/powerpc/sysdev/fsl_pci.c
> >> @@ -62,7 +62,11 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
> >>   #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
> >>   
> >>   #define MAX_PHYS_ADDR_BITS	40
> >> -static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
> >> +
> >> +u64 fsl_arch_pci64_dma_offset(void)
> >> +{
> >> +	return 1ull << MAX_PHYS_ADDR_BITS;
> >> +}
> >>   
> >>   static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
> >>   {
> >> @@ -77,17 +81,43 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
> >>   	if ((dev->bus == &pci_bus_type) &&
> >>   	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
> >>   		set_dma_ops(dev, &dma_direct_ops);
> >> -		set_dma_offset(dev, pci64_dma_offset);
> >> +		set_dma_offset(dev, fsl_arch_pci64_dma_offset());
> >>   	}
> > Is the intent for fsl_arch_pci64_dma_offset() to eventually do something
> > that isn't calculable at compile time?
> >   
> [Minghuan]  fsl_arch_pci64_dma_offset() is also called by pci-fsl.c to 
> setup inbound ATMU.
> I think different platform or architecture(LS1) may use different dma 
> offset(maybe I am wrong
> they can use the same offset 1ull << MAX_PHYS_ADDR_BITS).  I selected
>   u64 fsl_arch_pci64_dma_offset(void) not extern u64 pci64_dma_offset to 
> share the global
> value between /driver/pci/host/pci-fsl.c and 
> arch/powerpc/sysdev/fsl_pci.c or / arch/arm/..../fsl_pci.c
> 'extern' variable will cause the warning when checking patch.

It will only warn if you're doing it wrong. :-P

Put the extern in a header and the actual declaration in the
arch-specific C file.

> >>   	*dev->dma_mask = dma_mask;
> >>   	return 0;
> >>   }
> >>   
> >> +struct fsl_pci *fsl_arch_sys_to_pci(void *sys)
> >> +{
> >> +	struct pci_controller *hose = sys;
> >> +	struct fsl_pci *pci = hose->private_data;
> > If this were just to convert to fsl_pci, that seems like header
> > material.
> [Minghuan] In arm architecture it will be implemented like this:
> struct fsl_pci *fsl_arch_sys_to_pci(void *sys) {
>   struct pci_sys_data *sys_data  = sys;
>    return  sys_data->private_data;
> }

Right, so make it an inline function in each architecture's header file.

> driver/pci/host/pci-fsl.c should not include any arch specific header file.

include/linux/fsl/pci.h could include <asm/fsl/pci.h>.  If this is the
only arch-specific thing that you need in a header, though, then I guess
leave it in the C file.

> >> +	/* Update the first bus number */
> >> +	if (pci->first_busno != hose->first_busno)
> >> +		pci->first_busno = hose->first_busno;
> > This isn't part of the interface description in the header...
> [Minghuan] Yes. host->first_busno will be reassigned if defined 
> PCI_REASSIGN_ALL_BUS.
> and I can not find a chance to update pci->first_busno. this will cause 
> we can not
> read/write pci configuration space when the hose->first_busno is changed 
> but pci->first_busno
> is not updated synchronously.
> 
> the following code to check first_busno when access the configuration space.
> 
>      if (pci->indirect_type & INDIRECT_TYPE_NO_PCIE_LINK) {
>          if (bus != pci->first_busno)
>              return PCIBIOS_DEVICE_NOT_FOUND;
> ...
>      }
> 
> bus_no = (bus == pci->first_busno) ? pci->self_busno : bus;
> 
> So I added the sentences to this function to fix the issue.

How was this handled in the old PPC code?  I don't see anything similar.
Is it only an issue on ARM?

At the very least this side-effect should be mentioned in the function
interface documentation, but I'd rather see a less hacky solution.

> >> @@ -260,14 +259,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
> >>   	/* we only need the error registers */
> >>   	r.start += 0xe00;
> >>   
> >> -	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
> >> -					pdata->name)) {
> >> -		printk(KERN_ERR "%s: Error while requesting mem region\n",
> >> -		       __func__);
> >> -		res = -EBUSY;
> >> -		goto err;
> >> -	}
> > Why?  If the relationship between the edac driver and the main pci
> > driver is changing, explain that.
> [Minghuan] Ok.
> The main pci driver used devm_ioremap_resource() to map regester space.

And it didn't before?  It'd be nice if this "rework" patch could be
split into digestible chunks, each explained on its own.

> >> +config PCI_FSL
> >> +	bool "Freescale PCI/PCIe controller"
> >> +	depends on FSL_SOC_BOOKE || PPC_86xx
> > Needs help text.
> >
> > Make it clear that this is for 85xx/86xx/QorIQ/Layerscape, not all
> > Freescale chips with PCI/PCIe.
> [Minghuan] Ok. I will add help text.
> >>   no_bridge:
> >> -	iounmap(hose->private_data);
> >> -	/* unmap cfg_data & cfg_addr separately if not on same page */
> >> -	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
> >> -	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
> >> -		iounmap(hose->cfg_data);
> >> -	iounmap(hose->cfg_addr);
> >> -	pcibios_free_controller(hose);
> >> -	return -ENODEV;
> >> +	dev_info(&pdev->dev, "It works as EP mode\n");
> >> +	return -EPERM;
> > This is a poorly phrased message.  In any case, what does this change
> > have to do with making the PCI driver compatible with layerscape?
> [Minghuan] I can not quite understand what you mean.
> Should I remove the "dev_info(&pdev->dev, "It works as EP mode\n");"
> and not change ENODEV to EPERM?
> we do not really need this change.
> If the controller is in EP mode, we only need to return an error, 
> because at this time
> 'hose' has not been created.

I don't have a strong opinion on the error code, but if you do change it
to EPERM it should be a separate patch with its own explanation.
"dev_info" seems inappropriate here -- either it indicates the caller
did something wrong, and thus should be dev_err() with a clearer message
(e.g. avoid words like "it" and unnecessary abbreviation), or this is
the normal point at which we detect that the hardware isn't configured
in host mode (in which case it should be at most dev_dbg).

-Scott
