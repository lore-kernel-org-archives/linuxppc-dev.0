To: Daniel Wu <Daniel.Wu@alcatel.com.au>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: 8xx MMU Table Walk Base (was Re: kernel crashes at InstructionTLBMiss )
In-Reply-To: Message from Daniel Wu <Daniel.Wu@alcatel.com.au>
   of "Sun, 04 Jun 2000 14:40:31 +1000." <00Jun4.144038est.115228@border.alcanet.com.au>
Date: Mon, 05 Jun 2000 18:19:31 +1000
Message-ID: <21966.960193171@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>        mfspr   r20, M_TWB      /* Get level 1 table entry address */
...
>As you can see, r20 is 400f1c00, which looks wrong, but why? Any suggestions?

At this point, the MMU is disabled so r20, which is loaded from the MMU Table
Walk Base register, should be a physical address - 400f1c00 is not a likely
physical address for something in RAM (unless you have a weird disjoint RAM
setup), so yes it certainly looks wrong. Incorrect TWB contents is a disaster.

Here we come to a dilemma that I have had since I started with this stuff.
I have never been able to get an 8xx kernel running without adding a patch
to update the Table Walk Base register at the time that a new mm context is
activated.

Let me explain: normally the TWB is loaded at context switch time which makes
sense because a different task with a different virtual memory context will be
running. This is done in the following code in the _switch function in
arch/ppc/kernel/entry.S:

>	tophys(r0,r4)
>	mtspr	SPRG3,r0	/* Update current THREAD phys addr */
>#ifdef CONFIG_8xx
>	/* XXX it would be nice to find a SPRGx for this on 6xx,7xx too */
>	lwz	r9,PGDIR(r4)	/* cache the page table root */
>        tophys(r9,r9)		/* convert to phys addr */
>        mtspr   M_TWB,r9	/* Update MMU base address */
>	tlbia
>	SYNC
>#endif /* CONFIG_8xx */

The contents of the TWB should be the address stored in current->thread.pgdir
converted to a physical address. The above code is the only place that the
TWB is written to, anywhere in the kernel (that I can find). The TWB is then
used in the TLB miss handlers to load the TLB entry (assuming a mapping exists
- if not, do_page_fault() is called to fill it in).

But I have found that there is a situation during "exec()" where a newly
created mm context is "activated" (via activate_mm() in asm/mmu_context.h)
before the task is actually "switch"ed to (presumably to copy the arguments
and environment etc from the old task - which is being overwritten) i.e. the
TWB is not updated because a switch hasn't occurred [NOTE: this is only my
theory - I am not an expert on this stuff]

Without my patch, the exec of "/sbin/init" hangs in an endless TLBMiss handler
loop, where a virtual address is accessed which causes a TLB miss, the TWB
has contents of the old pgdir which does not have a mapping for that virtual
address so do_page_fault() is called to fill it in, but do_page_fault()
decides that that mapping exists and everything is ok so why the hell did
you call me, I'll just return doing nothing! - the access is re-tried which
causes a TLB miss again at the same virtual address. The kernel is in a
dead hang (although later 2.[34].* kernels exhibit different symptoms, which
mystifies me a bit - i.e. characters typed on the console are echoed, and I
know timer interrupts are occuring, because I have a rotating thingy on the
LCD display which updates once a second via the timer interrupt handler, so it
is not a complete dead hang).

The patch I always have to add to arch/ppc/kernel/head_8xx.S is:

  */
 _GLOBAL(set_context)
         mtspr   M_CASID,r3		/* Update context */
+	lwz	r3, THREAD+PGDIR(r2)
+	tophys(r3, r3)
+	mtspr	M_TWB, r3
         tlbia
 	SYNC
 	blr

