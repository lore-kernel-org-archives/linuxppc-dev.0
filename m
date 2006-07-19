Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.76])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A652367B80
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jul 2006 03:18:02 +1000 (EST)
Date: Wed, 19 Jul 2006 12:17:46 -0500 (CDT)
Message-Id: <200607191717.k6JHHk5l037485@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jimi Xenidis <jimix@watson.ibm.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: Kexec initial registers
In-Reply-To: <1152911297.23037.109.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jul 14, 2006, at 5:08 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2006-07-14 at 12:02 -0400, Jimi Xenidis wrote:
>> This is what I have so far:

The processor will be in real mode.  (well, whatever that means for book-e)

>>
>>    r3: address of device tree blob
>>    r4: address that kernel was loaded

mostly, see below.

>>    r5: not OF (=0)
>
> Correct and that's all that should be needed
>

For single processor.


>>    r13: local_paca address (0?)
>
> You shouldn't have to care about r13 at all, it should be set by the
> kernel before it's used. If not, please let us know as that means  
> there
> is a bug :)

[Mike Ellerman pointed out a recient patch to fix one such bug].

>> Did I miss the document on this?

The documentation for kexec is in arch/powerpc/kernel/misc_64.S in
the middle of kexec_sequence.  The documentation for the kernel
entry point is at Documentation/powerpc/booting-without-of.txt.

On the elected master cpu, r4 contains the address of the entry point.
Upon leaving the kernel r3 contains the hardware cpu identifier, and
r5 is 0 to say there is no of interface and r3 and r4 are valid.  Both
v2wrap.S and the standard kexec-tools purgatory code store this value
in the device tree struct header and point r3 to the header, which is
the entry requirement for the linux kerne.


To support multi-processor, 256 (0x100) bytes are copied from the
the entry point to address 0, r3 is loaded with the hardware cpu
id corresponding to a node in the device tree and execution of the
slave is at absolute 0x60.  Other than being in real mode, the only
state on a slave is r3 and the entry point.  Specifically, r4 and
r5 are unspecified.

Unfornately current kexec-tools doesnn't seem to look for the entry
point of the loaded image and assumes it is offset zero.  This
creates an unfornate limitation that I only reciently discovered,
and I hope someone will fix it.

Today the register state only applies to the PowerPC 64 bit interface;
the game cube is the only 32 bit port I am aware of and they didn't
have the multi-processor issues.  However, I expect 32 bit will
gain this interface well.


Histoory and Background:

Kexec went though some design refinement before it got merged.  Part
of this was standardization of the kexec syscall across architectures,
and part was moving to a concept of intermediate wrappers the any
environment setup required for the loaded image.  Kexec is supposed
to be able to load any code image and not be tied to loading a linux
kernel.  It was declared the only state at the end of the kernel
kexec implmentation would be specified memory contents, processor
execution mode, and entry point.  The entry point and memory contents
are specified explictily; the execution mode defaults to the
instruction set and word size of the kernel.  While any elf platform
type can be specified the kernel will likely only support only one
(native) or possbly two (for example a 32 bit mode may be added).
All setup of registers, mmu, and any other environment shall be
done in code inserted by kexec-tools or other kexec_load callers.
In kexec-tools, this stage is called purgatory (its neither here
nor there); it is built seperately and embedded in the kexec program.
The register state and other enviornmental parameters is patched
into the image before calling the kexec_load syscall).

Unfornately this would not quite meet the needs of multiprocessor
PowerPC platforms.  On x86 other processors have executed an interrupt
disabled halt instruction and therefore are waiting for a NMI or
"init".  Unlike x86, PowerPC does not guarantee a way to stop
execution of a processor.  How to start a secondary cpu is platform
specific.  Not all platforms have a park method that is reversable.
A way was needed to park the slaves.  In addition, there is no cross
platform way to determine which cpu you are executing on.

I chose the method that the kernel already did between the prom
code and the main kernel to solve both problems.  Copy 256 bytes
to zero, specifiy a second entry point of address 0x60 after the
copy, and specify r3 has the hardware id.

While having r3 point to the device-tree structure on the master
thread might seem to simplify the handoff, there were several
problems.  First, there is no method to pass the address of the
structure to the kernel.  I realized this was limiting to images
that wanted the kernel's  device tree structure and not in the load
anything, setup the environment using code added to the memory image,
design point  of kexec.  Passing the the hardware identifier
was the minimum requirement.  And passing it in r3 is the obvious
choice, both because that is what the slaves needed and it is the
first argument on many calling conventions.

Because branching to an arbitrary address requires loading
said address into a general purpose register I decided that specifing
that register would be r4 would have minimal impact to any code.
And specifiying r5 be zero was purely gratitious, but its one
instruction.

One other difference in the  PowerPC 64 bit kexec is that, due to
the limited addressability of memory in real mode in partitions
(HV=0), the initial copy is done with the mmu using the base kernel
and therefore the destination memory can not overlap it or the mmu
page table.  If an image requires memory in these areas to be
initialized, then some code must be added to purgatory; the linux
kernel already had the needed copy loop because of our interaction
with open firmware in prom_init.c and that was exploited.  In
addition, pSeries tce tables and RTAS are protected.

milton
