Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C3B0DDF23
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:32:35 +1000 (EST)
Date: Wed, 11 Apr 2007 03:32:17 -0500 (CDT)
Subject: [PATCH] kexec: send slaves to new kernel earlier
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Message-Id: <boot-4-misc-02.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
Cc: fastboot@lists.osdl.org, Vivek Goyal <vgoyal@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Copy the code and start the slaves on their journey to next
kernels spin loop as soon as we copy the kexec image into place.

The kernel doesn't know exactly which slaves are spinning in
kexec_wait.  This allows us to pass more than max-cpus to the
next kernel.  But it also means that we might leave some behind.

Moving the code here means they have the time it takes us to
clear the hash table to wake up and move on.  Moving the code
any earlier would reuqire walking the image description to
search for the code, which could span multiple pages.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
I applied this change while searching for the cause of lost cpus.   The actual
cause was a sequence error causing the slaves to attempt to execute invalid
instructions, but it showed the result is bouncing off the kernels ISI
handler scribling on low memory.

Index: kernel/arch/powerpc/kernel/misc_64.S
===================================================================
--- kernel.orig/arch/powerpc/kernel/misc_64.S	2007-04-09 02:25:01.000000000 -0500
+++ kernel/arch/powerpc/kernel/misc_64.S	2007-04-09 02:32:05.000000000 -0500
@@ -606,6 +606,19 @@ _GLOBAL(kexec_sequence)
 	/* turn off mmu */
 	bl	real_mode
 
+	/* copy  0x100 bytes starting at start to 0 */
+	li	r3,0
+	mr	r4,r30		/* start, aka phys mem offset */
+	li	r5,0x100
+	li	r6,0
+	bl	.copy_and_flush	/* (dest, src, copy limit, start offset) */
+1:	/* assume normal blr return */
+
+	/* release other cpus to the new kernel secondary start at 0x60 */
+	mflr	r5
+	li	r6,1
+	stw	r6,kexec_flag-1b(5)
+
 	/* clear out hardware hash page table and tlb */
 	ld	r5,0(r27)		/* deref function descriptor */
 	mtctr	r5
@@ -636,19 +649,6 @@ _GLOBAL(kexec_sequence)
  *    are the boot cpu ?????
  *    other device tree differences (prop sizes, va vs pa, etc)...
  */
-
-	/* copy  0x100 bytes starting at start to 0 */
-	li	r3,0
-	mr	r4,r30
-	li	r5,0x100
-	li	r6,0
-	bl	.copy_and_flush	/* (dest, src, copy limit, start offset) */
-1:	/* assume normal blr return */
-
-	/* release other cpus to the new kernel secondary start at 0x60 */
-	mflr	r5
-	li	r6,1
-	stw	r6,kexec_flag-1b(5)
 	mr	r3,r25	# my phys cpu
 	mr	r4,r30	# start, aka phys mem offset
 	mtlr	4
