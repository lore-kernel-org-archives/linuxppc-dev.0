Date: Tue, 20 Apr 1999 19:45:28 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Current egcs, binutils and kernel (fwd)
In-Reply-To: <Pine.LNX.4.10.9904201339320.26859-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.HPP.3.96.990420191014.20020L-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Tue, 20 Apr 1999, Geert Uytterhoeven wrote:

> 
> ---------- Forwarded message ----------
> Date: Tue, 20 Apr 1999 13:15:41 +0200
> From: Reinhard Nissl <rnissl@gmx.de>
> To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
> Cc: "linux-apus@sunsite.auc.dk" <linux-apus@sunsite.auc.dk>
> Subject: Re: Current egcs, binutils and kernel
> 
> Hi,
> 
> Geert Uytterhoeven wrote:
> 
> > On Wed, 14 Apr 1999, Reinhard Nissl wrote:
> > > has anyone had success in compiling (egcs-1.1.2 and binutils-2.9.1.0.23)
> > > the current APUS kernel with support for network block devices (nbd.c)?
> > >
> > > I get an undefined reference to __lshrdi3 from nbd_ioctl(), which looks
> > > like a compiler / binutils bug.
> >
> > Hence a __lshrdi3() routine needs to be added to arch/ppc/kernel/misc.S.
> 
> I had a look into misc.S and found similar routines (__ashrdi3) there. Then I
> searched in the egcs-1.1.2 sources for files, where such functions are
> referenced. I found definitions in egcs-1.1.2/gcc/config/rs6000/rs6000.md but
> they are not native ppc assembler instructions. As I'm not that much used to
> *.md files and ppc assembly code, I'm currently not able to define the missing
> function in misc.S myself.
> 
> I checked the kernel source diffs from version 2.2.4 to 2.2.6 for lshrdi3 and
> had only success for arch=sparc. So, is there anybody who can add the missing
> function to misc.S for arch=ppc?

I'd suggest the following patch. Note that the current versions of the
long long shifts will not work when the shift count is > 32. There is an
appendix in all good PPC manuals on how to do multiple precision shifts
and I've followed it (except for the exact order for better superscalar
issue/execution and completion, all the code should flow perfectly
through 2 pipes) with one exception: the arithmetic right
shift is one instruction longer but is branchless (conditional clear 
of a register using a shift whose amount is computed by an rlwinm
instruction).

I've also fixed a few other oddities in the code: 

- atomic_dec_and_test uses cntlzw the way God intended to evaluate 
`(x==0) ? 1 : 0' without any branch

- the abs function is also branchless now (it would nevertheless be better
to use the __builtin_abs function of GCC)

	Greetings,
	Gabriel.

--- linux-2.2.6/arch/ppc/kernel/misc.S	Thu Mar 11 05:30:32 1999
+++ linux/arch/ppc/kernel/misc.S	Tue Apr 20 20:14:03 1999
@@ -228,10 +228,8 @@
 	subi	r5,r5,1		/* Perform 'add' operation */
 	stwcx.	r5,0,r3		/* Update with new value */
 	bne-	10b		/* Retry if "reservation" (i.e. lock) lost */
-	cmpi	0,r5,0		/* Return 'true' IFF 0 */
-	li	r3,1
-	beqlr
-	li	r3,0
+	cntlzw	r3,r5		/* Return 'true' IFF 0 */
+	srwi	r3,r3,5		/* But do it the clever way */
 	blr
 _GLOBAL(atomic_clear_mask)
 10:	lwarx	r5,0,r4
@@ -355,38 +353,59 @@
 	blr	
 
 /*
- * Extended precision shifts
+ * Extended precision shifts.
+ * 
+ * Updated to be valid for shift counts from 0 to 63 inclusive.
+ * -- Gabriel 
  *
  * R3/R4 has 64 bit value
  * R5    has shift count
  * result in R3/R4
  *
- *  ashrdi3:     XXXYYY/ZZZAAA -> SSSXXX/YYYZZZ
- *  ashldi3:     XXXYYY/ZZZAAA -> YYYZZZ/AAA000
+ *  ashrdi3: arithmetic right shift (sign propagation)     
+ *  lslhdi3: logical right shift	
+ *  ashldi3: left shift
  */
 _GLOBAL(__ashrdi3)
-	li	r6,32
-	sub	r6,r6,r5
-	slw	r7,r3,r6	/* isolate YYY */
-	srw	r4,r4,r5	/* isolate ZZZ */
-	or	r4,r4,r7	/* YYYZZZ */
-	sraw	r3,r3,r5	/* SSSXXX */
+	subfic	r6,r5,32	
+	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
+	addi	r7,r5,32	# could be xori, or addi with -32
+	slw	r6,r3,r6	# t1 = count > 31 ? 0 :	MSW << (32-count)
+	rlwinm	r8,r7,0,32	# t3 = (count < 32) ? 32 : 0
+	sraw	r7,r3,r7	# t2 = MSW >> (count-32)
+	or	r4,r4,r6	# LSW |= t1
+	slw	r7,r7,r8	# t2 = (count < 32) ? 0 : t2
+	sraw	r3,r3,r5	# MSW = MSW >> count
+	or	r4,r4,r7	# LSW |= t2
 	blr
-	
+
 _GLOBAL(__ashldi3)
-	li	r6,32
-	sub	r6,r6,r5
-	srw	r7,r4,r6	/* isolate ZZZ */
-	slw	r4,r4,r5	/* AAA000 */
-	slw	r3,r3,r5	/* YYY--- */
-	or	r3,r3,r7	/* YYYZZZ */
+	subfic	r6,r5,32	
+	slw	r3,r3,r5	# MSW = count > 31 ? 0 : MSW << count
+	addi	r7,r5,32	# could be xori, or addi with -32
+	srw	r6,r4,r6	# t1 = count > 31 ? 0 :	LSW >> (32-count)
+	slw	r7,r4,r7	# t2 = count < 32 ? 0 :	LSW << (count-32)
+	or	r3,r3,r6	# MSW |= t1
+	slw	r4,r4,r5	# LSW = LSW << count
+	or	r3,r3,r7	# MSW |= t2
+	blr
+
+_GLOBAL(__lshrdi3)
+	subfic	r6,r5,32	
+	srw	r4,r4,r5	# LSW = count > 31 ? 0 : LSW >> count
+	addi	r7,r5,32	# could be xori, or addi with -32
+	slw	r6,r3,r6	# t1 = count > 31 ? 0 :	MSW << (32-count)
+	srw	r7,r3,r7	# t2 = count < 32 ? 0 :	MSW >> (count-32)
+	or	r4,r4,r6	# LSW |= t1
+	srw	r3,r3,r5	# MSW = MSW >> count
+	or	r4,r4,r7	# LSW |= t2 
 	blr
 
 _GLOBAL(abs)
-	cmpi	0,r3,0
-	bge	10f
-	neg	r3,r3
-10:	blr
+	srawi	r4,r3,31
+	xor	r3,r3,r4
+	sub	r3,r3,r4
+	blr
 
 _GLOBAL(_get_SP)
 	mr	r3,r1		/* Close enough */



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
