Message-ID: <000701c28cfa$e14e1a60$0200a8c0@telia.com>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: csum_partial() and csum_partial_copy_generic() in badly optimized?
Date: Sat, 16 Nov 2002 00:01:06 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi

Looking over the different checksums in I came across csum_partial() and csum_partial_copy_generic(), which lives in
arch/ppc/lib/checksum.S.

This comment in csum_partial:
/* the bdnz has zero overhead, so it should */
/* be unnecessary to unroll this loop */

got me wondering(code included last). A instruction can not have zero cost/overhead.
This instruction must be eating cycles. I think this function needs unrolling, but  I am pretty
useless on assembler so I need help.

Can any PPC/assembler guy comment on this and, if needed, do the
unrolling? I think  6 or 8 as unroll step will be enough.

The same goes for  csum_partial_copy_generic()

These functions are used to checksum every IP/TCP/UDP packet, so it
would be a good thing if they were properly optimized.

It would be really nice if there were more comments(and use names on jump labels, numbers
are very uninformative), it's hard enough to understand as is.

          Jocke


/ *
 * computes the checksum of a memory block at buff, length len,
 * and adds in "sum" (32-bit)
 *
 * csum_partial(buff, len, sum)
 */
_GLOBAL(csum_partial)
        addic   r0,r5,0
        subi    r3,r3,4
        srwi.   r6,r4,2
        beq     3f              /* if we're doing < 4 bytes */
        andi.   r5,r3,2         /* Align buffer to longword boundary */
        beq+    1f
        lhz     r5,4(r3)        /* do 2 bytes to get aligned */
        addi    r3,r3,2
        subi    r4,r4,2
        addc    r0,r0,r5
        srwi.   r6,r4,2         /* # words to do */
        beq     3f
1:      mtctr   r6
2:      lwzu    r5,4(r3)        /* the bdnz has zero overhead, so it should */
        adde    r0,r0,r5        /* be unnecessary to unroll this loop */
        bdnz    2b
        andi.   r4,r4,3
3:      cmpi    0,r4,2
        blt+    4f
        lhz     r5,4(r3)
        addi    r3,r3,2
        subi    r4,r4,2
        adde    r0,r0,r5
4:      cmpi    0,r4,1
        bne+    5f
        lbz     r5,4(r3)
        slwi    r5,r5,8         /* Upper byte of word */
        adde    r0,r0,r5
5:      addze   r3,r0           /* add in final carry */
        blr

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
