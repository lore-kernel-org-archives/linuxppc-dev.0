Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 69F44679F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 22:43:56 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 547E829ECF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 14:42:14 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05139-03 for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 14:42:13 +0200 (CEST)
Received: from archvile (unknown [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 6111329ECA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 14:42:13 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: kernel 2.6.15: cpm_uart driver broken?
Date: Tue, 18 Apr 2006 14:46:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604181446.08673.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

Situation 1: MPC852T with SMC1 as uart/console, and SCC3/SCC4 as additional 
uarts. SMC1 works fine, but SCC3/4 don't. On transmission attempt, both UARTS 
transmit a byte 0x00 instead of what was intended to be transmitted.\

Situation 2: The same as above, but console on either SCC3 or SCC4. The uart 
being initialized as console works ok, the other two don't.

I'm pretty sure the following is wrong, but I can't seem to fix it either. 
This seems to apply for both PQ and PQ2 type uarts:
from drivers/serial/cpm_uart/cpm_uart_cpm1.c (line 190):

....
	if (is_con) {
		/* was hostalloc but changed cause it blows away the */
		/* large tlb mapping when pinning the kernel area    */
		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
		dma_addr = 0;
	} else
		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
					      GFP_KERNEL);

....
	pinfo->dp_addr = dp_offset;
	pinfo->mem_addr = mem_addr;
	pinfo->dma_addr = dma_addr;

	pinfo->rx_buf = mem_addr;
....

AFAICS pinfo->rx_buf is the pointer to a buffer as seen from the CPM's point 
of view, so it should hold a physical adress, not a virtual address. It seems 
to me that it should be more like this (lines marked with ** are changed):

....
	if (is_con) {
		/* was hostalloc but changed cause it blows away the */
		/* large tlb mapping when pinning the kernel area    */
		mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
**		dma_addr = mem_addr;
	} else
		mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
					      GFP_KERNEL);

....
	pinfo->dp_addr = dp_offset;
	pinfo->mem_addr = mem_addr;
	pinfo->dma_addr = dma_addr;

**	pinfo->rx_buf = dma_addr;
....

This does not work either, but I suspect this is a different problem, because 
if I change dma_alloc_coherent() for something using kmalloc() and then 
dma_addr=virt_to_phys(mem_addr), uarts begin to work, but trasmit mixed old 
and new data from the buffers due to the cache getting in the way. At least 
reception seems to work ok then. 
So, why doesn't dma_alloc_coherent() work the way one would expect?
Obviously, changing "if (is_con)" into "if (1)" all three uarts work 
correctly, but I guess we want to save on DP_RAM usage if ever possible.

What else is wrong here?

Greetings,

-- 
David Jander
