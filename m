To: Peter Allworth <linsol@zeta.org.au>
Cc: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Low memory problems in 8xx Linux
References: <kfy3drel1xy.fsf@kieraypc07.p.y.ki.era.ericsson.se> <38964A23.3CAFFD88@zeta.org.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 01 Feb 2000 19:08:53 +0100
In-Reply-To: Peter Allworth's message of "Tue, 01 Feb 2000 13:51:15 +1100"
Message-ID: <kfyoga04wy2.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Peter Allworth <linsol@zeta.org.au> writes:

> Marcus Sundberg wrote:
> > is anybody else experiencing severe problems when free memory gets low
> > in Linux? And I'm not talking about _out of memory_, just simply low
> > on RAM...
>
> Marcus,
>
> The answer is yes. I first noticed this problem on a proprietary
> MPC860T board I've designed (and assumed the fault lay there) but
> since then have been able to reproduce it on a Motorola TFADS.
> (I've been working with Dan Malek's cllf-2.2.13.)
>
> The good news is I'm pretty sure I have a fix. You've caught me in
> the process of learning how to make an official contribution to the
> Linux kernel.

Indeed your fix works just beautifully, thanks a lot!

> My solution to this problem is as follows. In include/asm-ppc/pgtable.h,
> rename 0x0100 (the page changed bit) as _PAGE_HWWRITE and 0x0020 (currently
> the write-through cache bit) as _PAGE_DIRTY.
> Unfortunately this means the write-through function is lost since there
> are no more bits left so, for now, redefine _PAGE_WRITETHRU to be the
> same as _PAGE_NO_CACHE. (This is a bit inefficient so the fix is only
> temporary.)

It's not a real problem as _PAGE_WRITETHRU is not used by any PPC
code, except possibly in some fbcon drivers.

> > This happens with kernels 2.2.5, 2.2.10, 2.2.12, 2.2.13, 2.2.14 and
> > 2.2.15pre5 + Rik's boobytrap2 patch, on MBX, ADS, FADS, RPX Lite and
> > custom boards. (2.2.12 and earlier based on Dan Malek's 2.2.5, 2.2.13
> > and later based on his 2.2.13).
>
> You've been busy. I can tell!

We've had this problem for a long time...
First we thought it was our hardware. Then once things started working
reliably when not low on memory we thought it was just the regular oom
problem discussed on Linux kernel, and we simply fixed it by never
going oom. It was just recently that we discovered that the problem
occured even when there was plenty of RAM that could be freed up.

> My own kernel currently contains modifications that would have made
> the patches confusing so I generated these patches by diffing the originals
> against hand-modified copies of the originals.
> As such, the patches are untested in their current form. :(
> If you have any problems, please let me know.

This hunk won't work in 2.2 kernels:

@@ -1025,8 +1031,22 @@
 	tophys(r21, r21, 0)
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
-	mfspr	r20, MD_TWC	/* ....and get the pte address */
-	lwz	r20, 0(r20)	/* Get the pte */
+	stw	r21, 8(r0)		/* Save a copy of pte base address */
+	mfspr	r21, MD_TWC		/* ....and get the pte address */
+	lwz	r20, 0(r21)			/* Get the pte */
+	andi.	r20, r20, _PAGE_PRESENT		/* Set cr0 if it's invalid */
+	beq	4f				/* Skip update if invalid */
+	mfspr	r20, DSISR			/* Check for store op */
+	andis.	r20, r20, 0x0200		/* If set, indicates store */
+	lwz	r20, 0(r21)			/* Get the pte again */
+	beq	3f
+	ori	r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
+3:
+	ori	r20, r20, _PAGE_ACCESSED	/* Set the accessed flag */
+	stw	r20, 0(r21)			/* Update the pte */
+4:
+	lwz	r20, 0(r21)			/* Get the pte again */
+	lwz	r21, 8(r0)			/* Restore pte base address */

 	/* Insert the Guarded flag into the TWC from the Linux PTE.
 	 * It is bit 27 of both the Linux PTE and the TWC (at least

The code after the "Insert the Guarded flag..." comment is not in
normal kernels so r21 will hold an incorrect value.

Now, we have a quite modified kernel here too, so the code I put
there won't be of use for anyone else (it uses r3), but if I'm not
completely blind this diff should be good against Dan's 2.2.13:

@@ -1025,6 +1031,16 @@
 	tophys(r21, r21, 0)
 	ori	r21, r21, 1	/* Set valid bit in physical L2 page */
 	mtspr	MD_TWC, r21	/* Load pte table base address */
 	mfspr	r21, MD_TWC	/* ....and get the pte address */
-	lwz	r21, 0(r21)	/* Get the pte */
+	lwz	r20, 0(r21)			/* Get the pte */
+	andi.	r20, r20, _PAGE_PRESENT		/* Set cr0 if it's invalid */
+	beq	4f				/* Skip update if invalid */
+	mfspr	r20, DSISR			/* Check for store op */
+	andis.	r20, r20, 0x0200		/* If set, indicates store */
+	lwz	r20, 0(r21)			/* Get the pte again */
+	beq	3f
+	ori	r20, r20, _PAGE_DIRTY|_PAGE_HWWRITE /* Set the dirty flags */
+3:
+	ori	r20, r20, _PAGE_ACCESSED	/* Set the accessed flag */
+	stw	r20, 0(r21)			/* Update the pte */
+4:


//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
