Message-ID: <3D65FB4E.56E18A55@imc-berlin.de>
Date: Fri, 23 Aug 2002 11:07:26 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA on an MPC860
References: <3D64DA41.3000104@cambridgebroadband.com> <3D65EDC0.E16387CD@imc-berlin.de> <20020823095133.F12271@zambia.cambridgebroadband.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Zeffertt wrote:
>
> Steven,
>
> Thanks for your reply.  I did try an ethernet card as well.  With that
> I got a different problem -
> after insmodding the client driver I got the following error message:
>         eth1: command 0x5800 did not complete!
>
> I also got this error whenever I tried to ping.
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

Not realy. :-(

Which kernel version do you use?

I suggest you switch on PCMCIA_DEBUG in CS, put some extra printk's into
ide_cs.c _and_  in ide_init_hwif_ports() to find out which addressen are used!

Can you backtrace 'cardmgr' ?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
