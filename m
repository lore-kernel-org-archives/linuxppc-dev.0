Message-ID: <3AAB06CC.F5E5A5BA@routefree.com>
Date: Sat, 10 Mar 2001 21:02:04 -0800
From: David Blythe <blythe@routefree.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MMU_init buglet in 2.4.0-mvista_010216
Content-Type: multipart/mixed;
 boundary="------------DA6C3874358A62DB95C1FEEA"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------DA6C3874358A62DB95C1FEEA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

memory sizes > 16M but not a multiple of 16M not quite right.  for the
24M config i was playing with it manifests itself as a tlb miss/kernel
stack overflow.

patch attached.
	david
--------------DA6C3874358A62DB95C1FEEA
Content-Type: text/plain; charset=us-ascii;
 name="d7"
Content-Disposition: inline;
 filename="d7"
Content-Transfer-Encoding: 7bit

Index: arch/ppc/mm/init.c
===================================================================
diff -u -r1.1.1.4 init.c
--- arch/ppc/mm/init.c	2001/02/21 00:52:57	1.1.1.4
+++ arch/ppc/mm/init.c	2001/03/11 04:52:27
@@ -1015,7 +1015,7 @@
 	/* -----  pin 4MB chunks of memory  ----- */

 	if (size_pinned < size_DRAM) {
-		pinned_tlbs = ((size_DRAM - size_pinned) / SIZE_4MB);
+		pinned_tlbs += ((size_DRAM - size_pinned) / SIZE_4MB);

 		if (pinned_tlbs > PPC4xx_MAX_PINNED_TLB) {
 			printk(KERN_ERR "MMU_init(): memory configuration requires %d tlb entries.\n",

--------------DA6C3874358A62DB95C1FEEA--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
