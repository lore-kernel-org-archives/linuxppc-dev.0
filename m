From: wortman@austin.ibm.com
Message-Id: <200104161743.MAA23884@wortman.austin.ibm.com>
Subject: [PATCH] SMP bugs
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 16 Apr 2001 12:43:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is a patch I'ld like to suggest for some SMP bugs we ran into
while testing.

In arch/ppc/kernel/hashtable.S:
Modified to use sync and isync as required by the PowerPC Architecture.

In arch/ppc/mm/init.c:
local_flush_tlb_range will use local_flush_tlb_mm if the range
contains 20 or more pages. local_flush_tlb_mm "flushes" the tlb by
actually assigning new vsids for this process (leaving the old page
table entries (with the old vsids) as orphans. It also updates the
current thread's segment registers with the new vsids.  Other threads
of the same process, currently running on other processors do not
have their segment registers updated. They will continue to run with
the old translations (until the next task switch on their
processors). If the local_flush_tlb_range was called on behalf of a
mmap or munmap then the other threads may be running with the wrong
protection or even with the wrong real pages. (pages that have
already been freed).  The fix is to not call local_flush_tlb_mm on
SMP.  It may also be possible fix local_flush_tlb_mm to be smp safe.

Michael Wortman
PPC Linux - IBM Austin

--- base24/arch/ppc/kernel/hashtable.S	Fri Apr 13 07:40:58 2001
+++ smp_fix/arch/ppc/kernel/hashtable.S	Fri Apr 13 06:58:27 2001
@@ -85,7 +85,7 @@
 	cmpw	r6,r0
 	bdnzf	2,10b
 	tw	31,31,31
-11:	eieio
+11:	isync				/* discard any prefetched instructions*/
 	REST_2GPRS(7, r21)
 #endif
 	/* Get PTE (linux-style) and check access */
@@ -463,8 +463,8 @@
 	lis	r2,hash_table_lock@ha
 	tophys(r2,r2)
 	li	r0,0
+	sync			/* need to sync before releasing the lock */
 	stw	r0,hash_table_lock@l(r2)
-	eieio
 #endif

 	/* Return from the exception */
@@ -492,11 +492,11 @@

 #ifdef CONFIG_SMP
 hash_page_out:
+	sync			/* need to sync before releasing the lock */
 	lis	r2,hash_table_lock@ha
 	tophys(r2,r2)
 	li	r0,0
 	stw	r0,hash_table_lock@l(r2)
-	eieio
 	blr

 	.data
@@ -547,7 +547,7 @@
 	bne-	10b
 	stwcx.	r8,0,r9
 	bne-	10b
-	eieio
+	isync				/* discard any prefetched instructions*/
 #endif
 #ifndef CONFIG_PPC64BRIDGE
 	rlwinm	r3,r3,7,1,24		/* put VSID lower limit in position */
@@ -650,7 +650,7 @@
 	cmpi	0,r7,0
 	beq	10b
 	b	11b
-12:	eieio
+12:	isync				/* discard any prefetched instructions*/
 #endif
 #ifndef CONFIG_PPC64BRIDGE
 	rlwinm	r3,r3,11,1,20		/* put context into vsid */
--- base24/arch/ppc/mm/init.c	Fri Apr 13 07:39:18 2001
+++ smp_fix/arch/ppc/mm/init.c	Fri Apr 13 07:09:35 2001
@@ -591,10 +591,17 @@
 	if (mm->context != 0) {
 		if (end > TASK_SIZE)
 			end = TASK_SIZE;
+		/* This causes a bug, because new vsids are assigned
+ 		   for the thread.  Other threads on other prcessors
+		   do not have their segment registers updated with the
+		   new vsids.  They will run with old translations until
+		   the next task switch. Fixing flush_tlb_mm is being
+		   investigated.
 		if (end - start > 20 * PAGE_SIZE) {
 			flush_tlb_mm(mm);
 			return;
 		}
+		*/
 	}

 	for (; start < end; start += PAGE_SIZE)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
