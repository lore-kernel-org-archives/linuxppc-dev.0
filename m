Return-Path: <Joao.Pinto@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay2.synopsys.com
 [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0TnZ2TBwzDqy3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jan 2017 04:16:49 +1100 (AEDT)
Subject: Re: [PATCH 05/37] PCI: dwc: Add platform_set_drvdata
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-6-git-send-email-kishon@ti.com>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach
 <l.stach@pengutronix.de>, Murali Karicheri <m-karicheri2@ti.com>, "Minghuan
 Lian" <minghuan.Lian@freescale.com>, Mingkai Hu <mingkai.hu@freescale.com>,
 Roy Zang <tie-fei.zang@freescale.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Niklas Cassel
 <niklas.cassel@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Zhou Wang
 <wangzhou1@hisilicon.com>, Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 Stanimir Varbanov <svarbanov@mm-sol.com>, Pratyush Anand
 <pratyush.anand@gmail.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <dbaae6f0-f76f-1558-5a49-a17530459cdb@synopsys.com>
Date: Fri, 13 Jan 2017 17:16:15 +0000
MIME-Version: 1.0
In-Reply-To: <1484216786-17292-6-git-send-email-kishon@ti.com>
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

Às 10:25 AM de 1/12/2017, Kishon Vijay Abraham I escreveu:
> Add platform_set_drvdata in all designware based drivers to store the
> private data structure of the driver so that dev_set_drvdata can be
> used to get back private data pointer in add_pcie_port/host_init.
> This is in preparation for splitting struct pcie_port into core and
> host only structures. After the split pcie_port will not be part of
> the driver's private data structure and *container_of* used now
> to get the private data pointer cannot be used.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Minghuan Lian <minghuan.Lian@freescale.com>
> Cc: Mingkai Hu <mingkai.hu@freescale.com>
> Cc: Roy Zang <tie-fei.zang@freescale.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Niklas Cassel <niklas.cassel@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Joao Pinto <Joao.Pinto@synopsys.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/dwc/pci-dra7xx.c           |    3 ++-
>  drivers/pci/dwc/pci-exynos.c           |    3 ++-
>  drivers/pci/dwc/pci-imx6.c             |    3 ++-
>  drivers/pci/dwc/pci-keystone.c         |    2 ++
>  drivers/pci/dwc/pci-layerscape.c       |    2 ++
>  drivers/pci/dwc/pcie-armada8k.c        |    2 ++
>  drivers/pci/dwc/pcie-artpec6.c         |    2 ++
>  drivers/pci/dwc/pcie-designware-plat.c |    2 ++
>  drivers/pci/dwc/pcie-hisi.c            |    2 ++
>  drivers/pci/dwc/pcie-qcom.c            |    2 ++
>  drivers/pci/dwc/pcie-spear13xx.c       |    3 ++-
>  11 files changed, 22 insertions(+), 4 deletions(-)
> 

This is an example of a change that could be merged with another patch that
gives it more meaning, like I wrote in the review of patch 9/37.

Thanks,
Joao
