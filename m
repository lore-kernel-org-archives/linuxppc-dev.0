Date: Tue, 31 Oct 2000 18:20:08 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com.au
Subject: Re: 2.2.18pre17 again
In-Reply-To: <19340925082028.17042@192.168.1.2>
Message-ID: <Pine.HPX.4.10.10010311722330.15431-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 31 Oct 2000, Benjamin Herrenschmidt wrote:

> >
> >Why isn't udelay based on the timebase then ? Easy to scale
> >microseconds to timebase.
>
> Because you didn't implement it yet ? :)

Perhaps...

>
> >There is a multiplier for mulhwu somewhere in a global variable, I should
> >remember the name since I wrote the code, tb_to_us if I'm not messing up.
>
> Do we have that code in 2.2 ? Your time management patches are in 2.4
> only AFAIK (nice code BTW).

Well, maybe. I'm sure they are in my local 2.2 tree, which is still at
2.2.12, because I absolutely needed them for production: otherwise clocks
were drifting randomly by up to several milliseconds even when controlled
by NTP. In my case a clock off by 5 milliseconds is basically the same as
no clock ;-)

> >It needs some care for 601 because of the different registers (RTC) that
> >has the bad habit of jumping from 1e9 to 0. It is trivial to implement as
> >a subroutine and check for CPU inside the subroutine. After all it's a
> >delay, so performance should not be critical.
> >
> >udelay:
> >	lis	r4,tb_to_us@ha
> >	mfpvr	r5
> >	lwz	r4,tb_to_us@l(r4)
> >	srwi	r5,r5,16
> >	mulhwu	r4,r3,r4
> >	cmpwi	cr0,r5,1
> >	beq	2f
> >	mftbl	r5
> >1:	mftbl	r3
> >	sub	r3,r3,r5
> >	cmplw	cr0,r3,r4	# works for delays of up to almost 2^32 tb ticks
> >	blt	cr0,1b
> >	blr
> >
> >2:	mfrtcl	r5
> >3:	mfrtcl	r3
> >	sub.	r3,r3,r5	# if wraparound has occurred
> >	bnl+	4f		# bump elapsed time by one second
> >	addis	r3,r3,1000000000@ha
> >	addi	r3,r3,1000000000@l
> >4:	cmplw	cr0,r3,r4	# works for delays of up to almost 1 second
> >	blt	cr0,3b
> >	blr
> >
>
> What is the max delay supported ? I beleive we should implement it as
> __udelay and keept the macro mecanism to catch too high delays.

It's in the comments: 1 second for 601, 2^32 timebase ticks for the other
(minus maximum interrupt + bh running time if interrupts are enabled).

Catching too long delays in the macros is ok, but the code can also catch
it at runtime since it's only a few instructions in the subroutine:

	andis. r0,r3,0xfffe; bne- what_are_you_smoking

will limit the udelay constant to about 0.13 second (131072 microseconds
to be exact). Of course at what_are_you_smoking the kernel starts a
complex process to find the author of the offending code and fulminate
him/her ;-): udelay values above a few hundred are almost always the
result of laziness or careless programming.

Even with a 33 MHz timebase (keep dreaming), the maximal delay for non
601 CPUs is over 100 seconds. However, there is one problem if we start
having preemptible kernels, especially for 601: a preempted udelay
could be lengthened by multiples of 1 second. There is a solution to this
problem, but it requires reading the rtcu and doing all the math on every
iteration. I just did not feel like writing it, especially since I
can't test it. Put a big warning in a comment if necessary. It should also
be properly ifdefed so that when CONFIG_6XX is off, the 601 check and code
is removed.

	Gabriel.

BTW: is anybody interested in high resolution timers ? (Higher resolution
than one jiffy I mean). It should be relatively easy now that timing code
is cleaned up. But I won't have time to look at it for a few weeks...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
