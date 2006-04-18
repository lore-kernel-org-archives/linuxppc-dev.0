Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 86E0167A5A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 23:22:38 +1000 (EST)
Date: Tue, 18 Apr 2006 17:22:44 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Message-ID: <20060418172244.25eefcd3@vitb.ru.mvista.com>
In-Reply-To: <200604181446.08673.david.jander@protonic.nl>
References: <200604181446.08673.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 18 Apr 2006 14:46:08 +0200
David Jander <david.jander@protonic.nl> wrote:

> 
> Hi all,
> 
> Situation 1: MPC852T with SMC1 as uart/console, and SCC3/SCC4 as additional 
> uarts. SMC1 works fine, but SCC3/4 don't. On transmission attempt, both UARTS 
> transmit a byte 0x00 instead of what was intended to be transmitted.\
> 
> Situation 2: The same as above, but console on either SCC3 or SCC4. The uart 
> being initialized as console works ok, the other two don't.
> 
Well, existing code works just fine on 885ads and 866ads, that use SMC1 and SMC2 as UARTs.

> I'm pretty sure the following is wrong, but I can't seem to fix it either. 
> This seems to apply for both PQ and PQ2 type uarts:
> from drivers/serial/cpm_uart/cpm_uart_cpm1.c (line 190):
That's wrong - cpm_uart_cpm1.c applies to PQ only... 

> 
> ....
> 	if (is_con) {
> 		/* was hostalloc but changed cause it blows away the */
> 		/* large tlb mapping when pinning the kernel area    */
> 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
> 		dma_addr = 0;
> 	} else
> 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
> 					      GFP_KERNEL);
> 
> ....
> 	pinfo->dp_addr = dp_offset;
> 	pinfo->mem_addr = mem_addr;
> 	pinfo->dma_addr = dma_addr;
> 
> 	pinfo->rx_buf = mem_addr;
> ....
> 
> AFAICS pinfo->rx_buf is the pointer to a buffer as seen from the CPM's point 
> of view, so it should hold a physical adress, not a virtual address. It seems 
> to me that it should be more like this (lines marked with ** are changed):
> 

> ....
> 	if (is_con) {
> 		/* was hostalloc but changed cause it blows away the */
> 		/* large tlb mapping when pinning the kernel area    */
> 		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
> **		dma_addr = mem_addr;
> 	} else
> 		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
> 					      GFP_KERNEL);
> 
> ....
> 	pinfo->dp_addr = dp_offset;
> 	pinfo->mem_addr = mem_addr;
> 	pinfo->dma_addr = dma_addr;
> 
> **	pinfo->rx_buf = dma_addr;
> ....
> 
> This does not work either, but I suspect this is a different problem, because 
> if I change dma_alloc_coherent() for something using kmalloc() and then 
> dma_addr=virt_to_phys(mem_addr), uarts begin to work, but trasmit mixed old 
> and new data from the buffers due to the cache getting in the way. At least 
> reception seems to work ok then. 
> So, why doesn't dma_alloc_coherent() work the way one would expect?
> Obviously, changing "if (is_con)" into "if (1)" all three uarts work 
> correctly, but I guess we want to save on DP_RAM usage if ever possible.
> 
> What else is wrong here?
> 
Well, since it works on other boards, and kmalloc stuff seems to sorta work as well, then I guess reason is screwed DMA thing for your board. Check/alter CONFIG_CONSISTENT_* things and see if it will help.

And, try to just replace dma_alloc_.. with kmalloc (not changing rx_buf etc.) and reproduce the same behavior you had. BTW, rx_buf and tx_buf are never used actually in the code, hereby there is no difference what values they contain...


-- 
Sincerely, 
Vitaly
