Message-ID: <003201bfc5e4$95f2dcc0$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Magnus Damm" <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "Dan Malek" <dan@netx4.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA support for 860 -- lost interrupt
Date: Thu, 25 May 2000 08:59:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Damm wrote:
>
>
>Shuangjun Zhu wrote:
>>
>1. what board are you trying to use pcmcia with?


I'm using a MPC823 FADS board and PCMCIA for ATA/IDE,

>2. check and see that m8xx_pcmcia gets your MHz or Hz value correct.
>   The MHz/Hz value is used by my driver to calculate the number of
>   waitstates necessary for all pcmcia accesses. So, if that is bad
>   much stuff will get wierd.


I have set the M8XX_BUSFREQ as following in m8xx_pcmcia.c,
BTW, my MPC823 runs' frequency is 48MHZ, which pcmcia uses the SLOT_B.

#ifdef CONFIG_BD_IS_MHZ
#define M8XX_BUSFREQ (48 * 1000000)
#else
#define M8XX_BUSFREQ (48)
#endif


>> 1. why "lost interrupt"? irq for IDE is 9, PCMCIA_INTERRUPT=13,
>>    so, which hardware trigger IRQ 9?
>
>Well, you have to figure out that one for yourself.
>I have no idea. Maybe the MHz/Hz stuff above could help you.
>Check proc/interrupts...
>
>The m8xx_pcmcia driver handles 1 (one) interrupt.
>That interrupt is the status changed interrupt and it tells
>us if someone has inserted/removed a card and some other stuff.
>
>Then - the pcmcia package will figure out what other interrupt
>the device driver for the card you've inserted (ide, serial, etc)
>will use. And then that (ide) code will request that irq and use
>is as if it was any other interrupt. That is the second interrupt.


>From the code ide_cs.c in pcmcia package, the m8xx_pcmcia interrupt
handler will call the ide_event() in ide_cs.c, this function does
nothing with ide interrupt handler in the kernel.

Here is Dan's ideas
>See, this is why I changed the function name in the first place.
>request_irq() assumes a PC-like interrupt structure, which doesn't work
>on the MPC8xx internal interrupt controller.  You need to add an
>indirect function call to the 'md' structure that will install the
>IDE interrupt handler.  When you use the PCMCIA for ATA/IDE, you should
>call a function that installs the PCMCIA interrupt vector.

In drivers/block/ide-probe.c,
init_irq() function has installed the IDE interrupt handler of IRQ 9 as
ide_intr()
In m8xx_pcmcia.c from the pcmcia package, Damm has installed the PCMCIA
interrupt
IRQ 13 as m8xx_interrupt(), so problem is:
without 8259 controller in FADS board, how the m8xx_interrupt() route the
interrupt
event to the ide_intr(). No hardware triger the IRQ 9, no call ide_intr(),
so the
kernel think "lost interrupt", I guess.


BRs,
Shuangjun


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
