Message-Id: <v04003a00b43e690932c6@[216.81.26.227]>
In-Reply-To: <Pine.HPX.4.10.9910281205380.18743-100000@gra-ux1.iram.es>
References: <v04003a00b43d2b8b3cd6@[216.81.1.41]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 28 Oct 1999 16:20:38 -0500
To: Gabriel Paubert <paubert@iram.es>
From: Tony Mantler <eek@escape.ca>
Subject: Re: question about altivec registers
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:01 AM -0500 10/28/99, Gabriel Paubert wrote:
>On Wed, 27 Oct 1999, Tony Mantler wrote:
>
[...]
>> It would seem to me that using a bitmap to mark used registers would allow
>> more flexibility on the compiler side to play with register usage without
>> incurring longer context switch times. I wouldn't try to guess the relative
>> tradeoff values though.
>
>Since all 32 registers have exactly the same capabilities, using only a
>consecutive set of registers is not a problem for the compiler. That's how
>it works for integer registers and FP registers 14 to 31 (for integer
>actually register 0 is special).

I suppose I'm a bit too used to 68k stuff, where sorting register usage
takes a back seat to efficient register re-use. However, with the size of
the data in the Altivec registers, I would expect a bit of optimization to
slant away from cases where the registers can be easily sorted and packed.


>Taking into account the comments on the
>ABI, the only strategy which seems implementable is to distinguish 2 cases
>only vrsave=0 and vrsave!=0. Using a bitmap means a lot of conditional
>branches, which can obviously be folded but nevertheless bloat the code.
>(For save+restore: 64 conditional branches + 16 mtcrf= 320 bytes).

Quite true.


>There is also a problem of knowing how to update the bitmap in nested
>subroutines: to keep it correct the called subroutine must save the
>current vrsave and then or it with the bitmask of the registers it uses.
>Then on exit it has to restore caller's vrsave. Do we want such a complex
>strategy ? I don't mean that it is impossible to implement, but that it
>looks complex.

I think saving registers in a subroutine is a pain no matter how it's
implemented. If the VRSAVE is used as a count, the subroutine still has to
save the old value, save the overwritten registers, calculate what the
proper new value is (think new < old = oops!) then restore the overwritten
registers and old VRSAVE value when it exits.


>OTOH, if the register usage is designed similarly to integer and FP, the
>bitmask might look like 111...1100...0011...11 (i.e. with at most 2
>transitions between 0 and 1 in the bit string). It might be worth
>optimizing the save/restore routine for this case, saving/restoring more
>registers than necessary when vrsave does not have such a canonical form.

Hmm, count bits in from the left and right, mask and check for missed bits,
then branch to either a full save or a left+right save.

Doing it that way would also somewhat optimize VRSAVE=0, since both the
leftmost and rightmost bits are 0, it would pass right through the
left-save and right-save half of the optimized register save.

Perhaps a little longer than "if (VRSAVE==0) return;", but it's quick
enough for me.


[.. enforce proper VRSAVE usage ..]
>
>Indeed, I had not considered this problem. Note that conditional clearing
>of most registers can probably be done without conditional branches. Just
>put a copy of vrsave in one vr and then find a smart way to transform
>these bits in masks to clear the registers (probably you'll have to splat
>it first). It won't work for the the last register(s) because you need
>some workspace, however.

Mmm, the joys of a bitwise AND.


>Anyway, having a special fast path for the case vrsave=0 is probably the
>most important optimization IMHO.

Indeed.


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
