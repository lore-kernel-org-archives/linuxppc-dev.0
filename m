Date: Fri, 29 Oct 1999 14:49:22 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Tony Mantler <eek@escape.ca>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <v04003a00b43e690932c6@[216.81.26.227]>
Message-ID: <Pine.HPX.4.10.9910291404240.18743-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 28 Oct 1999, Tony Mantler wrote:

> I suppose I'm a bit too used to 68k stuff, where sorting register usage
> takes a back seat to efficient register re-use. However, with the size of
> the data in the Altivec registers, I would expect a bit of optimization to
> slant away from cases where the registers can be easily sorted and packed.

Things are different when all registers are identical and instructions
have separate operands for inputs and the output. I've programmed 68k to
and it's often painful (Intel is worse, to be fair). 

> >There is also a problem of knowing how to update the bitmap in nested
> >subroutines: to keep it correct the called subroutine must save the
> >current vrsave and then or it with the bitmask of the registers it uses.
> >Then on exit it has to restore caller's vrsave. Do we want such a complex
> >strategy ? I don't mean that it is impossible to implement, but that it
> >looks complex.
> 
> I think saving registers in a subroutine is a pain no matter how it's
> implemented. If the VRSAVE is used as a count, the subroutine still has to
> save the old value, save the overwritten registers, calculate what the
> proper new value is (think new < old = oops!) then restore the overwritten
> registers and old VRSAVE value when it exits.

In the end a bitmap seems the best, since the code can be free of
conditionals and fairly compact:
- at start of routine (register numbers chosen randomly):
	mfspr	r12,vrsave 
	oris	r0,r12,0x....	# mask of used bits
	ori	r0,r0,0x....	# mask of used bits (only is using vr16-vr31)
	stw	r12,somewhere on the stack
	mtspr	vrsave,r0

and the end:
	lwz	r12,somewhere on the stack
	mtspr	vrsave,r12

> >OTOH, if the register usage is designed similarly to integer and FP, the
> >bitmask might look like 111...1100...0011...11 (i.e. with at most 2
> >transitions between 0 and 1 in the bit string). It might be worth
> >optimizing the save/restore routine for this case, saving/restoring more
> >registers than necessary when vrsave does not have such a canonical form.
> 
> Hmm, count bits in from the left and right, mask and check for missed bits,
> then branch to either a full save or a left+right save.

Yes, cntlzw on a vrsave copy (after a few simple manipulations) is your
friend. Besides this the ABI separates two ranges: R0 to R13 and R14
to R31 (I could be off by one). Optimize for the common case, find the
first set bit with index >=14 and last set bit with index <=13 and save
only these 2 ranges. Optimizing for more complex cases is not worth the
trouble, just ensure that they work properly. 

> Doing it that way would also somewhat optimize VRSAVE=0, since both the
> leftmost and rightmost bits are 0, it would pass right through the
> left-save and right-save half of the optimized register save.

I would also optimize speecifically for the vrsave=0, a compare and a
conditional branch are not that costly, especially if the branch is done
well after the branch, with all the bitmap manipulation in between: 

	mfspr	r3,vrsave
	cpmwi	cr1,r3,0
	andis.	r4,r3,0,0xfffc
	rlwinm	r5,r3,0,0x0003ffff
	neg	r6,r4
	cntlzw	r5,r5		# first register of r14..r31 to save
	and	r4,r4,r6
	cntlzw	r4,r4		# last register of r0..r13 to save
	beq	cr1,nothing_to_save	

It's not finished: you've to setup registers to addres the save area and
compute a branch inside the save routine to actually perform the save
(backwards for r0..r13, forwards for r14..r31). 

> Perhaps a little longer than "if (VRSAVE==0) return;", but it's quick
> enough for me.

Probably close to optimal, lazy enough without trying to be too smart
and executing tons of code as the result. Never forget that this code
is unlikely to be found in L1 icache. 

> >Indeed, I had not considered this problem. Note that conditional clearing
> >of most registers can probably be done without conditional branches. Just
> >put a copy of vrsave in one vr and then find a smart way to transform
> >these bits in masks to clear the registers (probably you'll have to splat
> >it first). It won't work for the the last register(s) because you need
> >some workspace, however.
> 
> Mmm, the joys of a bitwise AND.

Well, after having a moore detailed look at Altivec, I missed a shift
by immdieate amount in bits to make the code as compact as possible. There
are probably tricks to work around this, I might have started with the
wrong idea on the way to implement this...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
