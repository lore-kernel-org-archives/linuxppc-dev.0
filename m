Message-ID: <3A3E37B1.9040908@galileo.co.il>
Date: Mon, 18 Dec 2000 18:13:37 +0200
From: Rabeeh Khoury <rabeeh@galileo.co.il>
Reply-To: rabeeh@galileo.co.il
MIME-Version: 1.0
To: Andreas Schreckenberg <ASchreckenberg@dspace.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 16550 uart without interrupts ?
References: <3A3E2F0A.3D687E6A@dspace.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In order to work in polling mode , you have to run a __check__ routine
that runs once, at least, in a constant period of time. The routine
checks if new data has arrived or not and accordingly operates.

I suggest that you hook such a routine to your real time clock interrupt
handler which calls function
'rs_interrupt_single' in file drivers/char/serial.c with the appropriate
parameters.

p.s. the function 'rs_interrupt_single' is suitable in case you are
using one port of the serial controller !

Another option is using the decrementer of the ppc CPU which is usually
also used by the Linux kernel. But you have to find a way how to share
the decrementer with your polling function and the kernel.


Regards,
Rabeeh


Andreas Schreckenberg wrote:

> Hello,
>
> Is there anybody with a serial console uart driver for
> ppc systems without using interrupts ?
> Is is possible to use any driver in "polling mode" ?
> (drivers/char/serial.c or arch/8xx_io/uart.c)
>
> I try to bring up Linux on my custom ppc board
> (PPC750, 64M, uart 16550) and my
> (selfmade) interrupt controller will not work at this
> moment.
>
> But it would be nice to have debug messages on the
> serial console. (log_buf is okay but not really the
> thing I would like to have)
>
> Can I work with a "polling driver" -> bash input/output ?
>
> I hope that I must not understand the whole driver :-)
> (only set the uart I/O range, and set the quartz divider)
>
> bye
> Andreas
> EMail: ASchreckenberg@dspace.de
> --
>           Life's not fair. But the root password helps ! :-)
>                    http://schrecky.home.pages.de
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
