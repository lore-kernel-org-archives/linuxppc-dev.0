Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9BEC32789
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2085120827
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 06:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n17ZoVV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2085120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pzgS4z3SzF3BM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 17:10:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n17ZoVV5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ti.com
 (client-ip=198.47.19.141; helo=fllv0015.ext.ti.com;
 envelope-from=kishon@ti.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="n17ZoVV5"; 
 dkim-atps=neutral
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pzcb6dwnzF35p
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 17:08:14 +1100 (AEDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA667Ghh050877;
 Tue, 6 Nov 2018 00:07:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1541484436;
 bh=oV2xEQML1iU4xFL/ov6+uu3i0JmRIX7v1/Io36rwBSs=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=n17ZoVV5ZlWRHhwAw5SOcZhlY93M7Lv298AXnS7YCuztswjt2f9dA0EPsYjyCcYm7
 I1EJFBX8ufizWM12meFygjqwtsC1lJFfcns1YVKfjJsRD0zhkRdGNW6E8nkQllMlDN
 ndcYdh0OuCwqZp8TkoSlkR/K0Q5ZOMF1T0cY12T4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA667Guq003139
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 Nov 2018 00:07:16 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 00:07:16 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 00:07:16 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA667A0e013958;
 Tue, 6 Nov 2018 00:07:11 -0600
Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
To: Xiaowei Bao <xiaowei.bao@nxp.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>, "shawnguo@kernel.org"
 <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "M.h. Lian" <minghuan.lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy
 Zang <roy.zang@nxp.com>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "cyrille.pitchen@free-electrons.com"
 <cyrille.pitchen@free-electrons.com>, "pombredanne@nexb.com"
 <pombredanne@nexb.com>, "shawn.lin@rock-chips.com"
 <shawn.lin@rock-chips.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
References: <20181025110901.5680-1-xiaowei.bao@nxp.com>
 <20181025110901.5680-5-xiaowei.bao@nxp.com>
 <d9d07e05-556b-a56d-bb7f-eaec9fb739b8@ti.com>
 <HE1PR04MB1497DF7D9428A5C791CB6A03F5F00@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <HE1PR04MB14979058170FA16A7465FF9EF5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <a85a6900-2478-0750-6f33-2e787cf80d1d@ti.com>
 <HE1PR04MB1497DF7378927C9BB5DF3E15F5CD0@HE1PR04MB1497.eurprd04.prod.outlook.com>
 <8ec7f502-e058-2c28-9140-5d125e4af6ff@ti.com>
 <HE1PR04MB1497DABC689F9A4A97FD4DF0F5CA0@HE1PR04MB1497.eurprd04.prod.outlook.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <dfedeaec-9a3b-632e-af37-cb1963dcae7c@ti.com>
Date: Tue, 6 Nov 2018 11:36:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <HE1PR04MB1497DABC689F9A4A97FD4DF0F5CA0@HE1PR04MB1497.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jiafei Pan <jiafei.pan@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(Removed Niklas as mails to him is bouncing)

Hi,

Please fix your email client. Refer Documentation/process/email-clients.rst

On 05/11/18 2:45 PM, Xiaowei Bao wrote:
> 
> 
> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com> 
> Sent: 2018年11月5日 16:57
> To: Xiaowei Bao <xiaowei.bao@nxp.com>; bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com; arnd@arndb.de; gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kstewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com; pombredanne@nexb.com; shawn.lin@rock-chips.com; niklas.cassel@axis.com; linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
> Cc: Jiafei Pan <jiafei.pan@nxp.com>
> Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
> 
> Hi,
> 
> On 31/10/18 4:08 PM, Xiaowei Bao wrote:
>>
>>
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: 2018年10月31日 12:15
>> To: Xiaowei Bao <xiaowei.bao@nxp.com>; bhelgaas@google.com; 
>> robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li 
>> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com; arnd@arndb.de; 
>> gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai 
>> Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; 
>> kstewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com; 
>> pombredanne@nexb.com; shawn.lin@rock-chips.com; 
>> niklas.cassel@axis.com; linux-pci@vger.kernel.org; 
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; 
>> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
>> Cc: Jiafei Pan <jiafei.pan@nxp.com>
>> Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
>>
>> Hi,
>>
>> On 31/10/18 8:03 AM, Xiaowei Bao wrote:
>>>
>>>
>>> -----Original Message-----
>>> From: Xiaowei Bao
>>> Sent: 2018年10月26日 17:19
>>> To: 'Kishon Vijay Abraham I' <kishon@ti.com>; bhelgaas@google.com;
>>> robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li
>>> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com; arnd@arndb.de; 
>>> gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; 
>>> Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; 
>>> kstewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com;
>>> pombredanne@nexb.com; shawn.lin@rock-chips.com; 
>>> niklas.cassel@axis.com; linux-pci@vger.kernel.org; 
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; 
>>> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
>>> Cc: Jiafei Pan <jiafei.pan@nxp.com>
>>> Subject: RE: [PATCH 5/6] pci: layerscape: Add the EP mode support.
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>> Sent: 2018年10月26日 13:29
>>> To: Xiaowei Bao <xiaowei.bao@nxp.com>; bhelgaas@google.com;
>>> robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li
>>> <leoyang.li@nxp.com>; lorenzo.pieralisi@arm.com; arnd@arndb.de; 
>>> gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; 
>>> Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; 
>>> kstewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com;
>>> pombredanne@nexb.com; shawn.lin@rock-chips.com; 
>>> niklas.cassel@axis.com; linux-pci@vger.kernel.org; 
>>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; 
>>> linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
>>> Subject: Re: [PATCH 5/6] pci: layerscape: Add the EP mode support.
>>>
>>> Hi,
>>>
>>> On Thursday 25 October 2018 04:39 PM, Xiaowei Bao wrote:
>>>> Add the PCIe EP mode support for layerscape platform.
>>>>
>>>> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
>>>> ---
>>>>  drivers/pci/controller/dwc/Makefile            |    2 +-
>>>>  drivers/pci/controller/dwc/pci-layerscape-ep.c |  161
>>>> ++++++++++++++++++++++++
>>>>  2 files changed, 162 insertions(+), 1 deletions(-)  create mode
>>>> 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/Makefile
>>>> b/drivers/pci/controller/dwc/Makefile
>>>> index 5d2ce72..b26d617 100644
>>>> --- a/drivers/pci/controller/dwc/Makefile
>>>> +++ b/drivers/pci/controller/dwc/Makefile
>>>> @@ -8,7 +8,7 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>>>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>>>>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>>>>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
>>>> -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
>>>> +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o 
>>>> +pci-layerscape-ep.o
>>>>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>>>>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>>>>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o diff --git 
>>>> a/drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>> b/drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>> new file mode 100644
>>>> index 0000000..3b33bbc
>>>> --- /dev/null
>>>> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
>>>> @@ -0,0 +1,161 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * PCIe controller EP driver for Freescale Layerscape SoCs
>>>> + *
>>>> + * Copyright (C) 2018 NXP Semiconductor.
>>>> + *
>>>> + * Author: Xiaowei Bao <xiaowei.bao@nxp.com>  */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/init.h>
>>>> +#include <linux/of_pci.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/of_address.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/resource.h>
>>>> +
>>>> +#include "pcie-designware.h"
>>>> +
>>>> +#define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
>>>
>>> The base address should come from dt.
>>>> +
>>>> +struct ls_pcie_ep {
>>>> +	struct dw_pcie		*pci;
>>>> +};
>>>> +
>>>> +#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
>>>> +
>>>> +static bool ls_pcie_is_bridge(struct ls_pcie_ep *pcie) {
>>>> +	struct dw_pcie *pci = pcie->pci;
>>>> +	u32 header_type;
>>>> +
>>>> +	header_type = ioread8(pci->dbi_base + PCI_HEADER_TYPE);
>>>> +	header_type &= 0x7f;
>>>> +
>>>> +	return header_type == PCI_HEADER_TYPE_BRIDGE; }
>>>> +
>>>> +static int ls_pcie_establish_link(struct dw_pcie *pci) {
>>>> +	return 0;
>>>> +}
>>>
>>> There should be some way by which EP should tell RC that it is not configured yet. Are there no bits to control LTSSM state initialization or Configuration retry status enabling?
>>> [Xiaowei Bao] There have not bits to control LTSSM state to tell the RC it is configured. The start link is auto completed.
>>> [Xiaowei Bao] Hi Kishon, is there any advice?
>>
>> If there is no HW support, I don't think anything could be done here. This could result in RC reading configuration space even before EP is fully initialized.
>> [Xiaowei Bao] The bootloader have initialized the EP device and set the config ready bit, and the kernel don't need to do anything.
> 
> What does bootloader initalize? The EP driver here will reinitialize everything right?
> [Xiaowei Bao] The bootloader initialize BAR size, outbound window, inbound window and set the config ready bit.

How will bootloader know the BAR size? The BAR size is based on the function
driver. How does bootloader configure the OB window? The OB window is
configured based on the size and address given by the host dynamically at runtime.

Thanks
Kishon
