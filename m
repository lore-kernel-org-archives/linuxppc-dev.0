Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 28D50DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 15:30:52 +1000 (EST)
In-Reply-To: <48E26025.9030208@linutronix.de>
References: <20080923195404.GA10935@www.tglx.de>
	<200809240124.m8O1O2QK076012@sullivan.realtime.net>
	<20080929200448.GA23025@www.tglx.de>
	<5162f4985b6fa3ced7fe8670cdae926a@bga.com>
	<48E26025.9030208@linutronix.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb72ceaf3497dca282cd7fe03f202eca@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] powerpc/boot: add kernel,end node to the cuboot target
Date: Wed, 1 Oct 2008 00:33:15 -0500
To: Sebastian Siewior <bigeasy@linutronix.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sep 30, 2008, at 12:21 PM, Sebastian Siewior wrote:
> Milton Miller wrote:
>>> |load: entry = 0x80053c flags = 0
>>> |nr_segments = 2
>>> |segment[0].buf   = 0x1002b8f0
>>> |segment[0].bufsz = 80
>>> |segment[0].mem   = (nil)
>>> |segment[0].memsz = 1000
>>> |segment[1].buf   = 0x4803f008
>>> |segment[1].bufsz = 3a3138
>>> |segment[1].mem   = 0x800000
>>> |segment[1].memsz = 3b0000
>> I would expect a third segment (kernel/zImage, dtb, and purgatory), 
>> but its not clear that you are getting that far yet.
>
> segment 0 looks like a small segment which should create "boot loader 
> environment". That one does nothing.
> Segment 1 is my cuImage. What is purgatory?

Purgatory is the code that runs between the old kernel exiting and the 
new image loading.   Its supposed to be where any registers, dynamic 
memory structures, etc get set before calling the image supplied to 
kexec user space.   Its built as part of the kexec-tools suite as a 
completley relocatable elf and selected and edited based on type of 
image being loaded.  For powerpc64 it is where we take the "boot" / 
master cpu's physical id from r3, put it in the dtb header, and load 
the address of r3 with the dtb before going into the kernel (for 
vmlinux, and could do for zImage but don't have support upstream).  If 
you were booting a cuImage (as opossed to the code you are aparently 
running, which is what grant called simple image, effectively), then 
you would set any registers uboot leaves behind in this code.

The standard code supplied by kexec-tools also calculates a checkum 
(sha1) of each loaded segment (except itself) and checks that vs the 
sum calculated by kexec-tools userspace (printing a message that on 
powerpc has no way to be displayed then going into an infinite 
spinloop.  Oh well, I digress.) and also where, for kdump, any memory 
backup copy is performed when a specific memory segment is needed to 
boot (eg initial page for ppc64 and classic32 that require interrupt 
(exception) vectors to be in page 0-2).

The powerpc64 code reads the existing device tree from 
/proc/device-tree and modifies a few things (initrd start, end, 
bootargs = command line, and (for kdump) which memory is available and 
usable to the kernel (vs reserved because it was used for the old 
kernel, whose image we want to dump, and which could be under dma).


>>> Now. The entry address in image->start is valid and is the 
>>> entrypoint of
>>> the "custom" cuImage. Custom means that it does not depend any 
>>> register
>>> values passed from u-boot (the original one needs a pointer to bd_t).
>>> The only requirement is a valid 1:1 memory mapping.
>> ok sounds good.  does this have the dtb in it too?
> Yes it does.

ok.   sounds like a simple image then ... ok to start with, but 
eventually we want to dtb passed via the tool so we can set command 
line etc.

I actually developed the powerpc 64 code this way to, and let someone 
else make the standard tool work.  But the standard tool is useful.

>>> The branch above is taken, so I've found my current mapping
>> ok, but should you not be using PID0 explictly to say global only?
> The kernel mapping should only be global and therefore that might be a 
> good idea.
>
>> obviously, a jtag or similar hardware debugger would be best.  Second
> I have here CodeWarrior usb tap but after more than one hour playing 
> with that thing I started to hack assembly char put. It helper more :) 
> kexec seems to work now :) I get "nobody cared irq X" from time to 
> time so I thing I have to fix here something.....

kexec is a bit harder than kdump in that you have to make sure all 
devices have shutdown handlers.   Easier for those that are modules 
that can be loaded and unloaded (make sure they have a shutdown method 
that is comparable to unload, or even unload in a script to test).   
kdump is harder in that while the dma is left running in the old 
kernel, the new kernel has to fit in the cracks left over, and has to 
initialize devices that were not shutdown.

>> As a final note, it looks like you are currently replacing the code 
>> in relocate_new_kernel with book-e code.  Obviously this will need 
>> refinement to select or move to heat_xx to merge.
> Yep, this is next what is going to happen. I would prefer to have them 
> runtime switchable instead of build depend.

well, I am thinking that we will end up with one exit condition for all 
book-e, one for classic 32, and one for powerpc64.   I don't understand 
what you think should be runtime switchable, unless you were thinking 
about code that should be in purgatory (supplied by userspace as far as 
the kernel is concerned).

Remember the exit point of the kernel is a single entry point (we cheat 
and make it 2 on powerpc64, one for master and a second for slaves, 
although for book-e we could follow epapr instead), and specified pages 
of memory with user specified content.  The state is supposed to be an 
emulation of "mmu off", not "I just ran uboot and am its client 
loader".

>> Again, I don't have any direct experience, but mauybe this gives you 
>> some ideas.
> Your hints helped. Thx for that.

sure.   Maybe the new hits about purgatory will keep you on track too.

milton
