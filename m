Message-ID: <004101bfc6be$a5c0dff0$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Magnus Damm" <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "Dan Malek" <dan@netx4.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA support for 860 -- lost interrupt
Date: Fri, 26 May 2000 11:01:09 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Magnus

I found a temp hacker to fix it.
Socket Driver and ATA/IDE driver share the same IRQ 13.
So I must modify the arch/ppc/kernel/irq.c: request_8xxirq(),
it only allow pci-ide share the irq.
It will not complain "lost interrupt".

BRs,
Shuangjun



>>From the code ide_cs.c in pcmcia package, the m8xx_pcmcia interrupt
>>handler will call the ide_event() in ide_cs.c, this function does
>>nothing with ide interrupt handler in the kernel.
>>
>>Here is Dan's ideas
>>>See, this is why I changed the function name in the first place.
>>>request_irq() assumes a PC-like interrupt structure, which doesn't work
>>>on the MPC8xx internal interrupt controller.  You need to add an
>>>indirect function call to the 'md' structure that will install the
>>>IDE interrupt handler.  When you use the PCMCIA for ATA/IDE, you should
>>>call a function that installs the PCMCIA interrupt vector.
>>
>>In drivers/block/ide-probe.c,
>>init_irq() function has installed the IDE interrupt handler of IRQ 9 as
>>ide_intr()
>>In m8xx_pcmcia.c from the pcmcia package, Damm has installed the PCMCIA
>>interrupt
>>IRQ 13 as m8xx_interrupt(), so problem is:
>>without 8259 controller in FADS board, how the m8xx_interrupt() route the
>>interrupt
>>event to the ide_intr(). No hardware triger the IRQ 9, no call ide_intr(),
>>so the
>>kernel think "lost interrupt", I guess.
>
>
>Here is the result:
>bash# cat /proc/inter*
>           CPU0
>  5:       2394   8xx SIU       cpm
>  9:          0   8xx SIU       ide0
> 13:          9   8xx SIU       m8xx_pcmcia
> 15:          0   8xx SIU       tbint
>BAD:          0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
