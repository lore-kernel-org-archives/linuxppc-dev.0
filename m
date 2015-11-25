Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 9CE911A0337
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 07:01:10 +1100 (AEDT)
Date: Wed, 25 Nov 2015 14:01:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jisheng Zhang <jszhang@marvell.com>
Cc: kishon@ti.com, bhelgaas@google.com, jingoohan1@gmail.com,
 kgene@kernel.org, k.kozlowski@samsung.com,
 Richard.Zhu@freescale.com, l.stach@pengutronix.de,
 m-karicheri2@ti.com, minghuan.Lian@freescale.com,
 mingkai.hu@freescale.com, tie-fei.zang@freescale.com,
 pratyush.anand@gmail.com, linux-omap@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PCI: designware: bail out if host_init failed
Message-ID: <20151125200103.GF8869@localhost>
References: <1447336125-5010-1-git-send-email-jszhang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447336125-5010-1-git-send-email-jszhang@marvell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jisheng,

On Thu, Nov 12, 2015 at 09:48:45PM +0800, Jisheng Zhang wrote:
> There's no reason to continue the initialization such as configure
> register, scan root bus etc. if customized host_init() failed. This
> patch tries to check the host_init result, bail out if failed.

This patch changes the (*host_init) return type and adds "return 0" to
the host_init() implementations of ten different drivers, all to
support a possible error in one driver.

Is there any way to detect and handle the error in
ls1021_pcie_host_init() earlier, maybe by doing the syscon_regmap
lookup in ls_pcie_probe() instead of in the host_init() function?

That would be even better because you wouldn't have to touch any of
the other drivers, and you'd detect the error even earlier, before
we've done any of the designware setup.

Bjorn

> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  drivers/pci/host/pci-dra7xx.c      |  4 +++-
>  drivers/pci/host/pci-exynos.c      |  4 +++-
>  drivers/pci/host/pci-imx6.c        |  4 +++-
>  drivers/pci/host/pci-keystone.c    |  4 +++-
>  drivers/pci/host/pci-layerscape.c  | 25 ++++++++++++++++---------
>  drivers/pci/host/pcie-designware.c |  7 +++++--
>  drivers/pci/host/pcie-designware.h |  2 +-
>  drivers/pci/host/pcie-spear13xx.c  |  4 +++-
>  8 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 8c36880..b3160a1 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -149,7 +149,7 @@ static void dra7xx_pcie_enable_interrupts(struct pcie_port *pp)
>  				   LEG_EP_INTERRUPTS);
>  }
>  
> -static void dra7xx_pcie_host_init(struct pcie_port *pp)
> +static int dra7xx_pcie_host_init(struct pcie_port *pp)
>  {
>  	dw_pcie_setup_rc(pp);
>  
> @@ -162,6 +162,8 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
>  	dra7xx_pcie_enable_interrupts(pp);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops dra7xx_pcie_host_ops = {
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index 01095e1..57f370b 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -481,10 +481,12 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static void exynos_pcie_host_init(struct pcie_port *pp)
> +static int exynos_pcie_host_init(struct pcie_port *pp)
>  {
>  	exynos_pcie_establish_link(pp);
>  	exynos_pcie_enable_interrupts(pp);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops exynos_pcie_host_ops = {
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index 22e8224..9a46680 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -425,7 +425,7 @@ static int imx6_pcie_establish_link(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static void imx6_pcie_host_init(struct pcie_port *pp)
> +static int imx6_pcie_host_init(struct pcie_port *pp)
>  {
>  	imx6_pcie_assert_core_reset(pp);
>  
> @@ -439,6 +439,8 @@ static void imx6_pcie_host_init(struct pcie_port *pp)
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
> +
> +	return 0;
>  }
>  
>  static void imx6_pcie_reset_phy(struct pcie_port *pp)
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 0aa81bd..2604571 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -250,7 +250,7 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
>  	return 0;
>  }
>  
> -static void __init ks_pcie_host_init(struct pcie_port *pp)
> +static int __init ks_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
>  	u32 val;
> @@ -277,6 +277,8 @@ static void __init ks_pcie_host_init(struct pcie_port *pp)
>  	 */
>  	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
>  			"Asynchronous external abort");
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops keystone_pcie_host_ops = {
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 3923bed..a6e9070 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -94,8 +94,9 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
>  	return 1;
>  }
>  
> -static void ls1021_pcie_host_init(struct pcie_port *pp)
> +static int ls1021_pcie_host_init(struct pcie_port *pp)
>  {
> +	int ret;
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
>  	u32 val, index[2];
>  
> @@ -103,15 +104,14 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
>  						     "fsl,pcie-scfg");
>  	if (IS_ERR(pcie->scfg)) {
>  		dev_err(pp->dev, "No syscfg phandle specified\n");
> -		pcie->scfg = NULL;
> -		return;
> +		ret = PTR_ERR(pcie->scfg);
> +		goto err;
>  	}
>  
> -	if (of_property_read_u32_array(pp->dev->of_node,
> -				       "fsl,pcie-scfg", index, 2)) {
> -		pcie->scfg = NULL;
> -		return;
> -	}
> +	ret = of_property_read_u32_array(pp->dev->of_node,
> +					 "fsl,pcie-scfg", index, 2);
> +	if (ret)
> +		goto err;
>  	pcie->index = index[1];
>  
>  	dw_pcie_setup_rc(pp);
> @@ -123,6 +123,11 @@ static void ls1021_pcie_host_init(struct pcie_port *pp)
>  	val = ioread32(pcie->dbi + PCIE_STRFMR1);
>  	val &= 0xffff;
>  	iowrite32(val, pcie->dbi + PCIE_STRFMR1);
> +
> +	return 0;
> +err:
> +	pcie->scfg = NULL;
> +	return ret;
>  }
>  
>  static int ls_pcie_link_up(struct pcie_port *pp)
> @@ -140,7 +145,7 @@ static int ls_pcie_link_up(struct pcie_port *pp)
>  	return 1;
>  }
>  
> -static void ls_pcie_host_init(struct pcie_port *pp)
> +static int ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
>  
> @@ -148,6 +153,8 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	ls_pcie_fix_class(pcie);
>  	ls_pcie_clear_multifunction(pcie);
>  	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
> +
> +	return 0;
>  }
>  
>  static int ls_pcie_msi_host_init(struct pcie_port *pp,
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 540f077..a80a9ba 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -515,8 +515,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		}
>  	}
>  
> -	if (pp->ops->host_init)
> -		pp->ops->host_init(pp);
> +	if (pp->ops->host_init) {
> +		ret = pp->ops->host_init(pp);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (!pp->ops->rd_other_conf)
>  		dw_pcie_prog_outbound_atu(pp, PCIE_ATU_REGION_INDEX1,
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index 2356d29..7b5317f 100644
> --- a/drivers/pci/host/pcie-designware.h
> +++ b/drivers/pci/host/pcie-designware.h
> @@ -63,7 +63,7 @@ struct pcie_host_ops {
>  	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
>  			unsigned int devfn, int where, int size, u32 val);
>  	int (*link_up)(struct pcie_port *pp);
> -	void (*host_init)(struct pcie_port *pp);
> +	int (*host_init)(struct pcie_port *pp);
>  	void (*msi_set_irq)(struct pcie_port *pp, int irq);
>  	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
>  	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index b95b756..50b3b31 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -256,10 +256,12 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static void spear13xx_pcie_host_init(struct pcie_port *pp)
> +static int spear13xx_pcie_host_init(struct pcie_port *pp)
>  {
>  	spear13xx_pcie_establish_link(pp);
>  	spear13xx_pcie_enable_interrupts(pp);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops spear13xx_pcie_host_ops = {
> -- 
> 2.6.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
