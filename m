Message-Id: <v04003a00b44016e13b4c@[216.81.20.101]>
In-Reply-To: <Pine.HPX.4.10.9910291404240.18743-100000@gra-ux1.iram.es>
References: <v04003a00b43e690932c6@[216.81.26.227]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 29 Oct 1999 23:14:19 -0500
To: Gabriel Paubert <paubert@iram.es>
From: Tony Mantler <eek@escape.ca>
Subject: Re: question about altivec registers
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:49 AM -0500 10/29/99, Gabriel Paubert wrote:
>On Thu, 28 Oct 1999, Tony Mantler wrote:
>
>> I suppose I'm a bit too used to 68k stuff, where sorting register usage
>> takes a back seat to efficient register re-use. However, with the size of
>> the data in the Altivec registers, I would expect a bit of optimization to
>> slant away from cases where the registers can be easily sorted and packed.
>
>Things are different when all registers are identical and instructions
>have separate operands for inputs and the output. I've programmed 68k to
>and it's often painful (Intel is worse, to be fair).

I haven't found it too bad. It's rather sensibly designed for it's intended
applications, and considering that it was originally laid out way back in
the early 80's (iirc), it's stood the test of time rather well.


[...]
>> I think saving registers in a subroutine is a pain no matter how it's
>> implemented. If the VRSAVE is used as a count, the subroutine still has to
>> save the old value, save the overwritten registers, calculate what the
>> proper new value is (think new < old = oops!) then restore the overwritten
>> registers and old VRSAVE value when it exits.
>
>In the end a bitmap seems the best, since the code can be free of
>conditionals and fairly compact:
>- at start of routine (register numbers chosen randomly):
>	mfspr	r12,vrsave
>	oris	r0,r12,0x....	# mask of used bits
>	ori	r0,r0,0x....	# mask of used bits (only is using vr16-vr31)
>	stw	r12,somewhere on the stack
>	mtspr	vrsave,r0
>
>and the end:
>	lwz	r12,somewhere on the stack
>	mtspr	vrsave,r12

Looks clean enough to me.


[...]
>Yes, cntlzw on a vrsave copy (after a few simple manipulations) is your
>friend. Besides this the ABI separates two ranges: R0 to R13 and R14
>to R31 (I could be off by one). Optimize for the common case, find the
>first set bit with index >=14 and last set bit with index <=13 and save
>only these 2 ranges. Optimizing for more complex cases is not worth the
>trouble, just ensure that they work properly.

Indeed.


>> Doing it that way would also somewhat optimize VRSAVE=0, since both the
>> leftmost and rightmost bits are 0, it would pass right through the
>> left-save and right-save half of the optimized register save.
>
>I would also optimize speecifically for the vrsave=0, a compare and a
>conditional branch are not that costly, especially if the branch is done
>well after the branch, with all the bitmap manipulation in between:
>
>	mfspr	r3,vrsave
>	cpmwi	cr1,r3,0
>	andis.	r4,r3,0,0xfffc
>	rlwinm	r5,r3,0,0x0003ffff
>	neg	r6,r4
>	cntlzw	r5,r5		# first register of r14..r31 to save
>	and	r4,r4,r6
>	cntlzw	r4,r4		# last register of r0..r13 to save
>	beq	cr1,nothing_to_save
>
>It's not finished: you've to setup registers to addres the save area and
>compute a branch inside the save routine to actually perform the save
>(backwards for r0..r13, forwards for r14..r31).

Yeah, one extra branch certainly won't kill anyone.


[.. clearing unused registers ..]
>Well, after having a moore detailed look at Altivec, I missed a shift
>by immdieate amount in bits to make the code as compact as possible. There
>are probably tricks to work around this, I might have started with the
>wrong idea on the way to implement this...

Hmm, I just re-read the altivec spec sheet and, though I wouldn't call
myself an expert on PPC, it would seem that there's 3 ways to clear the
registers.

The first way would be to use a bunch of branch conditionals, which we
probably want to avoid.

The second way would be to calculate a 0 or -1 entirely within the vector
unit, which would both use a bunch of vector registers, and probably be
rather messy, as it's not really what the vector unit is designed for.

The third would be to calculate a 0 or -1 in the GPRs, then copy and splat
it into a vector register. Unfortunaltey it would appear that copying a
value from a GPR to a Vector register can only be done by writing the value
to memory, then reading it back in again, which isn't very pretty at all.


Oh well, time to watch Southpark, filmed in hella-cool ((( Spooooky-vision
))) ;)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
