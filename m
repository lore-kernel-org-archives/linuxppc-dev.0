Return-Path: <Joao.Pinto@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay2.synopsys.com
 [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVVxV6SvLzDw1n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 21:38:38 +1100 (AEDT)
Subject: Re: [RFC PATCH] PCI: designware: add host_init() error handling
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
References: <1480593077-15402-1-git-send-email-srinivas.kandagatla@linaro.org>
CC: Kishon Vijay Abraham I <kishon@ti.com>, Jingoo Han <jingoohan1@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>, Richard Zhu
 <Richard.Zhu@freescale.com>, Lucas Stach <l.stach@pengutronix.de>, "Murali
 Karicheri" <m-karicheri2@ti.com>, Minghuan Lian
 <minghuan.Lian@freescale.com>, Mingkai Hu <mingkai.hu@freescale.com>, "Roy
 Zang" <tie-fei.zang@freescale.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, Stanimir Varbanov
 <svarbanov@mm-sol.com>, <linux-omap@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-msm@vger.kernel.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <f2c8ebba-e51a-5f47-2d96-c75f7e086c0e@synopsys.com>
Date: Fri, 2 Dec 2016 10:32:43 +0000
MIME-Version: 1.0
In-Reply-To: <1480593077-15402-1-git-send-email-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Srinivas,

Às 11:51 AM de 12/1/2016, Srinivas Kandagatla escreveu:
>  drivers/pci/host/pci-dra7xx.c           |  4 +++-
>  drivers/pci/host/pci-exynos.c           |  4 +++-
>  drivers/pci/host/pci-imx6.c             |  4 +++-
>  drivers/pci/host/pci-keystone.c         |  4 +++-
>  drivers/pci/host/pci-layerscape.c       | 12 ++++++++----
>  drivers/pci/host/pcie-armada8k.c        |  4 +++-
>  drivers/pci/host/pcie-designware-plat.c |  4 +++-
>  drivers/pci/host/pcie-designware.c      |  4 +++-
>  drivers/pci/host/pcie-designware.h      |  2 +-
>  drivers/pci/host/pcie-qcom.c            |  6 ++++--
>  drivers/pci/host/pcie-spear13xx.c       |  4 +++-
>  11 files changed, 37 insertions(+), 15 deletions(-)
> 

Thanks for the patch!

In my opinion your idea is good but only qcom driver is able to detect failure
in the specific host init routine, all others have a 'return 0' even if
something not well init. I would recomend that we take this issue a bit further
and add the error checking to all specific pci drivers in order to make them as
robust as qcom'.

Thanks,
Joao
