Subject: Kernel profiling patch for PPC architecture now available
To: linuxppc-dev@lists.linuxppc.org (Linux PowerPC developers mailing list)
Date: Wed, 16 Aug 2000 15:55:06 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000816055506.E058450510@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Yesterday, I asked:
> ... kernel profiling doesn't appear to be implemented for the ppc
> architecture in the standard 2.2 or 2.4 kernels. Has anyone done any work on
> this, or is anyone aware of any patches to add this functionality to the ppc
> subtree?

Well, the deafening silence told me that the answer was no, so now I've done
it, and I'd be very grateful for any feedback you might have.  The patch is
available at:
    http://members.xoom.com/greyhams/linux/patches/2.2/profile.patch

And here's the header to whet the appetite:

/proc/profile support for ppc & arm in 2.2		Updated: 16 August 2000
------------------------------------------		-----------------------

The following patch adds /proc/profile kernel profiling support in the Linux
2.2 series kernel to those architectures that currently lack it.  Previously,
ppc and arm had fallen through the cracks and didn't support this, so the info
in /proc/profile was always zeros.

Kernel profiling works like this: each timer interrupt calls the do_profile
function, and if the interrupt occurs during kernel code it increments a
counter for each range of addresses.  Profiling is enabled by the "profile="
option on the kernel command line, which also sets the granularity of data
collected.  The smaller the number, the finer the grain of data collected, and
the more memory required for the data buffer.  The user-space program
"readprofile" then reads the profiling data from /proc/profile, and displays
the data against kernel symbols read from System.map.  Modules don't get
profiled, sorry.

In the interest of reducing duplication, this patch hauls all the divergent
do_profile implementations out from those architectures that did support it,
and puts it in linux/sched.h where all architectures can see it.

I think the call to do_profile might be better moved to the architecture
independent do_timer routine, to ensure that all new architectures also
support profiling and prevent the problem which motivated this patch
recurring.  However, I'm not sure if this is correct for SMP machines and at
least one architecture (sparc/ap1000) uses a seperate hardware tick other
than the system timer to do profiling.

I don't know how well this works for SMP kernels, but it shouldn't be any
worse than it was before.  I can't see why write_profile only adjusts the
profiling timer on SMP machines in fs/proc/array.c; perhaps the #ifdef test
is backwards?

mips & sparc architectures had a CONFIG_PROFILE macro, but I couldn't see any
definition of it, so I removed it.  Perhaps I should add
architecture-independent support for it in include/linux/sched.h?

Note that other people are working on adding full _mcount-based gprof
profiling to the kernel, but generally only for the i386 architecture.  I'm
not planning on going to that extreme.  For examples, see:
     http://oss.sgi.com/projects/kernprof/
     ftp://ftp.suse.com/pub/people/andrea/kernel-patches/ikd/

I'm very keen to hear from anyone willing to give this a try, even on
architectures that already supported /proc/profile, just to make sure I didn't
break anything.  I'll follow up with a 2.4 patch once this has been tested.

Please let me know what you think!
--
Graham Stoney
greyham@research.canon.com.au

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
