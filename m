Date: Mon, 3 Dec 01 14:37:56 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0112032237.AA11733@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: RFC: i8259.c & PCI int ack
Cc: davidm@amberdata.demon.co.uk, hollis@austin.ibm.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hollis@austin.ibm.com wrote:

> - i8259_init now takes a 'long intack_addr', which on PReP is 0xbffffff0.
>   For platforms that only poll, this argument is irrelevant and can be 0x0
>
> [...]
>
> If this is the right idea, I intend to change all 8259 users:
> - ppc_md.get_irq = i8259_irq       ->   ppc_md.get_irq = i8259_poll
> - i8259_init()                     ->   i8259_init(0x0)
> - i8259_irq(smp_processor_id())    ->   i8259_poll()

With this patch on platforms that only poll, your code will still do an ioremap
on i8259_init's argument, even if it's 0. I'm not sure that is good.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
