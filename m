Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DEBC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:41:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFF720672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:41:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFF720672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JClG15Y5zDqVh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 18:41:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JChn4CTdzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:39:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43JChh2MRCz9vGxT;
 Mon, 17 Dec 2018 08:39:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id gv4wnchWpjDt; Mon, 17 Dec 2018 08:39:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43JChh1ZRDz9vGxS;
 Mon, 17 Dec 2018 08:39:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7CD398B7B7;
 Mon, 17 Dec 2018 08:39:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id VmYaXSKg397z; Mon, 17 Dec 2018 08:39:16 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 59DAF8B74B;
 Mon, 17 Dec 2018 08:39:16 +0100 (CET)
Subject: Re: [PATCH 2/8] powerpc/dma: properly wire up the unmap_page and
 unmap_sg methods
To: Christoph Hellwig <hch@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-3-hch@lst.de>
 <ea83ba21-feee-9776-ab0a-5bc78b237e4c@c-s.fr> <20181217073434.GC1933@lst.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7074a63b-2eda-b775-ef1f-9708618fc717@c-s.fr>
Date: Mon, 17 Dec 2018 08:39:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217073434.GC1933@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: Christian Lamparter <chunkeey@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 17/12/2018 à 08:34, Christoph Hellwig a écrit :
> On Mon, Dec 17, 2018 at 07:41:54AM +0100, Christophe Leroy wrote:
>>
>>
>> Le 16/12/2018 à 18:19, Christoph Hellwig a écrit :
>>> The unmap methods need to transfer memory ownership back from the device
>>> to the cpu by identical means as dma_sync_*_to_cpu.  I'm not sure powerpc
>>> needs to do any work in this transfer direction, but given that it does
>>> invalidate the caches in dma_sync_*_to_cpu already we should make sure
>>> we also do so on unmapping.
>>
>> Why do we have to do that on unmapping ? If we are unmapping it means we
>> are retiring the area, so why would we need to use CPU for syncing an area
>> than won't be used anymore ?
> 
> So in general we need the cache maintaince only at map time if the CPUs
> gurantee to never ѕpeculate into memory that might be under DMA, which
> for modern CPUs is increasingly rate.  If the CPUs could speculate into
> the area that was DMA mapped we need to do another round of cache
> maintainance on unmap to make sure we really do not have any data
> in the cache.  powerpc currently does that for dma_sync_*_to_cpu, but
> not for the unmap case, which not only looks odd but also seems to be
> worked around in drivers (see the ppc44x crypto patch).
> 
> Note that there are some way to optimize the amount of cache flushing
> done even when the cpu speculates, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arc/mm/dma.c#n93
> 
> But for that I need help with people that actually understand the
> non-coherent powerpc SOCs and who can test it.  For now this patch
> is conservative.
> 

I can help you with powerpc 8xx actually.

Christophe
