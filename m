Return-Path: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: vdso 64bits gettimeofday bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 08:09:00 +1100
Message-Id: <1140901740.24957.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg KH <greg@kroah.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Olaf Hering <olh@suse.de>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A bug in the assembly code of the vdso can cause gettimeofday() to hang
or to return incorrect results. The wrong register was used to test for
pending updates of the calibration variables and to create a dependency
for subsequent loads. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Might be worth applying to the stable series too and/or distro kernels
2.6.15 and later

--- linux-work.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-02-26 08:02:57.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S	2006-02-26 08:04:23.000000000 +1100
@@ -225,9 +225,9 @@
   .cfi_startproc
 	/* check for update count & load values */
 1:	ld	r8,CFG_TB_UPDATE_COUNT(r3)
-	andi.	r0,r4,1			/* pending update ? loop */
+	andi.	r0,r8,1			/* pending update ? loop */
 	bne-	1b
-	xor	r0,r4,r4		/* create dependency */
+	xor	r0,r8,r8		/* create dependency */
 	add	r3,r3,r0
 
 	/* Get TB & offset it */
