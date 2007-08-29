Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDD5DDDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 02:47:51 +1000 (EST)
Date: Wed, 29 Aug 2007 11:47:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 4/9] bootwrapper: Move strncmp() from flatdevtree_env.h to
	string.S/string.h.
Message-ID: <20070829164735.GC31640@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070829164534.GA31585@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It will be needed for PlanetCore firmware support.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
I prepared this patch before David posted his patch which also
does strstr; if you apply that one, then please ignore this one.

 arch/powerpc/boot/flatdevtree_env.h |   14 +-------------
 arch/powerpc/boot/string.S          |   13 +++++++++++++
 arch/powerpc/boot/string.h          |    1 +
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree_env.h b/arch/powerpc/boot/flatdevtree_env.h
index 83bc1c7..643bf7f 100644
--- a/arch/powerpc/boot/flatdevtree_env.h
+++ b/arch/powerpc/boot/flatdevtree_env.h
@@ -2,7 +2,7 @@
  * This file adds the header file glue so that the shared files
  * flatdevicetree.[ch] can compile and work in the powerpc bootwrapper.
  *
- * strncmp & strchr copied from <file:lib/strings.c>
+ * strchr copied from <file:lib/strings.c>
  * Copyright (C) 1991, 1992  Linus Torvalds
  *
  * Maintained by: Mark A. Greer <mgreer@mvista.com>
@@ -24,18 +24,6 @@
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
 static inline char *strchr(const char *s, int c)
 {
 	for (; *s != (char)c; ++s)
diff --git a/arch/powerpc/boot/string.S b/arch/powerpc/boot/string.S
index ac3d43b..ce68c58 100644
--- a/arch/powerpc/boot/string.S
+++ b/arch/powerpc/boot/string.S
@@ -61,6 +61,19 @@ strcmp:
 	beq	1b
 	blr
 
+	.globl strncmp
+strncmp:
+	mtctr	r5
+	addi	r5,r3,-1
+	addi	r4,r4,-1
+1:	lbzu	r3,1(r5)
+	cmpwi	1,r3,0
+	lbzu	r0,1(r4)
+	subf.	r3,r0,r3
+	beqlr	1
+	bdnzt	2, 1b
+	blr
+
 	.globl	strlen
 strlen:
 	addi	r4,r3,-1
diff --git a/arch/powerpc/boot/string.h b/arch/powerpc/boot/string.h
index 9fdff1c..db401b7 100644
--- a/arch/powerpc/boot/string.h
+++ b/arch/powerpc/boot/string.h
@@ -6,6 +6,7 @@ extern char *strcpy(char *dest, const char *src);
 extern char *strncpy(char *dest, const char *src, size_t n);
 extern char *strcat(char *dest, const char *src);
 extern int strcmp(const char *s1, const char *s2);
+extern int strncmp(const char *s1, const char *s2, size_t n);
 extern size_t strlen(const char *s);
 extern size_t strnlen(const char *s, size_t count);
 
-- 
1.5.0.3
