Message-ID: <3C59005A.4080400@elsoft.ch>
Date: Thu, 31 Jan 2002 09:29:14 +0100
From: "David =?ISO-8859-1?Q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] 3 patches against linuxppc_dev-2.4.18-pre7
References: <3C57F9AC.9040008@elsoft.ch> <3C58410B.802BC1F4@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

Armin Kuster wrote:

> "David Müller (ELSOFT AG)" wrote:
>
>>Hello
>>
>>The attached patch fixes the following issues:
>>
>>    - arch/ppc/kernel/ppc4xx_pic.c
>>       fixed constant in ppc405_pic_get_irq()
>>       (should be NR_AIC_IRQS as in ppc403_pic_get_irq())
>>
>
> David,
>
> include/asm-ppc/irq.h
> NR_IRQS = (NR_AIC_IRQS + NR_BOARD_IRQS) and was defined to allow
> cascading UIC's.
> NR_BOARD_IRQS is defined in some of the board files and its default is
> in include/asm-ppc/ibm4xx.h
>
> So i don't see the need to patch that file but the others look fine.
>
>

Exactly, NR_IRQS is the the total number of irqs possible in the system
as this number of irqs is reserved in the irq_desc table.

For example, we have a system with a PPC405GP and an additional PC like 8259 PIC
pair, we have NR_AIC_IRQS (32) + NR_BOARD_IRQS (16) = NR_IRQS (48).

In ppc405_pic_get_irq() the following code is executed:

	irq = 32 - ffs(bits);

	if (irq == NR_IRQS)
		irq = -1;

	return(irq);

with NR_IRQS equal 48 the condition is never true !

This results in an endless while-loop in do_IRQ() in arch/ppc/kernel/irq.c

Either this or my understanding how things are working is totally wrong. ;-)
Additionally, i don't see me why ppc403_pic_get_irq() is using NC_AIC_IRQS while
ppc405_pic_get_irq() is using NR_IRQS. Shouldn't they be "symmetric".


Dave


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
