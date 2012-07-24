Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2AE502C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 04:42:52 +1000 (EST)
Message-ID: <500EECA3.3050806@freescale.com>
Date: Tue, 24 Jul 2012 13:42:43 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH 1/6] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
In-Reply-To: <1343125210-16720-1-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/24/2012 05:20 AM, Jia Hongtao wrote:
> We unified the Freescale pci/pcie initialization by changing the fsl_pci
> to a platform driver.
> 
> In previous version pci/pcie initialization is in platform code which
> Initialize pci bridge base on EP/RC or host/agent settings.

The previous version of what?  This patch, or the PCI code?  What
changed in this patch since the last time you sent it, and where is the
version number?

> +#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
> +static const struct of_device_id pci_ids[] = {
> +	{ .compatible = "fsl,mpc8540-pci", },
> +	{ .compatible = "fsl,mpc8548-pcie", },
> +	{ .compatible = "fsl,mpc8641-pcie", },
> +	{ .compatible = "fsl,p1022-pcie", },
> +	{ .compatible = "fsl,p1010-pcie", },
> +	{ .compatible = "fsl,p1023-pcie", },
> +	{ .compatible = "fsl,p4080-pcie", },
> +	{ .compatible = "fsl,qoriq-pcie-v2.3", },
> +	{ .compatible = "fsl,qoriq-pcie-v2.2", },
> +	{},
> +};

Again, please base this on the latest tree, which has my PCI patches.
This table already exists in this file.  And you're still missing
fsl,mpc8610-pci.

> +int primary_phb_addr;
> +static int __devinit fsl_pci_probe(struct platform_device *pdev)
> +{
> +	struct pci_controller *hose;
> +	bool is_primary;
> +
> +	if (of_match_node(pci_ids, pdev->dev.of_node)) {
> +		struct resource rsrc;
> +		of_address_to_resource(pdev->dev.of_node, 0, &rsrc);
> +		is_primary = ((rsrc.start & 0xfffff) == primary_phb_addr);
> +		fsl_add_bridge(pdev->dev.of_node, is_primary);
> +
> +#ifdef CONFIG_SWIOTLB
> +		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
> +		/*
> +		 * if we couldn't map all of DRAM via the dma windows
> +		 * we need SWIOTLB to handle buffers located outside of
> +		 * dma capable memory region
> +		 */
> +		if (memblock_end_of_DRAM() > hose->dma_window_base_cur
> +				+ hose->dma_window_size) {
> +			ppc_swiotlb_enable = 1;
> +			set_pci_dma_ops(&swiotlb_dma_ops);
> +			ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
> +		}
> +#endif
> +	}

It's too late for swiotlb here.  Again, please don't break something in
one patch and then fix it in a later patch.  Use "git rebase -i" to edit
your patchset into a reviewable, bisectable form.

-Scott
