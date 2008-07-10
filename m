Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C021DDE1A
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:16:19 +1000 (EST)
Date: Thu, 10 Jul 2008 16:14:53 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch2-1@bga.com>
Subject: [1/3] powerpc: add _HEAD_GLOBAL to place functions in .text.head
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is the first step to moving the interrupt vectors to .text.head.

Rather than creating more repetition, factor out creating a function
descriptor, from declaring it to be global in a section.

The order of .globl and the symbol definitions is changed but is
a don't care.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I left the section in the macros, and added a new macro.   I didn't
want to hunt down other uses of _GLOBAL to audit the section, and _KPROBE
needs to set the section.


diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index 0966899..cb5a4b0 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -178,11 +178,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);					\
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
 
-#define _GLOBAL(name) \
-	.section ".text"; \
+#define _FUNCTION(name) \
 	.align 2 ; \
-	.globl name; \
-	.globl GLUE(.,name); \
 	.section ".opd","aw"; \
 name: \
 	.quad GLUE(.,name); \
@@ -192,57 +189,41 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define _GLOBAL(name) \
+	.section ".text"; \
+	.globl name; \
+	.globl GLUE(.,name); \
+	_FUNCTION(name)
+
 #define _INIT_GLOBAL(name) \
 	.section ".text.init.refok"; \
-	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
+	_FUNCTION(name)
+
+#define _HEAD_GLOBAL(name) \
+	.section ".text.head"; \
+	.globl name; \
+	.globl GLUE(.,name); \
+	_FUNCTION(name)
 
 #define _KPROBE(name) \
 	.section ".kprobes.text","a"; \
-	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
+	_FUNCTION(name)
 
 #define _STATIC(name) \
 	.section ".text"; \
-	.align 2 ; \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
+	_FUNCTION(name)
 
 #define _INIT_STATIC(name) \
 	.section ".text.init.refok"; \
-	.align 2 ; \
-	.section ".opd","aw"; \
-name: \
-	.quad GLUE(.,name); \
-	.quad .TOC.@tocbase; \
-	.quad 0; \
-	.previous; \
-	.type GLUE(.,name),@function; \
-GLUE(.,name):
+	_FUNCTION(name)
+
+#define _HEAD_STATIC(name) \
+	.section ".text.head"; \
+	_FUNCTION(name)
 
 #else /* 32-bit */
 
