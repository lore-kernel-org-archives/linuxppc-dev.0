Message-ID: <3AD78DB3.6077A539@routefree.com>
Date: Fri, 13 Apr 2001 16:37:23 -0700
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 4xx tlbmiss renables interrupts while in kgdb
Content-Type: multipart/mixed;
 boundary="------------4B5179B0DCB57D1E28D5909B"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------4B5179B0DCB57D1E28D5909B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The 4xx tlbmiss handler reenables interrupts while handling a page
fault.  Sometimes kgdb generates faults (that are ignored) while
grubbing around in memory for backtraces and such and has the side
effect of leaving interrupts enabled.  Makes debugging drivers more
entertaining.

Here is a small, but not particularly elegant patch to fix it (against
the mvista 010216 release for the 405).
	david
--------------4B5179B0DCB57D1E28D5909B
Content-Type: text/plain; charset=us-ascii;
 name="patch7"
Content-Disposition: inline;
 filename="patch7"
Content-Transfer-Encoding: 7bit

Index: arch/ppc/mm/4xx_tlb.c
===================================================================
diff -u -r1.2 4xx_tlb.c
--- arch/ppc/mm/4xx_tlb.c	2001/03/16 20:18:16	1.2
+++ arch/ppc/mm/4xx_tlb.c	2001/04/13 23:27:12
@@ -50,6 +50,9 @@


 /* Global Variables */
+#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
+extern void (*debugger_fault_handler)(struct pt_regs *);
+#endif

 static pin_entry_t    pin_table[PPC4XX_TLB_SIZE];
 static unsigned long  tlb_next_replace = 0;
@@ -347,6 +350,10 @@
 	dtlb_miss_count++;

 	if (tlbMiss(regs, badaddr, wasWrite, 1)) {
+#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
+		/* don't enable interrupts while in the debugger */
+		if (!debugger_fault_handler)
+#endif
 		sti();
 		do_page_fault(regs, badaddr, wasWrite);
 		cli();
@@ -362,6 +369,9 @@
 	itlb_miss_count++;

 	if (!current) {
+#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
+		if (!debugger_fault_handler)
+#endif
 		sti();
 		bad_page_fault(regs, regs->nip);
 		cli();
@@ -369,6 +379,9 @@
 	}

 	if (tlbMiss(regs, regs->nip, 0, 1)) {
+#if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
+		if (!debugger_fault_handler)
+#endif
 		sti();
 		do_page_fault(regs, regs->nip, 0);
 		cli();

--------------4B5179B0DCB57D1E28D5909B--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
