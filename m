Date: Fri, 23 Aug 2002 10:24:34 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Wolfgang Denk <wd@denx.de>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Cc: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: PCMCIA on an MPC860
Message-ID: <20020823102434.H12271@zambia.cambridgebroadband.com>
References: <20020823095133.F12271@zambia.cambridgebroadband.com> <20020823090906.3511611822@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <20020823090906.3511611822@denx.denx.de>; from wd@denx.de on Fri, Aug 23, 2002 at 10:09:01 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 2002.08.23 10:09 Wolfgang Denk wrote:
> In message <20020823095133.F12271@zambia.cambridgebroadband.com> you
> wrote:
> >
> > Here's my Oops:
> >
> >
> > Oops: kernel access of bad area, sig: 11
> > NIP: C00C0A0C XER: C000037F LR: C00C0A00 SP: C1763460 REGS: c17633b0
> > TRAP: 0300
> > MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> > DAR: 40009E9A, DSISR: 00000409
> > TASK = c1762000[117] 'cardmgr' Last syscall: 54 last math 00000000
> last
> > altivec 00000000
> > GPR00: C00C0A00 C1763460 C1762000 00009B78 000000EC 00000000
> C01C838C
> > C0009E9A GPR08: 00009032 40009E9A C0009E9A C01C8360 53935E95
> 1002205C
> > 00000000 100B9E90 GPR16: 100BA770 00000001 007FFF00 00000000
> C17636D8
> > C1C9D670 00000002 C4040000 GPR24: C4040000 0000010E 00000100
> C01C84B8
> > 00000000 00000000 C01C83C8 000000EC Call backtrace: C00C0A00
> C00C0F04
> > C00C10EC C00C188C C00C221C C00BBFD4 C00BCAAC C00BCB4C C403F7A4
> C403FBE0
> > C40031BC C4004808 C403F18C C400F874 C40105B4 C00435C8 C000259C
> 10002BAC
> > 100032C0 10004764 0FED9DBC 00000000
> >
> > Does this look familiar?  :-/
>
> Alex, I guess Steven was more interested in the _decoded_  output  of
> the stack backtrace.
>

Yes, of course.  The crash occurs in the ide_cs client.  The order of
calls is:

(CARD INSERTION) -> ide_event() -> ide_config() -> ide_register().

The crash occurs somewhere in ide_register(), but I find reading
through that code a bit hairy as I don't really know anything about IDE
myself.

I suspect that I've got a problem with byte ordering.  This would
explain the problem I get when I insert an ethernet card.  When I do
this, the client 3c574_cs tries to write a command to a register on the
card, and read another register to determine when the command has been
completed - however, this never happens.  This could be a result of
performing reads and writes in the wrong order.

In Magnus' email
(http://lists.linuxppc.org/linuxppc-embedded/200005/msg00227.html) he
talks about Endianness.  However, I've been through the source files he
talks about (my kernel is linux-2.4.4-2001-11-24) and all of the
changes he refers to are already there.

Any ideas?

Alex


> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> The software required `Windows 95 or better', so I installed Linux.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
