Return-Path: <linuxppc-dev+bounces-21174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21089CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:10:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKflf676mz30GH;
	Wed, 20 May 2026 02:10:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779207022;
	cv=none; b=HJ7+yCokSeoaHBBQqvr44sChjXpgfET3hU0BuSxpd1OP6kfgoCGSjuTy7DtuhsOpugblM0avTIaF4hHf6cD5Ax017O99kx6sCG7hzs+K9PtE/mJJZs4e6TB9gKFJFPkXQR9xIv0FaftDUbp3zqgR5K3x2ZzUFyeJpmOAq+97U63Rfo6zSssXJhiMpw0zYykDmm3WtTq2xrWUBbifSLzJdm4IRjBLUktU14lZCp94Skz1JkrA8+fUa0rfc+5D2+eNxzWS4ntHjJ6p4EDPqWhWww803HY6AY5YavFlbZmAo/L6TDU1x4dZLMpRwNEGvhtfMX37qZPIOPQkpw3AGVIOOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779207022; c=relaxed/relaxed;
	bh=JLeG6x1Y3dfOvgAW0mg1VnFVfEP9lZkOIYEiUHHIyoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Us6+Cx7ecOlePaRTqlU1Q6kwS/do5Ib6paPiv25y/3ux45Mdd26ep6e8JbUvOtORkD7fdLwhXC99uY03USU4omhPGwoXC0o+zIPXEKsvlzHOh3j1Wokt2eCNXf1lNy/BBqm+/ZuDi/ou0HR8HgZro1MNhLk7w6FSYpcR7k84pvpsOdgL+ivsXYU5vKw51gZJ+DdR5efiZC22RI90BW5M/8sG9H+mrMIVvU78GtFbm4A5Pxvx+tjEqD2DHkPiJU42eo8S50r96t7UtYWUsuIUhTXkdTV9GTrtIrh0+A59N+h4gnqQ1/dopYb0gt6b/mt4T+f9TcEbU8U2evBVWeOKXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JUyt0G87; dkim-atps=neutral; spf=pass (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JUyt0G87;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.5; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKflc0B0Sz30GG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:10:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=JLeG6x1Y3dfOvgAW0mg1VnFVfEP9lZkOIYEiUHHIyoA=;
	b=JUyt0G87rt7PYlK4QmM8e4B8RwvbyXFoil0YpiApMe3XoreMYWYuEqJf5cPfwf
	qlBIVDUaQLyHq0JgoD73DUE643nlzgebsfiYDyj3SJ0JmWnZ7d0U+bjJkV9ql9SY
	HGrtIli4iTrWBVdI6Ps9vODOFptHtzla5d5m36vbO5yK4=
Received: from [IPV6:240e:b8f:91b3:d000:9130:b3d8:6241:39fd] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXXrU4iwxqGKJPCQ--.44368S2;
	Wed, 20 May 2026 00:09:29 +0800 (CST)
Message-ID: <5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com>
Date: Wed, 20 May 2026 00:09:28 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] PCI: dwc: Cache PCIe capability offset and simplify
 drivers
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 jingoohan1@gmail.com, mx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509135152.2241235-1-18255117159@163.com>
 <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXXrU4iwxqGKJPCQ--.44368S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryfKrW8tFykKr18tF1fJFb_yoW5ArWkpa
	y5tF4IyF18tF4S9a12v3WDuF13t3Z7AFyDJ39xW34SvFya9F17Wr10yrWftF97JrW2qr1a
	kF45ta47uFs5JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRiiSJUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:9130:b3d8:6241:39fd]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BqOMmoMizpQVQAA3Y



On 5/19/26 21:57, Manivannan Sadhasivam wrote:
> On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
>> The DWC PCIe core and its many platform drivers repeatedly call
>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>> PCI Express Capability structure. This is wasteful and makes the code
>> verbose. And some even search for the PCI_CAP_ID_EXP offset value within
>> the suspend/resume functions.
>>
> 
> Sashiko has flagged some real issues with this series in accessing DBI space
> very early and 'pci->pcie_cap' being 0.


Hi Mani,

We have discussed this issue in the Cadence driver. I think it won't 
cause any problems. Specifically as follows:

https://lore.kernel.org/linux-pci/5823faec-d972-4c77-90ec-a215c686e0a8@163.com/
"""
As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions are 
required to implement the PCI Express Capability structure, which
must be included somewhere in this linked list.
"""



Bjorn also responded as follows:
https://lore.kernel.org/linux-pci/20260505212306.GA744158@bhelgaas/
"""
It's true that all Root Ports must have a PCIe Capability.
"""



Mani, should I continue to make the judgment that 'pci->pcie_cap' might 
be 0 as per your instructions?



Best regards,
Hans


> 
> Those needs to be fixed.
> 
> - Mani
> 
>> Add a cached pcie_cap field in struct dw_pcie and a helper
>> dw_pcie_get_pcie_cap() to initialize it once at probe time. Then replace
>> all explicit capability searches with the cached value across the
>> entire dwc subtree.
>>
>> Hans Zhang (3):
>>    PCI: dwc: Add pcie_cap field and helper in designware header
>>    PCI: dwc: Use cached PCIe capability offset in core
>>    PCI: dwc: Simplify platform drivers using cached capability offset
>>
>>   drivers/pci/controller/dwc/pci-imx6.c         |  6 +--
>>   .../pci/controller/dwc/pci-layerscape-ep.c    |  4 +-
>>   drivers/pci/controller/dwc/pci-meson.c        |  4 +-
>>   .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>>   .../pci/controller/dwc/pcie-designware-host.c |  4 +-
>>   drivers/pci/controller/dwc/pcie-designware.c  | 16 +++---
>>   drivers/pci/controller/dwc/pcie-designware.h  | 17 +++++++
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++---
>>   drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>>   drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
>>   drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     | 11 ++--
>>   drivers/pci/controller/dwc/pcie-qcom.c        | 24 ++++-----
>>   drivers/pci/controller/dwc/pcie-sophgo.c      |  8 ++-
>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c |  5 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c   |  6 +--
>>   drivers/pci/controller/dwc/pcie-tegra194.c    | 51 +++++++------------
>>   17 files changed, 85 insertions(+), 97 deletions(-)
>>
>>
>> base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
>> -- 
>> 2.34.1
>>
> 


