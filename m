Return-Path: <jeremy@goop.org>
Received: from claw.goop.org (claw.goop.org [74.207.240.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8A2DFDDF8A
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 01:58:17 +1000 (EST)
Message-ID: <4A20060C.2050701@goop.org>
Date: Fri, 29 May 2009 08:58:04 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Ian Campbell <ian.campbell@citrix.com>
Subject: Re: [PATCH 8/9] swiotlb: support HIGHMEM in swiotlb_bus_to_virt
References: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
	<1243586643-5554-9-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1243586643-5554-9-git-send-email-ian.campbell@citrix.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ian Campbell wrote:
> Rather than supplying a __weak hook which architectures which support
> highmem can overide simply provide a version of swiotlb_bus_to_virt
> which works with high memory. Make it conditional since it is a more
> expensive variant than the non-highmem version.
>
> Acutal function contents taken from the PowerPC swiotlb patchset by
> Becky Bruce.
>
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> Cc: Becky Bruce <beckyb@kernel.crashing.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Jeremy Fitzhardinge <jeremy@goop.org>
> Cc: linuxppc-dev@ozlabs.org
> ---
>  lib/swiotlb.c |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
>
> diff --git a/lib/swiotlb.c b/lib/swiotlb.c
> index e332342..c50a5ed 100644
> --- a/lib/swiotlb.c
> +++ b/lib/swiotlb.c
> @@ -130,10 +130,22 @@ static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
>  	return phys_to_dma(hwdev, virt_to_phys(address));
>  }
>  
> -void * __weak swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
> +#ifdef CONFIG_HIGHMEM
> +static void * swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
>   

I think it would be better to put the #ifdef within the function body so 
that there's no chance of prototype-drift.
> +{
> +	unsigned long pfn = PFN_DOWN(dma_to_phys(hwdev, addr));
> +	void *pageaddr = page_address(pfn_to_page(pfn));
> +
> +	if (pageaddr != NULL)
> +		return pageaddr + (addr % PAGE_SIZE);
>   
Is there an arch-independent test to see if a pfn is considered highmem 
or not (which returns a constant on non-highmem configurations)?  If so, 
then I think this could be common without having to go via a struct page.

    J
