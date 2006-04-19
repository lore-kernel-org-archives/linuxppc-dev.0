Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C4623679EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 20:21:00 +1000 (EST)
Date: Wed, 19 Apr 2006 14:21:05 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: kernel 2.6.15: cpm_uart driver broken?
Message-ID: <20060419142105.42cc43fd@vitb.ru.mvista.com>
In-Reply-To: <200604191128.50138.david.jander@protonic.nl>
References: <4D8794260B62C940BBA7150CC5EB3BD432D3A5@bosmail.BOS.int.mrv.com>
	<200604191128.50138.david.jander@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Kenneth Poole <kpoole@mrv.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 19 Apr 2006 11:28:49 +0200
David Jander <david.jander@protonic.nl> wrote:

> 
> Hi Kenneth,
> 
> On Tuesday 18 April 2006 21:19, Kenneth Poole wrote:
> > Regarding DMA allocation for CPM uarts, we had a similar issue with our
> > MPC857T and MPC885 boards. I think the real problem is that
> > bus_to_virt() and virt_to_bus() don't work on 8xx platforms for
> > addresses allocated using dma_alloc_coherent(). We had a previous
> > discussion Pantelis Antoniou and he agreed that the use of bus_to_virt()
> > and virt_to_bus() should be deprecated. This is also recommended in the
> > whitepaper series that discussed porting device drivers from 2.4 to 2.6.
> 
> You are right! I hadn't noticed the (implicit) use of virt_to_bus() in 
> cpm_uart_core.c. In the case that "((unsigned long)addr >= CPM_ADDR)", the 
> address isn't translated, that's why the uart keeps sending lots of 0xff's 
> instead of real data: There is empty flash at that adress (after 0xff100000)! 
> This also explains why the system hangs when I set CONFIG_CONSISTENT_START to 
> 0xfd100000, because then the CPM will access unadressed space.
> 
> Vitaly: Is it true that your ADS boards both have 
> IMMAP_ADDR < CONFIG_CONSISTENT_START ?
> That would explain why those do work.
> On the PQ2's dma_alloc_coherent(), behaves differently, so they might also 
> work.
> 
Right. 

> In fact, bus_to_virt(), which is also used, does nothing more than adding 
> KERNELBASE to the address, so a!=bus_to_virt(virt_to_bus(a)) if 'a' is 
> obtained by anything other than kmalloc(). So if 'a' is obtained from 
> dma_alloc_coherent(), will bus_to_virt(virt_to_bus(a)) at least yield a 
> correctly mapped virtual address?
> I am asking, because line 263 of cpm_uart_core.c does exactly this, and it 
> smells ;-)
> 

Well I was aware about no-good there, but since it works fine with my HW, and no other complaints, there were no reason to overhaul.

> > What we did was use dma_alloc_coherent() in cpm_uart_cpm1.c, saving
> > dma_addr in the pinfo structure. The in cpm_uart_core.c, we use dma_addr
> > as the base address for the cbd_bufaddr values in each of the
> > descriptors. The software, when accessing the DMA buffers, uses mem_addr
> > as the base, applying the same offset computed previously for the dma
> > addresses. This technique is used in other drivers all over 2.6.
> 
> Sounds like the correct thing to do, but do you (by any chance) have a patch 
> for this change, to share?
> 

If there is any code to reference, I'd appreciate it (and merge to the driver). 



-- 
Sincerely, 
Vitaly
