Return-Path: <dgibson@ozlabs.org>
Date: Tue, 28 Aug 2007 14:52:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Move bootwrapper's strchr() and strncmp() from .h to string.S
Message-ID: <20070828045257.GE6811@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the bootwrapper has implementations of strchr() and
strncmp(), but they're inlines in flatdevtree_env.h, rather than in
string.S with all the rest of the string functions.  This patch moves
them to string.S.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

Paul, please apply to the for-2.6.24 branch.

Index: working-2.6/arch/powerpc/boot/string.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/string.S	2006-12-08 10:42:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/string.S	2007-08-28 14:48:52.000000000 +1000
@@ -49,6 +49,17 @@ strcat:
 	bne	1b
 	blr
 
+	.globl	strchr
+strchr:
+	addi	r3,r3,-1
+1:	lbzu	r0,1(r3)
+	cmpw	0,r0,r4
+	beqlr
+	cmpwi	0,r0,0
+	bne	1b
+	li	r3,0
+	blr
+
 	.globl	strcmp
 strcmp:
 	addi	r5,r3,-1
@@ -61,6 +72,19 @@ strcmp:
 	beq	1b
 	blr
 
+	.globl	strncmp
+strncmp:
+	mtctr	r5
+	addi	r5,r3,-1
+	addi	r4,r4,-1
+1:	lbzu	r3,1(r5)
+	cmpwi	1,r3,0
+	lbzu	r0,1(r4)
+	subf.	r3,r0,r3
+	beqlr	1
+	bdnzt	eq,1b
+	blr
+
 	.globl	strlen
 strlen:
 	addi	r4,r3,-1
Index: working-2.6/arch/powerpc/boot/string.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/string.h	2006-12-08 10:42:48.000000000 +1100
+++ working-2.6/arch/powerpc/boot/string.h	2007-08-28 14:49:14.000000000 +1000
@@ -5,7 +5,9 @@
 extern char *strcpy(char *dest, const char *src);
 extern char *strncpy(char *dest, const char *src, size_t n);
 extern char *strcat(char *dest, const char *src);
+extern char *strchr(const char *s, int c);
 extern int strcmp(const char *s1, const char *s2);
+extern int strncmp(const char *s1, const char *s2, size_t n);
 extern size_t strlen(const char *s);
 extern size_t strnlen(const char *s, size_t count);
 
Index: working-2.6/arch/powerpc/boot/flatdevtree_env.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/flatdevtree_env.h	2007-08-15 16:56:30.000000000 +1000
+++ working-2.6/arch/powerpc/boot/flatdevtree_env.h	2007-08-28 14:38:29.000000000 +1000
@@ -24,24 +24,4 @@
 #define be64_to_cpu(x)		(x)
 #define cpu_to_be64(x)		(x)
 
-static inline int strncmp(const char *cs, const char *ct, size_t count)
-{
-	signed char __res = 0;
-
-	while (count) {
-		if ((__res = *cs - *ct++) != 0 || !*cs++)
-			break;
-		count--;
-	}
-	return __res;
-}
-
-static inline char *strchr(const char *s, int c)
-{
-	for (; *s != (char)c; ++s)
-		if (*s == '\0')
-			return NULL;
-	return (char *)s;
-}
-
 #endif /* _PPC_BOOT_FLATDEVTREE_ENV_H_ */

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
