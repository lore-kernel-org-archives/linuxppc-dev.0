Date: Wed, 27 Oct 1999 15:21:50 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Adrian Cox <apc@agelectronics.co.uk>
cc: Kumar Gala <kumar@chaos.ph.utexas.edu>, Jim Terman <terman@ddi.com>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: question about altivec registers
In-Reply-To: <3816BEA7.23AF7175@agelectronics.co.uk>
Message-ID: <Pine.HPX.4.10.9910271432490.18743-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 27 Oct 1999, Adrian Cox wrote:

> Linux on PowerPC should end up doing a classic lazy save/restore for the
> vector context, as it already does for the floating point registers. On
> SMP systems this simple approach isn't possible, but a quick
> approximation is to detect the first time a process uses Altivec, and
> marking it to always save and restore vector context from then on.

Agreed.

> I'd recommend that compiler writers use the vrsave register to mark
> which vector registers they use, as a precaution against future kernels
> which may look at this. Note that the G4 is extremely fast at linear
> sequences of cacheable stores (store miss merging), and it is probably
> cheaper for the kernel to ignore vrsave and avoid branches in the save
> and restore sequence.  Of course, it is correct to simply set every bit
> in vrsave at the start of your application, and never change it again.
> It may be non-optimal on future systems, but it should remain correct.

Don't forget nevertheless a worthwhile optimization: that VRSAVE=0 means
that the program has no active Altivec registers at the time so that the
save can be skipped altogether (except for vrsave and the control/status
register).

And why would you want to use a bitmap ? This seems braindead to me, put a
value between 0 and 32 in vrsave. Since all registers are identical
in use and purpose, save registers 0 to n. Disclaimer: I've not seen if
the ABI specifies how and which Altivec registers are saved restored
across calls. 

Paranoid point of view: the restore must reload all altivec registers
(or clear the ones which are not specified as used by VRSAVE), otherwise
you might leak the contents of the Altivec registers of another process.
I'm not a security expert, but I don't like this possibility at all. 

Code bloat concerns: actually to save or restore a single altivec
register, you need 2 instructions given the available addressing modes:  
this makes 512 bytes of code for 32 register save + 32 register restore
(there are ways to slightly reduce it but there is also the overhead of
setting up several integer registers, saving vrsave and the control/status
register...). Count 12 bytes/register if you use a bit in vrsave to check
every register. But the branches are not that expensive if the cr bits are
set enough in advance: assuming vrsave has been copied to r0:

	cmpwi	r0,0
	bne-	done
	mtcrf	0x1,r0
	la 	r3,vregsavearea+448
	li	r4,16
	li	r5,32
	li	r6,48
	bf	31,30f
	stvx	v31,r6,r3
30:	mtcrf	0x2,r0
	bf	30,29f
	stvx	v30,r5,r3
29:	srwi	r0,r0,8
	bf	29,28f
	stvx	v29,r4,r3
28:	bf	28,27f
	stvx	v28,0,r3
27:	addi	r3,r3,-64	
	bf	27,26f
	stvx	v27,r6,r3
26:	mtcrf	0x1,r0		
	bf	26,25f
	stvx	v26,r5,r3
25:	bf	25,24f
	stvx	v25,r4,r3
24:	bf	24,23f
	stvx	v24,0,r3
23:	addi	r3,r3,-64
	bf	31,22f
	stvx	v23,r6,r3
22:	mtcrf	0x2,r0		# Cycle since 30: repeats here
	bf	30,21f
	stvx	v22,r5,r3
21:	srwi	r0,r0,8
	bf	29,20f
	...
0:	bf	24,done
	stvx	v0,0,r3
done:	  			# now save the control/status register...
	
in this code the bits to test are always set or moe 3 branches ahead of
the test by interleaving 2 cr fields set up by mtcrf according to vrsave
bits.  But the code is significantly larger than using a count and
branching at the right place in the save routine.

> As for the cache thrashing effect, remember that 512 bytes going in and
> out of the L2 cache is not very expensive, and that there is probably 1
> or 2MB of L2 fitted.

My feeling is that it is unlikely that the code is in the L1 cache, this
code is not a tight loop which is executed 1000 times in a row, and it is
probably saturating L2 cache bandwidth. If you need 8 bytes of code and 16
bytes of data for each register save/load on average, it's 3 L2 data beats
or 6 clocks in the most common scenario (L2 at 1/2 core frequency).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
