To: Mike Coy <coym@embeddedplanet.com>
cc: Lucinda Schafer <lucsch@adaptivemicro.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA ATA flash support? 
In-Reply-To: Message from Mike Coy <coym@embeddedplanet.com>
   of "Tue, 20 Jun 2000 20:43:21 -0400." <4.3.2.7.0.20000620203521.00acd470@10.0.0.2>
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 21 Jun 2000 12:09:26 +1000
Message-ID: <5824.961553366@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 20 Jun 2000 20:43:21 -0400, Mike Coy <coym@embeddedplanet.com> writes:
>>Emulation routine where the panic is called. Use your System.map file to see
>>if you can find the last functions called, for example:
>>                 show_regs(regs);
>>                         print_backtrace( (unsigned long *)regs->gpr[1] );
>>                         instruction_dump((unsigned long *)regs->nip);
>>                         panic("Kernel Mode Software FPU Emulation");
>
>OK, i added the  backtrace, but hardly any of the calls are IN my system.map!
>Odd!

They won't be - the backtrace prints the return (or link in ppc speak)
address i.e. the next instruction to be executed after a return from the
current function (or stack frame). Just sort your System.map file on the
first column (hex address) and then look for the largest value in the
first column that is still less than the next address in the backtrace.
This gives you some idea of which function that address is within, and
how far in that function it is. A bit tedious but ok for a start.

What would be better is to get kgdb working, then gdb will work all this
out for you - and tell you a lot of other information as well. You can
compile in a breakpoint() just before the panic() and then hunt around
using gdb to try and find anything unusual e.g. you could examine the
memory at the address contained in "regs->nip", and the mmu page table
entries that map that kernel address. A "where" will give you all the
function names in the stack including the arguments they were called with.

See the other message I just sent to the list about kgdb. One thing I
forgot to say in that message was that I like to compile my kernel with
the "-g" flag and then run "gdb <ksrctopdir>/vmlinux" before doing the remote
to the target (actually you just chuck all these things into a .gdbinit
file e.g. in arch/ppc/mbxboot so it is all done automatically when gdb
is run in that directory). The "-g" shouldn't make your kernel any bigger
because only certain sections are copied when <topdir>/vmlinux is copied
into the arch/ppc/coffboot directory and compressed. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
