Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3922F2C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 10:05:22 +1000 (EST)
Message-ID: <1379376308.2536.217.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2][RFC][v3] pci: fsl: rework PCI driver compatible
 with Layerscape
From: Scott Wood <scottwood@freescale.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Date: Mon, 16 Sep 2013 19:05:08 -0500
In-Reply-To: <1378980438-29888-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1378980438-29888-1-git-send-email-Minghuan.Lian@freescale.com>
 <1378980438-29888-2-git-send-email-Minghuan.Lian@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-12 at 18:07 +0800, Minghuan Lian wrote:
> The Freescale's Layerscape series processors will use the same PCI
> controller but change cores from PowerPC to ARM. This patch is to
> rework FSL PCI driver to support PowerPC and ARM simultaneously.
> PowerPC uses structure pci_controller to describe PCI controller,
> but arm uses structure hw_pci and pci_sys_data. They also have
> different architecture implementation and initialization flow.
> The architecture-dependent driver will bridge the gap, get the
> settings from the common driver and initialize the corresponding
> structure and call the related interface to register PCI controller.
> The common driver pci-fsl.c removes all the architecture-specific
> code and provides structure fsl_pci to store all the controller
> settings and the common functionalities that include reading/writing
> PCI configuration space, parsing dts node and getting the MEM/IO and
> bus number ranges, setting ATMU and check link status.
> 
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
> Based on upstream master
> The function has been tested on MPC8315ERDB MPC8572DS P5020DS P3041DS
> and T4240QDS boards 
> 
> Change log:
> v3:
> 1. use 'fsl_arch' as function name prefix of all the
>    architecture-specific hooks.
> 2. Move PCI compatible definitions from arch/powerpc/sysdev/fsl_pci.c
>    to driver/pci/host/pci-fsl.c 
> 
> v2:
> 1. Use 'pci' instead of 'pcie' in new file name and file contents. 
> 2. Use iowrite32be()/iowrite32() instead of out_be32/le32()
> 3. Fix ppc_md.dma_set_mask setting
> 4. Synchronizes host->first_busno and pci->first_busno.
> 5. Fix PCI IO space settings
> 6. Some small changes according to Scott's comments.
> 
> 
>  arch/powerpc/Kconfig          |   1 +
>  arch/powerpc/sysdev/fsl_pci.c | 150 +++++++++-
>  drivers/edac/mpc85xx_edac.c   |   9 -
>  drivers/pci/host/Kconfig      |   4 +
>  drivers/pci/host/Makefile     |   1 +
>  drivers/pci/host/pci-fsl.c    | 656 +++++++++++++++++++++++++++---------------
>  include/linux/fsl/pci.h       |  69 +++++
>  7 files changed, 648 insertions(+), 242 deletions(-)

The PCI mailing list and maintainer should be included.

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6b7530f..657d90f 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -691,6 +691,7 @@ config FSL_SOC
>  
>  config FSL_PCI
>   	bool
> +	select PCI_FSL if FSL_SOC_BOOKE || PPC_86xx
>  	select PPC_INDIRECT_PCI
>  	select PCI_QUIRKS
>  
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index a189ff0..4cb12e8 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -62,7 +62,11 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
>  #if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
>  
>  #define MAX_PHYS_ADDR_BITS	40
> -static u64 pci64_dma_offset = 1ull << MAX_PHYS_ADDR_BITS;
> +
> +u64 fsl_arch_pci64_dma_offset(void)
> +{
> +	return 1ull << MAX_PHYS_ADDR_BITS;
> +}
>  
>  static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
>  {
> @@ -77,17 +81,43 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
>  	if ((dev->bus == &pci_bus_type) &&
>  	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
>  		set_dma_ops(dev, &dma_direct_ops);
> -		set_dma_offset(dev, pci64_dma_offset);
> +		set_dma_offset(dev, fsl_arch_pci64_dma_offset());
>  	}

Is the intent for fsl_arch_pci64_dma_offset() to eventually do something
that isn't calculable at compile time?
 
>  	*dev->dma_mask = dma_mask;
>  	return 0;
>  }
>  
> +struct fsl_pci *fsl_arch_sys_to_pci(void *sys)
> +{
> +	struct pci_controller *hose = sys;
> +	struct fsl_pci *pci = hose->private_data;

If this were just to convert to fsl_pci, that seems like header
material.

> +	/* Update the first bus number */
> +	if (pci->first_busno != hose->first_busno)
> +		pci->first_busno = hose->first_busno;

This isn't part of the interface description in the header...

> +static int mpc83xx_pcie_check_link(struct pci_controller *hose)
> +{
> +	u32 val = 0;
> +
> +#define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
> +#define PCIE_LTSSM_L0	0x16		/* L0 state */
> +
> +	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
> +	if (val < PCIE_LTSSM_L0)
> +		return 1;
> +	return 0;
> +}

Aren't PCIE_LTSSM and PCIE_LTSSM_L0 defined in include/linux/fsl/pci.h
at this point?

> @@ -260,14 +259,6 @@ int mpc85xx_pci_err_probe(struct platform_device *op)
>  	/* we only need the error registers */
>  	r.start += 0xe00;
>  
> -	if (!devm_request_mem_region(&op->dev, r.start, resource_size(&r),
> -					pdata->name)) {
> -		printk(KERN_ERR "%s: Error while requesting mem region\n",
> -		       __func__);
> -		res = -EBUSY;
> -		goto err;
> -	}

Why?  If the relationship between the edac driver and the main pci
driver is changing, explain that.

>  	pdata->pci_vbase = devm_ioremap(&op->dev, r.start, resource_size(&r));
>  	if (!pdata->pci_vbase) {
>  		printk(KERN_ERR "%s: Unable to setup PCI err regs\n", __func__);
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 3d95048..37d25ae 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -19,4 +19,8 @@ config PCI_TEGRA
>  	bool "NVIDIA Tegra PCIe controller"
>  	depends on ARCH_TEGRA
>  
> +config PCI_FSL
> +	bool "Freescale PCI/PCIe controller"
> +	depends on FSL_SOC_BOOKE || PPC_86xx

Needs help text.

Make it clear that this is for 85xx/86xx/QorIQ/Layerscape, not all
Freescale chips with PCI/PCIe.

>  no_bridge:
> -	iounmap(hose->private_data);
> -	/* unmap cfg_data & cfg_addr separately if not on same page */
> -	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
> -	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
> -		iounmap(hose->cfg_data);
> -	iounmap(hose->cfg_addr);
> -	pcibios_free_controller(hose);
> -	return -ENODEV;
> +	dev_info(&pdev->dev, "It works as EP mode\n");
> +	return -EPERM;

This is a poorly phrased message.  In any case, what does this change
have to do with making the PCI driver compatible with layerscape?

-Scott
