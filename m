Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419E4C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 11:13:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DD22086B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 11:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DD22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434dL85PMkzDqhT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 22:13:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434d9F2l2HzDqjG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 22:05:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 434d9D1Dk5z9ryk;
 Wed, 28 Nov 2018 22:05:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: use generic DMA mapping code in powerpc V4
In-Reply-To: <20181127074253.GB30186@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
Date: Wed, 28 Nov 2018 22:05:19 +1100
Message-ID: <87zhttfonk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:

> Any comments?  I'd like to at least get the ball moving on the easy
> bits.

Nothing specific yet.

I'm a bit worried it might break one of the many old obscure platforms
we have that aren't well tested.

There's not much we can do about that, but I'll just try and test it on
everything I can find.

Is the plan that you take these via the dma-mapping tree or that they go
via powerpc?

cheers

> On Wed, Nov 14, 2018 at 09:22:40AM +0100, Christoph Hellwig wrote:
>> Hi all,
>> 
>> this series switches the powerpc port to use the generic swiotlb and
>> noncoherent dma ops, and to use more generic code for the coherent
>> direct mapping, as well as removing a lot of dead code.
>> 
>> As this series is very large and depends on the dma-mapping tree I've
>> also published a git tree:
>> 
>>     git://git.infradead.org/users/hch/misc.git powerpc-dma.4
>> 
>> Gitweb:
>> 
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
>> 
>> Changes since v3:
>>  - rebase on the powerpc fixes tree
>>  - add a new patch to actually make the baseline amigaone config
>>    configure without warnings
>>  - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
>>    always present
>>  - fix compile in mem.c for one configuration
>>  - drop the full npu removal for now, will be resent separately
>>  - a few git bisection fixes
>> 
>> The changes since v1 are to big to list and v2 was not posted in public.
>> 
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---
