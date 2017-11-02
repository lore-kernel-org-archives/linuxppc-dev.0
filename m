Return-Path: <minghuan.lian@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0073.outbound.protection.outlook.com [104.47.2.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySKbb5NM5zDr6l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 20:31:39 +1100 (AEDT)
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
Subject: RE: [PATCH 3/3] ARMv8: pcie: make the DWC EP driver support for
 layerscape
Date: Thu, 2 Nov 2017 09:31:33 +0000
Message-ID: <VI1PR04MB1615DB65A3A9E50B4B31476CE85C0@VI1PR04MB1615.eurprd04.prod.outlook.com>
References: <20171024083045.31135-1-xiaowei.bao@nxp.com>
 <20171024083045.31135-4-xiaowei.bao@nxp.com>
In-Reply-To: <20171024083045.31135-4-xiaowei.bao@nxp.com>
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

Acked-by: Minghuan Lian <minghuan.Lian@nxp.com>

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
> Subject: [PATCH 3/3] ARMv8: pcie: make the DWC EP driver support for
> layerscape
>=20
> Layerscape pcie controllers support RC or EP mode, Add the EP mode suppor=
t in
> Kconfig, the driver will support both RC and EP mode, and the driver is a=
ble to
> judge the pcie controllers work on RC or EP mode.
>=20
> Signed-off-by: Bao Xiaowei <xiaowei.bao@nxp.com>
> ---
>  drivers/pci/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/pci/dwc/Kconfig b/drivers/pci/dwc/Kconfig index
> 22ec82fcdea2..b5f507795779 100644
> --- a/drivers/pci/dwc/Kconfig
> +++ b/drivers/pci/dwc/Kconfig
> @@ -108,6 +108,7 @@ config PCI_LAYERSCAPE
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select MFD_SYSCON
>  	select PCIE_DW_HOST
> +	select PCIE_DW_EP
>  	help
>  	  Say Y here if you want PCIe controller support on Layerscape SoCs.
>=20
> --
> 2.14.1
