Subject: Re: kernel crashes at InstructionTLBMiss
To: dan@netx4.com (Dan Malek)
Date: Tue, 6 Jun 2000 13:59:59 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
In-Reply-To: <393BCD68.556D4423@embeddededge.com> from "Dan Malek" at Jun 05, 2000 11:55:20 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000606035959.799D81B61D@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> I was just reminded of a patch to correct a mistake I made in this
> particular kernel.  It is attached.  Apply just this one to the
> MontaVista kernel :-).

I'd like to suggest the following patch as a more complete fix to avoid any
possible cmd_line corruption due to the CPU6 workaround.

Regards,
Graham

Index: arch/ppc/kernel/head.S
===================================================================
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 head.S
--- arch/ppc/kernel/head.S	2000/03/10 01:11:12	1.1.1.3
+++ arch/ppc/kernel/head.S	2000/06/06 03:53:32
@@ -2286,15 +2286,15 @@
         lwz     r9,PGD(r9)              /* get new->mm->pgd */
         addis   r9,r9,-KERNELBASE@h     /* convert to phys addr */
 #ifdef CONFIG_8xx_CPU6
-	lis	r6, cmd_line@h
-	ori	r6, r6, cmd_line@l
+	lis	r6, cpu6_bug@h
+	ori	r6, r6, cpu6_bug@l
 	li	r7, 0x3980
-	stw	r7, 12(r6)
-	lwz	r7, 12(r6)
+	stw	r7, 0(r6)
+	lwz	r7, 0(r6)
         mtspr   M_TWB, r9               /* Update MMU base address */
 	li	r7, 0x3380
-	stw	r7, 12(r6)
-	lwz	r7, 12(r6)
+	stw	r7, 0(r6)
+	lwz	r7, 0(r6)
         mtspr   M_CASID, r5             /* Update context */
 #else
         mtspr   M_TWB, r9               /* Update MMU base address */
@@ -2432,11 +2432,11 @@
 	SYNC			/* Some chip revs need this... */
 	mtmsr	r6
 	SYNC
-	lis	r7, cmd_line@h
-	ori	r7, r7, cmd_line@l
+	lis	r7, cpu6_bug@h
+	ori	r7, r7, cpu6_bug@l
 	li	r4, 0x3980
-	stw	r4, 12(r7)
-	lwz	r4, 12(r7)
+	stw	r4, 0(r7)
+	lwz	r4, 0(r7)
         mtspr   M_TWB, r3               /* Update MMU base address */
 	SYNC
 	mtmsr	r5
@@ -2452,11 +2452,11 @@
 	SYNC			/* Some chip revs need this... */
 	mtmsr	r6
 	SYNC
-	lis	r7, cmd_line@h
-	ori	r7, r7, cmd_line@l
+	lis	r7, cpu6_bug@h
+	ori	r7, r7, cpu6_bug@l
 	li	r4, 0x2c00
-	stw	r4, 12(r7)
-	lwz	r4, 12(r7)
+	stw	r4, 0(r7)
+	lwz	r4, 0(r7)
         mtspr   22, r3		/* Update Decrementer */
 	SYNC
 	mtmsr	r5
@@ -2899,6 +2899,11 @@
 	.globl	cmd_line
 cmd_line:
 	.space	512
+
+#ifdef CONFIG_8xx_CPU6
+cpu6_bug:
+	.space 4
+#endif

 /*
  * An undocumented "feature" of 604e requires that the v bit


--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
