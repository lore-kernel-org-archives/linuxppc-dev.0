Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD368C432C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 17:43:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A1820718
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 17:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A1820718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HY8h3WdczDqgq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 04:43:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 47HY6h0QhWzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 04:42:02 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A951FB;
 Tue, 19 Nov 2019 09:42:00 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D3FC3F703;
 Tue, 19 Nov 2019 09:41:59 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: generic DMA bypass flag
To: Christoph Hellwig <hch@lst.de>
References: <20191113133731.20870-1-hch@lst.de>
 <d27b7b29-df78-4904-8002-b697da5cb013@arm.com>
 <20191114074105.GC26546@lst.de>
 <9c8f4d7b-43e0-a336-5d93-88aef8aae716@arm.com> <20191116062258.GA8913@lst.de>
Message-ID: <f2335431-8cd4-e1ab-013d-573d163f4067@arm.com>
Date: Tue, 19 Nov 2019 17:41:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116062258.GA8913@lst.de>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 16/11/2019 6:22 am, Christoph Hellwig wrote:
> On Fri, Nov 15, 2019 at 06:12:48PM +0000, Robin Murphy wrote:
>> And is that any different from where you would choose to "just" set a
>> generic bypass flag?
> 
> Same spots, as intel-iommu moves from the identify to a dma domain when
> setting a 32-bit mask.  But that means once a 32-bit mask is set we can't
> ever go back to the 64-bit one.

Is that a problem though? It's not safe in general to rewrite the 
default domain willy-nilly, so if it's a concern that drivers get stuck 
having to use a translation domain if they do something dumb like:

	if (!dma_set_mask(DMA_BIT_MASK(32))
		dma_set_mask(DMA_BIT_MASK(64));

then the simple solution is "don't do that" - note that this doesn't 
affect overriding of the default 32-bit mask, because we don't use the 
driver API to initialise those.

>  And we had a couple drivers playing
> interesting games there.

If the games you're worried about are stuff like:

	dma_set_mask(dev, DMA_BIT_MASK(64));
	high_buf = dma_alloc_coherent(dev, ...);
	dma_set_mask(dev, DMA_BIT_MASK(32));
	low_buf = dma_alloc_coherent(dev, ...);

then iommu_need_mapping() already ensures that will end spectacularly 
badly. Unless we can somehow log when a mask has been "committed" by a 
mapping operation, I don't think any kind of opportunistic bypass 
mechanism is ever not going to blow up that case.

>  FYI, this is the current intel-iommu
> WIP conversion to the dma bypass flag:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma-bypass

Having thought a bit more, I guess my idea does end up with one slightly 
ugly corner wherein dma_direct_supported() has to learn to look for an 
IOMMU default domain and try iommu_dma_supported() before saying no, 
even if it's clean everywhere else. The bypass flag is more 'balanced' 
in terms of being equally invasive everywhere and preserving abstraction 
a bit better. Plus I think it might let us bring back the default 
assignment of dma_dummy_ops, which I do like the thought of :D

Either way, making sure that the fundamental bypass decision is correct 
and robust is still far more important than the implementation details.

Robin.
