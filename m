Return-Path: <xiaowei.bao@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0059.outbound.protection.outlook.com [104.47.1.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZxn66R62zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 15:02:48 +1100 (AEDT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, Madalin-cristian Bucur
 <madalin.bucur@nxp.com>, Sumit Garg <sumit.garg@nxp.com>, "Y.b. Lu"
 <yangbo.lu@nxp.com>, "hongtao.jia@nxp.com" <hongtao.jia@nxp.com>, Andy Tang
 <andy.tang@nxp.com>, Leo Li <leoyang.li@nxp.com>, "jingoohan1@gmail.com"
 <jingoohan1@gmail.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "songxiaowei@hisilicon.com" <songxiaowei@hisilicon.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "Z.q. Hou" <zhiqiang.hou@nxp.com>, "Mingkai
 Hu" <mingkai.hu@nxp.com>, "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCHv4 2/3] ARMv8: layerscape: add the pcie ep function support
Date: Mon, 13 Nov 2017 04:02:40 +0000
Message-ID: <HE1PR04MB311458CBEFE7A92DC457FAD5F52B0@HE1PR04MB3114.eurprd04.prod.outlook.com>
References: <20171110034847.17891-1-xiaowei.bao@nxp.com>
 <20171110034847.17891-3-xiaowei.bao@nxp.com>
 <d02ec499-5de5-11fe-9d95-591513037d49@ti.com>
In-Reply-To: <d02ec499-5de5-11fe-9d95-591513037d49@ti.com>
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



> -----Original Message-----
> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
> Sent: Friday, November 10, 2017 2:32 PM
> To: Xiaowei Bao <xiaowei.bao@nxp.com>; robh+dt@kernel.org;
> mark.rutland@arm.com; catalin.marinas@arm.com; will.deacon@arm.com;
> bhelgaas@google.com; shawnguo@kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Sumit Garg <sumit.garg@nxp.com>; Y.b. Lu
> <yangbo.lu@nxp.com>; hongtao.jia@nxp.com; Andy Tang
> <andy.tang@nxp.com>; Leo Li <leoyang.li@nxp.com>; jingoohan1@gmail.com;
> pbrobinson@gmail.com; songxiaowei@hisilicon.com;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; linux-pci@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Z.q. Hou <zhiqiang.hou@nxp.com>; Mingkai Hu
> <mingkai.hu@nxp.com>; M.h. Lian <minghuan.lian@nxp.com>
> Subject: Re: [PATCHv4 2/3] ARMv8: layerscape: add the pcie ep function su=
pport
>=20
> Hi,
>=20
> On Friday 10 November 2017 09:18 AM, Bao Xiaowei wrote:
> > Add the pcie controller ep function support of layerscape base on pcie
> > ep framework.
> >
> > Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> > ---
> >  v2:
> >  - fix the ioremap function used but no ioumap issue
> >  - optimize the code structure
> >  - add code comments
> >  v3:
> >  - fix the msi outband window request failed issue
> >  v4:
> >  - optimize the code, adjust the format
> >
> >  drivers/pci/dwc/pci-layerscape.c | 120
> > ++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 113 insertions(+), 7 deletions(-)
>=20
> $subject should begin with
> PCI: layerscape:
> >
> > diff --git a/drivers/pci/dwc/pci-layerscape.c
> > b/drivers/pci/dwc/pci-layerscape.c
> > index 87fa486bee2c..6f3e434599e0 100644
> > --- a/drivers/pci/dwc/pci-layerscape.c
> > +++ b/drivers/pci/dwc/pci-layerscape.c
> > @@ -34,7 +34,12 @@
> >  /* PEX Internal Configuration Registers */
> >  #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask
> Register1 */
> >
> > +#define PCIE_DBI2_BASE		0x1000	/* DBI2 base address*/
>=20
> The base address should come from dt.
We get the dbi base address form dt, and this is the offset base on the dbi=
 base address, if the follow patch is merged, this define is not needed.

> > +#define PCIE_MSI_MSG_DATA_OFF	0x5c	/* MSI Data register address*/
> > +#define PCIE_MSI_OB_SIZE	4096
> > +#define PCIE_MSI_ADDR_OFFSET	(1024 * 1024)
> >  #define PCIE_IATU_NUM		6
> > +#define PCIE_EP_ADDR_SPACE_SIZE 0x100000000
> >
> >  struct ls_pcie_drvdata {
> >  	u32 lut_offset;
> > @@ -44,12 +49,20 @@ struct ls_pcie_drvdata {
> >  	const struct dw_pcie_ops *dw_pcie_ops;  };
> >
> > +struct ls_pcie_ep {
> > +	dma_addr_t msi_phys_addr;
> > +	void __iomem *msi_virt_addr;
> > +	u64 msi_msg_addr;
> > +	u16 msi_msg_data;
> > +};
> > +
> >  struct ls_pcie {
> >  	struct dw_pcie *pci;
> >  	void __iomem *lut;
> >  	struct regmap *scfg;
> >  	const struct ls_pcie_drvdata *drvdata;
> >  	int index;
> > +	struct ls_pcie_ep *pcie_ep;
> >  };
> >
> >  #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
> > @@ -263,6 +276,99 @@ static const struct of_device_id ls_pcie_of_match[=
] =3D
> {
> >  	{ },
> >  };
> >
> > +static void ls_pcie_raise_msi_irq(struct ls_pcie_ep *pcie_ep) {
> > +	iowrite32(pcie_ep->msi_msg_data, pcie_ep->msi_virt_addr); }
> > +
> > +static int ls_pcie_raise_irq(struct dw_pcie_ep *ep,
> > +		enum pci_epc_irq_type type, u8 interrupt_num) {
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	struct ls_pcie *pcie =3D to_ls_pcie(pci);
> > +	struct ls_pcie_ep *pcie_ep =3D pcie->pcie_ep;
> > +	u32 free_win;
> > +
> > +	/* get the msi message address and msi message data */
> > +	pcie_ep->msi_msg_addr =3D ioread32(pci->dbi_base +
> MSI_MESSAGE_ADDR_L32) |
> > +		(((u64)ioread32(pci->dbi_base + MSI_MESSAGE_ADDR_U32)) <<
> 32);
> > +	pcie_ep->msi_msg_data =3D ioread16(pci->dbi_base +
> > +PCIE_MSI_MSG_DATA_OFF);
> > +
> > +	/* request and config the outband window for msi */
> > +	free_win =3D find_first_zero_bit(&ep->ob_window_map,
> > +					sizeof(ep->ob_window_map));
> > +	if (free_win >=3D ep->num_ob_windows) {
> > +		dev_err(pci->dev, "no free outbound window\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	dw_pcie_prog_outbound_atu(pci, free_win, PCIE_ATU_TYPE_MEM,
> > +					pcie_ep->msi_phys_addr,
> > +					pcie_ep->msi_msg_addr,
> > +					PCIE_MSI_OB_SIZE);
> > +
> > +	set_bit(free_win, &ep->ob_window_map);
>=20
> This custom logic is not required. You can use [1] instead
>=20
> [1] ->
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml=
.or
> g%2Flkml%2F2017%2F11%2F3%2F318&data=3D02%7C01%7Cxiaowei.bao%40nxp.
> com%7Cdefeb10941b145bc81ac08d528051939%7C686ea1d3bc2b4c6fa92cd99c
> 5c301635%7C0%7C0%7C636458924733901810&sdata=3D3TMGeoj3L9SlNsXeAYN
> %2BSe0K1Orv3xb7Ah9G%2BD9k4Rg%3D&reserved=3D0

These patchs have not merged on the latest kernel, yes? I will test it when=
 these patchs merged, analyzed the patch, it is viable for ls1046a platform=
.
> > +
> > +	/* generate the msi interrupt */
> > +	ls_pcie_raise_msi_irq(pcie_ep);
> > +
> > +	/* release the outband window of msi */
> > +	dw_pcie_disable_atu(pci, free_win, DW_PCIE_REGION_OUTBOUND);
> > +	clear_bit(free_win, &ep->ob_window_map);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct dw_pcie_ep_ops pcie_ep_ops =3D {
> > +	.raise_irq =3D ls_pcie_raise_irq,
> > +};
> > +
> > +static int __init ls_add_pcie_ep(struct ls_pcie *pcie,
> > +					struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci =3D pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	struct dw_pcie_ep *ep;
> > +	struct ls_pcie_ep *pcie_ep;
> > +	struct resource *cfg_res;
> > +	int ret;
> > +
> > +	ep =3D &pci->ep;
> > +	ep->ops =3D &pcie_ep_ops;
> > +
> > +	pcie_ep =3D devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
> > +	if (!pcie_ep)
> > +		return -ENOMEM;
> > +
> > +	pcie->pcie_ep =3D pcie_ep;
> > +
> > +	cfg_res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "config");
> > +	if (cfg_res) {
> > +		ep->phys_base =3D cfg_res->start;
> > +		ep->addr_size =3D PCIE_EP_ADDR_SPACE_SIZE;
> > +	} else {
> > +		dev_err(dev, "missing *config* space\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	pcie_ep->msi_phys_addr =3D ep->phys_base + PCIE_MSI_ADDR_OFFSET;
> > +
> > +	pcie_ep->msi_virt_addr =3D ioremap(pcie_ep->msi_phys_addr,
> > +						PCIE_MSI_OB_SIZE);
> > +	if (!pcie_ep->msi_virt_addr) {
> > +		dev_err(dev, "failed to map MSI outbound region\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret =3D dw_pcie_ep_init(ep);
> > +	if (ret) {
> > +		dev_err(dev, "failed to initialize endpoint\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int __init ls_add_pcie_port(struct ls_pcie *pcie)  {
> >  	struct dw_pcie *pci =3D pcie->pci;
> > @@ -309,18 +415,18 @@ static int __init ls_pcie_probe(struct
> platform_device *pdev)
> >  	if (IS_ERR(pci->dbi_base))
> >  		return PTR_ERR(pci->dbi_base);
> >
> > -	pcie->lut =3D pci->dbi_base + pcie->drvdata->lut_offset;
> > +	pci->dbi_base2 =3D pci->dbi_base + PCIE_DBI2_BASE;
> >
> > -	if (!ls_pcie_is_bridge(pcie))
> > -		return -ENODEV;
> > +	pcie->lut =3D pci->dbi_base + pcie->drvdata->lut_offset;
> >
> >  	platform_set_drvdata(pdev, pcie);
> >
> > -	ret =3D ls_add_pcie_port(pcie);
> > -	if (ret < 0)
> > -		return ret;
> > +	if (!ls_pcie_is_bridge(pcie))
> > +		ret =3D ls_add_pcie_ep(pcie, pdev);
>=20
> HOST or EP mode should be obtained directly from dt.

The RC or EP mode can configured by the rcw, we can't obtain the RC or EP m=
ode from the dt, we can  obtain the RC or EP mode by reading the specific r=
egister in code.
>=20
> Thanks
> Kishon
