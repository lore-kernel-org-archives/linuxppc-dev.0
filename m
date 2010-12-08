Return-Path: <anton@samba.org>
Date: Wed, 8 Dec 2010 16:58:17 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, sfr@ozlabs.org
Subject: [PATCH] powerpc: Hardcode popcnt instructions for old assemblers
Message-ID: <20101208165817.0df89814@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The popcnt instructions went into binutils relatively recently. As with a
number of other instructions, create macros and hardcode them.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/ppc-opcode.h	2010-12-08 16:50:12.760796093 +1100
+++ powerpc.git/arch/powerpc/include/asm/ppc-opcode.h	2010-12-08 16:57:10.181788576 +1100
@@ -36,6 +36,8 @@
 #define PPC_INST_NOP			0x60000000
 #define PPC_INST_POPCNTB		0x7c0000f4
 #define PPC_INST_POPCNTB_MASK		0xfc0007fe
+#define PPC_INST_POPCNTD		0x7c0003f4
+#define PPC_INST_POPCNTW		0x7c0002f4
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
 #define PPC_INST_RFMCI			0x4c00004c
@@ -88,6 +90,12 @@
 					__PPC_RB(b) | __PPC_EH(eh))
 #define PPC_MSGSND(b)		stringify_in_c(.long PPC_INST_MSGSND | \
 					__PPC_RB(b))
+#define PPC_POPCNTB(a, s)	stringify_in_c(.long PPC_INST_POPCNTB | \
+					__PPC_RA(a) | __PPC_RS(s))
+#define PPC_POPCNTD(a, s)	stringify_in_c(.long PPC_INST_POPCNTD | \
+					__PPC_RA(a) | __PPC_RS(s))
+#define PPC_POPCNTW(a, s)	stringify_in_c(.long PPC_INST_POPCNTW | \
+					__PPC_RA(a) | __PPC_RS(s))
 #define PPC_RFCI		stringify_in_c(.long PPC_INST_RFCI)
 #define PPC_RFDI		stringify_in_c(.long PPC_INST_RFDI)
 #define PPC_RFMCI		stringify_in_c(.long PPC_INST_RFMCI)
Index: powerpc.git/arch/powerpc/lib/hweight_64.S
===================================================================
--- powerpc.git.orig/arch/powerpc/lib/hweight_64.S	2010-12-08 16:50:12.760796093 +1100
+++ powerpc.git/arch/powerpc/lib/hweight_64.S	2010-12-08 16:50:16.560623089 +1100
@@ -28,7 +28,7 @@ BEGIN_FTR_SECTION
 	nop
 	nop
 FTR_SECTION_ELSE
-	popcntb	r3,r3
+	PPC_POPCNTB(r3,r3)
 	clrldi	r3,r3,64-8
 	blr
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POPCNTB)
@@ -42,14 +42,14 @@ BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
   BEGIN_FTR_SECTION_NESTED(50)
-	popcntb r3,r3
+	PPC_POPCNTB(r3,r3)
 	srdi	r4,r3,8
 	add	r3,r4,r3
 	clrldi	r3,r3,64-8
 	blr
   FTR_SECTION_ELSE_NESTED(50)
 	clrlwi  r3,r3,16
-	popcntw	r3,r3
+	PPC_POPCNTW(r3,r3)
 	clrldi	r3,r3,64-8
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 50)
@@ -66,7 +66,7 @@ BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
   BEGIN_FTR_SECTION_NESTED(51)
-	popcntb r3,r3
+	PPC_POPCNTB(r3,r3)
 	srdi	r4,r3,16
 	add	r3,r4,r3
 	srdi	r4,r3,8
@@ -74,7 +74,7 @@ FTR_SECTION_ELSE
 	clrldi	r3,r3,64-8
 	blr
   FTR_SECTION_ELSE_NESTED(51)
-	popcntw	r3,r3
+	PPC_POPCNTW(r3,r3)
 	clrldi	r3,r3,64-8
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 51)
@@ -93,7 +93,7 @@ BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
   BEGIN_FTR_SECTION_NESTED(52)
-	popcntb r3,r3
+	PPC_POPCNTB(r3,r3)
 	srdi	r4,r3,32
 	add	r3,r4,r3
 	srdi	r4,r3,16
@@ -103,7 +103,7 @@ FTR_SECTION_ELSE
 	clrldi	r3,r3,64-8
 	blr
   FTR_SECTION_ELSE_NESTED(52)
-	popcntd	r3,r3
+	PPC_POPCNTD(r3,r3)
 	clrldi	r3,r3,64-8
 	blr
   ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_POPCNTD, 52)
