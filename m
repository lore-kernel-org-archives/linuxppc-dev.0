Date: Sat, 21 Apr 2001 21:37:38 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Samuel Rydh <samuel@ibrium.se>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] gettimeofday stability
In-Reply-To: <20010421201602.B1115@ibrium.se>
Message-ID: <Pine.HPX.4.10.10104211923230.2724-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 21 Apr 2001, Samuel Rydh wrote:

> > Don't tell me that you fix the TB on each interrupt, please.
>
> The MOL user process runs in two modes, mac-mode and normal mode.
> In mac-mode, the MOL module is in full control of the CPU (including
> the MMU, DEC and the TB). When an interrupt occurs (or in general,
> a non-MOL exception), everything is restored to what linux expects
> before the exception is taken.

Ouch !!! Playing with the TB on each interrupt (external/decrementer) and
syscall too (don't forget that filesystems will call do_gettimeofday()
for timestamps) ?

> That is, TB is restored whenever an interrupt occurs in mac-mode.
> The TB will estimately loose 0-2 ticks at each switch
> (depending on the exact moment the clock happens to tick).

Well, this may mean thousands of time per second, it's bad. Anything which
can cause cumulative errors is not acceptable. It will badly interfere
with NTP for sure, especially if you have bursts of activity in MOL.

So I'd like to sugest a different solution, it will need an additional
(perhaps per CPU) global variable, that I shall call tb_error. I'll
assume that what you wnat to do is to bump the TB forward or backwards by
a given 64 bit offset (let us ignore the 601 for now, please :-)).

When interrupts are masked tbl+dec is constant and this fact can be used
to avoid cumulative errors:

1:	mftbl 	y
	mfdec 	x
	mftbl 	z		# low 32 bit of timestamp
	cmpw	y,z
	bne-	1b
	mftbu	y
	mftbl	t
	add	x,x,z
	subf	x,tb_error,x	# Theoretical current sum
	subfc	t,z,t		# This carry manipulation
	addme	y,y		# needs to be checked!
	subfc	z,tb_error,z
	subfze	y,y
# Now y,z is a corrected 64 bit timestamp, and x is a time independent
# constant betwen decrementer interrupts.
	addc	z,z,offsetl	# Bump the timebase and store it.
	adde	y,y,offsetu
	li	t,0		# This avoids an accidental carry into
	mttbl	t		# the MSW between mttbu and the second
	mttbu	y		# mttbl.
	mttbl	z
# Let us measure again the error
2:	mftbl	z		# The new tbl+dec constant should have
	mfdec	y		# been bumped by offsetl. But we can
	mftbl	t		# measure the error, save it and use it
	cmpw	t,z		# at the next timebase adjustment to
	bne-	2b		# avoid cumulative errors.
	add	y,y,z		# New constant
	subf	x,y,x		# Difference with old constant
	subf	new_tb_error,offsetl,x
# save new_tb_error for the next invocation

I think the mftb+mfdec+mftb loop will always work even on the slowest
processors, because mftb and mfdec are rather fast and it is comparable
to the recommended mftbl/mftbu/mftbl sequence used to read the full
timebase.

Of course the existence of the 601 will complicate the code (better write
a different routine, modulo 1e9 arithmetic will be a nightmare). But that
solution should not have _any_ cumulative error, which are _evil_ and the
only thing I care about (RTLinux folks might disagree, but then don't mix
RTLinux and MOL :-)).

Warning: untested, I just wrote it as is on the fly and that's assembly
(but with all the carry manipulations and privileged instructions, I have
the feeling that C would be even less readable ;-)).

Possible interface to this routine:

	tb_error = bump_tb(long long offset, int tb_error)

you just have to assign registers according to the standard API :-)

To test it a series of:
	tb_error = bump_tb(offset, tb_error);
	tb_error = bump_tb(-offset, tb_error);

(with interrupts disabled, using a small offset to avoid disrupting the
system) should never give large values for tb_error and the time should
not start drifting away. Actually tb_error should be a small negative
integer (or zero), which will vary depending on whether the i-cache is hot
or not when this code is executed. A small constant offset (well below one
microsecond) is no problem for timekeeping.

> Currently, MOL does not run on SMP due to certain MMU related
> complications. Much has been done here though, and only minor
> fixes should be needed in order to get MOL running on
> SMP.
>
> In any case, MOL won't touch TB on SMP since that would
> desynchronize the timebases which is clearly unacceptable.

If the technique I suggest turns out to work (a big if), it should make it
acceptable even on SMP :-)

> Currently this means that the save-session feature will
> not be available. But as I said, I'll investigate if it is
> possible to locate and patch out all mftb instructions
> in MacOS.

Maybe it's not even necessary... And don't forget that some applications
might also use mftb, or libraries, extensions, whatever...

However, I still think that switching the tb at each interrupt may be
overkill: we have control of who uses mftb in the kernel. I'm not 100%
sure, but it is possible that keeping a global (per processor on SMP)
variable which would be the low order 32 bits of (offset+tb_error) and
subtracting it from the mftb result whenever the tb is read would make
modifying the timebase only necessary on context switches.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
