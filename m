Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7FB2FDE086
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 03:07:58 +1000 (EST)
Date: Mon, 11 Aug 2008 21:07:56 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: [PATCH] pata_of_platform: fix no irq handling
Message-ID: <20080811170756.GA29827@oksana.dev.rtsoft.ru>
References: <48A05152.7020508@harris.com>
	<20080811151913.GA14690@oksana.dev.rtsoft.ru>
	<48A0676E.5020308@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48A0676E.5020308@harris.com>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>, "Sparks,
	Sam" <SSparks@aclaratech.com>, linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 11, 2008 at 12:23:10PM -0400, Steven A. Falco wrote:
> Anton Vorontsov wrote:
> > When no irq specified, pata_of_platform fills irq_res with -1,
> > which is wrong to do for two reasons:
> >
> > 1. By definition, 'no irq' should be IRQ 0, not some negative integer;
> > 2. pata_platform checks for irq_res.start > 0, but since irq_res.start
> >    is unsigned type, the check will be true for `-1'.
> >
> > Reported-by: Steven A. Falco <sfalco@harris.com>
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> 
> Thanks!  Your fix is better - I didn't really like the -1 stuff.
> 
> I found this bug because I had to disable the ATA interrupt on my system
> in order to get a compact-flash card to work.  I am still trying to find
> out why the interrupt doesn't work for me.  Here is part of the console
> log with the interrupt enabled:
> 
>     Uniform Multi-Platform E-IDE driver
>     ide: Assuming 33MHz system bus speed for PIO modes; override with
>     idebus=xx
>     Driver 'sd' needs updating - please use bus_type methods
>     irq: irq_create_mapping(0xc0574900, 0x1b)
>     irq: -> using host @c0574900
>     irq: -> obtained virq 32
>     scsi0 : pata_platform
>     ata1: PATA max PIO4 mmio cmd 0x1c1000000 ctl 0x1c1000080 irq 32
>     irq 32: nobody cared (try booting with the "irqpoll" option)
>     Call Trace:
>     [cf83fcc0] [c0005a64] show_stack+0x44/0x1ac (unreliable)
>     [cf83fd00] [c00489e4] __report_bad_irq+0x34/0xb8
>     [cf83fd20] [c0048cf0] note_interrupt+0x288/0x2d0
>     [cf83fd50] [c0049a94] handle_level_irq+0xac/0x114
>     [cf83fd60] [c0003df0] do_IRQ+0xa4/0xc8
>     [cf83fd70] [c000d60c] ret_from_except+0x0/0x18
>     [cf83fe30] [00000020] 0x20
>     [cf83fe50] [c0003d48] do_softirq+0x54/0x58
>     [cf83fe60] [c00241c0] irq_exit+0x90/0x94
>     [cf83fe70] [c0003df4] do_IRQ+0xa8/0xc8
>     [cf83fe80] [c000d60c] ret_from_except+0x0/0x18
>     [cf83ff40] [c01b2cc0] ata_pio_task+0x48/0x104
>     [cf83ff60] [c00307a0] run_workqueue+0xb8/0x148
>     [cf83ff90] [c0030d54] worker_thread+0x70/0xd0
>     [cf83ffd0] [c0034788] kthread+0x48/0x84
>     [cf83fff0] [c000cd6c] kernel_thread+0x44/0x60
>     handlers:
>     [<c01b2d7c>] (ata_sff_interrupt+0x0/0x234)
>     Disabling IRQ #32
> 
> 
> So it looks like the ATA handler was attached - not sure yet why I got
> the "nobody cared" message. 

Nobody cared means that ata_sff_interrupt handler didn't notice
any IDE events, and returned zero value. This could mean that

1. IDE status read does not work. (But am I understand correctly
   that IDE works well if IRQ is unspecified? Then this is hardly
   an issue.)
2. IDE interrupt comes when it should not. I'd recommend to use
   oscilloscope to find out what is happening there, that is, if
   the drive actually deasserts its irq line after status read.
   If so, than this could be a PIC problem.

What is the platform on which you're observing the issue, btw?

Just asking because recently Sam Sparks reported that he is observing
similar issue on MPC8349E-mITX-based boards, which I can't not
reproduce on my board though:

http://www.nabble.com/Compact-Flash-on-8349mITX-td18754330.html
http://www.nabble.com/Compact-flash-on-mpc8349eITX-td18777724.html

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
