Return-Path: <linuxppc-dev+bounces-16649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CB4EB28D9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 07:40:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6mGp4mxcz2xqk;
	Fri, 06 Feb 2026 18:40:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770363650;
	cv=none; b=KPml6Ns8/NWfvSghv4zydw1uDoiN1IDEQkXb0Hlp9pvO583WER/xmWviG/ZTvC8DkYFMlDN067aCkAHJIt74f/nmRsKToYDuXNn5n/q8u1g5YkNRlVZdrEfg1lqxCzLQikJkxSm0DQY4ahU6HPjje8TQdy3sUBjmAW/5SyOTEfIKer/o7I2FhbZhfdvVmZe9Qf7Fax2GG6ZJ6C4SCQygAAYvDmdCJJ1u/fDVGpkCZNtUxeiGm7Z2kRk7c8gjnzz03R74Vfz5/5NwDRg5q8DHA3cx3QCqbe8C2hfcbVgQ7Fy6wRfZRo2+Pxy3ZagX+j25cmL6VVm6IbvB/cUQjsWQaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770363650; c=relaxed/relaxed;
	bh=ZM3jUVWnJ9uaVrG3aDHcVLfZjBoDdiCFav4GZo0g+kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKKU4t5Nl4xT9LX7LGjXi4kTT3S+hsJ/rVOroutfbLInOIVl2Vdf2MEshiQTxbeMW/dWJbu7u4a4HmJpIvNujX52/O9et29nx/WY0X1jP5jNOiXko0QXgDduoC7ddF5h4AX7WqwffERcsIIWUAVaxVAhTmtzi28NrHcr8gjyFeWmMCyU3aEUq0gisxtm8dYlMWj7t0y//jMQAttrdqtOF9hLZp4KqvE8Pu6mJl42LHR2xYl3AzdRx9PqEZAlzBPpikU+Bb5HrT3LTyjjl3YcFX1nfzO4F2ONyrDL8TJJmYkLzwL8GiT/KjgswhLhlCp9K0WkcsigwgM+xpwUxPnJ3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VI+RgwCL; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VI+RgwCL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6mGl5SKTz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 18:40:45 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770363639; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ZM3jUVWnJ9uaVrG3aDHcVLfZjBoDdiCFav4GZo0g+kc=;
	b=VI+RgwCLxWVCuOtc/ch/JcheCy5T+0sXDNbrHvO4YlFO8JQu8BKGJKViwfi5molan/yerr9bhFpYwql9suIARn/RMseKqxzR0ZtD57xUuHp9nmBE2i+neU3xfNxJP6LPuY8ULMEhd8JGRiF4AniV9fkPxRg4X9ftXohkwLUKLkQ=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wydse.a_1770363635 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 15:40:36 +0800
Message-ID: <aceba0b1-b198-492d-b8c2-073a2b933b18@linux.alibaba.com>
Date: Fri, 6 Feb 2026 15:39:29 +0800
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
Subject: Re: [PATCH v7 5/5] PCI/AER: Only clear error bits in
 pcie_clear_device_status()
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <aYGpgSztxNMZO-oC@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYGpgSztxNMZO-oC@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 3:53 PM, Lukas Wunner wrote:
> On Sat, Jan 24, 2026 at 03:45:57PM +0800, Shuai Xue wrote:
>> +++ b/drivers/pci/pci.c
>> @@ -2246,7 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>   	u16 sta;
>>   
>>   	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>> -	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta & PCI_EXP_DEVSTA_ERR);
>>   }
> 
> I don't think there's any harm to write error bits which are currently 0,
> so I'd just get rid of the pcie_capability_read_word() and directly write
> the error bits.

Good point. I will remove the read step.

> 
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -534,6 +534,7 @@
>>   #define  PCI_EXP_DEVSTA_NFED	0x0002	/* Non-Fatal Error Detected */
>>   #define  PCI_EXP_DEVSTA_FED	0x0004	/* Fatal Error Detected */
>>   #define  PCI_EXP_DEVSTA_URD	0x0008	/* Unsupported Request Detected */
>> +#define  PCI_EXP_DEVSTA_ERR	0xf	/* Error bits */
> 
> There's only one user of PCI_EXP_DEVSTA_ERR and it feels a little
> awkward to define a macro in a uapi header which does not correspond
> to an "official" bit definition but is just there for convenience.
> 
> So maybe it's better to simply use the macros for the four bits in
> pcie_clear_device_status()?  Might also be slightly clearer.

Agreed, will move PCI_EXP_DEVSTA_ERR to drivers/pci/pci.c.

> 
> This patch could be submitted individually instead of being part
> of this series.


Got it. Will send a individual patch.

> 
> Thanks,
> 
> Lukas

Thanks for valuable comments.
Shuai


