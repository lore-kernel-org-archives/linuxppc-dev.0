Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3D65EDC0.E16387CD@imc-berlin.de>
Date: Fri, 23 Aug 2002 10:09:36 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA on an MPC860
References: <3D64DA41.3000104@cambridgebroadband.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex,

actually I had the Card Service running on MPC855/860 systems with Ethernet,
WaveLAN and ATA Cards.

It's a while back so I try to remember realy hard now!

I had this problem too.

1.) Did you try another PC Card, i.e. ethernet?
2.) How are your settings for IDE in your kernel configuration?
3.) I think I remember that I had to change something about the request_irq /
request_8xxirq.
    I think the oops comes because the driver can't request the irq!!!

Could you please show us you're oops!?

Steven


Alex Zeffertt wrote:
>
> All,
>
> Has anybody had any luck getting PCMCIA to work on an MPC860?
>
> I have a custom MPC860 board, with a single PCMCIA socket connected to Slot B.  This is what I have
> so far done:
>
> 1.
> Downloaded pcmcia-cs-3.2.0.tar.gz
> 2.
> Added board specific definitions in modules/m8xx_pcmcia.c for
>                 hardware_enable()
>                 hardware_disable()
>                 voltage_set()
>                 socket_get()
> 3.
> Cross compiled for the 8xx.
> 4.
> In my kernel (linux-2.4.4-2001-11-24 from Denx) I added the following lines
>                 include/asm-ppc/<board>.h:
>                         /* define IO_BASE for pcmcia */
>                         #define _IO_BASE 0x80000000
>                         #define _IO_BASE_SIZE (1024*64)
>                 arch/ppc/mm/init.c:
>                         void __init MMU_init(void) {
>                         ...
>                         ioremap(_IO_BASE,_IO_BASE_SIZE);
>
>         ...as suggested by Magnus Damm in
>         http://lists.linuxppc.org/linuxppc-embedded/200005/msg00227.html
>
> HOWEVER,
>
> 5.      When I boot my board with a Flash card in the PCMCIA slot, and I run:
>         /etc/rc.d/rc.pcmcia start
>         I find that ide_cs.o causes an Oops when it calls ide_register().  "cardctl status"
>         and "cardctl ident" work though.
>
> Can anybody suggest what I'm doing wrong?
>
> Thanks in advance,
>
> Alex
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
