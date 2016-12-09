Return-Path: <jh80.chung@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZXmK2Wv9zDw9v
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 11:14:41 +1100 (AEDT)
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OHW033SU5JJKI80@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 09 Dec 2016 09:04:32 +0900 (KST)
Subject: Re: [PATCH v2] PCI: designware: add host_init error handling
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <CGME20161207103322epcas3p104e9848fa94310f2b368c3555531128b@epcas3p1.samsung.com>
 <1481106769-1404-1-git-send-email-srinivas.kandagatla@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Murali Karicheri <m-karicheri2@ti.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Mingkai Hu <mingkai.hu@freescale.com>, Roy Zang <tie-fei.zang@freescale.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org
From: Jaehoon Chung <jh80.chung@samsung.com>
Message-id: <2e505caa-0d3a-7800-e73f-fd177ca196a4@samsung.com>
Date: Fri, 09 Dec 2016 09:04:31 +0900
MIME-version: 1.0
In-reply-to: <1481106769-1404-1-git-send-email-srinivas.kandagatla@linaro.org>
Content-type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Srinivas,


On 12/07/2016 07:32 PM, Srinivas Kandagatla wrote:
> This patch add support to return value from host_init() callback from drivers,
> so that the designware libary can handle or pass it to proper place. Issue with
> void return type is that errors or error handling within host_init() callback
> are never know to designware code, which could go ahead and access registers
> even in error cases.
> 
> Typical case in qcom controller driver is to turn off clks in case of errors,
> if designware code continues to read/write register when clocks are turned off
> the board would reboot/lockup.

