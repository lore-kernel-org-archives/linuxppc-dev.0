Return-Path: <nipun.gupta@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0072.outbound.protection.outlook.com [104.47.0.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zybX141VKzF1vH
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Mar 2018 05:29:50 +1100 (AEDT)
From: Nipun Gupta <nipun.gupta@nxp.com>
To: Christoph Hellwig <hch@lst.de>
CC: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "joro@8bytes.org" <joro@8bytes.org>, Leo Li
 <leoyang.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>
Subject: RE: [PATCH 5/6] dma-mapping: support fsl-mc bus
Date: Fri, 9 Mar 2018 18:29:41 +0000
Message-ID: <HE1PR0401MB2425871215B13AD0EFDCA5C3E6DE0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
 <20180305183938.GB20086@lst.de>
 <1729ae21-d08c-b413-51a3-f22c394b388d@arm.com>
 <HE1PR0401MB24251E99564CAA526F719ECCE6D90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
 <20180308074115.GB15748@lst.de>
In-Reply-To: <20180308074115.GB15748@lst.de>
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
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Thursday, March 08, 2018 13:11
>=20
> On Tue, Mar 06, 2018 at 04:41:56AM +0000, Nipun Gupta wrote:
> > Sorry for asking a trivial question - looking into dma_configure() I se=
e that
> > PCI is used in the start and the end of the API.
> > In the end part pci_put_host_bridge_device() is called.
> > So are two bus callbacks something like 'dma_config_start' &
> 'dma_config_end'
> > will be required where the former one will return "dma_dev"?
>=20
> I'd just use dma_configure as the callback.

This would be a decent stuff.

>=20
> Currently the of_dma_configure and acpi_dma_configure are only used
> for PCI anyway, as no one else sets a non-NULL dma dev.

My understanding is that even the platform bus uses the of_dma_configure
and probably acpi_dma_configure too. So platform bus may also need the
callback implemented. Please correct me if my understanding is wrong.

I will submit the patch with 'dma_configure' callback implemented for
the busses shortly.

> For fsl-mc I suspect only of_dma_configure is relevanet, so just call tha=
t directly.
> If at some point we get enough busses with either OF or ACPI we could
> create a helper called from ->dma_configure for that.

Totally agree with this.

Thanks,
Nipun
