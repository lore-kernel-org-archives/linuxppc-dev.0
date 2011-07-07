Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A082B6F6F
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2011 08:58:26 +1000 (EST)
Subject: Re: Analysing a kernel panic
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
In-Reply-To: <201107051619.50548.dargaud@lpsc.in2p3.fr>
References: <201107051619.50548.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jul 2011 08:58:13 +1000
Message-ID: <1310079493.14501.313.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-05 at 16:19 +0200, Guillaume Dargaud wrote:
> Hello all,
> one of my drivers is causing a kernel panic and I _think_ it happens in the 1st call to the interrupt routine.
> What kind of information can I extract from the following ?
> Is it like a core dump that I can load with the executable in the debugger to know exactly what happened (I doubt it) ?


> Kernel stack overflow in process c6ce80a0, r1=c778c070

That's bad...

> NIP: c000d270 LR: c000f3c8 CTR: c0017fd0
> REGS: c778bfc0 TRAP: 0501   Tainted: G      D     (2.6.34)
> MSR: 00029030 <EE,ME,CE,IR,DR>  CR: 24000048  XER: 00000000
> TASK = c6ce80a0[241] 'SoftNoy' THREAD: c778c000
> GPR00: 00029030 c778c070 c6ce80a0 c778c090 08000000 ffff32d8 00000001 00000001
> GPR08: ffff32da 00000000 00021032 c000d110 06ce82a8
> NIP [c000d270] program_check_exception+0x160/0x228
> LR [c000f3c8] ret_from_except_full+0x0/0x4c
> Call Trace:
> Instruction dump:
> 38090004 901f0080 480000d8 3ca00003 7fe4fb78 80df0080 60a50001 38600005
> 480000a8 7c0000a6 60008000 7c000124 <77c00c04> 41a20068 4bffef89 2f83fff2
> Kernel panic - not syncing: kernel stack overflow
> Call Trace:
> Rebooting in 180 seconds..
> 
> My driver is xad.ko, though /dev/xps-acqui-data. The user program is SoftNoy.
> The code for the ISR (note that this code works fine on the same driver for a slightly different piece of custom 
> hardware):
> 
> static irqreturn_t XadIsr(int irq, void *dev_id) {
> 	Xad.control_reg->fin_in = 0;		
> 	Xad.interrupt_reg->ISR  = 1;		
> 	Xad.interrupt_IPIF_reg->ISR = 4;
> 
> 	Xad.control_reg->flux_address[0] = BUFFER_PHY_BASE + BUF_SZ*(++Xad.Icnt % BUF_NB); 
> 	Xad.control_reg->flux_address[1] = Xad.control_reg->flux_address[0] + BUF_SZ/2;
> 
> 	if (Xad.Icnt<Xad.Rcnt+BUF_NB) 
> 		Xad.control_reg->flux_start=255;	// Arm the next interrupt
> 	else {
> 		// There aren't any buffers available for the next read. We'll do the start in the read routine
> 		Xad.Suspended=1;
> 		Xad.OverflowsSinceLastRead++;
> 		Xad.Overflow++;
> 		DBG_ADD_CHAR('*');
> 		if (Verbose) printk(KERN_WARNING SD "%dth buffer overflow: %d-%d=%d>=%d\n" FL, 
> 			Xad.Overflow, Xad.Icnt, Xad.Rcnt, Xad.Icnt-Xad.Rcnt, BUF_NB);
> 	}
> 
> 	wake_up_interruptible(&Xad.wait);
> 	return IRQ_HANDLED;
> }
> 
What is "Xad." ? (btw, coding style FAIL !)

Are you trying to write to HW registers using a structure like that
without using the appropriate MMIO register accessors ?

In that case, your accesses may happen our of order since you don't have
memory barriers (among other potential problems).

The crash looks like you aren't properly clearing the interrupt
condition on the HW, it remains asserted, tho it shouldn't overflow like
that, something seems wrong with your PIC.

What HW is this ? What PIC ? It looks like the interrupt source isn't
masked on the PIC itself while it's being handled or something...

Cheers,
Ben.
