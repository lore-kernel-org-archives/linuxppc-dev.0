Message-ID: <393BCD68.556D4423@embeddededge.com>
Date: Mon, 05 Jun 2000 11:55:20 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: Daniel Wu <Daniel.Wu@alcatel.com.au>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel crashes at InstructionTLBMiss
References: <00Jun4.144038est.115228@border.alcanet.com.au> <393BBE5D.49B17E9C@embeddededge.com>
Content-Type: multipart/mixed;
 boundary="------------E2311C818DB60A4A300CECD8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------E2311C818DB60A4A300CECD8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dan Malek wrote:

> ..... This is a 2.2.13 kernel with all patches and
> the option to include the "CPU6" patch.  Don't apply any other patches
> from anywhere.


I was just reminded of a patch to correct a mistake I made in this
particular kernel.  It is attached.  Apply just this one to the
MontaVista kernel :-).


	-- Dan
--------------E2311C818DB60A4A300CECD8
Content-Type: text/plain; charset=us-ascii;
 name="mv-cpu6-3.patch"
Content-Disposition: inline;
 filename="mv-cpu6-3.patch"
Content-Transfer-Encoding: 7bit

diff -Nru linux-2.2.13.orig/arch/ppc/kernel/head.S linux-2.2.13/arch/ppc/kernel/head.S
--- linux-2.2.13.orig/arch/ppc/kernel/head.S	Mon Jun  5 11:44:56 2000
+++ linux-2.2.13/arch/ppc/kernel/head.S	Mon Jun  5 11:45:59 2000
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
+	.space	4
+#endif

 /*
  * An undocumented "feature" of 604e requires that the v bit

--------------E2311C818DB60A4A300CECD8--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
