Message-ID: <39529455.811FC8B1@mvista.com>
Date: Thu, 22 Jun 2000 15:33:57 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Lucinda Schafer <lucsch@adaptivemicro.com>
CC: frowand@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation Panic,
References: <A109131318C4D1119AC20060088DECE330F4C1@amwmail.adaptivemicro.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lucinda Schafer wrote:
>
> The results of the backtrace are as follows :
>
>  C0016204  put_dirty_page
>  C0016A98  handle_mm_fault
>  C0009098  do_page_fault
>  C0002544  _switch
>  018A4490  ???
>  300E88A4  ???
>  0180C6D4  ???
>  0180C5D8  ???
>  01803250  ???
>  01802B64  ???
>  01801D80  ???
>
> Which order are these called? I haven't been able to link all four together,
> although I do know that  do_page_fault calls handle_mm_fault, the scheduler
> calls _switch,  execve calls put_dirty_page via load_elf_binary. This all
> happens during the rc.sysinit.

You got the order right.  According to this backtrace, _switch() called do_page_fault()
which called handle_mm_fault() which called put_dirty_page().  You left out the top of
the trace though, C0E87DF0.  Is that a valid address (it often isn't)?

Some more clues:

  The MSR is 00001000.  Does this mean instruction translation is turned off (I don't recall
  what processor this is on, so I can't look it up)?  If so, then  NIP: 00001FFC would be
  the last instruction of Trap_1f.  This is probably not a valid instruction, thus the
  software emulation panic.  In a kernel I have laying around (2.3.39 based, built for the
  IBN 405GP processor) the instruction at the place is:

      0xc0001ffc <Trap_1F+252>:       .long 0x0

  So the next question is how did you get to this location?  A bad branch?


> -----Original Message-----
> From: Frank Rowand [mailto:frank_rowand@mvista.com]
> Sent: Thursday, June 22, 2000 3:29 PM
> To: Lucinda Schafer
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Software Emulation Panic,
>
> Lucinda Schafer wrote:
> >
> > When I get a kernel panic I see:
> >
> > NIP: 00001FFC XER: 8000FF7F LR: 00000988 REGS: c0e87c90 TRAP: 1000
> > MSR: 00001000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> > TASK = c0e86000[7] 'rc.sysinit' mm->pgd c0e8b000 Last syscall: 67
> > last math 00000000
> > GPR00: 00000000 C0E87D40 C0E86000 C0E87D50 0189EE34 C0133404 C0E88278
> > C0E8B000
> > GPR08: C00DA634 00FBA9E1 00FBA9E1 00FBA9E1 3555F593 018A31D0 00000000
> > 00000D08
> > GPR16: 000000C1 01005000 0100A400 00300008 00001032 00E87D40 C00162F0
> > 00009032
> > GPR24: 0189EE34 C0E88278 C0615760 00FBA8A1 C0FBA000 C0E86000 C0F5F000
> > C0132510
>
> Look at the addresses that are of the form 0xCxxxxxxx in the backtrace, they
> may give you a clue:
>
> > Call backtrace:
> > C0E87DF0 C0016204 C0016A98 C0009098 C0002544 018A4490 300E88A4
> > 0180C6D4 0180C5D8 01803250 01802B64 01801D80
> > Instruction DUMP:
> >
> > If the NIP = 00001FFC, then where is that? That is in the middle of
> > "Trap_1f" according to the System.map.
> >
> > In the call backtrace, how do I know what addresses such as 018a4490 or
> > 300e88a4 fall? System.map only has C000000++?
> >
> > Please be patient with me. I am still learning. I really need to figure
> out
> > what is going on here. I come from the world of 8051 assembly programmed
> > into ROM. Memory management, task switching, and embedded operating
> systems
> > are new to me.
> >
> > Lucinda Schafer
> > Staff Software Engineer
> > Adaptive Micro-Ware, Inc.
> >
>
> -Frank
> --
> Frank Rowand <frank_rowand@mvista.com>
> MontaVista Software, Inc
>

--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
