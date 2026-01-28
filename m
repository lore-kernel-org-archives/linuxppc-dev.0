Return-Path: <linuxppc-dev+bounces-16359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E701D25B4B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 12:30:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1M6r71pMz2xlK;
	Wed, 28 Jan 2026 23:30:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769603412;
	cv=none; b=TQlxX4MLKoVaqzyMNlmqVojAwtL1eex9GjQn9Lal1/n+bcyme0fZePgfBhTBlo8brNheN0WUzKU7AAAtwQGU8Mu4yHlh9OEjF1X4Jsm620KOwww/auSgimPWkVWNrxSxg6m+1vYLjz7g7dHanNB06veUAQjKSDkEJfV84+iOvHC7Jq3HZq53npMxTfPDX1uq8dN66/eE2VPPNIUHbkBEPNYl66CMox2P0TAOYGGunfv6WjHUJIp8h+kmB5RQgqfqtAhgIAYx8NHxzIrhw79qGJjGxm6bB96zB4FYs+rqx5xMPKq7coHJ+CsNsaf6p4mQ7rXWc36otZ4ReASMvgdCPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769603412; c=relaxed/relaxed;
	bh=F50On8HKlI4ka25pRlURh9O9mME500DymQXKBhDiFm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpYRO5UvDC0UrKuPzy3a3YVGID3TfB23Qo7SRS0F0oSVAIxHqE3XFBaTen+xjPR2fn7cDw/5G4dn5nnI4bGs5txiicOlUL8C+z+T5z+C4z1HePYbFWZlK/COZUGZSACloo9iTnBcAQk/Modc7jI/1i1Gk311q2ViA/h3uRky/1UJvrdZp9Blgp5Q6gGmP9wzU/oGI8jEO9gXhAXxlNTbQXDr3o4z4EasLDlTYcqx5cbTNw/MELB/7h89iRmPRLCoVYBIHZOJUTJR9jJ7u6ooxxj6ZMUy+fwNhcSeFkwByKDnrZQObCOZPcd/LghbbUVWDURuFNPrGg5if7SoMbYY8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WlhfVTWG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WlhfVTWG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1M6q6s2tz2xjK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 23:30:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769603406; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F50On8HKlI4ka25pRlURh9O9mME500DymQXKBhDiFm0=;
	b=WlhfVTWGgJpCetfaiZcJnASiJNhc6DcjoL2cYLcjzCLMvBXGABCSwyG/vqDkVS8yA/cpEf3AbRLaoHPE5b9enddRxEyWk5KNVDThPES+MtyFViBzvgeVQf9mJV6B6lpZWY3yI7zubKHbPT01AOu21J8EJoeKQqG0VVTKXMZ26WQ=
Received: from 30.246.162.115(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wy3NkbG_1769603403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Jan 2026 20:30:04 +0800
Message-ID: <d23f7971-2c01-4242-b781-1378d96c130f@linux.alibaba.com>
Date: Wed, 28 Jan 2026 20:29:25 +0800
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
Subject: Re: [PATCH v7 3/5] PCI/AER: Report fatal errors of RCiEP and EP if
 link recoverd
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, terry.bowman@amd.com, tianruidong@linux.alibaba.com,
 lukas@wunner.de
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-4-xueshuai@linux.alibaba.com>
 <20260127103643.00007991@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260127103643.00007991@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/26 6:36 PM, Jonathan Cameron wrote:
> On Sat, 24 Jan 2026 15:45:55 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> The AER driver has historically avoided reading the configuration space of
>> an endpoint or RCiEP that reported a fatal error, considering the link to
>> that device unreliable. Consequently, when a fatal error occurs, the AER
>> and DPC drivers do not report specific error types, resulting in logs like:
>>
>>    pcieport 0015:00:00.0: EDR: EDR event received
>>    pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>>    pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>>    pcieport 0015:00:00.0: AER: broadcast error_detected message
>>    pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>>    pcieport 0015:00:00.0: AER: broadcast resume message
>>    pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>>    pcieport 0015:00:00.0: AER: device recovery successful
>>    pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>>    pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
>>
>> AER status registers are sticky and Write-1-to-clear. If the link recovered
>> after hot reset, we can still safely access AER status and TLP header of the
>> error device. In such case, report fatal errors which helps to figure out the
>> error root case.
>>
>> After this patch, the logs like:
>>
>>    pcieport 0015:00:00.0: EDR: EDR event received
>>    pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
>>    pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
>>    pcieport 0015:00:00.0: AER: broadcast error_detected message
>> + vfio-pci 0015:01:00.0: AER: Errors reported prior to reset
>> + vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
>> + vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
>> + vfio-pci 0015:01:00.0:    [12] TLP                    (First)
>> + vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
>>    pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
>>    pcieport 0015:00:00.0: AER: broadcast resume message
>>    pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
>>    pcieport 0015:00:00.0: AER: device recovery successful
>>    pcieport 0015:00:00.0: EDR: DPC port successfully recovered
>>    pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Hi Shuai,
> 
> With the structure zeroed below (just to make this easier to review, not because
> there is a bug as far as I can see)
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index e0bcaa896803..4c0a2bbe9197 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
> 
>> @@ -1447,17 +1450,38 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>>   	return 1;
>>   }
>>   
>> +void aer_report_frozen_error(struct pci_dev *dev)
>> +{
>> +	struct aer_err_info info;
>> +	int type = pci_pcie_type(dev);
>> +
>> +	if (type != PCI_EXP_TYPE_ENDPOINT && type != PCI_EXP_TYPE_RC_END)
>> +		return;
>> +
> 
> struct aer_err_info has a bunch of fields. I'd just make sure it's zeroed
> to avoid us having to check that they are all filled in. = {};
> or do it with the initial values being assigned.
> 
> 	info = (struct aer_err_info) {
> 		.err_dev_num = 0,
> 		.severity = AER_FATAL,
> 		.level = KERN_ERR,
> 	};
> 	add_error_device(&info, dev);
> 
> 

Got it. Will fix it in next verison.

Thanks for valuable comments.

Best Regards,
Shuai

