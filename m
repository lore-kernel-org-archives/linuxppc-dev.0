Date: Thu, 27 Jan 2000 19:58:08 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andreas Tobler <toa@pop.agri.ch>
cc: Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Backtrace interpretation?
In-Reply-To: <389092CE.60034142@pop.agri.ch>
Message-ID: <Pine.LNX.4.05.10001271955240.17766-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 27 Jan 2000, Andreas Tobler wrote:
> finally I managed to get my kernel backtrace out of the box into a file.
> --> serial_console
>
> Now I have some basic question how to interpret the log.
>
> are there limitations or other topics I have to pay attention to?
> - e.g. ix86 vs. ppc
> - little/big endian
> can I operate with ksyms or nm without any problems(topics above)
>
> For example the log below:
>
> ---
> Caused by (from msr): regs c4db77f0 Unknown values in msr
> NIP: C83363F8 XER: 00000000 LR: C83363E4 REGS: c4db77f0 TRAP: 0200
> MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c4db6000[467] 'cardmgr' mm->pgd c4db5000 Last syscall: 54
> last math 00000000
> GPR00: C83363E4 C4DB78A0 C4DB6000 FFFFFFFF 00000001 C01E8180 C01B0000 C01B0000
> GPR08: C01B0000 00000000 000010F6 C4DB77E0 24242422 10021974 00000001 00000000
> GPR16: 00000000 00000001 FFFFFFFF 00000016 00009032 0000000E 00000000 C0003B78
> GPR24: C51EAB60 1002C7B0 00000000 00000000 00000001 C01B0000 C5D22800 00000118
> Entering xmon kernel debugger.
> Unable to handle kernel paging request at virtual address efcf0000
> (error 42000000)
> NIP: C01D2264 XER: 00000000 LR: C01D21E0 REGS: c4db7500 TRAP: 0300
> MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
> TASK = c4db6000[467] 'cardmgr' mm->pgd c4db5000 Last syscall: 54
> last math 00000000
> GPR00: 00000000 C4DB75B0 C4DB6000 C0236000 FFFFFFFF 00000000 00000000 00000000
> GPR08: 00000000 00000000 00000000 00000000 C4DB75A8 10021974 00000001 00000000
> GPR16: 00000000 00000001 FFFFFFFF 00000016 00001032 04DB77E0 00000000 C0003B78
> GPR24: 00000000 FFFFFFFF 00000000 00000000 C01D2A30 C0236000 C01D2A31 EFCF0000
> ---
> The log continues, I only snipped the first two entries to find out if I
> understand it correct.
>
> - the NIP: C83363F8 is this the address of my break?

Yep, Next Instruction Pointer. The Link Register (`LR') usually contains the
return address for the current subroutine (most RISC CPUs don't push return
addresses on the stack but store them in a register, so the compiler can decide
to put it on the stack or not).

Unfortunately there's no backtrace (`BT'), but xmon was entered instead, which
crashed immediately as well. Note that I never used xmon.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
