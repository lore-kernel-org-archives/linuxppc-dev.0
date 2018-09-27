Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07EC43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 16:44:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC65D21533
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 16:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC65D21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Lgcz5Y2gzF37k
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 02:44:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=robin.murphy@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 42LgZ11qvQzF35g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 02:41:43 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEE3518A;
 Thu, 27 Sep 2018 09:41:39 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.Emea.Arm.com [10.4.12.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93DF03F5B3;
 Thu, 27 Sep 2018 09:41:38 -0700 (PDT)
Subject: Re: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
To: Christoph Hellwig <hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
 <20180920185247.20037-5-hch@lst.de>
 <a7626d1b-4dd8-abc4-0ab0-21ab7e5d1a4c@arm.com>
 <20180927153252.GE10566@lst.de>
 <967e98b1-99ab-8f95-4c89-6156ce489b93@arm.com>
 <20180927162737.GA11974@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b87ef7ac-81fc-c649-7ffb-73017ec99790@arm.com>
Date: Thu, 27 Sep 2018 17:41:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927162737.GA11974@lst.de>
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
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
Message-ID: <20180927164136.iPmiXebS8DfWSQkBHLZmZkMehNflY1dZ9xYLMc7T88w@z>

On 27/09/18 17:27, Christoph Hellwig wrote:
> On Thu, Sep 27, 2018 at 05:14:56PM +0100, Robin Murphy wrote:
>>> This just seemed more readable to me than min_not_zero, but if others
>>> prefer min_not_zero I can switch.
>>
>> Nah, just checking whether there were any intentionally different
>> assumptions compared to the couple of other places in the patch where
>> min_not_zero() *is* used. If it's purely a style thing then no worries
>> (personally I'd have written it yet another way anyway).
> 
> I'm curious: how would you have written it?

Come to think of it, I actually already have, in iommu-dma:

	if (dev->bus_dma_mask)
		mask &= dev->bus_dma_mask;

but of course it's not so pretty for those cases where you don't already 
have the local variable ready to go.

Robin.
