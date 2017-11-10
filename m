Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYDpG4xcKzDq78
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 20:12:53 +1100 (AEDT)
Subject: Re: [PATCHv4 2/3] ARMv8: layerscape: add the pcie ep function support
To: Bao Xiaowei <xiaowei.bao@nxp.com>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
 <will.deacon@arm.com>, <bhelgaas@google.com>, <shawnguo@kernel.org>,
 <madalin.bucur@nxp.com>, <sumit.garg@nxp.com>, <yangbo.lu@nxp.com>,
 <hongtao.jia@nxp.com>, <Yuantian.Tang@nxp.com>, <leoyang.li@nxp.com>,
 <jingoohan1@gmail.com>, <pbrobinson@gmail.com>,
 <songxiaowei@hisilicon.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <Zhiqiang.Hou@nxp.com>, <mingkai.hu@nxp.com>, <Minghuan.Lian@nxp.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-3-xiaowei.bao@nxp.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d02ec499-5de5-11fe-9d95-591513037d49@ti.com>
Date: Fri, 10 Nov 2017 12:01:58 +0530
MIME-Version: 1.0
In-Reply-To: <20171110034847.17891-3-xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> Add the pcie controller ep function support of layerscape base on
> pcie ep framework.
> 
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> ---
>  v2:
>  - fix the ioremap function used but no ioumap issue
>  - optimize the code structure
>  - add code comments
>  v3:
>  - fix the msi outband window request failed issue
>  v4:
>  - optimize the code, adjust the format
> 
>  drivers/pci/dwc/pci-layerscape.c | 120 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 113 insertions(+), 7 deletions(-)

$subject should begin with
PCI: layerscape:
> 
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layerscape.c
> index 87fa486bee2c..6f3e434599e0 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -34,7 +34,12 @@
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
>  
> +#define PCIE_DBI2_BASE		0x1000	/* DBI2 base address*/

The base address should come from dt.
> +#define PCIE_MSI_MSG_DATA_OFF	0x5c	/* MSI Data register address*/
> +#define PCIE_MSI_OB_SIZE	4096
> +#define PCIE_MSI_ADDR_OFFSET	(1024 * 1024)
>  #define PCIE_IATU_NUM		6
> +#define PCIE_EP_ADDR_SPACE_SIZE 0x100000000
>  
>  struct ls_pcie_drvdata {
>  	u32 lut_offset;
> @@ -44,12 +49,20 @@ struct ls_pcie_drvdata {
>  	const struct dw_pcie_ops *dw_pcie_ops;
>  };
>  
> +struct ls_pcie_ep {
> +	dma_addr_t msi_phys_addr;
> +	void __iomem *msi_virt_addr;
> +	u64 msi_msg_addr;
> +	u16 msi_msg_data;
> +};
> +
>  struct ls_pcie {
>  	struct dw_pcie *pci;
>  	void __iomem *lut;
>  	struct regmap *scfg;
>  	const struct ls_pcie_drvdata *drvdata;
>  	int index;
> +	struct ls_pcie_ep *pcie_ep;
>  };
>  
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> @@ -263,6 +276,99 @@ static const struct of_device_id ls_pcie_of_match[] = {
>  	{ },
>  };
>  
> +static void ls_pcie_raise_msi_irq(struct ls_pcie_ep *pcie_ep)
> +{
> +	iowrite32(pcie_ep->msi_msg_data, pcie_ep->msi_virt_addr);
> +}
> +
> +static int ls_pcie_raise_irq(struct dw_pcie_ep *ep,
> +		enum pci_epc_irq_type type, u8 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct ls_pcie *pcie = to_ls_pcie(pci);
> +	struct ls_pcie_ep *pcie_ep = pcie->pcie_ep;
> +	u32 free_win;
> +
> +	/* get the msi message address and msi message data */
> +	pcie_ep->msi_msg_addr = ioread32(pci->dbi_base + MSI_MESSAGE_ADDR_L32) |
> +		(((u64)ioread32(pci->dbi_base + MSI_MESSAGE_ADDR_U32)) << 32);
> +	pcie_ep->msi_msg_data = ioread16(pci->dbi_base + PCIE_MSI_MSG_DATA_OFF);
> +
> +	/* request and config the outband window for msi */
> +	free_win = find_first_zero_bit(&ep->ob_window_map,
> +					sizeof(ep->ob_window_map));
> +	if (free_win >= ep->num_ob_windows) {
> +		dev_err(pci->dev, "no free outbound window\n");
> +		return -ENOMEM;
> +	}
> +
> +	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
> +					pcie_ep->msi_phys_addr,
> +					pcie_ep->msi_msg_addr,
> +					PCIE_MSI_OB_SIZE);
> +
> +	set_bit(free_win, &ep->ob_window_map);

This custom logic is not required. You can use [1] instead

[1] -> https://lkml.org/lkml/2017/11/3/318
> +
> +	/* generate the msi interrupt */
> +	ls_pcie_raise_msi_irq(pcie_ep);
> +
> +	/* release the outband window of msi */
> +	dw_pcie_disable_atu(pci, free_win, DW_PCIE_REGION_OUTBOUND);
> +	clear_bit(free_win, &ep->ob_window_map);
> +
> +	return 0;
> +}
> +
> +static struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.raise_irq = ls_pcie_raise_irq,
> +};
> +
> +static int __init ls_add_pcie_ep(struct ls_pcie *pcie,
> +					struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct dw_pcie_ep *ep;
> +	struct ls_pcie_ep *pcie_ep;
> +	struct resource *cfg_res;
> +	int ret;
> +
> +	ep = &pci->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	pcie_ep = devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
> +	if (!pcie_ep)
> +		return -ENOMEM;
> +
> +	pcie->pcie_ep = pcie_ep;
> +
> +	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (cfg_res) {
> +		ep->phys_base = cfg_res->start;
> +		ep->addr_size = PCIE_EP_ADDR_SPACE_SIZE;
> +	} else {
> +		dev_err(dev, "missing *config* space\n");
> +		return -ENODEV;
> +	}
> +
> +	pcie_ep->msi_phys_addr = ep->phys_base + PCIE_MSI_ADDR_OFFSET;
> +
> +	pcie_ep->msi_virt_addr = ioremap(pcie_ep->msi_phys_addr,
> +						PCIE_MSI_OB_SIZE);
> +	if (!pcie_ep->msi_virt_addr) {
> +		dev_err(dev, "failed to map MSI outbound region\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize endpoint\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __init ls_add_pcie_port(struct ls_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> @@ -309,18 +415,18 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> -	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
> +	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_BASE;
>  
> -	if (!ls_pcie_is_bridge(pcie))
> -		return -ENODEV;
> +	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> -	ret = ls_add_pcie_port(pcie);
> -	if (ret < 0)
> -		return ret;
> +	if (!ls_pcie_is_bridge(pcie))
> +		ret = ls_add_pcie_ep(pcie, pdev);

HOST or EP mode should be obtained directly from dt.

Thanks
Kishon
