From: "Amit S. Kale" <amitkale@emsyssoft.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: PPC KGDB changes and some help?
Date: Wed, 21 Jan 2004 19:46:17 +0530
References: <20040120172708.GN13454@stop.crashing.org>
In-Reply-To: <20040120172708.GN13454@stop.crashing.org>
Cc: Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200401211946.17969.amitkale@emsyssoft.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Tom,

Yes. Software breakpoints have been tested in the TimeSys ppc kernel source.
They work quite well!! I'll be releasing that code soon.

Here are a couple of questions from a quick look at this code. I may have more
when I do a merge this code with what I have.

> -	bl	schedule
> +	bl	user_schedule

I still have #ifdef CONFIG_KGDB_THREAD here. Threads listing is a necessary
feature, agreed. Do you have any ideas on reducing the overhead of the code
added by having to push all registers when doing a switch_to?

if (kgdb enabled) do a full push of registers else go to usual switch_to

Does this sound good?


> +        */
> +#if 0
> +       extern atomic_t kgdb_setting_breakpoint;
> +       if (atomic_read(&kgdb_setting_breakpoint))
> +               regs->nip += 4;
> +#else
> +       if (linux_regs->nip == 0x7d821008 )
> +               /* Skip over breakpoint trap insn */
> +               linux_regs->nip += 4;
> +#endif

Why is kgdb_setting_breakpoint a bad idea?
My guess - problems on an smp board.
Hardcoded nip is worse.
Any ideas for a better code?


In following code, gdb packets and their responses appear correct. kgdb is
supposed handle software breakpoints.

The breakpoint 0xc0000000 placed by gdb is _evil_ It may clobber data. The gdb
at kgdb.sourceforge.net places it correctly at module_event.

Where is the other breakpoint placed? While you would have certainly done
that, please confirm that kgdb actually inserts a breakpoint where you have
asked it to: a simple printk at the address where the breakpoint is placed
should be sufficient. printing from gdb will not work as gdb removes all
breakpoints before giving control to a user.

> Now, when I say that things don't quite work, here's a gdb log:
> Remote debugging using /dev/ttyS0
> Sending packet: $qPassSignals:0e;10;14;17;1a;1b;1c;21;24;25;4c;#df...Ack
> Packet received:
> Packet qPassSignals (pass-signals) is NOT supported
> Sending packet: $Hc-1#09...Ack
> Packet received: OK
> Sending packet: $qC#b4...Ack
> Packet received: QC0000000000000001
> Sending packet: $qOffsets#4b...Ack
> Packet received:
> Sending packet: $?#3f...Ack
> Packet received: S05
> Sending packet: $Hg1#e0...Ack
> Packet received: OK
> Sending packet: $g#67...Ack
> Packet received:
> 00000001c3fddfd0c3fdb7400000002d00000448c01d4e7cffff8ae9c01d501c00007548c01
>d00000000ea5fc01d00008200002200000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000004000000035303d30000
>0000000000000c0003dec0000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>000000000c002c9580002903242000028c002c9ecc00d5574000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0 Sending packet: $mc002c9e8,c#2a...Ack
> Packet received: 4bffff513c60c0153863b1d0
> 0xc002c958 in breakpoint () at kernel/kgdbstub.c:1082
> 1082			wmb();
>
> << break show_cpuinfo >>
>
>
> Sending packet: $qSymbol::#5b...Ack
> Packet received:
> Packet qSymbol (symbol-lookup) is NOT supported
> Sending packet: $mc000be54,4#f0...Ack
> Packet received: 9421ffd0
> Sending packet: $mc000be58,4#f4...Ack
> Packet received: 7c0802a6
> Sending packet: $mc000be5c,4#1f...Ack
> Packet received: 39600000
> Sending packet: $mc000be60,4#ed...Ack
> Packet received: bf410018
> Sending packet: $mc000be64,4#f1...Ack
> Packet received: 90010034
> Sending packet: $mc000be68,4#f5...Ack
> Packet received: 37e4ffff
> Breakpoint 1 at 0xc000be68: file arch/ppc/kernel/setup.c, line 144.
>
> << continue >>
>
> Continuing.
> Sending packet: $Z0,c0000000,4#c9...Ack
> Packet received: OK
> Packet Z0 (software-breakpoint) is supported
> Sending packet: $Z0,c000be68,4#3e...Ack
> Packet received: OK
> Sending packet: $Hs1#ec...Ack
> Packet received:
> Sending packet: $Hc0#db...Ack
> Packet received: OK
> Sending packet: $c#63...Ack
> Packet received: S05p0000000000000001
> [New Thread 1]
> Sending packet: $g#67...Ack
> Packet received:
> 00000001c3fddfd0c3fdb7400000002d00000448c01d4e7cffff8ae9c01d501c00007548c01
>d00000000ea5fc01d00008200002200000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000004000000035303d30000
>0000000000000c0003dec0000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>000000000c002c9580002903242000028c002c9ecc00d5574000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
> Sending packet: $mc002c9e8,c#2a...Ack
> Packet received: 4bffff513c60c0153863b1d0
> Sending packet: $z0,c0000000,4#e9...Ack
> Packet received: OK
> Sending packet: $z0,c000be68,4#5e...Ack
> Packet received: OK
> 0xc002c958 in breakpoint () at kernel/kgdbstub.c:1082
> 1082			wmb();
>
> << continue >>
>
> Continuing.
> Sending packet: $Z0,c0000000,4#c9...Ack
> Packet received: OK
> Sending packet: $Z0,c000be68,4#3e...Ack
> Packet received: OK
> Sending packet: $c#63...Ack
> Packet received: S05p0000000000000001
> Sending packet: $g#67...Ack
> Packet received:
> 00000001c3fddfd0c3fdb7400000002d00000448c01d4e7cffff8ae9c01d501c00007548c01
>d00000000ea5fc01d00008200002200000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000004000000035303d30000
>0000000000000c0003dec0000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>000000000c002c9580002903242000028c002c9ecc00d5574000000000000000000000000000
>0000000000000000000000000000000000000000000000000000000000000000000000000000
>0
>
> Program received signal SIGTRAP, Trace/breakpoint trap.
> Sending packet: $mc002c9e8,c#2a...Ack
> Packet received: 4bffff513c60c0153863b1d0
> Sending packet: $z0,c0000000,4#e9...Ack
> Packet received: OK
> Sending packet: $z0,c000be68,4#5e...Ack
> Packet received: OK
> 0xc002c958 in breakpoint () at kernel/kgdbstub.c:1082
> 1082			wmb();
>
> << quit >>
>
> The program is running.  Exit anyway? (y or n) Sending packet: $k#6b...Ack
>
>
> Which leads me to wonder, has software breakpoints been tested at all?
> PPC allows for HW breakpoints, but in general there's only 1 or 2.  And,
> FWIW, I have a much uglier version of things which overrides the
> linux_debug_hook with the working handle_exception function in
> ppc-stub.c, and found the same problem.  Also, what I'm going to try and
> do next is to add support for using the HW breakpoints and see if that
> fixes things, or at least gets me further along.
>
> Any pointers or ideas?  Thanks.

--
Amit Kale
EmSysSoft (http://www.emsyssoft.com)
KGDB: Linux Kernel Source Level Debugger (http://kgdb.sourceforge.net)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