Added the comment for minor thing.
I agreed this approach.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> Currently designware code does not have a way return errors generated
> as part of host_init() callback in controller drivers. This is an issue
> with controller drivers like qcom which turns off the clocks in error
> handling path. As the dw core is un aware of this would continue to
> access registers which faults resulting in board reboots/hangs.
> 
> There are two ways to solve this issue,
> one is remove error handling in the qcom controller host_init() function
> other is to handle error and pass back to dw core code which would then
> pass back to controller driver as part of dw_pcie_host_init() return value.
> 
> Second option seems more sensible and correct way to fix the issue,
> this patch does the same.
> 
> As part of this change to host_init() return type I had to patch other
> ihost controller drivers which use dw core. Most of the changes to other drivers
> are to return proper error codes to upper layer.
> Only compile tested drivers.
> 
> Changes since RFC:
> 	- Add error handling to other drivers as suggested by Joao Pinto
> 
>  drivers/pci/host/pci-dra7xx.c           | 10 ++++++++--
>  drivers/pci/host/pci-exynos.c           | 10 ++++++++--
>  drivers/pci/host/pci-imx6.c             | 10 ++++++++--
>  drivers/pci/host/pci-keystone.c         | 10 ++++++++--
>  drivers/pci/host/pci-layerscape.c       | 22 +++++++++++++---------
>  drivers/pci/host/pcie-armada8k.c        |  4 +++-
>  drivers/pci/host/pcie-designware-plat.c | 10 ++++++++--
>  drivers/pci/host/pcie-designware.c      |  4 +++-
>  drivers/pci/host/pcie-designware.h      |  2 +-
>  drivers/pci/host/pcie-qcom.c            |  5 +++--
>  drivers/pci/host/pcie-spear13xx.c       | 10 ++++++++--
>  11 files changed, 71 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
> index 9595fad..811f0f9 100644
> --- a/drivers/pci/host/pci-dra7xx.c
> +++ b/drivers/pci/host/pci-dra7xx.c
> @@ -127,9 +127,10 @@ static void dra7xx_pcie_enable_interrupts(struct dra7xx_pcie *dra7xx)
>  				   LEG_EP_INTERRUPTS);
>  }
>  
> -static void dra7xx_pcie_host_init(struct pcie_port *pp)
> +static int dra7xx_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pp);
> +	int ret;
>  
>  	pp->io_base &= DRA7XX_CPU_TO_BUS_ADDR;
>  	pp->mem_base &= DRA7XX_CPU_TO_BUS_ADDR;
> @@ -138,10 +139,15 @@ static void dra7xx_pcie_host_init(struct pcie_port *pp)
>  
>  	dw_pcie_setup_rc(pp);
>  
> -	dra7xx_pcie_establish_link(dra7xx);
> +	ret = dra7xx_pcie_establish_link(dra7xx);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
>  	dra7xx_pcie_enable_interrupts(dra7xx);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops dra7xx_pcie_host_ops = {
> diff --git a/drivers/pci/host/pci-exynos.c b/drivers/pci/host/pci-exynos.c
> index f1c544b..c116fd9 100644
> --- a/drivers/pci/host/pci-exynos.c
> +++ b/drivers/pci/host/pci-exynos.c
> @@ -458,12 +458,18 @@ static int exynos_pcie_link_up(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static void exynos_pcie_host_init(struct pcie_port *pp)
> +static int exynos_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct exynos_pcie *exynos_pcie = to_exynos_pcie(pp);
> +	int ret;
> +
> +	ret = exynos_pcie_establish_link(exynos_pcie);
> +	if (ret < 0)
> +		return ret;
>  
> -	exynos_pcie_establish_link(exynos_pcie);
>  	exynos_pcie_enable_interrupts(exynos_pcie);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops exynos_pcie_host_ops = {
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index c8cefb0..1251e92 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -550,18 +550,24 @@ static int imx6_pcie_establish_link(struct imx6_pcie *imx6_pcie)
>  	return ret;
>  }
>  
> -static void imx6_pcie_host_init(struct pcie_port *pp)
> +static int imx6_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pp);
> +	int ret;
>  
>  	imx6_pcie_assert_core_reset(imx6_pcie);
>  	imx6_pcie_init_phy(imx6_pcie);
>  	imx6_pcie_deassert_core_reset(imx6_pcie);
>  	dw_pcie_setup_rc(pp);
> -	imx6_pcie_establish_link(imx6_pcie);
> +	ret = imx6_pcie_establish_link(imx6_pcie);
> +
> +	if (ret < 0)
> +		return ret;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
> +
> +	return 0;
>  }
>  
>  static int imx6_pcie_link_up(struct pcie_port *pp)
> diff --git a/drivers/pci/host/pci-keystone.c b/drivers/pci/host/pci-keystone.c
> index 043c19a..4067a75 100644
> --- a/drivers/pci/host/pci-keystone.c
> +++ b/drivers/pci/host/pci-keystone.c
> @@ -260,12 +260,16 @@ static int keystone_pcie_fault(unsigned long addr, unsigned int fsr,
>  	return 0;
>  }
>  
> -static void __init ks_pcie_host_init(struct pcie_port *pp)
> +static int __init ks_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct keystone_pcie *ks_pcie = to_keystone_pcie(pp);
>  	u32 val;
> +	int ret;
> +
> +	ret = ks_pcie_establish_link(ks_pcie);
> +	if (ret < 0)
> +		return ret;
>  
> -	ks_pcie_establish_link(ks_pcie);
>  	ks_dw_pcie_setup_rc_app_regs(ks_pcie);
>  	ks_pcie_setup_interrupts(ks_pcie);
>  	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
> @@ -287,6 +291,8 @@ static void __init ks_pcie_host_init(struct pcie_port *pp)
>  	 */
>  	hook_fault_code(17, keystone_pcie_fault, SIGBUS, 0,
>  			"Asynchronous external abort");
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops keystone_pcie_host_ops = {
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 6537079..60c8b84 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -103,30 +103,32 @@ static int ls1021_pcie_link_up(struct pcie_port *pp)
>  	return 1;
>  }
>  
> -static void ls1021_pcie_host_init(struct pcie_port *pp)
> +static int ls1021_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct device *dev = pp->dev;
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
>  	u32 index[2];
> +	int ret;
>  
>  	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						     "fsl,pcie-scfg");
>  	if (IS_ERR(pcie->scfg)) {
>  		dev_err(dev, "No syscfg phandle specified\n");
> -		pcie->scfg = NULL;
> -		return;
> +		return PTR_ERR(pcie->scfg);
>  	}
>  
> -	if (of_property_read_u32_array(dev->of_node,
> -				       "fsl,pcie-scfg", index, 2)) {
> -		pcie->scfg = NULL;
> -		return;
> -	}
> +	ret = of_property_read_u32_array(dev->of_node,
> +				       "fsl,pcie-scfg", index, 2);
> +	if (ret < 0)
> +		return ret;
> +
>  	pcie->index = index[1];
>  
>  	dw_pcie_setup_rc(pp);
>  
>  	ls_pcie_drop_msg_tlp(pcie);
> +
> +	return 0;
>  }
>  
>  static int ls_pcie_link_up(struct pcie_port *pp)
> @@ -144,7 +146,7 @@ static int ls_pcie_link_up(struct pcie_port *pp)
>  	return 1;
>  }
>  
> -static void ls_pcie_host_init(struct pcie_port *pp)
> +static int ls_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct ls_pcie *pcie = to_ls_pcie(pp);
>  
> @@ -153,6 +155,8 @@ static void ls_pcie_host_init(struct pcie_port *pp)
>  	ls_pcie_clear_multifunction(pcie);
>  	ls_pcie_drop_msg_tlp(pcie);
>  	iowrite32(0, pcie->pp.dbi_base + PCIE_DBI_RO_WR_EN);
> +
> +	return 0;
>  }
>  
>  static int ls_pcie_msi_host_init(struct pcie_port *pp,
> diff --git a/drivers/pci/host/pcie-armada8k.c b/drivers/pci/host/pcie-armada8k.c
> index 0ac0f18..29bdd8b 100644
> --- a/drivers/pci/host/pcie-armada8k.c
> +++ b/drivers/pci/host/pcie-armada8k.c
> @@ -134,12 +134,14 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
>  		dev_err(pp->dev, "Link not up after reconfiguration\n");
>  }
>  
> -static void armada8k_pcie_host_init(struct pcie_port *pp)
> +static int armada8k_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct armada8k_pcie *pcie = to_armada8k_pcie(pp);
>  
>  	dw_pcie_setup_rc(pp);
>  	armada8k_pcie_establish_link(pcie);

