Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58CF3DDDE5
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jun 2009 10:46:32 +1000 (EST)
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27-
	"no_irq_chip" error
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
In-Reply-To: <4A1E6877.2060106@aimvalley.nl>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl>
Content-Type: text/plain
Date: Tue, 02 Jun 2009 10:46:21 +1000
Message-Id: <1243903581.591.18.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 
> #define PIT_IRQ 65

In addition, the interrupt should be provided by the device-tree of
course, in which case a single function will look it up for you -and-
do the appropriate mapping.

Cheers,
Ben.

>      virq = irq_create_mapping(NULL, PIT_IRQ);
>      set_irq_type(virq, IRQ_TYPE_LEVEL_LOW);
> 
>      if(request_irq(virq, (irq_handler_t)timerEvent, 0, "timer2", (void *)0)) {
>          printk(KERN_ERR "request_irq() returned error for irq=%d virq=%d\n", PIT_IRQ, virq);
>      }
> 
> All the above info comes from this mailing (and the linuxppc-embedd list) though.
> If you search these lists you'll find plenty of answers to similar questions.
> 
> ---
> N. van Bolhuis
> AimValley
> 
> 
> 
> 
> Daniel Ng wrote:
> > Hi,
> > 
> > I'm attempting to port our Ethos HDLC driver from 2.6.14 to 2.6.27, on
> > a MPC8272-based platform.
> > 
> > So far, the kernel crashes when the driver tries to open (see below).
> > 
> > It seems that the interrupt handler fails to register, with the
> > following condition in setup_irq() in manage.c:
> > 
> > desc->chip == &no_irq_chip
> > 
> > I notice that the only place where desc->chip is assigned to anything
> > else besides &no_irq_chip is in __set_irq_handler() in
> > kernel/irq/chip.c
> > 
> > In that file, __set_irq_handler() assigns desc->chip to
> > &dummy_irq_chip, but this seems to be done for a special ARM-specific
> > case, according to the commenting:
> > 
> > /*
> >  * Some ARM implementations install a handler for really dumb
> >  * interrupt hardware without setting an irq_chip. This worked
> >  * with the ARM no_irq_chip but the check in setup_irq would
> >  * prevent us to setup the interrupt at all. Switch it to
> >  * dummy_irq_chip for easy transition.
> >  */
> > 
> > Should I try to somehow call __set_irq_handler(), or should I be
> > looking elsewhere?
> > 
> > If I should be calling __set_irq_handler(), it seems the only relevant
> > function that calls this is cpm2_pic_host_map().
> > 
> > The only relevant functions which call cpm2_pic_host_map() are
> > irq_setup_virq() or irq_alloc_hosts() with the IRQ_HOST_MAP_LEGACY
> > parameter. IRQ_HOST_MAP_LEGACY seems to be irrelevant. Can someone
> > tell me what a virq is?
> > 
> > Cheers,
> > Daniel
> > 
> > 
> > 
> > Badness at c00224ec [verbose debug info unavailable]
> > NIP: c00224ec LR: c019b254 CTR: c01aa9f8
> > REGS: c1a49c70 TRAP: 0700   Not tainted  (2.6.27.19-800-OS-03050107)
> > MSR: 00021032 <ME,IR,DR>  CR: 22002022  XER: 00000000
> > TASK = c1bda400[306] 'pppd' THREAD: c1a48000
> > GPR00: 00000001 c1a49d20 c1bda400 00000000 c0318880 c19c4d80 c1b92211 00000000
> > GPR08: 00001032 c02cb240 00000000 00000000 22002022 fffffffe 01ff8000 00000000
> > GPR16: 10344020 00000000 00000002 10049ac0 c194f800 ffff8914 c18cd900 c18cd90c
> > GPR24: c1a49e48 00009032 c1a48000 c02b5fdc 00000002 c19c4d80 c1a48000 c1a48000
> > NIP [c00224ec] local_bh_enable+0x94/0xb4
> > LR [c019b254] dev_queue_xmit+0x108/0x580
> > Call Trace:
> > [c1a49d20] [c19c4d80] 0xc19c4d80 (unreliable)
> > [c1a49d30] [c019b254] dev_queue_xmit+0x108/0x580
> > [c1a49d50] [c016ac98] sppp_flush_xmit+0x20/0x44
> > [c1a49d60] [c016c0b4] sppp_open+0x80/0xac
> > [c1a49d80] [c016a104] ppp_open+0x70/0x98
> > --- Exception: bfd26bb0 at 0x8914
> >     LR = 0xc1a49e90
> > [c1a49da0] [c01699e0] hdlc_open+0x3c/0x104 (unreliable)
> > [c1a49dc0] [c016cdd4] ethos_wan_genhdlc_open+0xb0/0xef8
> > [c1a49df0] [c019c490] dev_open+0xbc/0x120
> > [c1a49e00] [c019bbc8] dev_change_flags+0x8c/0x1d0
> > [c1a49e20] [c01e1678] devinet_ioctl+0x700/0x7ac
> > [c1a49e90] [c01e2538] inet_ioctl+0xcc/0xf8
> > [c1a49ea0] [c018b584] sock_ioctl+0x60/0x268
> > [c1a49ec0] [c0084ab0] vfs_ioctl+0x3c/0xc4
> > [c1a49ee0] [c0084bb8] do_vfs_ioctl+0x80/0x454
> > [c1a49f10] [c0084fcc] sys_ioctl+0x40/0x88
> > [c1a49f40] [c000f928] ret_from_syscall+0x0/0x38
> > --- Exception: c01 at 0x480af50c
> >     LR = 0x480af5e4
> > Instruction dump:
> > 41a20008 482044e1 80010014 83e1000c 38210010 7c0803a6 4e800020 3d20c02d
> > 3929b240 800900dc 7c000034 5400d97e <0f000000> 2f800000 41beff90 38000001
> > hdlc2: Carrier detected
> > setup_irq()- desc->chip == &no_irq_chip
> > request_irq()- setup_irq() FAILED
> > ethos_wan_genhdlc_open(): request_irq() FAILED! ethos_wan->io_addr: 0xc5080000
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
