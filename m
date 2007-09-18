Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 688B7DDE3F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 04:18:24 +1000 (EST)
Date: Tue, 18 Sep 2007 22:18:11 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [RFC] [PATCH] PowerPC: Add 64-bit phys addr support to 32-bit pci.
Message-ID: <20070918221811.57b92c18@localhost.localdomain>
In-Reply-To: <20070918160754.GA22698@ru.mvista.com>
References: <DF9456FB-459D-4800-B994-D9B198096069@kernel.crashing.org>
	<20070918160754.GA22698@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Valentine,

On Tue, 18 Sep 2007 20:07:54 +0400
Valentine Barshak wrote:

> Currently pci_32 doesn't support 64-bit physical addresses, while
> PowerPC440 platform has PCI space typically mapped above 4GB range.
> The patch adds 64-bit physical address support to 32-bit PCI code
> in order to bring-up PCI on 44x platform.
> 
The approach looks interesting, and resource_size_t<>ulong apparently makes sense,
but I would strongly disagree we need to add more nuts and bolts into ranges parse func:
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

[...]
>  void __init
>  pci_process_bridge_OF_ranges(struct pci_controller *hose,
>  			   struct device_node *dev, int primary)
>  {
>  	static unsigned int static_lc_ranges[256] __initdata;
>  	const unsigned int *dt_ranges;
> -	unsigned int *lc_ranges, *ranges, *prev, size;
> +	unsigned int *lc_ranges, *ranges, *prev;
>  	int rlen = 0, orig_rlen;
>  	int memno = 0;
>  	struct resource *res;
> +	u32 prev_pci_space, pci_space;
> +	u64 prev_pci_addr, pci_addr;
> +	u64 prev_size, size;
> +	phys_addr_t cpu_phys_addr;
> +	
>  	int np, na = of_n_addr_cells(dev);
>  	np = na + 5;
>  
> @@ -879,11 +891,18 @@
>  	prev = NULL;
>  	while ((rlen -= np * sizeof(unsigned int)) >= 0) {
>  		if (prev) {
> -			if (prev[0] == ranges[0] && prev[1] == ranges[1] &&
> -				(prev[2] + prev[na+4]) == ranges[2] &&
> -				(prev[na+2] + prev[na+4]) == ranges[na+2]) {
> -				prev[na+4] += ranges[na+4];
> +			prev_pci_space = prev[0];
> +			prev_pci_addr = pci_get_range64(&prev[1]);
> +			prev_size = pci_get_range64(&prev[na+3]);
> +			pci_space = ranges[0];
> +			pci_addr = pci_get_range64(&ranges[1]);
> +			if ((prev_pci_space == pci_space) && 
> +			    ((prev_pci_addr + prev_size) == pci_addr)) {
> +				size = pci_get_range64(&ranges[na+3]);
> +				prev_size += size;
>  				ranges[0] = 0;
> +				prev[na+3] = (u32)((prev_size >> 32) & 0xffffffff);
> +				prev[na+4] = (u32)(prev_size & 0xffffffff);
>  				ranges += np;
>  				continue;

I do think that ranges hacking (even on a copy) to cope with contiguous ranges is not a good deed. And nobody would object the upper looks horrible from the maintenance POV.
>  			}
> @@ -904,21 +923,22 @@
>  	rlen = orig_rlen;
>  	while (ranges && (rlen -= np * sizeof(unsigned int)) >= 0) {
>  		res = NULL;
> -		size = ranges[na+4];
> -		switch ((ranges[0] >> 24) & 0x3) {
> +		size = pci_get_range64(&ranges[na+3]);

This is not correct - it should depend on #ac of the parent node.
But I'll stop right here - there is no deep mutual difference between 32 & 64 bit so that to keep 2 similar implementations, none of which (esp 32bit) really comply the spec. It should work the same way, and, if there are differences, they should be handled
explicitly, and, of course, reconsidered if they make sense (like isa_io_base, absense of io_size in ppc32 and so on)

I am *not* telling here that my implementation is the only true way around. But we need to improve and make code cleaner rather then just extend existing error-prone approach.

-- 
Sincerely, Vitaly
