Message-ID: <393BD32A.741C33B0@embeddededge.com>
Date: Mon, 05 Jun 2000 12:19:54 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel crashes at InstructionTLBMiss
References: <00Jun4.144038est.115228@border.alcanet.com.au> <393BBE5D.49B17E9C@embeddededge.com> <393BCD68.556D4423@embeddededge.com>
Content-Type: multipart/mixed;
 boundary="------------9F99AE2E7866653B6AA68AF2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------9F99AE2E7866653B6AA68AF2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Malek wrote:

> I was just reminded of a patch to correct a mistake I made in this
> particular kernel.  It is attached.  Apply just this one to the
> MontaVista kernel :-).

Nope, not that one......try this one, sorry.  Too many windows open
and didn't see the build error......



	-- Dan
--------------9F99AE2E7866653B6AA68AF2
Content-Type: text/plain; charset=us-ascii;
 name="mv-cpu6-1.patch"
Content-Disposition: inline;
 filename="mv-cpu6-1.patch"
Content-Transfer-Encoding: 7bit

diff -Nru linux-2.2.13.orig/arch/ppc/kernel/head.S linux-2.2.13/arch/ppc/kernel/head.S
--- linux-2.2.13.orig/arch/ppc/kernel/head.S	Fri Mar 24 23:43:32 2000
+++ linux-2.2.13/arch/ppc/kernel/head.S	Fri Mar 24 23:51:19 2000
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
@@ -2899,6 +2899,10 @@
 	.globl	cmd_line
 cmd_line:
 	.space	512
+
+#ifdef CONFIG_8xx_CPU6
+cpu6_bug:
+	.space	4
+#endif

 /*
  * An undocumented "feature" of 604e requires that the v bit

--------------9F99AE2E7866653B6AA68AF2--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
