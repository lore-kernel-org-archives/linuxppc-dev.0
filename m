To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8xx MMU Table Walk Base (was Re: kernel crashes at InstructionTLBMiss ) 
In-reply-to: Your message of "Tue, 06 Jun 2000 16:05:42 -0400"
             <393D5996.4004845C@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 07 Jun 2000 19:17:49 +1000
Message-ID: <24756.960369469@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 06 Jun 2000 16:05:42 -0400, Dan Malek <dan@netx4.com> writes:
>Murray Jensen wrote:
>
>> I use the linuxppc_2_3 bitkeeper repository at hq.fsmlabs.com as the
>> base for my local changes.
>
>This has not run correctly on the 8xx for quite some time.

I know - I said as much in my message. I have a working 2.3.x kernel
from some months ago (October 1999).

>It won't
>boot since the addition of the IBM403 changes.

It boots fine for me, but eventually crashes with the following:

	kmem_alloc: Bad slab magic (corrupt) (name=buffer_head)

As far as I can tell, a completely new method of memory allocation was
introduced a few months ago and it hasn't worked since.

>> .... (including the I/O mappings, which are different
>> to the MBX in that they reside in the lower half of the address space which
>> required me to use ioremap() correctly by setting ioremap_base and saving
>> its return value and using this to access my devices) and some other minor
>> changes, which I believe are not relevant.
>
>Not again......Did you read any of my past postings about memory
>mapping on the 8xx?

I scanned the archives as best I could. I only found the linuxppc mailing
lists a couple of weeks ago (I don't know how I managed to overlook them
before).

>You can't change ioremap_base,

I have changed ioremap_base and it runs fine with a kernel based on 2.3.x
as at October 1999.

The way it was being done before is, in my opinion, incorrect. The return
value from ioremap() was being ignored, which is the same as assuming that
physical address == virtual address for all I/O mappings (because ioremap()
uses the physical address as the virtual address if the physical address is
greater than or equal to ioremap_base, but because the 8xx port does not set
ioremap_base, it defaults to zero, hence all I/O mappings are done in this
fashion).

The Cogent CMA286-60 by default has I/O devices starting at 0x02000000.
One of my problems in the early days of porting to Cogent was that I blindly
copied the way I/O mappings were being done for other platforms. When it
didn't work I had to find out why - of course it was because having an I/O
device mapped to kernel virtual address 0x02000000 was not a good idea.

I could move the location of these I/O devices in the physical address space
by manipulating the PowerPC hardware in the boot rom, but this would be
confusing at best (because the Cogent documentation says otherwise) and the
kernel would then be reliant upon being booted from a compatible boot ROM,
or to make the kernel independent, I could change the hardware mappings at
kernel boot time, but this would require hacking head_8xx.S and I didn't want
to change anything in there at the time.

So I instead chose to do the ioremap()'ing correctly, by setting ioremap_base
to a sensible value (I chose 0xf8000000, which isn't to say this is a sensible
value, just the value I chose), storing the return value from ioremap() and
using that as the base virtual address for access to the cogent I/O devices.

>and any memory
>mapping change is highly relevant.

OK, if you say so (and it makes sense), but I don't believe my I/O mappings
are causing any problems. However, I will change my boot rom and add a command
that will change the hardware mappings so that the cogent devices are up high
in the physical address space (by programming the base and option registers in
the memory controller), then I can test a kernel with a pristine
arch/ppc/mm/init.c and see how much difference it makes (this will take me a
while). I don't consider this a high priority though, since I have a working
kernel using these memory mappings.

>> I checked this out again, and one other change was moving most of the code
>> at _start in head_8xx.S
>
>Oh geeze.....Let me quickly paraphrase what I have written in the past.
>You should not be changing _any_ code in head_8xx.S.  This code will
>minimally map some memory and the IMMR.  This is all that is required
>to boot the kernel into further initialization functions.  If there
>are some devices that you must use early (such as board control/status
>registers), you ioremap() these in arch/ppc/mm/init.c.

I wanted to access the Cogent LCD display for diagnostic purposes, before
MMU_init was called. I simply added a second 8Mb temporary TLB entry (almost
identical to the one for the IMMR). This TLB entry would have been invalidated
after the first tlbia, same as for the IMMR. This was the only change to
head_8xx.S (I am very careful making changes in there, if I do it at all), but
it meant the code went over the available 0x100 bytes, so I moved it to 0x2000
(by the same method that is used to transfer execution to "start_here").

In any case, I believe this does not affect anything else because I have
run with and without that change and it appears to make no difference (other
than that I cannot access the LCD display). My kernel (the working one)
runs fine in either case.

