To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Using sys_sendto() in Kernel instead of sendto() in app 
In-reply-to: Your message of "Mon, 11 Nov 2002 11:18:46 -0500"
             <01C28974.1A34BA30.svacca@valcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 12 Nov 2002 10:39:15 +1100
Message-ID: <27136.1037057955@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 11 Nov 2002 11:18:46 -0500, Steven Vacca <svacca@valcom.com> writes:
>Could I have some guidance on using sendto()'s (sys_sendto()'s)
>from within the kernel?

The first thing is to make sure that the kernel knows that you are making
the call from kernel space and not user space. Here is what I do in my driver:

	mm_segment_t fs;

	...

	fs = get_fs();
	set_fs(get_ds());

	... make system call ...

	set_fs(fs);

	...

This stuff is a hangover from x86 Linux - on ppc they are trivial macros -
but you still have to do it (and who knows, maybe your driver will be portable
to x86 one day?).

Secondly, you can't just call the sys_...() function - you still have to go
through the system call mechanism after doing the above (please anyone out
there - correct me if I'm wrong about this) - this requires a bit of assembly,
for which there are support macros. e.g. my driver calls the sched_setscheduler
system call - here is how I do it:

static int errno; /* this should be exported by the kernel */

static inline _syscall3(int, sched_setscheduler, \
    pid_t, pid, int, policy, struct sched_param *, param)

(note no semi-colon on the end - although it probably wouldn't hurt - haven't
thought about it - but it makes clear that it isn't your usual function decl)
after which I can just call

	struct sched_param sp;

	...

	if (sched_setscheduler(0, SCHED_FIFO, &sp) < 0) {
		...

I don't think the declaration of errno would be necessary if my driver was
not a module (errno should be exported by the kernel so that loadable
modules can see it).

The third thing is to make sure you do all your stuff from within a process
context, not interrupt context. This usually means having a (perhaps high
priority) kernel task which you wake up with a semaphore from the interrupt
handler (which is what I do), or else using tasklets etc. The important thing
is that you can't do much from within the actual ISR, other than poking
registers or whatever, to acknowledge the interrupt. The real work is done
elsewhere.

Apologies if you knew all this already (I couldn't tell from your post).
Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
