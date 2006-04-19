Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 30C3F679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 19:26:35 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Date: Wed, 19 Apr 2006 11:28:49 +0200
References: <4D8794260B62C940BBA7150CC5EB3BD432D3A5@bosmail.BOS.int.mrv.com>
In-Reply-To: <4D8794260B62C940BBA7150CC5EB3BD432D3A5@bosmail.BOS.int.mrv.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200604191128.50138.david.jander@protonic.nl>
Cc: Kenneth Poole <kpoole@mrv.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Kenneth,

On Tuesday 18 April 2006 21:19, Kenneth Poole wrote:
> Regarding DMA allocation for CPM uarts, we had a similar issue with our
> MPC857T and MPC885 boards. I think the real problem is that
> bus_to_virt() and virt_to_bus() don't work on 8xx platforms for
> addresses allocated using dma_alloc_coherent(). We had a previous
> discussion Pantelis Antoniou and he agreed that the use of bus_to_virt()
> and virt_to_bus() should be deprecated. This is also recommended in the
> whitepaper series that discussed porting device drivers from 2.4 to 2.6.

You are right! I hadn't noticed the (implicit) use of virt_to_bus() in 
cpm_uart_core.c. In the case that "((unsigned long)addr >= CPM_ADDR)", the 
address isn't translated, that's why the uart keeps sending lots of 0xff's 
instead of real data: There is empty flash at that adress (after 0xff100000)! 
This also explains why the system hangs when I set CONFIG_CONSISTENT_START to 
0xfd100000, because then the CPM will access unadressed space.

Vitaly: Is it true that your ADS boards both have 
IMMAP_ADDR < CONFIG_CONSISTENT_START ?
That would explain why those do work.
On the PQ2's dma_alloc_coherent(), behaves differently, so they might also 
work.

In fact, bus_to_virt(), which is also used, does nothing more than adding 
KERNELBASE to the address, so a!=bus_to_virt(virt_to_bus(a)) if 'a' is 
obtained by anything other than kmalloc(). So if 'a' is obtained from 
dma_alloc_coherent(), will bus_to_virt(virt_to_bus(a)) at least yield a 
correctly mapped virtual address?
I am asking, because line 263 of cpm_uart_core.c does exactly this, and it 
smells ;-)

> What we did was use dma_alloc_coherent() in cpm_uart_cpm1.c, saving
> dma_addr in the pinfo structure. The in cpm_uart_core.c, we use dma_addr
> as the base address for the cbd_bufaddr values in each of the
> descriptors. The software, when accessing the DMA buffers, uses mem_addr
> as the base, applying the same offset computed previously for the dma
> addresses. This technique is used in other drivers all over 2.6.

Sounds like the correct thing to do, but do you (by any chance) have a patch 
for this change, to share?

Thanks a lot to everyone for their comments and help.

Greetings,

-- 
David Jander
