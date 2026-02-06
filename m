Return-Path: <linuxppc-dev+bounces-16650-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586DEEB28D6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Feb 2026 08:14:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6n1C5LZPz2xqk;
	Fri, 06 Feb 2026 19:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770365647;
	cv=none; b=XsECUuwYm6BMHgWOcnzq0sWCfQzy1JuhQRKVplIqVSPs0p69G1yuDXdm0Qk8uX40OdsaRDo4oknKI66wZVJL34SJWKZbJvX+nq7Q+dUMpsvbWJEuu2A4l+ZdHRhvLFoy5A8Rhr87iRQ4o8LAvJRfzzYtu5uRN9EfismzUgmxK5XtTZTMqXQI3qSzHVgZAmScT+mmMXFuykS2glhk17MEQzSDmERUvsghssyaJtd9aN0NEGJz+GQeq24OizNED5mDRzzJAncXhws3zu4h10PHxbnV8dJAymXnpRodQmoP0nNU3sf2cL150Al91hjbZoXETAluk9MHX6vWP/wr5e96MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770365647; c=relaxed/relaxed;
	bh=SUR3J96tpew0aIA17uFoZSxztnE+e1qWG/WJy7zluF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRN19xKOq9NyAUZgAfwdkw+N9H7Iyhp6vHLGNrE5JG5xYDhV44SDpW8IJhJJa0ya1lvAnhUv48vmjN8BBRUtsh7OTRZcA6RjQWx7ot+qr1lvvOoNOcrGh7CGjiirJKzchSVdEUzOh//imoAKQU00a2pZx8nufdmHP7mW19XVkB7cWxB1Wj7Dc2dLDEWm9+fb+J9idcukn5foY6aiOB9t6JWdDryxG/kxKOaNncY/D46NipZCvPzBp0ABe56jVz1nq6YJOvb5c9IBvJUu29TOZ310H/P2o1AcXmz+cWv1INKMSdOYFgmi817e07INHJjyGR6sU5UDLfkSw1X6L+G+zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pLcD7kEb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pLcD7kEb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6n110Sp4z2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Feb 2026 19:13:54 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770365629; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SUR3J96tpew0aIA17uFoZSxztnE+e1qWG/WJy7zluF0=;
	b=pLcD7kEbB7Yk9VCqbAN9Fd4cParoysbmBsZEQFDxld6NF6O7jD7YNK/Nrzu2sa/VxfSSHlWXQMSHUoF+5Ukjh+UQlMrxTllKLw/bJG3oDntgwxllXpo5tfpSjvzEtJTUcUlI2ez6VqyMqM/6VLdnvBVeOih0DL7H9PoEBsyTnCU=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WydyNkV_1770365626 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 16:13:47 +0800
Message-ID: <83411a03-e5f8-4f28-b781-b4010a785f1b@linux.alibaba.com>
Date: Fri, 6 Feb 2026 16:12:39 +0800
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
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-6-xueshuai@linux.alibaba.com>
 <20260127104520.0000579c@huawei.com>
 <881e57b7-aa73-4df6-b37b-d71571567436@linux.alibaba.com>
 <aYGne72Gjb_d9Myd@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYGne72Gjb_d9Myd@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 3:44 PM, Lukas Wunner wrote:
> On Wed, Jan 28, 2026 at 08:45:36PM +0800, Shuai Xue wrote:
>> The revised the commit message is:
>>
>> PCI/AER: Only clear error bits in PCIe Device Status register
>>
>> Currently, pcie_clear_device_status() clears the entire PCIe Device
>> Status register (PCI_EXP_DEVSTA), which includes both error status bits
>> and other status bits.
>>
>> According to PCIe Base Spec r6.0 sec 7.5.3.5, the Device Status register
>> contains different types of status bits:
> 
> Always cite the latest spec revision, i.e. PCIe r7.0 sec 7.5.3.5.

Sure, I will update the cite version.

> 
>> - RW1C (read/write 1 to clear) non-error bits: For example, Emergency
>>    Power Reduction Detected (bit 6). Unconditionally clearing these bits
>>    can interfere with other drivers or subsystems that rely on them.
> 
> It would be good to explicitly call out that this bit was introduced with
> PCIe r5.0 in 2019 and that it's currently the only writable bit in the
> register besides the error bits.

Sure, will add it.

> 
>> - Reserved bits: May be used for future features and should be preserved.
> 
> Wrong, they're marked "RsvdZ" (not "RsvdP"), so they're supposed to be
> written as zero (not preserved).

Thanks for correcting me. Will fix it.

> 
> Thanks,
> 
> Lukas


Thanks for valuable comments.
Shuai


