Return-Path: <linuxppc-dev+bounces-26021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD9D6C5DF85
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Aug 2026 15:18:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hQnBJ1yfhz2xT6;
	Fri, 21 Aug 2026 01:18:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787239080;
	cv=none; b=TZ6oAJoJ5g1s3hT1Bc4edjHWFQt4mc7A/Itrb13x0RThgFkuCpI3Irgkn4RoXYG8SJSnXXPViZBbrWDgn4dL+sEbEPAIjfoZuXWlj8MLUjJ/aWDrW/FrPrueAZ2bzoQ9fKwVLQKQanfRn5iqFnwyuy+BD4oPBqYOdychy1vq5bhrVBBw7FeZfzIfCPJs/Nm1fOijeYf3blURV60W8sBtBrkwC2NL87iWfNPcoqBEtCoZHhqSTIcq8E9gq/g6Ru+1NWRiilVHwaHnuomyaFg5cyr5OB9/jOXIJmQsrW2C/bQGXTCrj03sqI7104S4dnxD7O0xCm11kHa3EFPkWWrcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787239080; c=relaxed/relaxed;
	bh=hCBCfkhuylDswajnEAey0yhp/w2gaAIUfLfZkrqLJZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofqvb7BDbiQ8UzeNddvId5/KyZdn6uZcB/pCE6DEr215ZOD2blC3oJLLE5xXOVbRUEwruLnViTeX353D6m/y3ubva9I3Y9w7Qifcl9rEMx9nWn1jEZ5OnOccYN+R1rq6d1FpR0mOszfzFhavno1z98b6gCwAP7ciQapsSKxSuTDC/meah6oWywqeQSSxgpc3m7doToEzRJ2DYXQgPpGvti2G3BZYimIHx4dhkeiYFpVP3mkE9fnzCWhuqNXeq+yFlSC9kg5msf80HkKhadSZcb2vN4QP4nScMGJL0Ew/cH3UjV+N3R+Kd7jOJizm5MNIUTisX8Wn7ySdGU+Tfvf3Zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jz7Yb4NV; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=jz7Yb4NV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=18255117159@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hQnB85n49z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 01:17:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hCBCfkhuylDswajnEAey0yhp/w2gaAIUfLfZkrqLJZI=;
	b=jz7Yb4NV2f4ape26Kp1GE/Cg4BTdXVJCyxo9NcOQCjfIZGGbmJazQ27Qg+bQ8E
	K9iqAp0NKgajM4aFMscqoafCMxBrzSFXaGCX0qxzW+EEXJDVnZ6q9s4aaPkyr85P
	DVveMqpuEMuJ7rSa8XEECERFA43Wfvq3V2lj4f80cLFVM=
Received: from [IPV6:240e:b8f:91b3:d000:fc9b:5f4:477a:dca5] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCHTa9jGodqjxLpQQ--.14990S2;
	Thu, 20 Aug 2026 23:16:52 +0800 (CST)
Message-ID: <a2f0c2d6-750e-4076-aae2-6efaba1009a1@163.com>
Date: Thu, 20 Aug 2026 23:16:50 +0800
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
Subject: Re: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 jingoohan1@gmail.com, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-3-18255117159@163.com>
 <ps2qzgcb5lixkoqz2xbofdurkgmsiojg7e5ueqfdhyissqvzf2@tuderrjgzg6b>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <ps2qzgcb5lixkoqz2xbofdurkgmsiojg7e5ueqfdhyissqvzf2@tuderrjgzg6b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHTa9jGodqjxLpQQ--.14990S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF15GFy5tryfZw17uFy8Zrb_yoW8ur18p3
	yaqr4ayr4kZrW2vFWxJa1YqF10gF98trW3J3s3Kr15ZwsxCFWxJrW2yryYvF9rGrWqyr1F
	kF4UXryDur98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRi2-OUUUUU=
X-Originating-IP: [240e:b8f:91b3:d000:fc9b:5f4:477a:dca5]
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AQcv2qHGmR67gAA3M



On 8/13/26 14:06, Manivannan Sadhasivam wrote:
> On Mon, Jul 20, 2026 at 11:06:05PM +0800, Hans Zhang wrote:
>> Modify the DWC core functions to use the cached pcie_cap offset instead
>> of calling dw_pcie_find_capability() each time.
>>
>> In the DWC core, dw_pcie_find_capability() is called at several locations:
>> - dw_pcie_ep_init_non_sticky_registers()
>> - dw_pcie_wait_for_link()
>> - dw_pcie_link_set_max_speed()
>> - dw_pcie_link_get_max_link_width()
>> - dw_pcie_link_set_max_link_width()
>>
>> The cached offset is initialized after hardware is ready:
>> - In host mode: dw_pcie_host_init() calls pp->ops->host_init() (enables
>>    clocks/resets), then dw_pcie_get_pcie_cap() caches the offset.
>> - In endpoint mode: the core no longer caches automatically. Instead,
>>    drivers must call dw_pcie_get_pcie_cap() after hardware is enabled
>>    (e.g., after PERST# deassert).
> 
> But you didn't modify all DWC EP drivers to call dw_pcie_get_pcie_cap(). This
> can lead to pcie_cap being 0.
> 
>> dw_pcie_ep_init_non_sticky_registers()
>>    is called after that point, so it can safely use pci->pcie_cap.
>>
>> dw_pcie_ep_init_non_sticky_registers() now assumes pci->pcie_cap is
>> valid. if not, it prints a warning and skips the operation.
> 
> Where is this warning printed?
> 
> These are already pointed out by Sashiko. You should go really go through all of
> them (not the pre-existing issues) and comment whether the issues are valid or
> false positive. For a series touching many controller drivers, this is necessary
> to avoid introducing regressions.
> 
> I'm not going to merge this series until you fix the real issues Sashiko
> reported or mark them as false positive if not valid.

Hello Mani,

I'm truly sorry. Recently, due to work commitments, I haven't had any 
spare time. I plan to handle this series after v7.3-rc1 is released. 
Thank you very much for your reply. I will carefully consider the 
subsequent review comments regarding Sashiko. Thank you again.


Best regards,
Hans

> 
> - Mani
> 


