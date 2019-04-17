Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF9C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:38:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A53720872
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A53720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kRJ96ZB9zDqN9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kRGN6zwkzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 12:37:16 +1000 (AEST)
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 051CDC13ADFA5248D7C5;
 Wed, 17 Apr 2019 10:37:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Wed, 17 Apr 2019
 10:37:00 +0800
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
 <20190409125308.18304-2-thunder.leizhen@huawei.com>
 <010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
 <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
 <20190416152100.GB4187@fuggles.cambridge.arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CB6914A.8050308@huawei.com>
Date: Wed, 17 Apr 2019 10:36:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190416152100.GB4187@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
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
Cc: linux-ia64 <linux-ia64@vger.kernel.org>,
 Sebastian Ott <sebott@linux.ibm.com>, linux-doc <linux-doc@vger.kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>,
 linux-s390 <linux-s390@vger.kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 John Garry <john.garry@huawei.com>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, Tony Luck <tony.luck@intel.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/4/16 23:21, Will Deacon wrote:
> On Fri, Apr 12, 2019 at 02:11:31PM +0100, Robin Murphy wrote:
>> On 12/04/2019 11:26, John Garry wrote:
>>> On 09/04/2019 13:53, Zhen Lei wrote:
>>>> +static int __init iommu_dma_mode_setup(char *str)
>>>> +{
>>>> +    if (!str)
>>>> +        goto fail;
>>>> +
>>>> +    if (!strncmp(str, "passthrough", 11))
>>>> +        iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
>>>> +    else if (!strncmp(str, "lazy", 4))
>>>> +        iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
>>>> +    else if (!strncmp(str, "strict", 6))
>>>> +        iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
>>>> +    else
>>>> +        goto fail;
>>>> +
>>>> +    pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
>>>
>>> What happens if the cmdline option iommu.dma_mode is passed multiple
>>> times? We get mutliple - possibily conflicting - prints, right?
>>
>> Indeed; we ended up removing such prints for the existing options here,
>> specifically because multiple messages seemed more likely to be confusing
>> than useful.

I originally intended to be compatible with X86 printing.

 		} else if (!strncmp(str, "strict", 6)) {
 			pr_info("Disable batched IOTLB flush\n");
			intel_iommu_strict = 1;
 		}

>>
>>> And do we need to have backwards compatibility, such that the setting
>>> for iommu.strict or iommu.passthrough trumps iommu.dma_mode, regardless
>>> of order?
>>
>> As above I think it would be preferable to just keep using the existing
>> options anyway. The current behaviour works out as:
>>
>> iommu.passthrough |      Y	|	  N
>> iommu.strict	  |      x	|    Y         N
>> ------------------|-------------|---------|--------
>> MODE		  | PASSTHROUGH | STRICT  |  LAZY
>>
>> which seems intuitive enough that a specific dma_mode option doesn't add
>> much value, and would more likely just overcomplicate things for users as
>> well as our implementation.
> 
> Agreed. We can't remove the existing options, and they do the job perfectly
> well so I don't see the need to add more options on top.

OK, I will remove the iommu.dma_mode option in the next version. Thanks for you three.

I didn't want to add it at first, but later found that the boot options on
each ARCH are different, then want to normalize it.

In addition, do we need to compatible the build option name IOMMU_DEFAULT_PASSTHROUGH? or
change it to IOMMU_DEFAULT_DMA_MODE_PASSTHROUGH or IOMMU_DEFAULT_MODE_PASSTHROUGH?

> 
> Will
> 
> .
> 

-- 
Thanks!
BestRegards

