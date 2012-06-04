Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 17:58:58 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 mikey@neuling.org
Subject: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
Message-ID: <20120604175858.38dac554@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I blame Mikey for this. He elevated my slightly dubious testcase:

# dd if=/dev/zero of=/dev/null bs=1M count=10000

to benchmark status. And naturally we need to be number 1 at creating
zeros. So lets improve __clear_user some more.

As Paul suggests we can use dcbz for large lengths. This patch gets
the destination 128 byte aligned then uses dcbz on whole cachelines.

Before:
10485760000 bytes (10 GB) copied, 0.414744 s, 25.3 GB/s

After:
10485760000 bytes (10 GB) copied, 0.268597 s, 39.0 GB/s

39 GB/s, a new record.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/lib/string_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/string_64.S	2012-06-04 16:18:56.351604302 +1000
+++ linux-build/arch/powerpc/lib/string_64.S	2012-06-04 16:47:10.538500871 +1000
@@ -78,7 +78,7 @@ _GLOBAL(__clear_user)
 	blt	.Lshort_clear
 	mr	r8,r3
 	mtocrf	0x01,r6
-	clrldi	r6,r6,(64-3)
+	clrldi	r7,r6,(64-3)
 
 	/* Get the destination 8 byte aligned */
 	bf	cr7*4+3,1f
@@ -93,11 +93,16 @@ err1;	sth	r0,0(r3)
 err1;	stw	r0,0(r3)
 	addi	r3,r3,4
 
-3:	sub	r4,r4,r6
-	srdi	r6,r4,5
+3:	sub	r4,r4,r7
+
 	cmpdi	r4,32
+	cmpdi	cr1,r4,512
 	blt	.Lshort_clear
-	mtctr	r6
+	bgt	cr1,.Llong_clear
+
+.Lmedium_clear:
+	srdi	r7,r4,5
+	mtctr	r7
 
 	/* Do 32 byte chunks */
 4:
@@ -139,3 +144,52 @@ err1;	stb	r0,0(r3)
 
 10:	li	r3,0
 	blr
+
+.Llong_clear:
+	/* Destination is 8 byte aligned, need to get it 128 byte aligned */
+	bf	cr7*4+0,11f
+err2;	std	r0,0(r3)
+	addi	r3,r3,8
+	addi	r4,r4,-8
+
+11:	srdi	r6,r6,4
+	mtocrf	0x01,r6
+
+	bf	cr7*4+3,12f
+err2;	std	r0,0(r3)
+err2;	std	r0,8(r3)
+	addi	r3,r3,16
+	addi	r4,r4,-16
+
+12:	bf	cr7*4+2,13f
+err2;	std	r0,0(r3)
+err2;	std	r0,8(r3)
+err2;	std	r0,16(r3)
+err2;	std	r0,24(r3)
+	addi	r3,r3,32
+	addi	r4,r4,-32
+
+13:	bf	cr7*4+1,14f
+err2;	std	r0,0(r3)
+err2;	std	r0,8(r3)
+err2;	std	r0,16(r3)
+err2;	std	r0,24(r3)
+err2;	std	r0,32(r3)
+err2;	std	r0,40(r3)
+err2;	std	r0,48(r3)
+err2;	std	r0,56(r3)
+	addi	r3,r3,64
+	addi	r4,r4,-64
+
+14:	srdi	r6,r4,7
+	mtctr	r6
+
+15:
+err2;	dcbz	r0,r3
+	addi	r3,r3,128
+	addi	r4,r4,-128
+	bdnz	15b
+
+	cmpdi	r4,32
+	blt	.Lshort_clear
+	b	.Lmedium_clear
