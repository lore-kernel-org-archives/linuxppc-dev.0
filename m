Date: Wed, 4 Aug 1999 10:29:05 +1000
Message-Id: <199908040029.KAA08994@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Andrew_Klosterman@3com.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <882567C2.008325F6.00@hqoutbound.ops.3com.com>
	(Andrew_Klosterman@3com.com)
Subject: Re: PPC kernel bootstrapping and relocation
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <882567C2.008325F6.00@hqoutbound.ops.3com.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew_Klosterman@3com.com wrote:

> 1. What is the rationale behind the address at which the kernel should be
> compiled?  There is the KERNELLOAD value defined in /arch/ppc/Makefile that is
> set to 0xc000_0000 as well as a value in /include/asm-ppc/page.h that defines
> PAGE_OFFSET and KERNELBASE to 0xc000_0000.  KERNELLOAD is used as the text
> linkage address for the kernel, but the kernel gets relocated during the boot
> process.

The idea is that virtual addresses (what IBM calls logical addresses)
from 0 to 0xbfffffff are available to user programs (actually at the
moment only up to 0x7fffffff, but that can easily be changed) and
0xc0000000 to 0xffffffff are used by the kernel.  The kernel sits at
the beginning of this area.  In addition, all of physical RAM is
mapped in contiguously starting at 0xc0000000.

> 2. Is the kernel supposed to run at 0 or at 0xc000_0000?  Sure it gets compiled
> for 0xc000_0000, but then it gets copied down to zero by relocate_kernel in
> /arch/ppc/kernel/head.S.

The kernel runs at physical address 0 and virtual address 0xc0000000.
That copy runs with the MMU off.

> 3. Do the BATs do the necessary translation of addresses while the kernel is
> starting/running (wherever it end up executing at)?  I haven't quite sorted out
> the way that memory ends up for the running kernel because I haven't yet managed
> to get the kernel running yet.  :)

We use 1 or 2 BATs to set up the mapping of physical memory into the
kernel address space.  The other 2 BATs are available for mapping I/O
or frame buffers.

> 4. Ultimately, what is the view of memory that the BATs set up for the kernel?
> (This leads in to point #5.)

Have a look in arch/ppc/init/mm.c:MMU_init() and mapin_ram().  What
I/O is mapped depends on the architecture.

> 5. How can I exclude the kernel from using certain memory regions?  I have some
> special memory areas to worry about that other hardware on this board needs.
> Therefore, I need to be able to exclude some memory ranges from use by the
> kernel.  Any hints?

I assume you are talking about physical addresses.  Basically the
kernel doesn't access any physical addresses (apart from RAM) unless a
driver or some architecture-dependent code maps them in with ioremap()
or setbat().

> 6. What sort of environment is the kernel expecting to be starting from?  What
> are the default settings for the memory architecture (BATs) that is expected?  I
> still have to deal with the peculiarities of this particular board, but I can
> have my own boot code set things up to a more standard configuration before
> passing jumping to the kernel start.

The kernel expects to start with the kernel loaded into a
physically-contiguous region somewhere in memory (it doesn't matter
where).  It expects some values in r3 - r7 depending on how it was
started, e.g., if it was started from Open Firmware, then r5 contains
the entry point for OF client calls.  The MMU can be either on or off.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
