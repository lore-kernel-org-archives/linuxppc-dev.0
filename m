Date: Sun, 13 Dec 1998 18:05:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dmalek@jlc.net>
cc: "Guy G. Sotomayor, Jr." <ggs@shiresoft.com>,
        Cort Dougan <cort@persephone.cs.nmt.edu>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
In-Reply-To: <36700A9F.C1C99794@jlc.net>
Message-ID: <Pine.HPP.3.96.981213172728.17076D-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 10 Dec 1998, Dan Malek wrote:

> 
> Guy G. Sotomayor, Jr. wrote:
> 
> > Umm, but why are you keeping track of time with the decrementer?
> 
> Because that is the way it was done when I first looked at the kernel
> a long time ago :-).
> 
> 
> > .....use the timebase to keep track of time and the decrementer
> > to deliver periodic interrupts?
> 
> Excellent idea.  I have started to implement this on an MPC8xx board,
> so I will let everyone know the results pretty quickly.
> 
> It appears the TB is part of every PPC core.  If anyone knows different
> please let me know.

Yes, the problem is the good old 601. The TB uses different register
numbers (it's called the RTC, split into RTCU and RTCL like TBU and TBL).
Register numbers are 20(RTCU)/21(RTCL), they can also be read from user
mode as registers 4 and 5. 

However, the most troublesome characteritice of the 601 timebase is that
the RTCL overflows at 1 billion exactly (it virtually counts in
nanoseconds), in such a way that the RTCU is incremented by 1 every
second. This is not a straight binary 64 bit counter. It can be
transformed into one, however:

1:	mfrtcu	r3
	mfrtcl	r4
	mfrtcu	r5
	cmpw	r3,r5
	bne	1b
	lis	r5,(1000000000/64)>>16
	addi	r5,r5,(1000000000/64)&0xffff
	mullw   r6,r3,r5
	mulhwu  r3,r3,r5
	srwi    r4,r4,6
	addc    r4,r4,r6
	addze   r3,r3

returns the equivalent of a 64 bit (not exactly, since the 8 MSB will
always be zero) timebase with 64nsec resolution, almost equivalent to
what most processors give with 66MHz buses (60nS resolution).
If you only need the 32 LSB, you can even simplify it, replace the last
five instructions with:

	mullw   r3,r3,r5
	srwi	r4,r4,6
	add	r3,r3,r4


According to my 601 doc, the RTC input is a 7.8125 MHz clock, which
increases by one count every 128 nS, the 7 LSB are always zero and you
can't lose any precision by shifting right the RTCL value by 6 as I
suggest. High 601 speed grades might have a clock at a higher rate (15.625
or 31.25 MHz), I don't know but it would be required to fulfill the
following condition "enough bits are implemented to provide a resolution
that is finer than the time required to execute 10 Add Immediate (addi)
instructions".

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
