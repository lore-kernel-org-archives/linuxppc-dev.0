Message-ID: <37A801BD.52B2BD85@agelectronics.co.uk>
Date: Wed, 04 Aug 1999 10:02:53 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Andrew_Klosterman@3com.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC kernel bootstrapping and relocation
References: <882567C2.008325F6.00@hqoutbound.ops.3com.com> <199908040029.KAA08994@tango.anu.edu.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here's a few more notes from my recent explorations of this subject.
This is actually one of the trickier bits in ports to non PREP/CHRP
machines.

Paul Mackerras wrote:
> Andrew_Klosterman@3com.com wrote:
> > 2. Is the kernel supposed to run at 0 or at 0xc000_0000?  Sure it gets compiled
> > for 0xc000_0000, but then it gets copied down to zero by relocate_kernel in
> > /arch/ppc/kernel/head.S.
> The kernel runs at physical address 0 and virtual address 0xc0000000.
> That copy runs with the MMU off.

Note that in a lot of cases, no actual copying will occur. Copying only
happens when your bootstrap was unable to load the code to physical
address 0.

> > 3. Do the BATs do the necessary translation of addresses while the kernel is
> > starting/running (wherever it end up executing at)?  I haven't quite sorted out
> > the way that memory ends up for the running kernel because I haven't yet managed
> > to get the kernel running yet.  :)
> We use 1 or 2 BATs to set up the mapping of physical memory into the
> kernel address space.  The other 2 BATs are available for mapping I/O
> or frame buffers.

This is a bit more tricky than that. The kernel start up code in head.S
will clobber DBATs 0-2 before it calls MMU_init(). In particular, this
may stop you accessing any memory mapped IO until MMU_init() has
finished. Make your bootloader read any interesting configuration
values, and store them somewhere in memory. Then you'll be able to avoid
modifying head.S. Adding machine specific code to head.S will just make
it even harder to read.

In particular, the kernel will call prom_init() in this state. You will
have to modify prom_init() to return instantly unless you actually do
have open firmware. My trick is to make the bootloader load a code to
identify my board into r3, and add another check next to the APUS check
in prom_init().

> > 4. Ultimately, what is the view of memory that the BATs set up for the kernel?
> > (This leads in to point #5.)
> Have a look in arch/ppc/init/mm.c:MMU_init() and mapin_ram().  What
> I/O is mapped depends on the architecture.

MMU_init() is the key. You'll have to add yet another machine specific
portion to MMU_init(), where at least it will be in good company. In
general, physical memory is mapped starting at 0xc0000000. You should
then map any fixed IO devices which use BATs somewhere at the top of the
address space. ioremap() will then use the free space between the end of
the kernel mapping and your fixed devices.

> > 5. How can I exclude the kernel from using certain memory regions?  I have some
> > special memory areas to worry about that other hardware on this board needs.
> > Therefore, I need to be able to exclude some memory ranges from use by the
> > kernel.  Any hints?
> I assume you are talking about physical addresses.  Basically the
> kernel doesn't access any physical addresses (apart from RAM) unless a
> driver or some architecture-dependent code maps them in with ioremap()
> or setbat().

If you're talking about making holes in your RAM, which you can access
without page faults, but won't be added to the free page list, use one
of the xxx_find_end_of_memory() functions as a template. What you need
to do is to first create a mapping for all your memory:
	append_mem_piece(&phys_mem, 0, top);
Then remove bits that can't be used as free pages:
	/* Remove kernel from view */
	kstart = __pa(_stext);	/* should be 0 */
	ksize = PAGE_ALIGN(_end - _stext);
	remove_mem_piece(&phys_avail, kstart, ksize, 1);  
        remove_mem_piece(&phys_avail, my_buffer_base, my_buffer_size,
1);

> > 6. What sort of environment is the kernel expecting to be starting from?  What
> > are the default settings for the memory architecture (BATs) that is expected?  I
> > still have to deal with the peculiarities of this particular board, but I can
> > have my own boot code set things up to a more standard configuration before
> > passing jumping to the kernel start.
> The kernel expects to start with the kernel loaded into a
> physically-contiguous region somewhere in memory (it doesn't matter
> where).  It expects some values in r3 - r7 depending on how it was
> started, e.g., if it was started from Open Firmware, then r5 contains
> the entry point for OF client calls.  The MMU can be either on or off.

And set r1 to point to a sensible location for an initial stack.

- Adrian Cox, AG Electronics

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
