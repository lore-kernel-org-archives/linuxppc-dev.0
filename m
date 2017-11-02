Return-Path: <minghuan.lian@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0072.outbound.protection.outlook.com [104.47.2.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySKY51nS2zDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 20:29:27 +1100 (AEDT)
From: "M.h. Lian" <minghuan.lian@nxp.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, "Y.b. Lu"
 <yangbo.lu@nxp.com>, "hongtao.jia@nxp.com" <hongtao.jia@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, Leo Li <leoyang.li@nxp.com>, "kishon@ti.com"
 <kishon@ti.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>, "songxiaowei@hisilicon.com"
 <songxiaowei@hisilicon.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>
CC: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH 2/3] ARMv8: layerscape: add the pcie ep function support
Date: Thu, 2 Nov 2017 09:29:20 +0000
Message-ID: <VI1PR04MB1615D32BA610611E92244B7FE85C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
 <20171024083045.31135-3-xiaowei.bao@nxp.com>
In-Reply-To: <20171024083045.31135-3-xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Xiaowei,

Please see my comments inline.

> -----Original Message-----
> From: Bao Xiaowei [mailto:xiaowei.bao@nxp.com]
> Sent: Tuesday, October 24, 2017 4:31 PM
> To: robh+dt@kernel.org; mark.rutland@arm.com; catalin.marinas@arm.com;
> will.deacon@arm.com; bhelgaas@google.com; shawnguo@kernel.org;
> Madalin-cristian Bucur <madalin.bucur@nxp.com>; Sumit Garg
> <sumit.garg@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; hongtao.jia@nxp.com;
> Andy Tang <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>;
> kishon@ti.com; jingoohan1@gmail.com; pbrobinson@gmail.com;
> songxiaowei@hisilicon.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Z.q. Hou
> <zhiqiang.hou@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; M.h. Lian
> <minghuan.lian@nxp.com>
> Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
> Subject: [PATCH 2/3] ARMv8: layerscape: add the pcie ep function support
>=20
> Add the pcie controller ep function support of layerscape base on pcie ep
> framework.
>=20
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> ---
>  drivers/pci/dwc/pci-layerscape.c | 137
> +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 131 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/pci/dwc/pci-layerscape.c b/drivers/pci/dwc/pci-layer=
scape.c
> index 87fa486bee2c..5c6fa7534a8e 100644
> --- a/drivers/pci/dwc/pci-layerscape.c
> +++ b/drivers/pci/dwc/pci-layerscape.c
> @@ -34,7 +34,12 @@
>  /* PEX Internal Configuration Registers */
>  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1
> */
>=20
> +#define PCIE_DBI2_BASE		0x1000	/* DBI2 base address*/
> +#define PCIE_MSI_MSG_DATA_OFF	0x5c	/* MSI Data register address*/
> +#define PCIE_MSI_OB_SIZE	4096
> +#define PCIE_MSI_ADDR_OFFSET	(1024 * 1024)
>  #define PCIE_IATU_NUM		6
> +#define PCIE_EP_ADDR_SPACE_SIZE 0x100000000
>=20
>  struct ls_pcie_drvdata {
>  	u32 lut_offset;
> @@ -44,12 +49,20 @@ struct ls_pcie_drvdata {
>  	const struct dw_pcie_ops *dw_pcie_ops;  };
>=20
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
>=20
>  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> @@ -263,6 +276,113 @@ static const struct of_device_id ls_pcie_of_match[]=
 =3D
> {
>  	{ },
>  };
>=20
> +static void ls_pcie_raise_msi_irq(struct ls_pcie_ep *pcie_ep) {
> +	iowrite32(pcie_ep->msi_msg_data, pcie_ep->msi_virt_addr); }
> +
> +static void ls_pcie_ep_msi_init(struct dw_pcie_ep *ep) {
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	struct ls_pcie *pcie =3D to_ls_pcie(pci);
> +	struct ls_pcie_ep *pcie_ep =3D pcie->pcie_ep;
> +	struct device *dev =3D pci->dev;
> +	u32 free_win;
> +
> +	pcie_ep->msi_phys_addr =3D ep->phys_base + PCIE_MSI_ADDR_OFFSET;
> +
> +	pcie_ep->msi_virt_addr =3D ioremap(pcie_ep->msi_phys_addr,
> +						PCIE_MSI_OB_SIZE);
> +	if (!pcie_ep->msi_virt_addr)
> +		dev_err(dev, "failed to map MSI outbound region\n");
[Minghuan Lian]  If failed, should return an error?=20
You may keep the mapping so, just call ioremap() once or call "iounmap" to =
release mapping after finishing msi test.
> +
> +	pcie_ep->msi_msg_addr =3D ioread32(pci->dbi_base +
> MSI_MESSAGE_ADDR_L32) |
> +		(((u64)ioread32(pci->dbi_base + MSI_MESSAGE_ADDR_U32)) <<
> 32);
> +	pcie_ep->msi_msg_data =3D ioread16(pci->dbi_base +
> +PCIE_MSI_MSG_DATA_OFF);
> +
> +	/* outbound iATU for MSI */
> +	free_win =3D find_first_zero_bit(&ep->ob_window_map,
> +					sizeof(ep->ob_window_map));
> +	if (free_win >=3D ep->num_ob_windows)
> +		dev_err(pci->dev, "no free outbound window\n");
> +
> +	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
> +					pcie_ep->msi_phys_addr,
> +					pcie_ep->msi_msg_addr,
> +					PCIE_MSI_OB_SIZE);
> +
> +	set_bit(free_win, &ep->ob_window_map);
> +	ep->outbound_addr[free_win] =3D pcie_ep->msi_phys_addr; }
> +
> +static int ls_pcie_raise_irq(struct dw_pcie_ep *ep,
> +		enum pci_epc_irq_type type, u8 interrupt_num) {
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +	struct ls_pcie *pcie =3D to_ls_pcie(pci);
> +	struct ls_pcie_ep *pcie_ep =3D pcie->pcie_ep;
> +	u32 index;
> +
> +	ls_pcie_ep_msi_init(ep);
> +
> +	ls_pcie_raise_msi_irq(pcie_ep);
> +
> +	for (index =3D 0; index < ep->num_ob_windows; index++) {
> +		if (ep->outbound_addr[index] =3D=3D pcie_ep->msi_phys_addr)
> +			break;
> +	}
> +
> +	if (index >=3D ep->num_ob_windows)
> +		return -1;
> +
> +	dw_pcie_disable_atu(pci, index, DW_PCIE_REGION_OUTBOUND);
> +	clear_bit(index, &ep->ob_window_map);
> +
> +	return 0;
> +}
> +
> +static struct dw_pcie_ep_ops pcie_ep_ops =3D {
> +	.raise_irq =3D ls_pcie_raise_irq,
> +};
> +
> +static int __init ls_add_pcie_ep(struct ls_pcie *pcie,
> +					struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci =3D pcie->pci;
> +	struct device *dev =3D pci->dev;
> +	struct dw_pcie_ep *ep;
> +	struct ls_pcie_ep *pcie_ep;
> +	struct resource *cfg_res;
> +	int ret;
> +
> +	ep =3D &pci->ep;
> +	ep->ops =3D &pcie_ep_ops;
> +
> +	pcie_ep =3D devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
> +	if (!pcie_ep)
> +		return -ENOMEM;
> +
> +	pcie->pcie_ep =3D pcie_ep;
> +
> +	cfg_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "config");
> +	if (cfg_res) {
> +		ep->phys_base =3D cfg_res->start;
> +		ep->addr_size =3D PCIE_EP_ADDR_SPACE_SIZE;
> +	} else {
> +		dev_err(dev, "missing *config* space\n");
> +		return -ENODEV;
> +	}
> +
> +	ret =3D dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize endpoint\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +
> +}
> +
>  static int __init ls_add_pcie_port(struct ls_pcie *pcie)  {
>  	struct dw_pcie *pci =3D pcie->pci;
> @@ -309,16 +429,21 @@ static int __init ls_pcie_probe(struct platform_dev=
ice
> *pdev)
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>=20
> -	pcie->lut =3D pci->dbi_base + pcie->drvdata->lut_offset;
> +	pci->dbi_base2 =3D pci->dbi_base + PCIE_DBI2_BASE;
>=20
> -	if (!ls_pcie_is_bridge(pcie))
> -		return -ENODEV;
> +	pcie->lut =3D pci->dbi_base + pcie->drvdata->lut_offset;
>=20
>  	platform_set_drvdata(pdev, pcie);
>=20
> -	ret =3D ls_add_pcie_port(pcie);
> -	if (ret < 0)
> -		return ret;
> +	if (!ls_pcie_is_bridge(pcie)) {
> +		ret =3D ls_add_pcie_ep(pcie, pdev);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret =3D ls_add_pcie_port(pcie);
> +		if (ret < 0)
> +			return ret;
> +	}
>=20
>  	return 0;
>  }
> --
> 2.14.1
