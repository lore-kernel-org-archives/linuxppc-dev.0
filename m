Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFtfn0CWBzDvmc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 08:42:08 +1100 (AEDT)
Date: Fri, 11 Nov 2016 15:42:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Wei Yongjun <weiyongjun1@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] PCI: layerscape: Remove redundant dev_err call in
 ls_pcie_probe()
Message-ID: <20161111214202.GJ9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1476716140-30608-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476716140-30608-1-git-send-email-weiyj.lk@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 17, 2016 at 02:55:40PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> There is a error message within devm_ioremap_resource
> already, so remove the dev_err call to avoid redundant
> error message.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to pci/host-layerscape for v4.10, thanks!

> ---
>  drivers/pci/host/pci-layerscape.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 2cb7315..bbd3d23 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -251,10 +251,8 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
>  
>  	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
>  	pcie->pp.dbi_base = devm_ioremap_resource(dev, dbi_base);
> -	if (IS_ERR(pcie->pp.dbi_base)) {
> -		dev_err(dev, "missing *regs* space\n");
> +	if (IS_ERR(pcie->pp.dbi_base))
>  		return PTR_ERR(pcie->pp.dbi_base);
> -	}
>  
>  	pcie->drvdata = match->data;
>  	pcie->lut = pcie->pp.dbi_base + pcie->drvdata->lut_offset;
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
