Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFRyQ7329zDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 08:38:38 +1000 (AEST)
Date: Thu, 26 May 2016 08:38:13 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 acsawdey@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: Remove assembly versions of strcpy, strcat,
 strlen and strcmp
Message-ID: <20160526083813.0f96a454@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A number of our assembly implementations of string functions do not
align their hot loops. I was going to align them manually, but I
realised that they are are almost instruction for instruction
identical to what gcc produces, with the advantage that gcc does
align them.

In light of that, let's just remove the assembly versions.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

index e40010a..da3cdff 100644
Index: linux.junk/arch/powerpc/include/asm/string.h
===================================================================
--- linux.junk.orig/arch/powerpc/include/asm/string.h
+++ linux.junk/arch/powerpc/include/asm/string.h
@@ -3,12 +3,8 @@
 
 #ifdef __KERNEL__
 
-#define __HAVE_ARCH_STRCPY
 #define __HAVE_ARCH_STRNCPY
-#define __HAVE_ARCH_STRLEN
-#define __HAVE_ARCH_STRCMP
 #define __HAVE_ARCH_STRNCMP
-#define __HAVE_ARCH_STRCAT
 #define __HAVE_ARCH_MEMSET
 #define __HAVE_ARCH_MEMCPY
 #define __HAVE_ARCH_MEMMOVE
Index: linux.junk/arch/powerpc/lib/ppc_ksyms.c
===================================================================
--- linux.junk.orig/arch/powerpc/lib/ppc_ksyms.c
+++ linux.junk/arch/powerpc/lib/ppc_ksyms.c
@@ -9,11 +9,7 @@ EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memcmp);
 EXPORT_SYMBOL(memchr);
 
-EXPORT_SYMBOL(strcpy);
 EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strcmp);
 EXPORT_SYMBOL(strncmp);
 
 #ifndef CONFIG_GENERIC_CSUM
Index: linux.junk/arch/powerpc/lib/string.S
===================================================================
--- linux.junk.orig/arch/powerpc/lib/string.S
+++ linux.junk/arch/powerpc/lib/string.S
@@ -16,15 +16,6 @@
 	PPC_LONG_ALIGN
 	.text
 	
-_GLOBAL(strcpy)
-	addi	r5,r3,-1
-	addi	r4,r4,-1
-1:	lbzu	r0,1(r4)
-	cmpwi	0,r0,0
-	stbu	r0,1(r5)
-	bne	1b
-	blr
-
 /* This clears out any unused part of the destination buffer,
    just as the libc version does.  -- paulus */
 _GLOBAL(strncpy)
@@ -45,30 +36,6 @@ _GLOBAL(strncpy)
 	bdnz	2b
 	blr
 
-_GLOBAL(strcat)
-	addi	r5,r3,-1
-	addi	r4,r4,-1
-1:	lbzu	r0,1(r5)
-	cmpwi	0,r0,0
-	bne	1b
-	addi	r5,r5,-1
-1:	lbzu	r0,1(r4)
-	cmpwi	0,r0,0
-	stbu	r0,1(r5)
-	bne	1b
-	blr
-
-_GLOBAL(strcmp)
-	addi	r5,r3,-1
-	addi	r4,r4,-1
-1:	lbzu	r3,1(r5)
-	cmpwi	1,r3,0
-	lbzu	r0,1(r4)
-	subf.	r3,r0,r3
-	beqlr	1
-	beq	1b
-	blr
-
 _GLOBAL(strncmp)
 	PPC_LCMPI 0,r5,0
 	beq-	2f
@@ -85,14 +52,6 @@ _GLOBAL(strncmp)
 2:	li	r3,0
 	blr
 
-_GLOBAL(strlen)
-	addi	r4,r3,-1
-1:	lbzu	r0,1(r4)
-	cmpwi	0,r0,0
-	bne	1b
-	subf	r3,r3,r4
-	blr
-
 #ifdef CONFIG_PPC32
 _GLOBAL(memcmp)
 	PPC_LCMPI 0,r5,0
