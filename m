Date: Thu, 28 Oct 1999 13:01:52 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Tony Mantler <eek@escape.ca>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <v04003a00b43d2b8b3cd6@[216.81.1.41]>
Message-ID: <Pine.HPX.4.10.9910281205380.18743-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 27 Oct 1999, Tony Mantler wrote:

> At 8:21 AM -0500 10/27/99, Gabriel Paubert wrote:
> [...]
> >And why would you want to use a bitmap ? This seems braindead to me, put a
> >value between 0 and 32 in vrsave. Since all registers are identical
> >in use and purpose, save registers 0 to n. Disclaimer: I've not seen if
> >the ABI specifies how and which Altivec registers are saved restored
> >across calls.
> 
> It would seem to me that using a bitmap to mark used registers would allow
> more flexibility on the compiler side to play with register usage without
> incurring longer context switch times. I wouldn't try to guess the relative
> tradeoff values though.

Since all 32 registers have exactly the same capabilities, using only a
consecutive set of registers is not a problem for the compiler. That's how
it works for integer registers and FP registers 14 to 31 (for integer
actually register 0 is special). Taking into account the comments on the
ABI, the only strategy which seems implementable is to distinguish 2 cases
only vrsave=0 and vrsave!=0. Using a bitmap means a lot of conditional
branches, which can obviously be folded but nevertheless bloat the code.
(For save+restore: 64 conditional branches + 16 mtcrf= 320 bytes). 

There is also a problem of knowing how to update the bitmap in nested
subroutines: to keep it correct the called subroutine must save the
current vrsave and then or it with the bitmask of the registers it uses.
Then on exit it has to restore caller's vrsave. Do we want such a complex
strategy ? I don't mean that it is impossible to implement, but that it
looks complex. 

OTOH, if the register usage is designed similarly to integer and FP, the
bitmask might look like 111...1100...0011...11 (i.e. with at most 2
transitions between 0 and 1 in the bit string). It might be worth
optimizing the save/restore routine for this case, saving/restoring more
registers than necessary when vrsave does not have such a canonical form.


> 
> 
> >Paranoid point of view: the restore must reload all altivec registers
> >(or clear the ones which are not specified as used by VRSAVE), otherwise
> >you might leak the contents of the Altivec registers of another process.
> >I'm not a security expert, but I don't like this possibility at all.
> [...]
> 
> Beyond security, clearning the registers would also serve to enforce strict
> usage of whatever is defined as the VRSAVE format, and avoid the
> possibility of a mouth-breathing code-typist releasing a binary that
> doesn't mark it's registers, which in theory would only break once a
> different application touches the altivec registers, resulting in a
> situation of either A: the kernel being forced to save all altivec
> registers (bad) or B: allowing those binaries to be broken and upsetting
> it's users (slightly less bad). Obviously pre-breaking those binaries would
> be the preferable solution, so they never need see the light of day.

Indeed, I had not considered this problem. Note that conditional clearing
of most registers can probably be done without conditional branches. Just
put a copy of vrsave in one vr and then find a smart way to transform
these bits in masks to clear the registers (probably you'll have to splat
it first). It won't work for the the last register(s) because you need
some workspace, however. 

Anyway, having a special fast path for the case vrsave=0 is probably the
most important optimization IMHO. 

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
