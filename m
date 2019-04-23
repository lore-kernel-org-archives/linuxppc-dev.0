Return-Path: <SRS0=/W8y=SZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F86C10F11
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 02:47:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3654A206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 02:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3654A206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44p7CJ5gf0zDqP0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 12:47:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.190; helo=huawei.com;
 envelope-from=thunder.leizhen@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44p79Y6Y9KzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 12:45:51 +1000 (AEST)
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5C8025C6578F44F050BD;
 Tue, 23 Apr 2019 10:45:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.23.164) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 10:45:39 +0800
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
To: Joerg Roedel <joro@8bytes.org>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
 <20190409125308.18304-2-thunder.leizhen@huawei.com>
 <20190412111649.GK4518@8bytes.org>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <5CBE7C51.8070002@huawei.com>
Date: Tue, 23 Apr 2019 10:45:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20190412111649.GK4518@8bytes.org>
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
 linux-s390 <linux-s390@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, x86 <x86@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Will Deacon <will.deacon@arm.com>, John Garry <john.garry@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Gerald
 Schaefer <gerald.schaefer@de.ibm.com>, Tony Luck <tony.luck@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2019/4/12 19:16, Joerg Roedel wrote:
> On Tue, Apr 09, 2019 at 08:53:03PM +0800, Zhen Lei wrote:
>> +static int __init iommu_dma_mode_setup(char *str)
>> +{
>> +	if (!str)
>> +		goto fail;
>> +
>> +	if (!strncmp(str, "passthrough", 11))
>> +		iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
>> +	else if (!strncmp(str, "lazy", 4))
>> +		iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
>> +	else if (!strncmp(str, "strict", 6))
>> +		iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
>> +	else
>> +		goto fail;
>> +
>> +	pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
> 
> Printing a number is not very desriptive or helpful to the user. Please
> print the name of the mode instead.

OK, thanks. I have given up adding iommu.dma_mode boot option according
to Robin and Will's suggestion. So these codes will be removed in v6.

> 
> 
> Regards,
> 
> 	Joerg
> 
> .
> 

-- 
Thanks!
BestRegards

