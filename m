Message-ID: <392C42C9.28AF07D8@embeddededge.com>
Date: Wed, 24 May 2000 16:59:53 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Shuangjun Zhu <r44089@email.sps.mot.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA support for 860 -- lost interrupt
References: <006f01bfc53e$3eb0c680$69f001dc@sjzhu.sps.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Shuangjun Zhu wrote:
>
> 1. why "lost interrupt"? irq for IDE is 9, PCMCIA_INTERRUPT=13,
>    so, which hardware trigger IRQ 9?
> 2. why vpp=0.0, where can I change it, in ide_cs.c or m8xx_pcmcia.c?
>
> Note:
>
> I have changed arch/ppc/kernel/ppc8xx_pic.c, so that request_irq() looks
> like this:

See, this is why I changed the function name in the first place.
request_irq() assumes a PC-like interrupt structure, which doesn't work
on the MPC8xx internal interrupt controller.  You need to add an
indirect function call to the 'md' structure that will install the
IDE interrupt handler.  When you use the PCMCIA for ATA/IDE, you should
call a function that installs the PCMCIA interrupt vector.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
