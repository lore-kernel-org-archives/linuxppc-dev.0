Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16996.54212.518924.846267@cargo.ozlabs.ibm.com>
Date: Tue, 19 Apr 2005 19:47:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: pestes@us.ibm.com
In-Reply-To: <1113853327.3750.21.camel@unary.wma.ibm.com>
References: <1113853327.3750.21.camel@unary.wma.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: writev test failure related to arch/ppc/lib/string.S changes?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Phil Estes writes:

> Recently I applied some 2.6.7 ppc32 patches to a 2.6.5 kernel, which
> included the 1.1612.2.78 changeset titled "[PATCH] PPC32: Fix copy
> prefetch on non coherent PPCs".  The functionality I meant to get from
> that backport is working fine, but a test team which is testing my
> changes note that a standard LTP testcase in the writev family now
> fails, which they tracked to the changes made in arch/ppc/lib/string.S
> from the above changeset.

Yeah.  This patch should fix it.  Mind testing it and letting us know
how it goes?

Paul.

diff -urN linux/arch/ppc/lib/string.S ppc/arch/ppc/lib/string.S
--- linux/arch/ppc/lib/string.S	2005-01-29 09:58:49.000000000 +1100
+++ ppc/arch/ppc/lib/string.S	2005-04-19 16:54:34.000000000 +1000
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
