Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7EBAB7BE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 11:22:57 +1100 (EST)
Subject: Re: help with unhandled IRQ error with mpt2sas driver and powerpc
	460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <4AE72D83.7000404@elkhashab.com>
References: <4AE72D83.7000404@elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Oct 2009 11:22:38 +1100
Message-ID: <1256689358.11607.139.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-27 at 12:27 -0500, Ayman El-Khashab wrote:
> 
> The first problem I noticed is that the physical address is read into a 
> 32 bit variable, but the 460ex has a 36 bit bus so the ioremap would 
> always fail.  I've change the defn of chip_phys in mpt2sas_base.h to u64 
> and that cleared up that issue.

That looks indeed like a common driver bug. Please make sure you submit
the fix upstream. The "right" type to use is resource_size_t in fact.

>    As soon as the unmask_interrupts 
> method is called (or not long after), 

What exactly is that "method" ? IE. A driver function that enables
emission of interrupts on the device ?

> I get an interrupt -- presumably 
> from the sas controller.  If I comment out the unmask, the interrupt 
> never occurs.  If I unmask them, I get the interrupt.  I've traced the 
> code through the interrupt handler all the way to ~ line 757.

Unmask at what level ? The linux level (enable_irq() -> UIC unmask) or
the card level ?

>  rpf = &ioc->reply_post_free[ioc->reply_post_host_index];
> 
> I've verified that at the end of this, IRQ_NONE is returned.  At this 
> point the kernel prints the following -- the last statements lead me to 
> think that the sas controller expected something but never got it.  I am 
> unsure how to proceed at this point.  I am using a denx kernel head 
> pulled from git today since there were some changes to thsi driver for 
> endian issues.

Well, if the interrupt is indeed coming from the card and the driver's
interrupt handler can't figure it out, then you are facing a bug in the
driver. I would recommend you work with whoever is maintaining that
driver to help sort it out.

Cheers,
Ben.

> irq 18: nobody cared (try booting with the "irqpoll" option)
> Call Trace:
> [c0367df0] [c0005eac] show_stack+0x44/0x16c (unreliable)
> [c0367e30] [c004eedc] __report_bad_irq+0x34/0xb8
> [c0367e50] [c004f118] note_interrupt+0x1b8/0x224
> [c0367e80] [c004ff50] handle_level_irq+0xa0/0x11c
> [c0367e90] [c0018ba4] uic_irq_cascade+0xf8/0x12c
> [c0367eb0] [c00041d0] do_IRQ+0x98/0xb4
> [c0367ed0] [c000df40] ret_from_except+0x0/0x18
> [c0367f90] [c0006ed8] cpu_idle+0x50/0xd8
> [c0367fb0] [c000197c] rest_init+0x5c/0x70
> [c0367fc0] [c0320848] start_kernel+0x224/0x2a0
> [c0367ff0] [c0000200] skpinv+0x190/0x1cc
> handlers:
> [<c01aba98>] (_base_interrupt+0x0/0x8f8)
> Disabling IRQ #18
> mpt2sas0: _base_event_notification: timeout
> mf:
>         07000000 00000000 00000000 00000000 00000000 0f2f3fff fffffffc 
> ffffffff
>         ffffffff 00000000 00000000
> mpt2sas0: sending diag reset !!
> mpt2sas0: diag reset: SUCCESS
> mpt2sas0: failure at 
> drivers/scsi/mpt2sas/mpt2sas_scsih.c:5989/_scsih_probe()!
> 
> Thanks
> Ayman
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 
