Return-Path: <mikey@neuling.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38317DE055
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 16:24:32 +1000 (EST)
To: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 24 Apr 2009 16:24:31 +1000
Subject: [PATCH 1/2] powerpc: Enable CPU feature sections for inline asm
In-Reply-To: <1240554271.668632.486641775152.qpush@pale>
Message-Id: <20090424062431.C2FD8120E6@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Milton Miller <miltonm@bga.com>

powerpc: Enable CPU feature sections for inline asm

This adds the ability to do CPU feature sections for inline asm.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/feature-fixups.h |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/feature-fixups.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/feature-fixups.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/feature-fixups.h
@@ -8,8 +8,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifdef __ASSEMBLY__
-
 /*
  * Feature section common macros
  *
@@ -23,10 +21,12 @@
 /* 64 bits kernel, 32 bits code (ie. vdso32) */
 #define FTR_ENTRY_LONG		.llong
 #define FTR_ENTRY_OFFSET	.long 0xffffffff; .long
+#elif defined(CONFIG_PPC64)
+#define FTR_ENTRY_LONG		.llong
+#define FTR_ENTRY_OFFSET	.llong
 #else
-/* 64 bit kernel 64 bit code, or 32 bit kernel 32 bit code */
-#define FTR_ENTRY_LONG		PPC_LONG
-#define FTR_ENTRY_OFFSET	PPC_LONG
+#define FTR_ENTRY_LONG		.long
+#define FTR_ENTRY_OFFSET	.long
 #endif
 
 #define START_FTR_SECTION(label)	label##1:
@@ -141,6 +141,21 @@ label##5:					       	\
 #define ALT_FW_FTR_SECTION_END_IFCLR(msk)	\
 	ALT_FW_FTR_SECTION_END_NESTED_IFCLR(msk, 97)
 
+#ifndef __ASSEMBLY__
+
+#define ASM_FTR_IF_X(string, estring, msk, val)			\
+	stringify_in_c(BEGIN_FTR_SECTION)			\
+	string "; "						\
+	stringify_in_c(FTR_SECTION_ELSE)			\
+	estring "; "						\
+	stringify_in_c(ALT_FTR_SECTION_END((msk), (val)))
+
+#define ASM_FTR_IFSET(string, estring, msk)			\
+	ASM_FTR_IF_X(string, estring, (msk), (msk))
+
+#define ASM_FTR_IFCLR(string, estring, msk)			\
+	ASM_FTR_IF_X(string, estring, (msk), 0)
+
 #endif /* __ASSEMBLY__ */
 
 /* LWSYNC feature sections */
