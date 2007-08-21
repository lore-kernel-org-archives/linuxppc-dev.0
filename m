Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 13:06:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 16/20] bootwrapper: Move strncmp() and strchr() from
	flatdevtree_env.h to string.h.
Message-ID: <20070821030641.GP15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174007.GO30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820174007.GO30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:40:07PM -0500, Scott Wood wrote:
> strncmp() will be needed for PlanetCore firmware support.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Hmm.  They should be moved, but if we are, I'm inclined to implement
them in string.S with the rest of the string functions, rather than as
inlines.  Below is a patch I've had in my queue for some time which
does exactly that for strchr().

Move bootwrapper's strchr() from .h to string.S

Currently the bootwrapper has an implementation of strchr(), but it's
done as an inline in flatdevtree_env.h, rather than implemented in
string.S with the rest of the string functions.  This patch moves it
to string.S, matching the other string functions.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/string.S
===================================================================
--- working-2.6.orig/arch/powerpc/boot/string.S	2007-06-28 14:30:16.000000000 +1000
+++ working-2.6/arch/powerpc/boot/string.S	2007-06-28 14:38:01.000000000 +1000
@@ -49,6 +49,17 @@
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
Index: working-2.6/arch/powerpc/boot/string.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/string.h	2007-06-28 14:38:52.000000000 +1000
+++ working-2.6/arch/powerpc/boot/string.h	2007-06-28 14:39:14.000000000 +1000
@@ -5,6 +5,7 @@
 extern char *strcpy(char *dest, const char *src);
 extern char *strncpy(char *dest, const char *src, size_t n);
 extern char *strcat(char *dest, const char *src);
+extern char *strchr(const char *s, int c);
 extern int strcmp(const char *s1, const char *s2);
 extern size_t strlen(const char *s);
 extern size_t strnlen(const char *s, size_t count);
Index: working-2.6/arch/powerpc/boot/flatdevtree_env.h
===================================================================
--- working-2.6.orig/arch/powerpc/boot/flatdevtree_env.h	2007-06-28 14:39:55.000000000 +1000
+++ working-2.6/arch/powerpc/boot/flatdevtree_env.h	2007-06-28 14:40:00.000000000 +1000
@@ -36,12 +36,4 @@
 	return __res;
 }
 
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
