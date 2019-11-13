Return-Path: <SRS0=PO5t=ZF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3495C432C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 20:36:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F510206D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Nov 2019 20:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F510206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47CxGw0ltHzF7GW
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Nov 2019 07:36:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 47CxDT4l0dzF61k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Nov 2019 07:34:31 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ECF57A7;
 Wed, 13 Nov 2019 12:34:28 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CFC03F52E;
 Wed, 13 Nov 2019 12:34:23 -0800 (PST)
Subject: Re: [PATCH] dma-mapping: treat dev->bus_dma_mask as a DMA limit
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
References: <20191113161340.27228-1-nsaenzjulienne@suse.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f74cd8a6-00bf-46c3-8e2e-d278e72d6e0e@arm.com>
Date: Wed, 13 Nov 2019 20:34:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113161340.27228-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
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
Cc: linux-mips@vger.kernel.org, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Burton <paulburton@kernel.org>, x86@kernel.org, phil@raspberrypi.org,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 linux-pci@vger.kernel.org, James Hogan <jhogan@kernel.org>,
 Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 13/11/2019 4:13 pm, Nicolas Saenz Julienne wrote:
> Using a mask to represent bus DMA constraints has a set of limitations.
> The biggest one being it can only hold a power of two (minus one). The
> DMA mapping code is already aware of this and treats dev->bus_dma_mask
> as a limit. This quirk is already used by some architectures although
> still rare.
> 
> With the introduction of the Raspberry Pi 4 we've found a new contender
> for the use of bus DMA limits, as its PCIe bus can only address the
> lower 3GB of memory (of a total of 4GB). This is impossible to represent
> with a mask. To make things worse the device-tree code rounds non power
> of two bus DMA limits to the next power of two, which is unacceptable in
> this case.
> 
> In the light of this, rename dev->bus_dma_mask to dev->bus_dma_limit all
> over the tree and treat it as such. Note that dev->bus_dma_limit is
> meant to contain the higher accesible DMA address.

Neat, you win a "why didn't I do it that way in the first place?" :)

Looking at it without all the history of previous attempts, this looks 
entirely reasonable, and definitely a step in the right direction.

[...]
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 5a7551d060f2..f18827cf96df 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1097,7 +1097,7 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>   		 * Limit coherent and dma mask based on size
>   		 * retrieved from firmware.
>   		 */
> -		dev->bus_dma_mask = mask;
> +		dev->bus_dma_limit = mask;

Although this preserves the existing behaviour, as in of_dma_configure() 
we can do better here since we have the original address range to hand. 
I think it's worth keeping the ACPI and OF paths in sync for minor 
tweaks like this, rather than letting them diverge unnecessarily.

Otherwise, the rest looks OK to me - in principle we could store it as 
an exclusive limit such that we could then streamline the min_not_zero() 
tests to just min(mask, limit - 1), but that's probably too clever for 
its own good.

Robin.

>   		dev->coherent_dma_mask = mask;
>   		*dev->dma_mask = mask;
>   	}
