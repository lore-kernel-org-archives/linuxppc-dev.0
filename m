Date: Fri, 17 Oct 2003 17:05:51 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: [PATCH] Remove 7  instructions in 8xx ITLB Miss when pinned TLBs is set
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIEHIGAAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I realized that kernel space won't cause ITLB misses when CONFIG_PIN_TLB is set. At least on
my system(no module support).

The patch below is agaist a fairly recent _devel head_8xx.S(around 2.4.20-2.4.21)
Comments?

Index: arch/ppc/kernel/head_8xx.S
===================================================================
RCS file: /home/cvsadmin/cvsroot/kernel/linuxppc/arch/ppc/kernel/head_8xx.S,v
retrieving revision 1.10
diff -u -r1.10 head_8xx.S
--- arch/ppc/kernel/head_8xx.S	8 Oct 2003 10:15:40 -0000	1.10
+++ arch/ppc/kernel/head_8xx.S	17 Oct 2003 14:47:34 -0000
@@ -325,8 +325,10 @@
 	lwz	r3, 12(r0)
 #endif
 	mtspr	M_TW, r20	/* Save a couple of working registers */
+#ifndef CONFIG_PIN_TLB
 	mfcr	r20
 	stw	r20, 0(r0)
+#endif
 	stw	r21, 4(r0)
 	mfspr	r20, SRR0	/* Get effective address of fault */
 #ifdef CONFIG_8xx_CPU6
@@ -337,6 +339,7 @@
 	mtspr	MD_EPN, r20	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r20, M_TWB	/* Get level 1 table entry address */

+#ifndef CONFIG_PIN_TLB
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
@@ -349,6 +352,13 @@
 	lwz	r21, 0(r20)	/* Get the level 1 entry */
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
 	beq	2f		/* If zero, don't try to find a pte */
+#else
+	lwz	r21, 0(r20)	/* Get the level 1 entry */
+	mfcr	r20
+	cmplwi	cr0,r21,0x0fff	/* Test page descriptor page address */
+	bng-	2f		/* If zero, don't try to find a pte */
+	mtcr	r20
+#endif

 	/* We have a pte table, so load the MI_TWC with the attributes
 	 * for this "segment."
@@ -390,17 +400,24 @@
 	mtspr	MI_RPN, r20	/* Update TLB entry */

 	mfspr	r20, M_TW	/* Restore registers */
+#ifndef CONFIG_PIN_TLB
 	lwz	r21, 0(r0)
 	mtcr	r21
+#endif
 	lwz	r21, 4(r0)
 #ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
 #endif
 	rfi

-2:	mfspr	r20, M_TW	/* Restore registers */
+2:
+#ifndef CONFIG_PIN_TLB
 	lwz	r21, 0(r0)
 	mtcr	r21
+#else
+	mtcr	r20
+#endif
+	mfspr	r20, M_TW	/* Restore registers */
 	lwz	r21, 4(r0)
 #ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
