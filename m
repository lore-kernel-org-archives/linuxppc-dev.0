From: Simon Winwood <sjw@cse.unsw.edu.au>
To: Matt Porter <mporter@mvista.com>
Date: Wed, 28 Nov 2001 06:18:57 +1100
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More walnut boottime "fun"
Message-ID: <20011128061857.A390@cse.unsw.edu.au>
References: <20011127103042.A11612@cse.unsw.edu.au> <20011126221728.D13091@cpe-24-221-152-185.az.sprintbbd.net> <20011127050754.B15728@cx258813-a.chnd1.az.home.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
In-Reply-To: <20011127050754.B15728@cx258813-a.chnd1.az.home.com>; from mporter@mvista.com on Tue, Nov 27, 2001 at 05:07:54AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2001 at 05:07:54AM -0700, Matt Porter wrote:
> On Mon, Nov 26, 2001 at 10:17:28PM -0700, Tom Rini wrote:
> >
>

[...]

> That said, the two stage relocator is "The Right Thing To Do(tm)".
> It only needs to be two stage, though when the load point > -Ttext.

	I have fixed the relocate code so it does it in 2 stages ...
first it moves the relocate code, then it relocates the image, either
start first or end first, so it doesn't overwrite itself.

	The code is a bit verbose, but I guess size isn't really an issue
for the boot code.
>
> Why doesn't walnut simply call mktree with the option to load at
> it's -Ttext to avoid the original problem?  That's why I added the
> parameter to mktree and use it on the Spruce build...no need to
> do an extra copy if we control the load point.

	That would be too easy ;)  Besides, I had pretty much finished
the code when I got this email (would have finished it last night, except
that 'mtcr' and 'mtctr' are apparently both valid instructions ;(

	Simon

--
Simon Winwood
IBM T.J. Watson Research Center

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ppc-relocate

===== arch/ppc/boot/common/relocate.S 1.5 vs edited =====
--- 1.5/arch/ppc/boot/common/relocate.S	Mon Nov 19 19:17:42 2001
+++ edited/arch/ppc/boot/common/relocate.S	Tue Nov 27 14:49:50 2001
@@ -22,8 +22,10 @@
 #include <asm/cache.h>
 #include <asm/ppc_asm.h>

+#define GETSYM(reg, sym)	\
+	lis	reg, sym@h; ori	reg, reg, sym@l
+
 	.text
-
 	/* We get called from the early initialization code.
 	 * Register 3 has the address where we were loaded,
 	 * Register 4 contains any residual data passed from the
@@ -39,10 +41,9 @@
 	mr	r11, r4

 	/* compute the size of the whole image in words. */
-	lis	r4,start@h
-	ori	r4,r4,start@l
-	lis	r5,end@h
-	ori	r5,r5,end@l
+	GETSYM(r4,start)
+	GETSYM(r5,end)
+
 	addi	r5,r5,3		/* round up */
 	sub	r5,r5,r4	/* end - start */
 	srwi	r5,r5,2
@@ -55,33 +56,94 @@
 	cmp	cr0,r3,r4
 	beq	start_ldr	/* If 0, we don't need to relocate */

-	/*
-	 * No matter where we're loaded, move ourselves to -Ttext
-	 * address.  Always copy end->start to accomodate images
-	 * that cross the -Ttext boundary.
-	 *
-	 * Note: There are still many ways we can wipe ourselves out
-	 * while relocating.  If we are loaded > -Ttext and the
-	 * sizeof(zImage[.initrd]) > (load point - -Ttext) then we
-	 * will wipe ourselves out.  We need a two stage relocater
-	 * to handle this case. -MDP
+	/* Move this code somewhere safe.  This is max(load + size, end)
+	 * r8 == load address
 	 */
-	lis	r4,end@h	/* Load ending address */
-	ori	r4,r4,end@l
-	mr	r5,r7		/* Get the # of longwords again */
-	mtctr	r5		/* Setup for a loop */
-	slwi	r5,r5,2		/* Get size in bytes */
-	add	r3, r3, r5	/* Calculate end of loaded image */
-	li	r6,0
-00:	lwzu	r5,-4(r3)	/* Load and decrement */
-	stwu	r5,-4(r4)	/* Store and decrement */
-	xor	r6,r6,r5	/* Are we done? */
-	bdnz	00b
-	lis	r3,start_ldr@h
-	ori	r3,r3,start_ldr@l
+	GETSYM(r4, start)
+	GETSYM(r5, end)
+
+	sub	r6, r5, r4
+	add	r6, r8, r6	/* r6 == phys(load + size) */
+
+	cmpw	r5, r6
+	bgt	1f
+	b	2f
+1:
+	mr	r6, r5
+2:
+	/* dest is in r6 */
+	/* Ensure alignment --- this code is precautionary */
+	addi	r6, r6, 4
+	li	r5, 0x0003
+	andc	r6, r6, r5
+
+	/* Find physical address and size of do_relocate */
+	GETSYM(r5, do_relocate)
+	GETSYM(r4, do_relocate_end)
+	GETSYM(r3, start)
+
+	/* Size to copy */
+	sub	r4, r4, r5
+	srwi	r4, r4, 2
+
+	/* Src addr to copy (= do_relocate - start + where_loaded) */
+	sub	r3, r5, r3
+	add	r5, r8, r3
+
+	/* Save dest */
+	mr	r3, r6
+
+	/* Do the copy */
+	mtctr	r4
+3:	lwz	r4, 0(r5)
+	stw	r4, 0(r3)
+	addi	r3, r3, 4
+	addi	r5, r5, 4
+	bdnz	3b
+
+	/* This will return to the relocated do_relocate */
+	mtlr	r6
+	b	flush_instruction_cache
+
+do_relocate:
+	/* We have 2 cases --- start < load, or start > load
+	 * This determines whether we copy from the end, or the start.
+	 * Its easier to have 2 loops than to have paramaterised
+	 * loops.  Sigh.
+	 */
+	li	r6, 0		/* Clear checksum */
+	mtctr	r7		/* Setup for a loop */
+
+	GETSYM(r4, start)
+	mr	r3, r8		/* Get the load addr */
+
+	cmp	cr0, r4, r3	/* If we need to copy from the end, do so */
+	bgt	do_relocate_from_end
+
+do_relocate_from_start:
+1:	lwz	r5, 0(r3)	/* Load and decrement */
+	stw	r5, 0(r4)	/* Store and decrement */
+	addi	r3, r3, 4
+	addi	r4, r4, 4
+	xor	r6,r6,r5	/* Update checksum */
+	bdnz	1b		/* Are we done? */
+	b	do_relocate_out	/* Finished */
+
+do_relocate_from_end:
+	GETSYM(r3, end)
+	slwi	r4, r7, 2
+	add	r4, r8, r4	/* Get the physical end */
+1:	lwzu	r5, -4(r4)
+	stwu	r5, -4(r3)
+	xor	r6, r6, r5
+	bdnz	1b
+
+do_relocate_out:
+	GETSYM(r3,start_ldr)
 	mtlr	r3		/* Easiest way to do an absolute jump */
 	blr
-
+do_relocate_end:
+
 start_ldr:
 /* Some boards don't boot up with the I-cache enabled.  Do that
  * now because the decompress runs much faster that way.

--liOOAslEiF7prFVr--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