If my understanding is right, 
armada8k_pcie_establish_link can change to return value when Linkup is failed.

Because there also is the checking "dw_pcie_link_up()".

> +
> +	return 0;
>  }
>  
>  static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
> diff --git a/drivers/pci/host/pcie-designware-plat.c b/drivers/pci/host/pcie-designware-plat.c
> index 1a02038..e01adbb 100644
> --- a/drivers/pci/host/pcie-designware-plat.c
> +++ b/drivers/pci/host/pcie-designware-plat.c
> @@ -35,13 +35,19 @@ static irqreturn_t dw_plat_pcie_msi_irq_handler(int irq, void *arg)
>  	return dw_handle_msi_irq(pp);
>  }
>  
> -static void dw_plat_pcie_host_init(struct pcie_port *pp)
> +static int dw_plat_pcie_host_init(struct pcie_port *pp)
>  {
> +	int ret;
> +
>  	dw_pcie_setup_rc(pp);
> -	dw_pcie_wait_for_link(pp);
> +	ret = dw_pcie_wait_for_link(pp);
> +	if (ret)
> +		return ret;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		dw_pcie_msi_init(pp);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops dw_plat_pcie_host_ops = {
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index bed1999..4a81b72 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -638,7 +638,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	}
>  
>  	if (pp->ops->host_init)
> -		pp->ops->host_init(pp);
> +		ret = pp->ops->host_init(pp);
> +			if (ret < 0)
> +				goto error;

Maybe..you need to check the indent at here? :)
And how about adding the dev_dbg() for knowing what is failed.


Best Regards,
Jaehoon Chung

>  
>  	pp->root_bus_nr = pp->busn->start;
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
> index a567ea2..eacf18f 100644
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
> diff --git a/drivers/pci/host/pcie-qcom.c b/drivers/pci/host/pcie-qcom.c
> index 3593640..7d5fb38 100644
> --- a/drivers/pci/host/pcie-qcom.c
> +++ b/drivers/pci/host/pcie-qcom.c
> @@ -429,7 +429,7 @@ static int qcom_pcie_link_up(struct pcie_port *pp)
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> -static void qcom_pcie_host_init(struct pcie_port *pp)
> +static int qcom_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct qcom_pcie *pcie = to_qcom_pcie(pp);
>  	int ret;
> @@ -455,12 +455,13 @@ static void qcom_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err;
>  
> -	return;
> +	return ret;
>  err:
>  	qcom_ep_reset_assert(pcie);
>  	phy_power_off(pcie->phy);
>  err_deinit:
>  	pcie->ops->deinit(pcie);
> +	return ret;
>  }
>  
>  static int qcom_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> diff --git a/drivers/pci/host/pcie-spear13xx.c b/drivers/pci/host/pcie-spear13xx.c
> index 3cf197b..2408f80 100644
> --- a/drivers/pci/host/pcie-spear13xx.c
> +++ b/drivers/pci/host/pcie-spear13xx.c
> @@ -174,12 +174,18 @@ static int spear13xx_pcie_link_up(struct pcie_port *pp)
>  	return 0;
>  }
>  
> -static void spear13xx_pcie_host_init(struct pcie_port *pp)
> +static int spear13xx_pcie_host_init(struct pcie_port *pp)
>  {
>  	struct spear13xx_pcie *spear13xx_pcie = to_spear13xx_pcie(pp);
> +	int ret;
> +
> +	ret = spear13xx_pcie_establish_link(spear13xx_pcie);
> +	if (ret < 0)
> +		return ret;
>  
> -	spear13xx_pcie_establish_link(spear13xx_pcie);
>  	spear13xx_pcie_enable_interrupts(spear13xx_pcie);
> +
> +	return 0;
>  }
>  
>  static struct pcie_host_ops spear13xx_pcie_host_ops = {
> 
