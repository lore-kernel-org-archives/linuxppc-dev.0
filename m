Date: Thu, 03 Apr 2003 14:50:26 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: mpc8xx DCBZ (&friends) hw bug. Tests, analysis + conclusions.
In-reply-to: <3E825307.8000404@slac.stanford.edu>
To: Till Straumann <strauman@SLAC.Stanford.EDU>,
	Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEELJFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> CONCLUSION:
>
>    - the only correct workaround for TLBError
>      is the one I suggested earlier: TLBError
>      handler has to inspect the faulting opcode
>      and fixup DAR and MD_EPN based on the GPR
>      values if the faulting instruction is any
>      of dcbf, dcbi, dcbst or dcbz.
>      Performance of this solution could be
>      improved (eliminate opcode-check in the
>      vast majority of the cases) by storing
>      a 'tag' value in DAR.

Hi again

I have been hacking on dcxx address decoder. Since assembler isn't my cup of tea,
I used C mixed with asm statements. The resulting assembler isn't too bad either IMHO.

To load the instruction into r21 I used:
	mfspr	r20,SRR0
	andis.	r21, r20, 0x8000
	beq	56f

	tophys(r21, r20)
	lwz r21,0(r21)
56:
This only works for kernel space addresses. I can't figure out how to get to user space as well.
I can live without user space anyway.

I am still thinking about the 'tag'. Since MD_EPN isn't set as well as DAR I thinking about
storing a tag in MD_EPN instead. It's less intrusive. Maybe it is enough to look at the
valid bit in MD_EPN?

What do you think so far?
Oh, this should go into the DTLB Error handler.

     Jocke
======================= dcxx address decoder =========================

#define	RA(inst)	(((inst) & 0x001F0000) >> 16)
#define	RA_MASK	        0x001F0000
#define	RB(inst)	(((inst) & 0x0000F800) >> 11)
#define	RB_MASK	        0x0000F800

/* Compile with ppc_8xx-gcc -S -O2 -mregnames dcbz.c -fcall-used-r20 -fcall-used-r21
 * to see the resulting assembler */
/* Assumes dcxx instruction in reg 21 when called */
decode_dcxx_and_sum(void)
{
  register unsigned long r21 asm("r21"); /* make it live in reg 21 */
  register unsigned long r20 asm("r20"); /* make it live in reg 20 */

  asm("mfctr %0\n\t"
      "stw %0, 16(0)":: "r" (r20)); /* save ctr reg on stack */
  r20 = RB(r21) * 8; /* offset into jump table for reg RB */
  asm("addi %0, %0, 100f@l":: "r" (r20)); /* add start of table */
  asm("mtctr %0":: "r" (r20)); /* load ctr with jump address */
  r20 = 0; /* sum starts at zero */
  asm("bctr"::); /* jump into table */
  /* Below is the jump table. */
  asm("100:\n\t"
      "add %0, %0, 0\n\t"
      "b 99f\n\t"
      "add %0, %0, 1\n\t"
      "b 99f\n\t"
      "add %0, %0, 2\n\t"
      "b 99f\n\t"
      "add %0, %0, 3\n\t"
      "b 99f\n\t"
      "add %0, %0, 4\n\t"
      "b 99f\n\t"
      "add %0, %0, 5\n\t"
      "b 99f\n\t"
      "add %0, %0, 6\n\t"
      "b 99f\n\t"
      "add %0, %0, 7\n\t"
      "b 99f\n\t"
      "add %0, %0, 8\n\t"
      "b 99f\n\t"
      "add %0, %0, 9\n\t"
      "b 99f\n\t"
      "add %0, %0, 10\n\t"
      "b 99f\n\t"
      "add %0, %0, 11\n\t"
      "b 99f\n\t"
      "add %0, %0, 12\n\t"
      "b 99f\n\t"
      "99:\n\t"
      : : "r" (r20));
  r21 = RA(r21) * 8; /* offset into jump table for reg RA */
  if(r21){ /* if reg zero, don't add it */
    asm("addi %0, %0, 100b@l":: "r" (r21)); /* add start of table */
    asm("mtctr %0":: "r" (r21)); /* load ctr with jump address */
    r21 &= ~RA_MASK; /* make sure we don't execute this mre than once */
    asm("bctr":: "r" (r21)); /* jump into table */
  }
  asm("mtdar %0": : "r" (r20)); /* save sum to DAR */
  asm("lwz %0, 16(0)\n\t"
      "mtctr %0" :: "r" (r21)); /* restore ctr reg from stack */
}

This is the resulting assembler:

	.file	"dcbz.c"
gcc2_compiled.:
	.section	".text"
	.align 2
	.globl decode_dcxx_and_sum
	.type	 decode_dcxx_and_sum,@function
decode_dcxx_and_sum:
	mfctr %r20
	stw %r20, 16(0)
	rlwinm %r20,%r21,24,24,28
	addi %r20, %r20, 100f@l
	mtctr %r20
	li %r20,0
	bctr
	100:
	add %r20, %r20, 0
	b 99f
	add %r20, %r20, 1
	b 99f
	add %r20, %r20, 2
	b 99f
	add %r20, %r20, 3
	b 99f
	add %r20, %r20, 4
	b 99f
	add %r20, %r20, 5
	b 99f
	add %r20, %r20, 6
	b 99f
	add %r20, %r20, 7
	b 99f
	add %r20, %r20, 8
	b 99f
	add %r20, %r20, 9
	b 99f
	add %r20, %r20, 10
	b 99f
	add %r20, %r20, 11
	b 99f
	add %r20, %r20, 12
	b 99f
	99:

	rlwinm. %r21,%r21,19,24,28
	bc 12,2,.L3
	addi %r21, %r21, 100b@l
	mtctr %r21
	rlwinm %r21,%r21,0,16,10
	bctr
.L3:
	mtdar %r20
	lwz %r21, 16(0)
	mtctr %r21
	blr
.Lfe1:
	.size	 decode_dcxx_and_sum,.Lfe1-decode_dcxx_and_sum
	.ident	"GCC: (GNU) 2.95.3 20010315 (release/MontaVista)"


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
