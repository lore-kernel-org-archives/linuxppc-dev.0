Return-Path: <anton@samba.org>
Date: Tue, 5 Jun 2012 12:02:22 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 mikey@neuling.org, galak@kernel.crashing.org, olof@lixom.net
Subject: [PATCH] powerpc: Optimise the 64bit optimised __clear_user
Message-ID: <20120605120222.6722a3e3@kryten>
In-Reply-To: <20120604175858.38dac554@kryten>
References: <20120604175858.38dac554@kryten>
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
the destination cacheline aligned then uses dcbz on whole cachelines.

Before:
10485760000 bytes (10 GB) copied, 0.414744 s, 25.3 GB/s

After:
10485760000 bytes (10 GB) copied, 0.268597 s, 39.0 GB/s

39 GB/s, a new record.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: handle any cacheline size

Index: linux-build/arch/powerpc/lib/string_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/string_64.S	2012-06-04 16:18:56.351604302 +1000
+++ linux-build/arch/powerpc/lib/string_64.S	2012-06-05 11:42:10.044654851 +1000
@@ -19,6 +19,12 @@
  */
 
 #include <asm/ppc_asm.h>
+#include <asm/asm-offsets.h>
+
+	.section	".toc","aw"
+PPC64_CACHES:
+	.tc		ppc64_caches[TC],ppc64_caches
+	.section	".text"
 
 /**
  * __clear_user: - Zero a block of memory in user space, with less checking.
@@ -94,9 +100,14 @@ err1;	stw	r0,0(r3)
 	addi	r3,r3,4
 
 3:	sub	r4,r4,r6
-	srdi	r6,r4,5
+
 	cmpdi	r4,32
+	cmpdi	cr1,r4,512
 	blt	.Lshort_clear
+	bgt	cr1,.Llong_clear
+
+.Lmedium_clear:
+	srdi	r6,r4,5
 	mtctr	r6
 
 	/* Do 32 byte chunks */
@@ -139,3 +150,53 @@ err1;	stb	r0,0(r3)
 
 10:	li	r3,0
 	blr
+
+.Llong_clear:
+	ld	r5,PPC64_CACHES@toc(r2)
+
+	bf	cr7*4+0,11f
+err2;	std	r0,0(r3)
+	addi	r3,r3,8
+	addi	r4,r4,-8
+
+	/* Destination is 16 byte aligned, need to get it cacheline aligned */
+11:	lwz	r7,DCACHEL1LOGLINESIZE(r5)
+	lwz	r9,DCACHEL1LINESIZE(r5)
+
+	/*
+	 * With worst case alignment the long clear loop takes a minimum
+	 * of 1 byte less than 2 cachelines.
+	 */
+	sldi	r10,r9,2
+	cmpd	r4,r10
+	blt	.Lmedium_clear
+
+	neg	r6,r3
+	addi	r10,r9,-1
+	and.	r5,r6,r10
+	beq	13f
+
+	srdi	r6,r5,4
+	mtctr	r6
+	mr	r8,r3
+12:
+err1;	std	r0,0(r3)
+err1;	std	r0,8(r3)
+	addi	r3,r3,16
+	bdnz	12b
+
+	sub	r4,r4,r5
+
+13:	srd	r6,r4,r7
+	mtctr	r6
+	mr	r8,r3
+14:
+err1;	dcbz	r0,r3
+	add	r3,r3,r9
+	bdnz	14b
+
+	and	r4,r4,r10
+
+	cmpdi	r4,32
+	blt	.Lshort_clear
+	b	.Lmedium_clear
