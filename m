Message-ID: <367A9EC8.2C191581@jlc.net>
Date: Fri, 18 Dec 1998 13:28:24 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Raphael Massin <massin@col.bsf.alcatel.fr>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux with MPC860
References: <199812161356.OAA01863@c5s144.clb>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Raphael Massin wrote:

> 1) in arch/ppc/kernel/time.c (mbx_calibrate_decr)
>         * the OSCM is used instead of the system clock to clock the decrementer
>          => no need to set bit 6 of SCCR

This is incorrect.  The code should force the setting of TBS
in the SCCR.  All of the timing in the system assumes
the TBS is GCLK2/16.  I have since removed the warning
message and simply force the setting of this bit.  This way,
all MPC8xx implementations are identical and don't require
any special configuration between processors or boards.


> 2) in arch/ppc/boot/mbxtty.c (serial_init)
>         * a 48MHz source clock is used instead of a 25MHz source clock
>         => modify accordingly BRGC1

This is also incorrect.  All of the 8xx ports have a
board identification structure.  At boot time, whether it
is done by the board boot prom or the Linux bootloader,
this should be properly initialized. One of the values
in that structure is the processor clock speed and bus
speed.  No code should be changing in the kernel
to support different clock speeds for 8xx processors.


> 3) in arch/ppc/8xx_io/commproc.c (mbx_cpm_setbrg)
>         * idem => modify BRG_INT_CLK macro

This is also because of above.   This shouldn't change.


> 4) in arch/ppc/8xx_io/enet.c
>         * CLK2 and CLK3 are used for ethern emission/reception
>         => modify PAPAR, PADIR and SICR
>         * port D, pin 12 is used to enable ethernet

Correct!  This is now part of the general configuration
scripts so you shouldn't have to do this in the future.


> These are my modifications, do you think i forgot something ?

What would really help is instead of the "it crashes" statement
are a System.map and register dump :-).  Otherwise, there
isn't much help anyone can provide.


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
