From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 13 Mar 2003 15:38:53 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
Message-ID: <20030313223853.GA6921@rover.farnsworth.org>
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org> <3E650AAF.7060804@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E650AAF.7060804@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 08:21:03PM +0000, Dan Malek wrote:
> Dale Farnsworth wrote:
>
> >No, I wasn't sure.  Now after some more looking, I'm sure that
> >it *won't* work for 40x, 44x, and 8xx.
> >
> >I'll find another way.
>
> Well, one option that may be the easiest is to just change all
> of the linux head.S files to have the three nops again.  When we
> split these file apart a while back, we just removed everything that
> wasn't necessary.  Just put a note in those files why they are
> present.  They don't cost anything since these are exception vector
> locations or temporary storage locations for special purposes.

I didn't find a better way.
This patch does the following:

Avoid using the first 3 locations of kernel text, since they
may be overwritten by SMP startup code before the kernel is
started.  Modify the common bootwrapper code to start the kernel
at 0x000c.  Add nops at the beginning of teh various head*.S files.

Modified files:
arch/ppc/boot/common/relocate.S
	Start the kernel at 0x000c, since the first few instructions
	may be overwritten by SMP startup code.

arch/ppc/kernel/head_440.S
	Place three nop instructions at _stext since the bootloader
	now starts the kernel at 0x000c.

arch/ppc/kernel/head_4xx.S
	Place three nop instructions at _stext since the bootloader
	now starts the kernel at 0x000c.

arch/ppc/kernel/head_8xx.S
	Place three nop instructions at _stext since the bootloader
	now starts the kernel at 0x000c.

arch/ppc/kernel/iSeries_head.S
	Place three nop instructions at _stext since the bootloader
	now starts the kernel at 0x000c.

Please consider applying.

Thanks,
-Dale

===== arch/ppc/boot/common/relocate.S 1.6 vs edited =====
--- 1.6/arch/ppc/boot/common/relocate.S	Thu Feb 27 12:40:14 2003
+++ edited/arch/ppc/boot/common/relocate.S	Thu Mar 13 15:00:03 2003
@@ -199,9 +197,11 @@
 	li	r6,0

 	/*
-	 * Start at the begining.
+	 * Start at the beginning.
+	 * Well, actually on the 4th instruction since we
+	 * sometimes overwrite the first 3 (which are 'nop').
 	 */
-	li	r9,0x0000
+	li	r9,0x000c
 	mtlr	r9
 	blr

===== arch/ppc/kernel/head_440.S 1.13 vs edited =====
--- 1.13/arch/ppc/kernel/head_440.S	Mon Feb 24 16:26:48 2003
+++ edited/arch/ppc/kernel/head_440.S	Thu Mar 13 14:56:17 2003
@@ -58,6 +58,11 @@
 	 * of abatron_pteptrs
 	 */
 	nop
+	/* To accomodate some SMP systems that overwrite the first few
+	 * locations before cpu 0 starts, the bootloader starts us at 0xc.
+	 */
+	nop
+	nop
 /*
  * Save parameters we are passed
  */
===== arch/ppc/kernel/head_4xx.S 1.42 vs edited =====
--- 1.42/arch/ppc/kernel/head_4xx.S	Thu Feb 27 12:40:15 2003
+++ edited/arch/ppc/kernel/head_4xx.S	Thu Mar 13 14:56:19 2003
@@ -62,6 +62,13 @@
 _GLOBAL(_stext)
 _GLOBAL(_start)

+	/* To accomodate some SMP systems that overwrite the first few
+	 * locations before cpu 0 starts, the bootloader starts us at 0xc.
+	 */
+	nop
+	nop
+	nop
+
 	/* Save parameters we are passed.
 	*/
 	mr	r31,r3
===== arch/ppc/kernel/head_8xx.S 1.41 vs edited =====
--- 1.41/arch/ppc/kernel/head_8xx.S	Thu Feb 27 12:40:15 2003
+++ edited/arch/ppc/kernel/head_8xx.S	Thu Mar 13 14:56:20 2003
@@ -79,6 +79,12 @@

 	.globl	__start
 __start:
+	/* To accomodate some SMP systems that overwrite the first few
+	 * locations before cpu 0 starts, the bootloader starts us at 0xc.
+	 */
+	nop
+	nop
+	nop
 	mr	r31,r3			/* save parameters */
 	mr	r30,r4
 	mr	r29,r5
===== arch/ppc/kernel/iSeries_head.S 1.9 vs edited =====
--- 1.9/arch/ppc/kernel/iSeries_head.S	Wed Nov  7 15:41:38 2001
+++ edited/arch/ppc/kernel/iSeries_head.S	Thu Mar 13 14:56:21 2003
@@ -80,6 +80,12 @@

 	.globl	__start
 __start:
+	/* To accomodate some SMP systems that overwrite the first few
+	 * locations before cpu 0 starts, the bootloader starts us at 0xc.
+	 */
+	nop
+	nop
+	nop
 	b	start_here


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
