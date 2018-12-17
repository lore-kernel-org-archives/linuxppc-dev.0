Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3798DC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 06:44:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F4B20675
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 06:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F4B20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JBSv0DnZzDqjl
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 17:43:59 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JBQd06kDzDqbq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 17:41:59 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43JBQV0GgQz9v08N;
 Mon, 17 Dec 2018 07:41:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7PD14UHQpQ7i; Mon, 17 Dec 2018 07:41:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43JBQT6tyVz9v08K;
 Mon, 17 Dec 2018 07:41:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FBDF8B7B4;
 Mon, 17 Dec 2018 07:41:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id htzz2EhOwswQ; Mon, 17 Dec 2018 07:41:54 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 16C7F8B74B;
 Mon, 17 Dec 2018 07:41:54 +0100 (CET)
Subject: Re: [PATCH 2/8] powerpc/dma: properly wire up the unmap_page and
 unmap_sg methods
To: Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-3-hch@lst.de>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ea83ba21-feee-9776-ab0a-5bc78b237e4c@c-s.fr>
Date: Mon, 17 Dec 2018 07:41:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181216171951.31306-3-hch@lst.de>
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
Cc: linuxppc-dev@lists.ozlabs.org, Christian Lamparter <chunkeey@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/12/2018 à 18:19, Christoph Hellwig a écrit :
> The unmap methods need to transfer memory ownership back from the device
> to the cpu by identical means as dma_sync_*_to_cpu.  I'm not sure powerpc
> needs to do any work in this transfer direction, but given that it does
> invalidate the caches in dma_sync_*_to_cpu already we should make sure
> we also do so on unmapping.

Why do we have to do that on unmapping ? If we are unmapping it means we 
are retiring the area, so why would we need to use CPU for syncing an 
area than won't be used anymore ?

Christophe


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/powerpc/kernel/dma.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> index dbfc7056d7df..d442d23e182b 100644
> --- a/arch/powerpc/kernel/dma.c
> +++ b/arch/powerpc/kernel/dma.c
> @@ -210,10 +210,15 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
>   	return nents;
>   }
>   
> -static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
> +static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
>   				int nents, enum dma_data_direction direction,
>   				unsigned long attrs)
>   {
> +	struct scatterlist *sg;
> +	int i;
> +
> +	for_each_sg(sgl, sg, nents, i)
> +		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
>   }
>   
>   static u64 dma_nommu_get_required_mask(struct device *dev)
> @@ -247,6 +252,8 @@ static inline void dma_nommu_unmap_page(struct device *dev,
>   					 enum dma_data_direction direction,
>   					 unsigned long attrs)
>   {
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		__dma_sync(bus_to_virt(dma_address), size, dir);
>   }
>   
>   #ifdef CONFIG_NOT_COHERENT_CACHE
> 
