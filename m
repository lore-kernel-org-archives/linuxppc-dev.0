Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40whTR54j9zDr6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 17:06:19 +1000 (AEST)
Message-Id: <e3b55565fe2dc503466ce5882a8ec0a768f81af9.1527663626.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527663626.git.christophe.leroy@c-s.fr>
References: <cover.1527663626.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 2/2] powerpc/lib: optimise PPC32 memcmp
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 07:06:15 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the time being, memcmp() compares two chunks of memory
byte per byte.

This patch optimises the comparison by comparing word by word.

On the same way as commit 15c2d45d17418 ("powerpc: Add 64bit
optimised memcmp"), this patch moves memcmp() into a dedicated
file named memcmp_32.S

A small benchmark performed on an 8xx comparing two chuncks
of 512 bytes performed 100000 times gives:

Before : 5852274 TB ticks
After:   1488638 TB ticks

This is almost 4 times faster

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/Makefile    |  4 ++--
 arch/powerpc/lib/memcmp_32.S | 45 ++++++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/string.S    | 17 -----------------
 3 files changed, 47 insertions(+), 19 deletions(-)
 create mode 100644 arch/powerpc/lib/memcmp_32.S

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 2c9b8c0adf22..d0ca13ad8231 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -26,14 +26,14 @@ obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
 			       memcpy_power7.o
 
 obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
-	   memcpy_64.o memcmp_64.o pmem.o
+	   memcpy_64.o pmem.o
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 obj64-$(CONFIG_KPROBES_SANITY_TEST) += test_emulate_step.o
 
 obj-y			+= checksum_$(BITS).o checksum_wrappers.o \
-			   string_$(BITS).o
+			   string_$(BITS).o memcmp_$(BITS).o
 
 obj-y			+= sstep.o ldstfp.o quad.o
 obj64-y			+= quad.o
diff --git a/arch/powerpc/lib/memcmp_32.S b/arch/powerpc/lib/memcmp_32.S
new file mode 100644
index 000000000000..dcb6ab45be66
--- /dev/null
+++ b/arch/powerpc/lib/memcmp_32.S
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * memcmp for PowerPC32
+ *
+ * Copyright (C) 1996 Paul Mackerras.
+ *
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/export.h>
+
+	.text
+
+_GLOBAL(memcmp)
+	srawi.	r7, r5, 2		/* Divide len by 4 */
+	mr	r6, r3
+	beq-	3f
+	mtctr	r7
+	li	r7, 0
+1:	lwzx	r3, r6, r7
+	lwzx	r0, r4, r7
+	addi	r7, r7, 4
+	cmplw	cr0, r3, r0
+	bdnzt	eq, 1b
+	bne	5f
+3:	andi.	r3, r5, 3
+	beqlr
+	cmplwi	cr1, r3, 2
+	blt-	cr1, 4f
+	lhzx	r3, r6, r7
+	lhzx	r0, r4, r7
+	addi	r7, r7, 2
+	subf.	r3, r0, r3
+	beqlr	cr1
+	bnelr
+4:	lbzx	r3, r6, r7
+	lbzx	r0, r4, r7
+	subf.	r3, r0, r3
+	blr
+5:	li	r3, 1
+	bgtlr
+	li	r3, -1
+	blr
+EXPORT_SYMBOL(memcmp)
diff --git a/arch/powerpc/lib/string.S b/arch/powerpc/lib/string.S
index 5343a88e619e..4b41970e9ed8 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -54,23 +54,6 @@ _GLOBAL(strncmp)
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
-- 
2.13.3
