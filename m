Return-Path: <linuxppc-dev+bounces-18071-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986301125851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:36:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWGc23r4wz3bf8;
	Thu, 12 Mar 2026 03:36:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=154.81.10.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773247010;
	cv=none; b=R2x41aiR2io/FkF7vjHjTlHDAz3Od4cYTYpv7aePRddAKRJGyULeOW0pVL/y1eAySDdjlnUW0UG4KR2CKutEkMG1Y38IfqILsPCdALTluf2hF679e7CZLu9EI09tsGlr00QlWAZYFSlNt4Wx8NrweDFsyNSVBpG9of69S5FES28kH6BKvzT4vKw6K49BnHc+3uCiapMqfrxxRsnSNCi/OFIdy3LmrWvvF3UDpwS9I5cJaw62WDRV8u0HEe9OVJF9ET63KSUPzQyZI7HGybbd5hGnOjoA5r1/D8Ckk47nEFKtqwOGGwU45SlECVj0TReOluof99Ikzdi42dE9TMmJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773247010; c=relaxed/relaxed;
	bh=PAFS6SUaQW7xKOcNcQrq2ISZ+ChhVUr2hv2lfFTcIcs=;
	h=Cc:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OKr6jB5+z89V2g8ROepNkzbpO1uDYUfZeM2tmBQVSA1uZuUhrHTxQgisAdVW6lLp/1GT9mSCkQavW1xvHv7whQRJOUITL5p7JUK0x12v4bQP02p9HzmRJGu+wwGLxu9kuNnSe1fUIcKNIxLCHq8GM0KAXfQcAznDaget50MQtLAG9I5i9/RuWPx++KS0XDzTV1gOEb6S9tp5ckn7g+X+gnzYJcJ6yXVV0U5jO4EmvLryQAKdFgq6VYpnKasv6qPPTHK06JIBJIyQUVPYT+adMmJCvJ/zOXDl7I9ezGEry9+zFjXGwLliOIHgJeolpOoGdy/hMMMFYYTiwa9d5TKnVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=WBhuHUzX; dkim-atps=neutral; spf=pass (client-ip=154.81.10.179; helo=mail-m10179.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org) smtp.mailfrom=rock-chips.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=WBhuHUzX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rock-chips.com (client-ip=154.81.10.179; helo=mail-m10179.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 40539 seconds by postgrey-1.37 at boromir; Thu, 12 Mar 2026 03:36:46 AEDT
Received: from mail-m10179.netease.com (mail-m10179.netease.com [154.81.10.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWGby5qFgz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 03:36:43 +1100 (AEDT)
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3681eb934;
	Wed, 11 Mar 2026 13:20:56 +0800 (GMT+08:00)
Cc: shawn.lin@rock-chips.com, manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
 Brian Norris <briannorris@chromium.org>, Wilson Ding <dingwei@marvell.com>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 2/4] PCI: host-common: Add link down handling for Root
 Ports
To: Manivannan Sadhasivam <mani@kernel.org>
References: <20260310-pci-port-reset-v7-0-9dd00ccc25ab@oss.qualcomm.com>
 <20260310-pci-port-reset-v7-2-9dd00ccc25ab@oss.qualcomm.com>
 <2eb738fb-9dfe-1e88-6ea7-afdba9cb3d25@rock-chips.com>
 <vnsmjvtwaeticdxwz6u43dxnpi6duhc3r5motwnfer4l2bpqcm@noeme6lgq4jf>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <b80b2364-2b13-44e0-fc3f-df335fc426a0@rock-chips.com>
Date: Wed, 11 Mar 2026 13:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
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
In-Reply-To: <vnsmjvtwaeticdxwz6u43dxnpi6duhc3r5motwnfer4l2bpqcm@noeme6lgq4jf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cdb5748be09cckunm13bcff7618b6f0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQksZTlYeGEJMH0wYHR0dGk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WBhuHUzXt2thVHZYmxTGM2+dktPzKjU3jRcVDumQwxTvN/ZF6KuBXlPAi4h5K/L4IimlhmM+BbLJDa1D98M3hAq5vc++t3KYr2IAaYi9QbJWLCfjlJ6VuL+uK780xW/Y7YrqYFB1C+e/4XPMs1PH4dDDf/0+IhPo0LR+UmCll+8=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=PAFS6SUaQW7xKOcNcQrq2ISZ+ChhVUr2hv2lfFTcIcs=;
	h=date:mime-version:subject:message-id:from;

在 2026/03/11 星期三 13:04, Manivannan Sadhasivam 写道:
> On Wed, Mar 11, 2026 at 08:55:01AM +0800, Shawn Lin wrote:
>> Hi Mani
>>
>> 在 2026/03/10 星期二 22:02, Manivannan Sadhasivam via B4 Relay 写道:
>>> From: Manivannan Sadhasivam <mani@kernel.org>
>>>
>>> The PCI link, when down, needs to be recovered to bring it back. But on
>>> some platforms, that cannot be done in a generic way as link recovery
>>> procedure is platform specific. So add a new API
>>> pci_host_handle_link_down() that could be called by the host bridge drivers
>>> for a specific Root Port when the link goes down.
>>>
>>> The API accepts the 'pci_dev' corresponding to the Root Port which observed
>>> the link down event. If CONFIG_PCIEAER is enabled, the API calls
>>> pcie_do_recovery() function with 'pci_channel_io_frozen' as the state. This
>>> will result in the execution of the AER Fatal error handling code. Since
>>> the link down recovery is pretty much the same as AER Fatal error handling,
>>> pcie_do_recovery() helper is reused here. First, the AER error_detected()
>>> callback will be triggered for the bridge and then for the downstream
>>> devices. Finally, pci_host_reset_root_port() will be called for the Root
>>> Port, which will reset the Root Port using 'reset_root_port' callback to
>>> recover the link. Once that's done, resume message will be broadcasted to
>>> the bridge and the downstream devices, indicating successful link recovery.
>>>
>>> But if CONFIG_PCIEAER is not enabled in the kernel, only
>>> pci_host_reset_root_port() API will be called, which will in turn call
>>> pci_bus_error_reset() to just reset the Root Port as there is no way we
>>> could inform the drivers about link recovery.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>> Tested-by: Brian Norris <briannorris@chromium.org>
>>> Tested-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>> Tested-by: Richard Zhu <hongxing.zhu@nxp.com>
>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>    drivers/pci/controller/pci-host-common.c | 35 ++++++++++++++++++++++++++++++++
>>>    drivers/pci/controller/pci-host-common.h |  1 +
>>>    drivers/pci/pci.c                        |  1 +
>>>    drivers/pci/pcie/err.c                   |  1 +
>>>    4 files changed, 38 insertions(+)
>>>
>>> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
>>> index d6258c1cffe5..15ebff8a542a 100644
>>> --- a/drivers/pci/controller/pci-host-common.c
>>> +++ b/drivers/pci/controller/pci-host-common.c
>>> @@ -12,9 +12,11 @@
>>>    #include <linux/of.h>
>>>    #include <linux/of_address.h>
>>>    #include <linux/of_pci.h>
>>> +#include <linux/pci.h>
>>>    #include <linux/pci-ecam.h>
>>>    #include <linux/platform_device.h>
>>> +#include "../pci.h"
>>>    #include "pci-host-common.h"
>>>    static void gen_pci_unmap_cfg(void *ptr)
>>> @@ -106,5 +108,38 @@ void pci_host_common_remove(struct platform_device *pdev)
>>>    }
>>>    EXPORT_SYMBOL_GPL(pci_host_common_remove);
>>> +static pci_ers_result_t pci_host_reset_root_port(struct pci_dev *dev)
>>> +{
>>> +	int ret;
>>> +
>>> +	pci_lock_rescan_remove();
>>> +	ret = pci_bus_error_reset(dev);
>>> +	pci_unlock_rescan_remove();
>>> +	if (ret) {
>>> +		pci_err(dev, "Failed to reset Root Port: %d\n", ret);
>>> +		return PCI_ERS_RESULT_DISCONNECT;
>>> +	}
>>> +
>>> +	pci_info(dev, "Root Port has been reset\n");
>>> +
>>> +	return PCI_ERS_RESULT_RECOVERED;
>>> +}
>>> +
>>> +static void pci_host_recover_root_port(struct pci_dev *port)
>>> +{
>>> +#if IS_ENABLED(CONFIG_PCIEAER)
>>> +	pcie_do_recovery(port, pci_channel_io_frozen, pci_host_reset_root_port);
>>> +#else
>>> +	pci_host_reset_root_port(port);
>>
>> Since pci_host_reset_root_port() returns pci_ers_result_t, shouldn't we
>> check the result? If the return value is intentionally ignored here,
>> maybe pci_host_reset_root_port actually doesn't need a return value at
>> all?
>>
> 
> The return value is mostly for pcie_do_recovery() which iterates through the
> subordinate devices and calls pci_host_reset_root_port(). It also makes use of
> the return value, so we cannot make it void.
> 
> The reason why I skipped the return value in pci_host_handle_link_down() is
> that, we canot do much in the case of failure other than reporting the failure,
> which is already taken care in pci_host_reset_root_port().
> 

Ok, it makes sense to me, thanks for the explanation.
Feel free to add:

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>>> +#endif
>>> +}
>>> +
>>> +void pci_host_handle_link_down(struct pci_dev *port)
>>> +{
>>> +	pci_info(port, "Recovering Root Port due to Link Down\n");
>>> +	pci_host_recover_root_port(port);
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_host_handle_link_down);
>>
>> This function shouldn't be called like in interrupt context because of
>> the pci_lock_rescan_remove() and pci_bus_error_reset()::pci_slot_mutex,
>> but it's not so obvious from the API name. It's prone for host drivers
>> to use it like:
>>
>> register_LDn_irq -> irq isr -> pci_host_handle_link_down()
>>
>> So perhaps add a comment about it would be better.
>>
> 
> Yes, I agree. I mentioned in the cover letter that this API should be called
> from a threaded IRQ handler, but it should be mentioned in the API description
> too. I will add it in next version or ammend it while applying.
> 
> - Mani
> 

