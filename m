Date: Wed, 12 Sep 2001 13:33:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Paul Mackerras <paulus@samba.org>
Subject: Some more 4xx exception fixes
Message-ID: <20010912133344.S4823@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The patch below fixes one problem, and cleans up a wart (which didn't
really cause any problems) in head_4xx.S.

The problem was that the DSI handler would not call do_page_fault()
for zone protection faults which were writes - which meant that a user
process attempting to write to kernel (or read protected) memory would
not be SEGVed but instead would spin re-entering the exception handler
(I've confirmed this with a test program).  In fact zone faults are
the only possible cause of a DSI on a read operation, so we don't need
to check whether the operation was a write.

The wart is that the ISI handler passed SRR1 (i.e. saved MSR) to
do_page_fault(), whereas the comment above do_page_fault() says that
do_page_fault() should be passed 0 for instruction faults on 4xx.
Since nothing in do_page_fault() checked any bits that mattered, it
didn't actually break anything.

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S linux-bungo/arch/ppc/kernel/head_4xx.S
--- ../linuxppc_2_4_devel/arch/ppc/kernel/head_4xx.S	Tue Sep 11 18:18:05 2001
+++ linux-bungo/arch/ppc/kernel/head_4xx.S	Wed Sep 12 13:15:15 2001
@@ -221,11 +221,14 @@
 	mtspr	SPRG7, r21
 	mtspr	SPRG6, r22

-	/* First, make sure this was a store operation.
+	/* First, check if it was a zone fault (which means a user
+	* tried to access a kernel or read-protected page - always
+	* a SEGV).  All other faults here must be stores, so no
+	* need to check ESR_DST as well. */
 	*/
 	mfspr	r20, SPRN_ESR
-	andis.	r20, r20, ESR_DST@h
-	beq	2f
+	andis.	r20, r20, ESR_DIZ@h
+	bne	2f

 	mfspr	r20, SPRN_DEAR		/* Get faulting address */

@@ -315,7 +318,7 @@
 	START_EXCEPTION(0x0400, InstructionAccess)
 	STND_EXCEPTION_PROLOG(0x0400)
 	mr	r4,r22			/* Pass SRR0 as arg2 */
-	mr	r5,r23			/* Pass SRR1 as arg3 */
+	li	r5,0
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r7,STND_EXC
 	li	r20,MSR_KERNEL

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
