Message-ID: <007701c24a86$52d72620$bfba459b@ntu.edu.sg>
From: "shaowei dai" <dshaowei@rfnetech.com>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3D64DA41.3000104@cambridgebroadband.com> <3D65EDC0.E16387CD@imc-berlin.de> <20020823095133.F12271@zambia.cambridgebroadband.com>
Subject: Re: PCMCIA on an MPC860
Date: Fri, 23 Aug 2002 17:20:29 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Alex:

You might want to use 'ksymoops' to find more useful information from this
oops.
It's smart to tell you which routine caused the trouble.

regards
----- Original Message -----
From: "Alex Zeffertt" <ajz@cambridgebroadband.com>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, August 23, 2002 4:51 PM
Subject: Re: PCMCIA on an MPC860


>
> Steven,
>
>
> Thanks for your reply.  I did try an ethernet card as well.  With that
> I got a different problem -
> after insmodding the client driver I got the following error message:
> eth1: command 0x5800 did not complete!
>
> I also got this error whenever I tried to ping.
>
>
> My Kernel IDE config is as follows:
>
> # ATA/IDE/MFM/RLL support
> #
> CONFIG_IDE=y
>
> #
> # IDE, ATA and ATAPI Block devices
> #
> CONFIG_BLK_DEV_IDE=y
> # CONFIG_BLK_DEV_HD_IDE is not set
> # CONFIG_BLK_DEV_HD is not set
> CONFIG_BLK_DEV_IDEDISK=y
> (everything else IDE related is not set)
>
> Here's my Oops:
>
>
> Oops: kernel access of bad area, sig: 11
> NIP: C00C0A0C XER: C000037F LR: C00C0A00 SP: C1763460 REGS: c17633b0
> TRAP: 0300
> MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> DAR: 40009E9A, DSISR: 00000409
> TASK = c1762000[117] 'cardmgr' Last syscall: 54 last math 00000000 last
> altivec 00000000
> GPR00: C00C0A00 C1763460 C1762000 00009B78 000000EC 00000000 C01C838C
> C0009E9A GPR08: 00009032 40009E9A C0009E9A C01C8360 53935E95 1002205C
> 00000000 100B9E90 GPR16: 100BA770 00000001 007FFF00 00000000 C17636D8
> C1C9D670 00000002 C4040000 GPR24: C4040000 0000010E 00000100 C01C84B8
> 00000000 00000000 C01C83C8 000000EC Call backtrace: C00C0A00 C00C0F04
> C00C10EC C00C188C C00C221C C00BBFD4 C00BCAAC C00BCB4C C403F7A4 C403FBE0
> C40031BC C4004808 C403F18C C400F874 C40105B4 C00435C8 C000259C 10002BAC
> 100032C0 10004764 0FED9DBC 00000000
>
> Does this look familiar?  :-/
>
> Thanks,
>
> Alex
>
>
> On 2002.08.23 09:09 Steven Scholz wrote:
> >
> > Alex,
> >
> > actually I had the Card Service running on MPC855/860 systems with
> > Ethernet,
> > WaveLAN and ATA Cards.
> >
> > It's a while back so I try to remember realy hard now!
> >
> > I had this problem too.
> >
> > 1.) Did you try another PC Card, i.e. ethernet?
> > 2.) How are your settings for IDE in your kernel configuration?
> > 3.) I think I remember that I had to change something about the
> > request_irq /
> > request_8xxirq.
> >     I think the oops comes because the driver can't request the irq!!!
> >
> > Could you please show us you're oops!?
> >
> > Steven
> >
> >
> > Alex Zeffertt wrote:
> > >
> > > All,
> > >
> > > Has anybody had any luck getting PCMCIA to work on an MPC860?
> > >
> > > I have a custom MPC860 board, with a single PCMCIA socket connected
> > to Slot B.  This is what I have
> > > so far done:
> > >
> > > 1.
> > > Downloaded pcmcia-cs-3.2.0.tar.gz
> > > 2.
> > > Added board specific definitions in modules/m8xx_pcmcia.c for
> > >                 hardware_enable()
> > >                 hardware_disable()
> > >                 voltage_set()
> > >                 socket_get()
> > > 3.
> > > Cross compiled for the 8xx.
> > > 4.
> > > In my kernel (linux-2.4.4-2001-11-24 from Denx) I added the
> > following lines
> > >                 include/asm-ppc/<board>.h:
> > >                         /* define IO_BASE for pcmcia */
> > >                         #define _IO_BASE 0x80000000
> > >                         #define _IO_BASE_SIZE (1024*64)
> > >                 arch/ppc/mm/init.c:
> > >                         void __init MMU_init(void) {
> > >                         ...
> > >                         ioremap(_IO_BASE,_IO_BASE_SIZE);
> > >
> > >         ...as suggested by Magnus Damm in
> > >
> > http://lists.linuxppc.org/linuxppc-embedded/200005/msg00227.html
> > >
> > > HOWEVER,
> > >
> > > 5.      When I boot my board with a Flash card in the PCMCIA slot,
> > and I run:
> > >         /etc/rc.d/rc.pcmcia start
> > >         I find that ide_cs.o causes an Oops when it calls
> > ide_register().  "cardctl status"
> > >         and "cardctl ident" work though.
> > >
> > > Can anybody suggest what I'm doing wrong?
> > >
> > > Thanks in advance,
> > >
> > > Alex
> > >
> >
> >
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
