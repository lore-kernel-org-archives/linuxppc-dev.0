Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8199BDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 03:23:37 +1100 (EST)
Message-Id: <A1C24C7B-B995-4062-9D81-86F1CD2FD514@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081201045413.1E539DDD0C@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Fix dma_map_sg() cache flushing on non coherent
	platforms
Date: Mon, 1 Dec 2008 10:23:26 -0600
References: <20081201045413.1E539DDD0C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 30, 2008, at 10:53 PM, Benjamin Herrenschmidt wrote:

> On PowerPC 4xx or other non cache coherent platforms, we lost the
> appropriate cache flushing in dma_map_sg() when merging the 32
> and 64-bit DMA code.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Becky Bruce <beckyb@kernel.crashing.org>

Sins of omission are always the hardest to catch.....  My apologies,  
and thanks!

-B

>
> ---
>
> Oops .. nobody spotted that when Becky patches went in !
>
> Paul: This is a 2.6.28 regression and should be merged asap
>
> arch/powerpc/kernel/dma.c |    1 +
> 1 file changed, 1 insertion(+)
>
> --- linux-work.orig/arch/powerpc/kernel/dma.c	2008-12-01  
> 15:44:55.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/dma.c	2008-12-01  
> 15:45:13.000000000 +1100
> @@ -75,6 +75,7 @@ static int dma_direct_map_sg(struct devi
> 	for_each_sg(sgl, sg, nents, i) {
> 		sg->dma_address = sg_phys(sg) + get_dma_direct_offset(dev);
> 		sg->dma_length = sg->length;
> +		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
> 	}
>
> 	return nents;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