>These physical
>hardware addresses must reside outside of the user and kernel text/data
>virtual addresses.

Only because the ioremap()'ing in arch/ppc/mm/init.c is not done correctly.
My working kernel runs fine with the Cogent I/O devices located at 0x02000000
in the physical address space. They are not at that location in the virtual
address space, but this is hidden (by indirection).

>> ..... to after the exception handlers because the extra
>> mappings required for the Cogent devices caused this code to exceed 0x100
>> bytes.
>
>All of this mapping should be done inside of the device drivers, not
>part of the early kernel initialization.

Hmm.. I do all I/O mapping in MMU_init() using ioremap() - is there another
way? I suppose I could map each individual device in the driver initialisation
routines (probably the usual way?), but the Cogent has the concept of I/O
slots, which have a fixed location and size in the physical address space
(by default), so I simply map the entire range (32Mb) for the slot, and then
each device driver treats I/O addresses as offsets from the I/O slot's virtual
base address, as returned by ioremap() (it's actually done generically by
macros in the board specific header). This is wasteful in the page map (even
the I/O slot that has the flash, only uses 8Mb - although it could have had
16Mb flash on it - I only got the 8Mb version), but conceptually simpler.
However, the device registers are fairly sparsely arranged within the 32Mb
address ranges, especially for the motherboard I/O area, so I reckon the
saving trying to do it bit by bit wouldn't really be worth the extra
complication.

>> These are all 2.2.x, no? I believe I need 2.[34].x because I want to use
>> the latest RT-Linux stuff eventually, which only works with the 2.3.x, or
>> later, kernels.
>
>Yes, but 2.4.xx doesn't work right now.

I know, I have been tracking it, but it doesn't seem to be getting much
better.

>I am trying to get that working among other things.

I too am trying various things (but its not a priority at the moment).

>You have to back up to a much older
>version of 2.3.xx if you want to use this baseline right now.

Yep, I have done that - I backed up to October 1999 and it works. I could
try later versions, but each attempt is fairly arduous and I have one that
works, so I didn't bother.

Now back to my original post - updating the TWB: here is the relevant
code in include/asm-ppc/mmu_context.h:

	/*
	 * After we have set current->mm to a new value, this activates
	 * the context for the new mm so we see the new mappings.
	 */
	static inline void activate_mm(struct mm_struct *active_mm, struct mm_struct *mm)
	{
		current->thread.pgdir = mm->pgd;
		get_mmu_context(mm);
		set_context(mm->context);
	}

I believe it is wrong to change current->thread.pgdir, without mirroring
that change in the MMU TWB register. This is the gist of my (long winded?)
first posting. Is this true or not?

Similarly, this code:

	static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
				     struct task_struct *tsk, int cpu)
	{
		tsk->thread.pgdir = next->pgd;
		get_mmu_context(next);
		set_context(next->context);
	}

Surely:

	1. the set_context() should not be done, unless (tsk == current)
	   is true;

	2. if (tsk == current) is true, then the TWB should be updated
	   with the contents of tsk->thread.pgdir.

However, in this second case, switch_mm() is only called inside _switch()
(as far as I can see) and therefore the TWB will be updated anyway when the
task switch happens, so this second case is not that important (other than
the case when someone thinks "oh, all I have to do here is call switch_mm()
and that will save me a lot of work" but instead all hell breaks lose because
the code isn't right).

But I believe the first case will cause problems. In an exec, a new mm context
is created, and the current one is destroyed (after copying arguments and
environment etc). It looks to me like this is done using activate_mm() i.e.
the new mm context is activated using this function (makes sense - no point
creating a whole new task, just use the one we have - this is the entire point
of exec). But the call is not happening inside _switch() as with the other
case and so it will only be fluke if the TWB maintains the correct value (e.g.
maybe a task switch occurs before any damage happens in all but the most
exceptional circumstances).

I would like to hear people's opinions on this.

Finally, is the "Wrath of Dan" some sort of juvenile initiation right that
all new members of the elite "Linux/PPC Embedded" gang have to go through?
Twice now you have treated me with contempt or in a condescending way. I
should be able to ignore it, because *I know* that I have some skill in this
area (I was hacking drivers for 4.2BSD on a VAX 15 years ago), but others
might be put off by your attitude and open development in this area might
suffer as a result. Please try to accept this as constructive criticism
(despite my sarcastic crack above - as Maxwell Smart would say, "I hope I
wasn't outta-line with that crack about the gang" :-). I want to learn from
you and others, and I hope I will be able to give some knowledge/experience
back. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
