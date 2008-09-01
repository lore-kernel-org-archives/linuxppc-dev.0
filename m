Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 525FCDDF07
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Sep 2008 10:38:16 +1000 (EST)
Subject: Re: [PATCH] powerpc: Avoid integer overflow in page_is_ram()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <adar687i33c.fsf_-_@cisco.com>
References: <f608b67d0808261926p67e27770mb7c64cc14015b9ab@mail.gmail.com>
	<ada3akri1i5.fsf@cisco.com> <200808271013.18659.arnd@arndb.de>
	<f608b67d0808271613g2092b287o44c3418fb7d33499@mail.gmail.com>
	<adawsi2j8wt.fsf@cisco.com> <adak5e1kf2u.fsf@cisco.com>
	<adar687i33c.fsf_-_@cisco.com>
Content-Type: text/plain
Date: Mon, 01 Sep 2008 10:27:26 +1000
Message-Id: <1220228846.13162.403.camel@pasglop>
Mime-Version: 1.0
Cc: vb <vb@vsbe.com>, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-29 at 20:39 -0700, Roland Dreier wrote:
> Commit 8b150478 ("ppc: make phys_mem_access_prot() work with pfns
> instead of addresses") fixed page_is_ram() in arch/ppc to avoid overflow
> for addresses above 4G on 32-bit kernels.  However arch/powerpc's
> page_is_ram() is missing the same fix -- it computes a physical address
> by doing pfn << PAGE_SHIFT, which overflows if pfn corresponds to a page
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

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> This is a fix but the bug is pretty long-standing -- I think this is
> 2.6.28 material.
> 
>  arch/powerpc/mm/mem.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 1c93c25..98d7bf9 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -75,11 +75,10 @@ static inline pte_t *virt_to_kpte(unsigned long vaddr)
>  
>  int page_is_ram(unsigned long pfn)
>  {
> -	unsigned long paddr = (pfn << PAGE_SHIFT);
> -
>  #ifndef CONFIG_PPC64	/* XXX for now */
> -	return paddr < __pa(high_memory);
> +	return pfn < max_pfn;
>  #else
> +	unsigned long paddr = (pfn << PAGE_SHIFT);
>  	int i;
>  	for (i=0; i < lmb.memory.cnt; i++) {
>  		unsigned long base;
