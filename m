Message-Id: <4.2.2.20000302111129.00a638d0@mail.kerbango.com>
Date: Thu, 02 Mar 2000 12:20:03 -0800
To: linuxppc-embedded@lists.linuxppc.org
From: Steve Calfee <calfee@kerbango.com>
Subject: commproc.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I have been working on doing a 823 USB driver. It is my first driver for
Linux, and generally I am impressed with the ease of adding a driver and
with modules in general. Documentation and examples of how to do simple
programming is weak. The "Linux Device Drivers" book is good, but mostly
obsolete for people working for 2.2.x and beyond kernels. At least with the
kernel source it is possible to figure stuff out, but not easy. We are
using a relatively stable kernel v2.2.5 for the MPC823.

In the interest of improving the 823 implementation, I have some comments
on commproc.c. I tried to download the latest kernel source, but the ftp
sites wont let me in anonymously, so if someone has already addressed these
things in later versions, nevermind.... How do I get the latest kernel sources?


/* Allocate some memory from the dual ported ram.  We may want to
  * enforce alignment restrictions, but right now everyone is a good
  * citizen.
  */
uint
m8xx_cpm_dpalloc(uint size)
{
	uint	retloc;
	if ((dp_alloc_base + size) >= dp_alloc_top)
		return(CPM_DP_NOSPACE);
	retloc = dp_alloc_base;
	dp_alloc_base += size;
	return(retloc);
}

This is a primitive routine to allocate CPM memory. It allocates size bytes
of CPM memory. Even a good citizen that lives by the CPM imposed
constraints of alignment (usually on a 8 byte boundary, but sometimes up to
on a 32 byte boundary), needs help with getting properly aligned memory.
The only way is to get more than you need and then adjust the pointer to be
aligned. It needs to maintain a main memory data structure for memory
allocations. We also need a m8xx_cpm_free() function to give back CPM
memory when we are done. This is especially the case for kernel drivers,
once I insmod and rmmod a few times, I run out of CPM memory and have to
reboot.

/* CPM interrupt controller interrupt.
*/
static	void
cpm_interrupt(int irq, void * dev, struct pt_regs * regs)
{
	uint	vec;
	/* Get the vector by setting the ACK bit and then reading
	 * the register.
	 */
	((volatile immap_t *)IMAP_ADDR)->im_cpic.cpic_civr = 1;
	vec = ((volatile immap_t *)IMAP_ADDR)->im_cpic.cpic_civr;
	vec >>= 11;
	if (cpm_vecs[vec].handler != 0)
		(*cpm_vecs[vec].handler)(cpm_vecs[vec].dev_id);
	else
		((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr &= ~(1 << vec);
	/* After servicing the interrupt, we have to remove the status
	 * indicator.
	 */
	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cisr |= (1 << vec);

}

Above is the interrupt routine, called by the main PPC interrupt routine.
Note that the caller regs are not passed to the user installed cpm
interrupt routine. I agree that it is a rare use, but if I want to
backtrace the interrupted stack from my interrupt routine for profiling or
finding someone who shuts interrupts of for too long, it is necessary.
Changing the user interrupt routine calls to include the regs will affect
all existing cpm interrupt routines though...






A GOOFY IDEA to make Linux run realtime:

I have done some timings using the hardware timers. It takes a minimum of
about 3000 cpu cycles to get to my interrupt routine, sometimes up to 12000
cycles, and if NFS is running it can be 40000 cycles. This makes it tough
to do some timing critical stuff, like USB frame timing in software. I
realize that Linux is not a real time operating system, but this is the
embedded group, so better real time response should be a legitimate desire.
I looked at RTLinux, but it seems to be a hack, where another realtime OS
is run under Linux which is another task of the realtime system. This seems
kind of overkill, when all you need is real time interrupts and a way to
communicate with the regular Linux tasks.

The one good idea in RTLinux is the idea to redefine CLI(); to not shut off
interrupts, just tell the realtime system that the Linux kernel should not
be reentered. Right now CLI() clears the EA bit on the 823 ppc. What
exactly is an external interrupt? presumably it is all CPM interrupts, but
what about the Decrementer or timebase interrrupt, are they external? The
823 manual, while huge, does not communicate information well.

Anyway, what if we redefined CLI to be saveregs, and then clear all but a
system wide mask of the CPM interrupts in ((immap_t
*)IMAP_ADDR)->im_cpic.cpic_cimr (from above). This would still allow
interrupts that were requested in the mask to occur even though the kernel
has requested all ints off. These realtime interrupts would NOT be allowed
to call system functions or data structures, and could only communicate
with Linux tasks via common memory areas. Restructuring the system
interrupt entry routines to minimize overhead with such things as remapping
virtual memory to physical etc would be required.

This scheme would impose more restrictions on interrupt routine writers,
but it would make realtime interrupts possible.

Steve Calfee	--	embedded systems consultant
calfee@home.com
Kerbango phone: (408) 517-3355
home office ph: (510) 657-6039

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
