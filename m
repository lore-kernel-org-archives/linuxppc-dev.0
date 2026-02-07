Return-Path: <linuxppc-dev+bounces-16709-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3692EE6B76
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Feb 2026 08:35:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f7PRg2ngGz2xm3;
	Sat, 07 Feb 2026 19:35:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770453343;
	cv=none; b=TaYPFC+J22g7I51fhK5kVjJ63kus3eqh5oKpayS28j9LNiGUQrTt1qnN8kvsYSzxntkCO6RXxKixr7sInHPmrEoKrPUO+nCvsRDXRsBZU+P62muDtd78WP+yaTaDHis4bfiJq863gNgWbJQwzhMPG+jRODU0Af1cINBLSY7xR+NQbInZQa1WGupJLV7aJPYf1fKyYd9WSbRCTyPKtl/PwHmPtd7RY/uo4PcaxDu/OBj1fxghfgBUY5QD3CIwGWuN7w6YAa/otriBcsD21OiDMa+WXkbMZlybt0+E/MjBX08EczyhFEyFfY6Lrh42re+MSwjCUtomKNX0zPOtl661zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770453343; c=relaxed/relaxed;
	bh=NdAVUBsBt+q9ht9jChQ+fU7/bdKbU4jceYqVa9txGzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bz2z20OmUGq7CzdJmA4ij+RxXqIm9ipM/YLIob7LLq465qDtMxuKe7D9OpJjMJnis4BBA47RoXNSJVJGhlkOWJHvblunhsGWe8sCgNHDCSJdMiyXnJ5S+w3/y0tPI5ZKse4cuYqASU8COPDQ37UzajQVy/NnE+OUPF+bkL9pecgiw7Ayq44qAfrz8v4tXfdv9cv8fwZECfcD3EjfVWeZ3y5kQasRLUHGssNPGgoaDiPYdFFXk/KbnRC5uCwihlJxkfdYEAv/V0EE7ygnxL4JHW62ts2M4SfTJKUuq3T5pX1qi79WOcbBTkkp10/KzLDjhaEB08esEdvcx7BqTVyNvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CM4oQQE1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CM4oQQE1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=xueshuai@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f7PRd22Lgz2xWJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Feb 2026 19:35:39 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770453335; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NdAVUBsBt+q9ht9jChQ+fU7/bdKbU4jceYqVa9txGzY=;
	b=CM4oQQE17iGnlLhDv5F4te2WbgEM6Aw4ZLJjuBoH5qfFE6DHIB9Zebt3uuSdRE31Dqj8KVzWGrgLvWXlF6i8igIMe4vwQXBzJNuu3t0w48RTXW8tUuR0PqSVHjWclqvT/oEmpdNj3CfdEznYwgLEAAQLVbeahCOs9BdGLakqtc8=
Received: from 30.246.162.188(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WyhXHoT_1770453333 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 07 Feb 2026 16:35:34 +0800
Message-ID: <de195f39-8197-494e-8451-2cf8fde064ea@linux.alibaba.com>
Date: Sat, 7 Feb 2026 16:34:23 +0800
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
Subject: Re: [PATCH v7 4/5] PCI/AER: Clear both AER fatal and non-fatal status
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, kbusch@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
 tianruidong@linux.alibaba.com
References: <20260124074557.73961-1-xueshuai@linux.alibaba.com>
 <20260124074557.73961-5-xueshuai@linux.alibaba.com>
 <aYGsmgyVwvbj83YI@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aYGsmgyVwvbj83YI@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/26 4:06 PM, Lukas Wunner wrote:
> On Sat, Jan 24, 2026 at 03:45:56PM +0800, Shuai Xue wrote:
>> The DPC driver clears AER fatal status for the port that reported the
>> error, but not for the downstream device that deteced the error.  The
>> current recovery code only clears non-fatal AER status, leaving fatal
>> status bits set in the error device.
> 
> That's not quite accurate:
> 
> The error device has undergone a Hot Reset as a result of the Link Down
> event.  To be able to use it again, pci_restore_state() is invoked by
> the driver's ->slot_reset() callback.  And pci_restore_state() does
> clear fatal status bits.
> 
> pci_restore_state()
>    pci_aer_clear_status()
>      pci_aer_raw_clear_status()
> 
>> Use pci_aer_raw_clear_status() to clear both fatal and non-fatal error
>> status in the error device, ensuring all AER status bits are properly
>> cleared after recovery.
> 
> Well, pci_restore_state() already clears all AER status bits so why
> is this patch necessary?

You're right that many drivers call pci_restore_state() in their
->slot_reset() callback, which clears all AER status bits.  However,
since ->slot_reset() is driver-defined and not all drivers invoke
pci_restore_state(), there could be cases where fatal AER status bits
remain set after the frozen recovery completes.

> 
>> +++ b/drivers/pci/pcie/err.c
>> @@ -285,7 +285,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	 */
>>   	if (host->native_aer || pcie_ports_native) {
>>   		pcie_clear_device_status(dev);
>> -		pci_aer_clear_nonfatal_status(dev);
>> +		pci_aer_raw_clear_status(dev);
>>   	}
> 
> This code path is for the case when pcie_do_recovery() is called
> with state=pci_channel_io_normal, i.e. in the nonfatal case.
> That's why only the nonfatal bits need to be cleared here.
> 
> In the fatal case clearing of the error bits is done by
> pci_restore_state().
> 
> I understand that this is subtle and should probably be changed
> to improve clarity, but this patch doesn't look like a step
> in that direction.
> 

I notice that pcie_clear_device_status()
(called just before pci_aer_clear_nonfatal_status()) already clears
*all* error bits in the Device Status register (CED, NFED, FED, URD),
including the Fatal Error Detected (FED) bit, regardless of whether
we're in a fatal or nonfatal recovery path.

So there's an inconsistency in the current design:
- pcie_clear_device_status() clears all error bits (including FED)
- pci_aer_clear_nonfatal_status() only clears nonfatal AER status

This means that even in the nonfatal case, the FED bit in Device
Status is cleared, even though we preserve the fatal bits in the AER
Uncorrectable Error Status register.

Would you prefer that I:
1. Make both pcie_clear_device_status() and the AER clearing
    conditional on the 'state' parameter, so that nonfatal recovery
    truly preserves fatal bits in both registers, or
2. Drop this patch and instead move the AER-specific clearing logic
    out of pcie_do_recovery() entirely (as you suggested earlier), so
    that each caller can handle the status clearing explicitly for the
    appropriate error sources and severity?

Thanks,
Shuai


