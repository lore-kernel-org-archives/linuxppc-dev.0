Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: nbasker@india.tejasnetworks.com
To: Wolfgang Denk <wd@denx.de>
Subject: Re: data address causing machine check exception
Message-ID: <1032528899.3d8b2403648a5@pop-mail.india.tejasnetworks.com>
Date: Fri, 20 Sep 2002 19:04:59 +0600 (IST)
Cc: nbasker@india.tejasnetworks.com,
	linuxppc-embedded@lists.linuxppc.org
References: <20020919170814.E25F9FA8E@denx.denx.de>
In-Reply-To: <20020919170814.E25F9FA8E@denx.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi:

In the sample crash I had sent in the previous mail (attached below),
I deliberately caused a crash by accessing an invalid address
0xfd040000 which is in gpr[3], the first parameter to a
function that caused the crash.

But this invalid address is not in DAR or SRR0 as I expected,
instead I found the following;
srr0 = c0017f70 srr1 = 00001032 dar = 00000000 dsisr = 00000000.

Is it not gauranteed that DAR will have invalid address.

 Machine check in kernel mode.
 Caused by (from msr): regs c46bb4c0 Unknown values in msr
 NIP: CC050014 XER: 40001F7F LR: CC0542FC REGS: c46bb4c0 TRAP: 0200
 MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
 TASK = c46ba000[529] 'test' mm->pgd c59ca000 Last syscall: 54
 last math 00000000
 GPR00: CC0512DC C46BB570 C46BA000 FD040000 00000000 00000000 C46BBDFC 00000000
 GPR08: 00000000 00000000 00000000 C000B794 30026438 1001BA08 100C4490 00000000
 GPR16: 100A9A10 7FFFDBC8 10014F45 00000000 00009032 046BBE80 00000000 C000253C
 GPR24: C000227C 00000000 C4796960 C49F7360 7FFFFD00 CC0E5398 C47A8380 40086A02
 Call backtrace:
 CC0E5398 CC0512DC CC0E5158 C0034640 C00022D0 1000080C 10001AC8
 10000C28 0FE334F8 00000000
 Kernel panic: machine check

Thanks,
Nicholas.

Quoting Wolfgang Denk <wd@denx.de>:

> In message <1032445842.3d89df925ac65@pop-mail.india.tejasnetworks.com>
> you wrote:
> >
> > In my driver module, there is an invalid memory access
> > that causes a machine check exception.
> ...
> > Since the exception is caused due to load/store related
> > error, I was expecting the dar register to hold the Effective
> > Address of the data, but I find zero.
>
> Why don't you belive that, then? Maybe this _is_ the probem?
> Somebody trying to dereferece NULL?
>
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> It's a small world, but I wouldn't want to paint it.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
