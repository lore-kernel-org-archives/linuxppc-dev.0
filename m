Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17284.61088.219693.162392@cargo.ozlabs.ibm.com>
Date: Thu, 24 Nov 2005 09:35:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20051123202115.GA17320@suse.de>
References: <17277.28534.614112.962810@cargo.ozlabs.ibm.com>
	<20051118075158.GB14865@suse.de> <20051118221309.GA12724@suse.de>
	<17278.40894.898159.724090@cargo.ozlabs.ibm.com>
	<20051119102952.GA32273@suse.de> <20051119172900.GA11829@suse.de>
	<20051119204742.GA17604@suse.de> <20051123202115.GA17320@suse.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] generate COFF zImage in arch/powerpc/boot
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> It just died while uncompressing vmlinux. Some unaligned load.
> So we either need a very simple byte by byte memcpy, or my version below.

This should achieve the same effect and is quite a bit simpler.  Your
version looks a bit strange - it copies 1-3 bytes to align the source
pointer, then copies 1-3 bytes to align the destination pointer, then
if the source pointer isn't aligned it goes back and tries again... :)

Regards,
Paul.

diff -urN powerpc/arch/powerpc/boot/string.S merge-hack/arch/powerpc/boot/string.S
--- powerpc/arch/powerpc/boot/string.S	2005-11-16 15:55:17.000000000 +1100
+++ merge-hack/arch/powerpc/boot/string.S	2005-11-24 09:18:47.000000000 +1100
@@ -107,7 +107,7 @@
 	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
 	addi	r6,r3,-4
 	addi	r4,r4,-4
-	beq	2f			/* if less than 8 bytes to do */
+	beq	3f			/* if less than 8 bytes to do */
 	andi.	r0,r6,3			/* get dest word aligned */
 	mtctr	r7
 	bne	5f
@@ -132,6 +132,11 @@
 	bdnz	4b
 	blr
 5:	subfic	r0,r0,4
+	cmpw	cr1,r0,r5
+	add	r7,r0,r4
+	andi.	r7,r7,3			/* will source be word-aligned too? */
+	ble	cr1,3b
+	bne	3b			/* do byte-by-byte if not */
 	mtctr	r0
 6:	lbz	r7,4(r4)
 	addi	r4,r4,1
@@ -149,7 +154,7 @@
 	rlwinm.	r7,r5,32-3,3,31		/* r7 = r5 >> 3 */
 	add	r6,r3,r5
 	add	r4,r4,r5
-	beq	2f
+	beq	3f
 	andi.	r0,r6,3
 	mtctr	r7
 	bne	5f
@@ -171,7 +176,12 @@
 	stbu	r0,-1(r6)
 	bdnz	4b
 	blr
-5:	mtctr	r0
+5:	cmpw	cr1,r0,r5
+	subf	r7,r0,r4
+	andi.	r7,r7,3
+	ble	cr1,3b
+	bne	3b
+	mtctr	r0
 6:	lbzu	r7,-1(r4)
 	stbu	r7,-1(r6)
 	bdnz	6b
