Date: Fri, 18 Oct 2002 16:59:55 +0200
Subject: Re: Problems with 2_4_devel & MVME2600 serial interrupts
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1A322033-E1E0-11D6-8132-0003931C2BFA@control.lth.se>
Message-Id: <432E39D0-E2AA-11D6-8132-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> When trying 2_4_devel on a MVME2600 box, the system hangs on the first
> access to stdout (printk works OK).
>
> The problem occurs when my /bin/sh gets invoked as the init task, so all
> kernel initialization seems to work OK (lots of reasonable output at least)
> . What seems to happen is:
>
> 1. A write to stdout eventually reach rs_write (drivers/char/serial/serial.
> c),
>    where the following gets executed:
>
> 		info->IER |= UART_IER_THRI;
> 		serial_out(info, UART_IER, info->IER);
>
> 2. When the interrupts gets enabled, the system gets an interrupt and
> eventually
>    calls i8259_irq, which reads 0xff from pci_intack, which it will
> continue to
>    do	forever in this loop (do_IRQ, arch/kernel/irq.c):
>
>      while ((irq = ppc_md.get_irq(regs)) >= 0) {
> 		ppc_irq_dispatch_handler(regs, irq);
> 		first = 0;
>      }
>
> Does anybody has a clue what might be wrong (linuxppc_2_4 works OK, but not
> the linuxppc_2_4_devel)?

A quick (and working, but probably unclean) solution is call
'i8259_init(intack_addr)' with intack_addr set to zero (instead of the
0xbffffff0 from prep_setup.c), thus forcing the interrupt to be polled from
the 8259 controller. Could somebody who understands open_pic (is this a
relative to MPIC?), give me a hint of suitable further reading before I to
try to clean this up?

Regards

Anders Blomdell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
