Return-Path: <linuxppc-dev+bounces-21179-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BADCD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:53:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKgjl3869z2yCM;
	Wed, 20 May 2026 02:53:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779209627;
	cv=none; b=IOLN1wmAmomOWksISDhYSDtINzghMkVgvkOSl1hgczPq5TZ+7MWNmjoewBL1slNo6TWrK59QJzAjHeE3inFnIIjzOCsbe2PdpqyiNZT1mK1JdtldJEZebLwfbvh8QB1Gn7q9edqU9dbhdZ7ggG45XJVZhTQ+fPIQEcN4ao8MSBfkFxjmw3eT4lmcQ0ZnfqPPsXm9kbvJp1d7zv+p91pPWd/klBECh6/6a1EQUdBGC/hVBRTRWuS/Ms6txFcZ6ZiDz7iR4ThZjKtzyewIF4qXMH/MrutqH4KMOqqrDKS9AVfYjJBqh3/v6OONNqLr0zIUUvHJMH/Nky33Hqh6V2PzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779209627; c=relaxed/relaxed;
	bh=8sTqgK7mp+Unp9Wpw9+a9pZzPmJnG02xCCH/x+as8c0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZI2q5pF4QPlSLxvBWCUQCDlV4EKRalYNiZsIIk8Ec4XlOLT2rC1KVbMC9N6IEn0tBvRWAFtuo/LOihmUGMELpuEY1cXjj0V4XsaxlC0NLn2BD13DTbgA8Xe0dfrgg485eNdqA5Kuqop0weQRhJJTJAtUcpUDNmVQ73G5REkHDeiHnmR24WymfjcfdtGlikK6PKhkykwXh2OyVNQagQCJO1rUKJJ1zZQiuupjaN2sIfwu+LgfDCoO7tJEUbivG40gq6BmMoAqTIYsvkTZPrAXlWV06buNyYFG8sxzR+v2S84eWFCBtITIypZ1+nTDa/h57Myqa4ccRhEGQsHCRlkWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Xu0Xi0jk; dkim-atps=neutral; spf=pass (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Xu0Xi0jk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=220.197.31.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKgjj0BGhz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:53:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=8sTqgK7mp+Unp9Wpw9+a9pZzPmJnG02xCCH/x+as8c0=;
	b=Xu0Xi0jk2I5naAv7BW68F8wp+zf1WAfWvdPqJpYEhtBNnvKKpsM19fbiGRrZPS
	F4gw7ba0Z9JxW9iVOQ/J8DKU643Vejg2Re33hDXOK5KpZquw7itTVc+DsmEKjzR9
	6MmRfJR7mRKX3hFEotycCpHiXhM1D+4enlNArWgobDb24=
Received: from [IPV6:240e:b8f:91b3:d000:7f44:7c72:8a1e:7e64] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHGflilQxqMA8gCQ--.43458S2;
	Wed, 20 May 2026 00:52:51 +0800 (CST)
Message-ID: <e0c89a4a-709e-42c6-ad1c-7ec50cc5790c@163.com>
Date: Wed, 20 May 2026 00:52:49 +0800
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
 <3464ded9-721a-4eb2-afb6-bbca6fdc8a46@163.com>
 <m332ocvmmdzcgnzmzxmbn2nmczxuhplt5efh64fd22fagrot42@x3okixj5qjb2>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <m332ocvmmdzcgnzmzxmbn2nmczxuhplt5efh64fd22fagrot42@x3okixj5qjb2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHGflilQxqMA8gCQ--.43458S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4rZw1kKFy5Gr48Xr47Jwb_yoW8uFWDpa
	y3JayFyF4UXF4Iya1Ivw48XF4xKasxJry7Xr95Gry5Arn0vF1rJr4FvrWYkF9rGrWvyr1Y
	vF4Yq3429r15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRMrW7UUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:7f44:7c72:8a1e:7e64]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AQcv2oMlWSKKgAA38



On 5/20/26 00:49, Manivannan Sadhasivam wrote:
> On Wed, May 20, 2026 at 12:27:21AM +0800, Hans Zhang wrote:
>>
>>
>> On 5/20/26 00:15, Manivannan Sadhasivam wrote:
>>> On Wed, May 20, 2026 at 12:09:28AM +0800, Hans Zhang wrote:
>>>>
>>>>
>>>> On 5/19/26 21:57, Manivannan Sadhasivam wrote:
>>>>> On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
>>>>>> The DWC PCIe core and its many platform drivers repeatedly call
>>>>>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>>>>>> PCI Express Capability structure. This is wasteful and makes the code
>>>>>> verbose. And some even search for the PCI_CAP_ID_EXP offset value within
>>>>>> the suspend/resume functions.
>>>>>>
>>>>>
>>>>> Sashiko has flagged some real issues with this series in accessing DBI space
>>>>> very early and 'pci->pcie_cap' being 0.
>>>>
>>>>
>>>> Hi Mani,
>>>>
>>>> We have discussed this issue in the Cadence driver. I think it won't cause
>>>> any problems. Specifically as follows:
>>>>
>>>> https://lore.kernel.org/linux-pci/5823faec-d972-4c77-90ec-a215c686e0a8@163.com/
>>>> """
>>>> As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions are
>>>> required to implement the PCI Express Capability structure, which
>>>> must be included somewhere in this linked list.
>>>> """
>>>>
>>>>
>>>>
>>>> Bjorn also responded as follows:
>>>> https://lore.kernel.org/linux-pci/20260505212306.GA744158@bhelgaas/
>>>> """
>>>> It's true that all Root Ports must have a PCIe Capability.
>>>> """
>>>>
>>>
>>> Ok, what about reading the DBI registers very early?
>>
>> Hi Mani,
>>
>> Yes. I have performed the DBI read register operation at the very beginning
>> of the following code.
>>
>>
>> dw_pcie_ep_init()
>>    dw_pcie_get_pcie_cap(pci);
>>
>> dw_pcie_host_init
>>    dw_pcie_get_pcie_cap(pci);
>>
> 
> These both calls will cause crash on a lot of platforms because these will be
> reading the DBI registers while the resources are not enabled.

Hi Mani,

Next, I will check all the DBI register-related issues. It will be fixed 
in the next version. Thank you very much.

Best regards,
Hans