I know this is wrong, but it seems to work for me (unless the TWB can be
considered to be part of the MMU context, and therefore it is legitimate
to update it in set_context()? I don't know).

I have tried other things e.g. adding a "set_context_and_twb()" function,
just after the set_context() function (without above patch), e.g.:

--- arch/ppc/kernel/head_8xx.S	2000/04/28 06:35:05	1.1.1.5
+++ arch/ppc/kernel/head_8xx.S	2000/06/05 07:51:50
@@ -905,6 +905,19 @@
 	SYNC
 	blr

+/*
+ * the 8xx tablewalk base register (M_TWB) must be consistent with
+ * the currently active mm. This is called from switch_mm() and
+ * activate_mm() in include/asm-ppc/mmu_context.h
+ */
+_GLOBAL(set_context_and_twb)
+        mtspr   M_CASID,r3		/* Update context */
+	tophys(r4, r4)
+	mtspr	M_TWB, r4
+	tlbia
+	SYNC
+	blr
+
 /* Jump into the system reset for the rom.
  * We first disable the MMU, and then jump to the ROM reset address.
  *

Then doing something like this:

--- include/asm-ppc/mmu_context.h	2000/03/07 03:59:54	1.1.1.2
+++ include/asm-ppc/mmu_context.h	2000/06/05 07:46:35
@@ -52,6 +52,11 @@
 extern void set_context(int context);

 #ifdef CONFIG_8xx
+/* same as above plus loads the 8xx tablewalk base register also */
+extern void set_context_and_twb(int, void *);
+#endif
+
+#ifdef CONFIG_8xx
 extern inline void mmu_context_overflow(void)
 {
 	atomic_set(&next_mmu_context, -1);
@@ -85,7 +90,10 @@
 {
 	tsk->thread.pgdir = next->pgd;
 	get_mmu_context(next);
-	set_context(next->context);
+	if (tsk == current)
+		set_context_and_twb(next->context, tsk->thread.pgdir);
+	else
+		set_context(next->context);
 }

 /*
@@ -96,7 +104,7 @@
 {
 	current->thread.pgdir = mm->pgd;
 	get_mmu_context(mm);
-	set_context(mm->context);
+	set_context_and_twb(mm->context, current->thread.pgdir);
 }

 /*

This works also, though I'm not sure about it. I was thinking that maybe the
set_context() in switch_mm() should only be done if the switch_mm() is being
performed on the "current" task. e.g.

	tsk->thread.pgdir = next->pgd;
	get_mmu_context(next);
	if (tsk == current)
		set_context(next->context);

Then set_context() could simply update the TWB with current->thread.pgdir.
But I think the only place switch_mm() is called is in the task context
switch code anyway, which means current is about to change, and also means
I get confused :-) But I know activate_mm() is used in other places -
something to do with "lazy tlb" mode, and also in exec(). I give up.

One thing I think is for certain in all this - do_page_fault() should
*NEVER* return without having done something - anything - to ensure
that the same fault does not re-occur after the handler returns - if it
can't handle the fault, it should either kill the task if it is in user
mode, or panic if in kernel mode.

One thing that bothers me is why this behaviour only occurs for me? I have
no idea, but obviously it is only me, otherwise no-one would have a working
embedded 8xx 2.[34].* kernel. I suspect I am doing something else which
triggers this bug, or else there is something I don't understand
(not unlikely :-).

Note: I have only ever tried the 2.[34].* series of kernels. I have not
tried the 2.2.* kernels, but some code snippets I have seen in the list
archives suggest ... I just searched the list and found the following
comment from Dan Malek on 16 Dec 98:

	> BTW, why must the M_TWB be set in SET_PAGE_DIR ?

	The M_TWB points to the first level page table (Linux pgd_t)
	and is used in the mpc8xx page fault handler.  When Linux
	deletes or otherwise modifies the memory map object such that
	the first level page table is modified (as during exec), it
	uses SET_PAGE_DIR.  Since the first level table has potentially
	moved to a new memory location, we have to set M_TWB at
	this time.  If we don't, a process exec without an intervening
	context switch will cause us to use a bogus M_TWB when
	trying to find page tables.


	    -- Dan

OK - where is SET_PAGE_DIR() in the 2.[34].* kernels? Following the threads
it appears that this discussion was had a long time ago, but in the other
direction - the TWB was being updated too often, and the consensus was that
it should only be updated when the SET_PAGE_DIR macro was setting the page
dir for the current task. Now it is not setting it at all.

I think I'd better shut up now and let other more experienced people tell me
what I have missed or where I have gone wrong :-) Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
