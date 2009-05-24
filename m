Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FF77DE070
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 20:23:59 +1000 (EST)
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40905232347t57187d0fv51c714bfe6dd40d9@mail.gmail.com>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<fa686aa40905232347t57187d0fv51c714bfe6dd40d9@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 24 May 2009 20:21:27 +1000
Message-Id: <1243160487.22770.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Albert Herranz <albert_herranz@yahoo.es>,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-05-24 at 00:47 -0600, Grant Likely wrote:
> Ilya, any comment on this?  Can a fix be made quickly, or should this
> patch be reverted until a more robust version can be crafted?
> 
> g.

Nasty...

We need to see if we can get the vmalloc allocator safe for GFP_ATOMIC
context, might be doable.

As for free, unfortunately, even the old allocator won't help with SMP,
since that needs to do IPIs for cross TLB invalidates.

Maybe we should enqueue free blocks and do the actual freeing from a
workqueue or something similar.

Cheers,
Ben.

> On Thu, May 21, 2009 at 10:50 AM, Albert Herranz
> <albert_herranz@yahoo.es> wrote:
> >
> > Hello list,
> >
> > Commit 33f00dcedb0e22cdb156a23632814fc580fcfcf8 seems to have broken DMA coherent allocations for CONFIG_NOT_COHERENT_CACHE platforms.
> >
> > The problems seem to be that the new __dma_alloc_coherent() and __dma_free_coherent() implementations:
> >
> > - don't respect anymore the passed gfp flags (__dma_alloc_coherent() unconditionally uses GFP_KERNEL within the function irrespective of the caller flags)
> > - can't be used in interrupt context as they use get_vm_area_caller()/vfree() which end up triggering BUG_ON(in_interrupt())
> >
> > One victim happens to be the USB core subsystem which sometimes frees dma coherent memory in interrupt context for drivers flagged HCD_LOCAL_MEM.
> >
> > This has been experienced while writing a new EHCI driver for the Nintendo Wii platform.
> >
> > usb 1-1: new high speed USB device using ehci-mipc and address 2
> > ------------[ cut here ]------------
> > kernel BUG at mm/vmalloc.c:1328!
> > Oops: Exception in kernel mode, sig: 5 [#1]
> > PREEMPT wii
> > Modules linked in:
> > NIP: c008ea20 LR: c0015890 CTR: c00111d4
> > REGS: d2c65b10 TRAP: 0700   Not tainted  (2.6.30-rc2-isobel-wii-00092-gcba94db-dirty)
> > MSR: 00021032 <ME,CE,IR,DR>  CR: 42482028  XER: 00000000
> > TASK = d2c600f0[28] 'kmmcd' THREAD: d2c64000
> > GPR00: 00010000 d2c65bc0 d2c600f0 d4030000 d4030000 d4030000 12da1000 00000001
> > GPR08: 00000000 d2c64000 00000020 00000000 22482022 94fdfb98 6e1979bc c6bbdbdd
> > GPR16: 00000020 00200200 00100100 d4020060 00000001 d401c0ec 00000001 d401c0ec
> > GPR24: d2d9a6c0 00000000 00000000 d2f69de0 d2d9a600 d2f69e30 d2f69e2c d2da08e0
> > NIP [c008ea20] vfree+0xc/0x18
> > LR [c0015890] __dma_free_coherent+0x14/0x24
> > Call Trace:
> > [d2c65bc0] [c0017af8] __mipc_recv_req+0x160/0x178 (unreliable)
> > [d2c65bd0] [c00111ec] dma_direct_free_coherent+0x18/0x28
> > [d2c65be0] [c01cfca4] hcd_free_coherent+0x7c/0x12c
> > [d2c65c10] [c01d00b8] unmap_urb_for_dma+0x150/0x1cc
> > [d2c65c20] [c01d0174] usb_hcd_giveback_urb+0x40/0xe4
> > [d2c65c30] [c01df474] ehci_urb_done+0xf0/0x114
> > [d2c65c50] [c01e3870] qh_completions+0x41c/0x4dc
> > [d2c65ca0] [c01e44e0] scan_async+0x9c/0x1a0
> > [d2c65cc0] [c01e49ec] ehci_work+0x58/0xc4
> > [d2c65cd0] [c01e5424] ehci_irq+0x22c/0x230
> > [d2c65d00] [c01cfa88] usb_hcd_irq+0x50/0xa8
> > [d2c65d20] [c00597d8] handle_IRQ_event+0xdc/0x250
> > [d2c65d60] [c005ba20] handle_level_irq+0x9c/0x138
> > [d2c65d80] [c001cbc8] hollywood_pic_irq_cascade+0x7c/0xf8
> > [d2c65da0] [c00064b4] do_IRQ+0x9c/0xc4
> > [d2c65dc0] [c0011fb8] ret_from_except+0x0/0x14
> >
> > Any comments on how to address this issue (other than reverting the above mentioned commit, which fixes it) are welcome.
> >
> > Thanks,
> > Albert
> >
> >
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> 
> 
> 
