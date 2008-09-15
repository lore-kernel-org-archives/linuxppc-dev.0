Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8E01DE04C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 08:44:30 +1000 (EST)
Message-Id: <D5A2FA91-E013-41EF-BCB5-E2645C20A918@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adak5ddf8co.fsf@cisco.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Avoid integer overflow in page_is_ram()
Date: Mon, 15 Sep 2008 17:44:05 -0500
References: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
	<adak5ddf8co.fsf@cisco.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 15, 2008, at 3:43 PM, Roland Dreier wrote:

> Commit 8b150478 ("ppc: make phys_mem_access_prot() work with pfns
> instead of addresses") fixed page_is_ram() in arch/ppc to avoid  
> overflow
> for addresses above 4G on 32-bit kernels.  However arch/powerpc's
> page_is_ram() is missing the same fix -- it computes a physical  
> address
> by doing pfn << PAGE_SHIFT, which overflows if pfn corresponds to a  
> page
> above 4G.
>
> In particular this causes pages above 4G to be mapped with the wrong
> caching attribute; for example many ppc440-based SoCs have PCI space
> above 4G, and mmap()ing MMIO space may end up with a mapping that has
> caching enabled.
>
> Fix this by working with the pfn and avoiding the conversion to
> physical address that causes the overflow.  This patch compares the
> pfn to max_pfn, which is a semantic change from the old code -- that
> code compared the physical address to high_memory, which corresponds
> to max_low_pfn.  However, I think that was is another bug, since
> highmem pages are still RAM.
>
> Reported-by: vb <vb@vsbe.com>
> Signed-off-by: Roland Dreier <rolandd@cisco.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> ---
> Paul, didn't see this in your list... please add for 2.6.28.
>
> arch/powerpc/mm/mem.c |    5 ++---
> 1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 1c93c25..98d7bf9 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -75,11 +75,10 @@ static inline pte_t *virt_to_kpte(unsigned long  
> vaddr)
>
> int page_is_ram(unsigned long pfn)
> {
> -	unsigned long paddr = (pfn << PAGE_SHIFT);
> -
> #ifndef CONFIG_PPC64	/* XXX for now */
> -	return paddr < __pa(high_memory);
> +	return pfn < max_pfn;
> #else
> +	unsigned long paddr = (pfn << PAGE_SHIFT);

seems like this could be a phys_addr_t

>
> 	int i;
> 	for (i=0; i < lmb.memory.cnt; i++) {
> 		unsigned long base;

- k
