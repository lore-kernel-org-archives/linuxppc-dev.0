Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V10] powerpc/fsl-pci: Unify pci/pcie initialization code
In-reply-to: <1346139848-28021-1-git-send-email-B38951@freescale.com>
References: <1346139848-28021-1-git-send-email-B38951@freescale.com>
Date: Tue, 18 Sep 2012 19:56:14 +1000
Message-ID: <14502.1347962174@neuling.org>
Cc: B07421@freescale.com, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +static int __devinit fsl_pci_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct device_node *node;
> +	struct pci_controller *hose;
> +
> +	node = pdev->dev.of_node;
> +	ret = fsl_add_bridge(node, fsl_pci_primary == node);
>  
>  #ifdef CONFIG_SWIOTLB
> -	/*
> -	 * if we couldn't map all of DRAM via the dma windows
> -	 * we need SWIOTLB to handle buffers located outside of
> -	 * dma capable memory region
> -	 */
> -	if (memblock_end_of_DRAM() - 1 > max)
> -		ppc_swiotlb_enable = 1;
> +	if (ret == 0) {
> +		hose = pci_find_hose_for_OF_device(pdev->dev.of_node);
> +
> +		/*
> +		 * if we couldn't map all of DRAM via the dma windows
> +		 * we need SWIOTLB to handle buffers located outside of
> +		 * dma capable memory region
> +		 */
> +		if (memblock_end_of_DRAM() - 1 > hose->dma_window_base_cur +
> +				hose->dma_window_size)
> +			ppc_swiotlb_enable = 1;
> +	}
>  #endif
> +
> +	mpc85xx_pci_err_probe(pdev);
> +
> +	return 0;
> +}

This breaks when CONFIG_SWIOTLB is disabled (chroma_defconfig hit this
next-20120918), but think this could also hit in Linus tree:

  arch/powerpc/sysdev/fsl_pci.c: In function 'fsl_pci_probe':
  arch/powerpc/sysdev/fsl_pci.c:867:25: error: unused variable 'hose' [-Werror=unused-variable]
  cc1: all warnings being treated as errors

Mikey
