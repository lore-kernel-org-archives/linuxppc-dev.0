Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Oct 2007 12:36:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: powerpc commits for 2.6.24
Message-ID: <20071012023620.GB21056@localhost.localdomain>
References: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18190.5965.836544.396721@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

One more for you.  This is preparation for the libfdt merge.

Add memchr() to the bootwrapper

This patch adds a memchr() implementation to the bootwrapper.  libfdt
will need this.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/string.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/string.S	2007-09-27 18:36:21.000000000 +1000
+++ working-2.6/arch/powerpc/boot/string.S	2007-09-27 18:40:24.000000000 +1000
@@ -219,6 +219,19 @@ backwards_memcpy:
 	mtctr	r7
 	b	1b
 
+	.globl	memchr
+memchr:
+	cmpwi	0,r5,0
+	blelr
+	mtctr	r5
+	addi	r3,r3,-1
+1:	lbzu	r0,1(r3)
+	cmpw	r0,r4
+	beqlr
+	bdnz	1b
+	li	r3,0
+	blr
+
 	.globl	memcmp
 memcmp:
 	cmpwi	0,r5,0
Index: working-2.6/arch/powerpc/boot/string.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/string.h	2007-09-27 18:40:27.000000000 +1000
+++ working-2.6/arch/powerpc/boot/string.h	2007-09-27 18:40:58.000000000 +1000
@@ -14,6 +14,7 @@ extern size_t strnlen(const char *s, siz
 extern void *memset(void *s, int c, size_t n);
 extern void *memmove(void *dest, const void *src, unsigned long n);
 extern void *memcpy(void *dest, const void *src, unsigned long n);
+extern void *memchr(const void *s, int c, size_t n);
 extern int memcmp(const void *s1, const void *s2, size_t n);
 
 #endif	/* _PPC_BOOT_STRING_H_ */


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
