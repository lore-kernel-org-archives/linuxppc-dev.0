Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40r0rv4746zDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 02:06:55 +1000 (AEST)
Message-Id: <6c0d2a733ded800e504eefe971be903661aea089.1527004752.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527004752.git.christophe.leroy@c-s.fr>
References: <cover.1527004752.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 1/3] powerpc/lib: move PPC32 specific functions out of
 string.S
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 May 2018 18:06:51 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation of optimisation patches, move PPC32 specific
memcmp() and __clear_user() into string_32.S

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/Makefile    |  5 +--
 arch/powerpc/lib/string.S    | 61 -------------------------------------
 arch/powerpc/lib/string_32.S | 72 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 63 deletions(-)
 create mode 100644 arch/powerpc/lib/string_32.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 653901042ad7..2c9b8c0adf22 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -26,13 +26,14 @@ obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
 			       memcpy_power7.o
 
 obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
-	   string_64.o memcpy_64.o memcmp_64.o pmem.o
+	   memcpy_64.o memcmp_64.o pmem.o
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
 
-obj-y			+= checksum_$(BITS).o checksum_wrappers.o
+obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
+			   string_$(BITS).o
 
 obj-y			+= sstep.o ldstfp.o quad.o
 obj64-y			+= quad.o
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 0378def28d41..b03c1a6861f4 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -56,23 +56,6 @@ _GLOBAL(strncmp)
 	blr
 EXPORT_SYMBOL(strncmp)
 
-#ifdef CONFIG_PPC32
-_GLOBAL(memcmp)
-	PPC_LCMPI 0,r5,0
-	beq-	2f
-	mtctr	r5
-	addi	r6,r3,-1
-	addi	r4,r4,-1
-1:	lbzu	r3,1(r6)
-	lbzu	r0,1(r4)
-	subf.	r3,r0,r3
-	bdnzt	2,1b
-	blr
-2:	li	r3,0
-	blr
-EXPORT_SYMBOL(memcmp)
-#endif
-
 _GLOBAL(memchr)
 	PPC_LCMPI 0,r5,0
 	beq-	2f
@@ -86,47 +69,3 @@ _GLOBAL(memchr)
 2:	li	r3,0
 	blr
 EXPORT_SYMBOL(memchr)
-
-#ifdef CONFIG_PPC32
-_GLOBAL(__clear_user)
-	addi	r6,r3,-4
-	li	r3,0
-	li	r5,0
-	cmplwi	0,r4,4
-	blt	7f
-	/* clear a single word */
-11:	stwu	r5,4(r6)
-	beqlr
-	/* clear word sized chunks */
-	andi.	r0,r6,3
-	add	r4,r0,r4
-	subf	r6,r0,r6
-	srwi	r0,r4,2
-	andi.	r4,r4,3
-	mtctr	r0
-	bdz	7f
-1:	stwu	r5,4(r6)
-	bdnz	1b
-	/* clear byte sized chunks */
-7:	cmpwi	0,r4,0
-	beqlr
-	mtctr	r4
-	addi	r6,r6,3
-8:	stbu	r5,1(r6)
-	bdnz	8b
-	blr
-90:	mr	r3,r4
-	blr
-91:	mfctr	r3
-	slwi	r3,r3,2
-	add	r3,r3,r4
-	blr
-92:	mfctr	r3
-	blr
-
-	EX_TABLE(11b, 90b)
-	EX_TABLE(1b, 91b)
-	EX_TABLE(8b, 92b)
-
-EXPORT_SYMBOL(__clear_user)
-#endif
diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
new file mode 100644
index 000000000000..204db8a834fd
--- /dev/null
+++ b/arch/powerpc/lib/string_32.S
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * String handling functions for PowerPC32
+ *
+ * Copyright (C) 1996 Paul Mackerras.
+ *
+ */
+
+#include <asm/processor.h>
+#include <asm/errno.h>
+#include <asm/ppc_asm.h>
+#include <asm/export.h>
+
+	.text
+
+_GLOBAL(memcmp)
+	cmpwi	cr0, r5, 0
+	beq-	2f
+	mtctr	r5
+	addi	r6,r3,-1
+	addi	r4,r4,-1
+1:	lbzu	r3,1(r6)
+	lbzu	r0,1(r4)
+	subf.	r3,r0,r3
+	bdnzt	2,1b
+	blr
+2:	li	r3,0
+	blr
+EXPORT_SYMBOL(memcmp)
+
+_GLOBAL(__clear_user)
+	addi	r6,r3,-4
+	li	r3,0
+	li	r5,0
+	cmplwi	0,r4,4
+	blt	7f
+	/* clear a single word */
+11:	stwu	r5,4(r6)
+	beqlr
+	/* clear word sized chunks */
+	andi.	r0,r6,3
+	add	r4,r0,r4
+	subf	r6,r0,r6
+	srwi	r0,r4,2
+	andi.	r4,r4,3
+	mtctr	r0
+	bdz	7f
+1:	stwu	r5,4(r6)
+	bdnz	1b
+	/* clear byte sized chunks */
+7:	cmpwi	0,r4,0
+	beqlr
+	mtctr	r4
+	addi	r6,r6,3
+8:	stbu	r5,1(r6)
+	bdnz	8b
+	blr
+90:	mr	r3,r4
+	blr
+91:	mfctr	r3
+	slwi	r3,r3,2
+	add	r3,r3,r4
+	blr
+92:	mfctr	r3
+	blr
+
+	EX_TABLE(11b, 90b)
+	EX_TABLE(1b, 91b)
+	EX_TABLE(8b, 92b)
+
+EXPORT_SYMBOL(__clear_user)
-- 
2.13.3
