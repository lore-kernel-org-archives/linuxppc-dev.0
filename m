Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17037.35023.212381.62648@cargo.ozlabs.ibm.com>
Date: Fri, 20 May 2005 16:50:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: [PATCH] ppc32: Fix __copy_tofrom_user return value
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Recently the __copy_tofrom_user routine was modified to avoid doing
prefetches past the end of the source array.  However, in doing so we
introduced a bug in that it now returns the wrong value for the number
of bytes not copied when a fault is encountered.  This fixes it to
return the correct number.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff -urN linux-2.6/arch/ppc/lib/string.S pmac-2.5/arch/ppc/lib/string.S
--- linux-2.6/arch/ppc/lib/string.S	2005-04-26 15:37:55.000000000 +1000
+++ pmac-2.5/arch/ppc/lib/string.S	2005-04-26 20:33:39.000000000 +1000
@@ -446,6 +446,7 @@
 #ifdef CONFIG_8xx
 	/* Don't use prefetch on 8xx */
 	mtctr	r0
+	li	r0,0
 53:	COPY_16_BYTES_WITHEX(0)
 	bdnz	53b
 
@@ -564,7 +565,9 @@
 /* or write fault in cacheline loop */
 105:	li	r9,1
 92:	li	r3,LG_CACHELINE_BYTES
-	b	99f
+	mfctr	r8
+	add	r0,r0,r8
+	b	106f
 /* read fault in final word loop */
 108:	li	r9,0
 	b	93f
@@ -585,7 +588,7 @@
  * r5 + (ctr << r3), and r9 is 0 for read or 1 for write.
  */
 99:	mfctr	r0
-	slw	r3,r0,r3
+106:	slw	r3,r0,r3
 	add.	r3,r3,r5
 	beq	120f			/* shouldn't happen */
 	cmpwi	0,r9,0
