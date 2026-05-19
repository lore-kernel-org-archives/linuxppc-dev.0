Return-Path: <linuxppc-dev+bounces-21177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBA9CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:28:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKg8P6L4Qz2yL8;
	Wed, 20 May 2026 02:28:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779208101;
	cv=none; b=GV5e5mAwYBdlTYPXC1VKuBq4us4lRomnjUwgIt0WPAJEhshtxZ3rgdRz4v7+h4YRKR67tR6SXINPZajIQjRmw34icaHWCNw/poenvfe53AUDH4+SUr64LdqWbEr9A+ys5iRTmxzrFSz6hLspwPFle45FCGT0LGc9oiJCQhNzRxuu0YYFQZfQD0kuuDuDnjwVtebAR0C9yF7Ea5IibEgoI46joojhpffCC2XwvVBRoZCLW4sWHBmqx3FY50PjY/cX6Rk0S3dBDf7plvadi4h1MUltJYb3/5ObpLPEB3VtB5QePnb0lFvCBM1W8xLnd2KpOGD/t+/7xGN89wbPl6LbNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779208101; c=relaxed/relaxed;
	bh=HEzVodalGePwQa0r0A0yc+dOQ9J8DF1f8pqfWHrsuSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuPepLwDY/iPbYYBDhW1XWXDa9+lx8Tk99WVKOao1yVcQIciBON2a4zCOBu/EUBediueDv6Mjly1QPSYAvUvn0U95fgzjkYxNVMDBJhJ9naLjE8djgHNyCgeJ6rHj2sM+D8apIaB3MCw2wS83Tx6jrsC0INMQdf9byc9Hsf1GjJyKxehNrysPPk40QCstVgT6cQLdg6sqrk9uHUpPC/zOv9kM6SqLNW9/yipB9Mc/Oy70RFCh+5ELBUq55ul/EbxunfxzfaT/dfLtLrFCn3GkhljiuYWpdd5d4P7yNzHfgfP7wI0SRIHUnakbX9/Ix+FN6g2a6Kd1rUJFuD3zAioMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mkAQ+9qg; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=mkAQ+9qg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKg8M19nDz2yF7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:28:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=HEzVodalGePwQa0r0A0yc+dOQ9J8DF1f8pqfWHrsuSk=;
	b=mkAQ+9qgGabS1i8OItgzH9nPB22PSXb1+d91WzICOmsEtS/r6QFeeHtqKA1W5/
	m9VrN7fmFjkpo6vTEdLqaVrbjqtXsvmwIJodwhdIl3IMv7T2BavKmxqxify2H8uO
	PjyXtOG+aBdv1+ITi0wqxv/8WztCkfwZOUJRUZNCESIyk=
Received: from [IPV6:240e:b8f:91b3:d000:9130:b3d8:6241:39fd] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXEFBpjwxq6iYtCQ--.55083S2;
	Wed, 20 May 2026 00:27:22 +0800 (CST)
Message-ID: <3464ded9-721a-4eb2-afb6-bbca6fdc8a46@163.com>
Date: Wed, 20 May 2026 00:27:21 +0800
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
 <5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com>
 <bejh7em2a67a6wohtakovbg6wqwhjoxkuqtdompsexfm5bbzrf@yqwcqeg6yugq>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <bejh7em2a67a6wohtakovbg6wqwhjoxkuqtdompsexfm5bbzrf@yqwcqeg6yugq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXEFBpjwxq6iYtCQ--.55083S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr47Gw4rWF47AFy3tr43Jrb_yoW8uryfpa
	y3JF1Syr48XF4fXan2va1rZF4xt3ZxArWUZ395Cryavr9I9Fy3JrsY9ryYkF9rCFs2yr15
	uF4Yqry29r15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRiiSJUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:9130:b3d8:6241:39fd]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAubP2oMj2sFdQAA3Z



On 5/20/26 00:15, Manivannan Sadhasivam wrote:
> On Wed, May 20, 2026 at 12:09:28AM +0800, Hans Zhang wrote:
>>
>>
>> On 5/19/26 21:57, Manivannan Sadhasivam wrote:
>>> On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
>>>> The DWC PCIe core and its many platform drivers repeatedly call
>>>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>>>> PCI Express Capability structure. This is wasteful and makes the code
>>>> verbose. And some even search for the PCI_CAP_ID_EXP offset value within
>>>> the suspend/resume functions.
>>>>
>>>
>>> Sashiko has flagged some real issues with this series in accessing DBI space
>>> very early and 'pci->pcie_cap' being 0.
>>
>>
>> Hi Mani,
>>
>> We have discussed this issue in the Cadence driver. I think it won't cause
>> any problems. Specifically as follows:
>>
>> https://lore.kernel.org/linux-pci/5823faec-d972-4c77-90ec-a215c686e0a8@163.com/
>> """
>> As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions are
>> required to implement the PCI Express Capability structure, which
>> must be included somewhere in this linked list.
>> """
>>
>>
>>
>> Bjorn also responded as follows:
>> https://lore.kernel.org/linux-pci/20260505212306.GA744158@bhelgaas/
>> """
>> It's true that all Root Ports must have a PCIe Capability.
>> """
>>
> 
> Ok, what about reading the DBI registers very early?

Hi Mani,

Yes. I have performed the DBI read register operation at the very 
beginning of the following code.


dw_pcie_ep_init()
   dw_pcie_get_pcie_cap(pci);

dw_pcie_host_init
   dw_pcie_get_pcie_cap(pci);


However, for some glue drivers, they need to configure the registers of 
the PCIe Express Capability earlier than calling 
dw_pcie_host_init()/dw_pcie_ep_init(). So, for example, in the file: 
drivers/pci/controller/dwc/pcie-tegra194.c. Here, it is necessary to 
find the value of 'pci->pcie_cap' earlier. Then, 
dw_pcie_host_init()/dw_pcie_ep_init() will no longer search for the 
offset value of the PCIe Express Capability.


Best regards,
Hans


