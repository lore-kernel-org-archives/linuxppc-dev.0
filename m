Date: Wed, 9 May 2001 21:18:44 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Brian Kuschak <brian.kuschak@skystream.com>
Cc: "'Dan Malek'" <dan@mvista.com>, Eli Chen <eli@routefree.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: dcache BUG()
In-Reply-To: <B25E2E5A003CD311B61E00902778AF2A0204465E@SERVER1>
Message-ID: <Pine.HPX.4.10.10105092010530.29518-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 9 May 2001, Brian Kuschak wrote:

> I'm using gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo), from
> MontaVista.
> Your right, one of the first things I did was look at the generated assembly
> code, that's how I noticed the one-bit difference between bne and bne-.
> Here's a little snippet from one of the atomic ops.  It looks ok to me,
> except for the fact that lwarx r11,0,r31 shows up as lwarx r11,r0,r31.

Yes, it's ok.

> Objdump seems to do this everywhere, I'm not sure why.

Just because objdump prints r0 instead of 0 systematically when
disassembling instructions, even in the case where the contents of the
register are ignored and replaced by 0. Not a problem, you can also write
the assembly source with r0 instead of 0 if you want. As long as it means
that the corresponding field in the instruction enconding is zero, it does
not matter.

>
> static __inline__ void atomic_set(atomic_t *v, int a)
> {
> c004f9e8:       38 00 00 01     li      r0,1
>         int t;
>
>         __asm__ __volatile__("\n\
> c004f9ec:       7d 60 f8 28     lwarx   r11,r0,r31
> c004f9f0:       60 0b 00 00     ori     r11,r0,0
> c004f9f4:       7d 60 f9 2d     stwcx.  r11,r0,r31
> c004f9f8:       40 a2 ff f4     bne-    c004f9ec <d_alloc+0x90>
>
>         atomic_set(&dentry->d_count, 1);


Is there any reason for atomic_set to use this sequence. I believe that a
simple store (stw in this case) would be ok. This looks like a very
convoluted and bloated way to set a variable. An aligned stw is guaranteed
to set the variable atomically wrt all other processors.


Hmmm, now thinking about the problem we are tracking. Is it possible that
we have the same problem when switching tasks ?  After all there is an rfi
there to switch contexts and I've been unable to spot a place where a
stale reservation would be cancelled in schedule on UP (it would be
cancelled on SMP because of spinlocks). Note that in many cases there are
atomic operations, but I believe that it is not guaranteed depending
on whether kernel threads are involved or not.

However, it should not affect the kernel since there should be no process
switching between lwarx and stwcx., unless you ar using a preemptible
kernel. However, this seems to be a bug which could affect multithreaded
applications or appliactions with atomic operations on shared memory:

1) application interrupted between lwarx and stwcx.

2) switch_to another application

3) switch_to back to this application with reservaton set

4) returns to the application with reservation set, stwcx. succeeds even
if the shared variable has been modified...

Patch follows, it includes my previous patch. I don't think that it will
solve your problem, unless you happen to use a preemptible kernel.
While I was at it,  I removed the useless stwcx. in transfer_to_handler.

	Regards,
	Gabriel.

===== head.S 1.13 vs edited =====
--- 1.13/arch/ppc/kernel/head.S	Fri Apr 13 20:44:42 2001
+++ edited/head.S	Wed May  9 20:53:20 2001
@@ -765,8 +765,6 @@
 	mflr	r23
 	andi.	r24,r23,0x3f00		/* get vector offset */
 	stw	r24,TRAP(r21)
-	li	r22,RESULT
-	stwcx.	r22,r22,r21		/* to clear the reservation */
 	li	r22,0
 	stw	r22,RESULT(r21)
 	mtspr	SPRG2,r22		/* r1 is now kernel sp */
===== entry.S 1.7 vs edited =====
--- 1.7/arch/ppc/kernel/entry.S	Fri Apr 13 20:44:42 2001
+++ edited/entry.S	Wed May  9 20:52:41 2001
@@ -266,6 +266,7 @@
 10:	lwz	r2,_CTR(r1)
 	lwz	r0,_LINK(r1)
 	mtctr	r2
+	stwcx.	r1,0,r1			/* Clear reservation - Gabriel. */
 	mtlr	r0
 	lwz	r2,_XER(r1)
 	lwz	r0,_CCR(r1)
@@ -382,6 +383,7 @@
 	CLR_TOP32(r8)
 	mtspr	SPRG2,r8		/* phys exception stack pointer */
 1:
+	stwcx.	r1,0,r1			/* Clear reservation - Gabriel. */
 	lwz	r3,_CTR(r1)
 	lwz	r0,_LINK(r1)
 	mtctr	r3
===== head_4xx.S 1.3 vs edited =====
--- 1.3/arch/ppc/kernel/head_4xx.S	Mon Apr  2 03:36:29 2001
+++ edited/head_4xx.S	Wed May  9 20:53:39 2001
@@ -387,8 +387,6 @@
 	mflr	r23
 	andi.	r24,r23,0x3f00		# Get vector offset
 	stw	r24,TRAP(r21)
-	li	r22,RESULT
-	stwcx.	r22,r22,r21		# Clear the reservation
 	li	r22,0
 	stw	r22,RESULT(r21)
 	mtspr	SPRN_SPRG2,r22		# r1 is now the kernel stack pointer
===== head_8xx.S 1.6 vs edited =====
--- 1.6/arch/ppc/kernel/head_8xx.S	Wed Apr 11 12:10:57 2001
+++ edited/head_8xx.S	Wed May  9 20:53:54 2001
@@ -678,8 +678,6 @@
 	mflr	r23
 	andi.	r24,r23,0x3f00		/* get vector offset */
 	stw	r24,TRAP(r21)
-	li	r22,RESULT
-	stwcx.	r22,r22,r21		/* to clear the reservation */
 	li	r22,0
 	stw	r22,RESULT(r21)
 	mtspr	SPRG2,r22		/* r1 is now kernel sp */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
