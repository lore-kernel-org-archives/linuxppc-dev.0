Return-Path: <jingoohan1@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBCxv3YgTzDrF1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 05:28:19 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id a66so20768066qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 12:28:19 -0700 (PDT)
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Joao Pinto'" <Joao.Pinto@synopsys.com>,
 "'Bjorn Andersson'" <bjorn.andersson@linaro.org>
Cc: "'Kishon Vijay Abraham I'" <kishon@ti.com>,
 "'Bjorn Helgaas'" <bhelgaas@google.com>, "'Kukjin Kim'" <kgene@kernel.org>,
 "'Krzysztof Kozlowski'" <krzk@kernel.org>,
 "'Richard Zhu'" <hongxing.zhu@nxp.com>,
 "'Lucas Stach'" <l.stach@pengutronix.de>,
 "'Murali Karicheri'" <m-karicheri2@ti.com>,
 "'Minghuan Lian'" <minghuan.Lian@freescale.com>,
 "'Mingkai Hu'" <mingkai.hu@freescale.com>,
 "'Roy Zang'" <tie-fei.zang@freescale.com>,
 "'Thomas Petazzoni'" <thomas.petazzoni@free-electrons.com>,
 "'Niklas Cassel'" <niklas.cassel@axis.com>,
 "'Jesper Nilsson'" <jesper.nilsson@axis.com>,
 "'Xiaowei Song'" <songxiaowei@hisilicon.com>,
 "'Binghui Wang'" <wangbinghui@hisilicon.com>,
 "'Stanimir Varbanov'" <svarbanov@mm-sol.com>,
 "'Pratyush Anand'" <pratyush.anand@gmail.com>,
 "'open list:PCI DRIVER FOR TI DRA7XX'" <linux-omap@vger.kernel.org>,
 "'open list:PCI DRIVER FOR TI DRA7XX'" <linux-pci@vger.kernel.org>,
 "'open list'" <linux-kernel@vger.kernel.org>,
 "'moderated list:PCI DRIVER FOR SAMSUNG EXYNOS'"
 <linux-arm-kernel@lists.infradead.org>,
 "'moderated list:PCI DRIVER FOR SAMSUNG EXYNOS'"
 <linux-samsung-soc@vger.kernel.org>,
 "'open list:PCI DRIVER FOR FREESCALE LAYERSCAPE'"
 <linuxppc-dev@lists.ozlabs.org>,
 "'open list:PCIE DRIVER FOR AXIS ARTPEC'" <linux-arm-kernel@axis.com>,
 "'open list:PCIE DRIVER FOR QUALCOMM MSM'" <linux-arm-msm@vger.kernel.org>
References: <20170716063947.3272-1-bjorn.andersson@linaro.org>
 <73b9c442-38f6-cc5b-c6e0-4ce7187dc0a8@synopsys.com>
In-Reply-To: <73b9c442-38f6-cc5b-c6e0-4ce7187dc0a8@synopsys.com>
Subject: Re: [PATCH 1/3] PCI: dwc: Handle host_init failures
Date: Mon, 17 Jul 2017 15:28:13 -0400
Message-ID: <000a01d2ff32$d5d59e00$8180da00$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, July 17, 2017 7:18 AM, Joao Pinto wrote:
>=20
> Hi Bjorn Andersson,
>=20
> =C3=80s 7:39 AM de 7/16/2017, Bjorn Andersson escreveu:
> > In several dwc based drivers host_init can fail, so make sure to
> > propagate and handle this to avoid continuing operation of a driver =
or
> > hardware in an invalid state.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/pci/dwc/pci-dra7xx.c           |  4 +++-
> >  drivers/pci/dwc/pci-exynos.c           |  4 +++-
> >  drivers/pci/dwc/pci-imx6.c             |  4 +++-
> >  drivers/pci/dwc/pci-keystone.c         |  4 +++-
> >  drivers/pci/dwc/pci-layerscape.c       | 14 ++++++++++----
> >  drivers/pci/dwc/pcie-armada8k.c        |  4 +++-
> >  drivers/pci/dwc/pcie-artpec6.c         |  4 +++-
> >  drivers/pci/dwc/pcie-designware-host.c |  7 +++++--
> >  drivers/pci/dwc/pcie-designware-plat.c |  4 +++-
> >  drivers/pci/dwc/pcie-designware.h      |  2 +-
> >  drivers/pci/dwc/pcie-kirin.c           |  4 +++-
> >  drivers/pci/dwc/pcie-qcom.c            |  6 ++++--
> >  drivers/pci/dwc/pcie-spear13xx.c       |  4 +++-
> >  13 files changed, 47 insertions(+), 18 deletions(-)
> >

[.....]

>=20
> A step in the right direction :). In the future we should add host =
init
> validation in the specific SoC drivers, like Layerscape and Qcom have, =
to
> assure
> that any problem is treated properly in the core driver.

I agree with your opinion.

>=20
> Acked-by: Joao Pinto <jpinto@synopsys.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han
