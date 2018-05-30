Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40whTP5JrlzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 17:06:17 +1000 (AEST)
Message-Id: <23d156759ff411f5fd932e167b8b5f5ecd6aa88b.1527663626.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527663626.git.christophe.leroy@c-s.fr>
References: <cover.1527663626.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 1/2] powerpc/lib: optimise 32 bits __clear_user()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 07:06:13 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rewrite clear_user() on the same principle as memset(0), making use
of dcbz to clear complete cache lines.

This code is a copy/paste of memset(), with some modifications
in order to retrieve remaining number of bytes to be cleared,
as it needs to be returned in case of error.

On the same way as done on PPC64 in commit 17968fbbd19f1
("powerpc: 64bit optimised __clear_user"), the patch moves
__clear_user() into a dedicated file string_32.S

On a MPC885, throughput is almost doubled:

Before:
~# dd if=/dev/zero of=/dev/null bs=1M count=1000
1048576000 bytes (1000.0MB) copied, 18.990779 seconds, 52.7MB/s

After:
~# dd if=/dev/zero of=/dev/null bs=1M count=1000
1048576000 bytes (1000.0MB) copied, 9.611468 seconds, 104.0MB/s

On a MPC8321, throughput is multiplied by 2.12:

Before:
root@vgoippro:~# dd if=/dev/zero of=/dev/null bs=1M count=1000
1048576000 bytes (1000.0MB) copied, 6.844352 seconds, 146.1MB/s

After:
root@vgoippro:~# dd if=/dev/zero of=/dev/null bs=1M count=1000
1048576000 bytes (1000.0MB) copied, 3.218854 seconds, 310.7MB/s

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/Makefile    |  5 ++-
 arch/powerpc/lib/string.S    | 46 ----------------------
 arch/powerpc/lib/string_32.S | 90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 48 deletions(-)
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
index 0378def28d41..5343a88e619e 100644
--- a/arch/powerpc/lib/string.S
+++ b/arch/powerpc/lib/string.S
@@ -8,8 +8,6 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  */
-#include <asm/processor.h>
-#include <asm/errno.h>
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 #include <asm/cache.h>
@@ -86,47 +84,3 @@ _GLOBAL(memchr)
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
index 000000000000..6de67d2dbad6
--- /dev/null
+++ b/arch/powerpc/lib/string_32.S
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * String handling functions for PowerPC32
+ *
+ * Copyright (C) 1996 Paul Mackerras.
+ *
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/export.h>
+#include <asm/cache.h>
+
+	.text
+
+CACHELINE_BYTES = L1_CACHE_BYTES
+LG_CACHELINE_BYTES = L1_CACHE_SHIFT
+CACHELINE_MASK = (L1_CACHE_BYTES-1)
+
+_GLOBAL(__clear_user)
+/*
+ * Use dcbz on the complete cache lines in the destination
+ * to set them to zero.  This requires that the destination
+ * area is cacheable.
+ */
+	cmplwi	cr0, r4, 4
+	mr	r10, r3
+	li	r3, 0
+	blt	7f
+
+11:	stw	r3, 0(r10)
+	beqlr
+	andi.	r0, r10, 3
+	add	r11, r0, r4
+	subf	r6, r0, r10
+
+	clrlwi	r7, r6, 32 - LG_CACHELINE_BYTES
+	add	r8, r7, r11
+	srwi	r9, r8, LG_CACHELINE_BYTES
+	addic.	r9, r9, -1	/* total number of complete cachelines */
+	ble	2f
+	xori	r0, r7, CACHELINE_MASK & ~3
+	srwi.	r0, r0, 2
+	beq	3f
+	mtctr	r0
+4:	stwu	r3, 4(r6)
+	bdnz	4b
+3:	mtctr	r9
+	li	r7, 4
+10:	dcbz	r7, r6
+	addi	r6, r6, CACHELINE_BYTES
+	bdnz	10b
+	clrlwi	r11, r8, 32 - LG_CACHELINE_BYTES
+	addi	r11, r11, 4
+
+2:	srwi	r0 ,r11 ,2
+	mtctr	r0
+	bdz	6f
+1:	stwu	r3, 4(r6)
+	bdnz	1b
+6:	andi.	r11, r11, 3
+	beqlr
+	mtctr	r11
+	addi	r6, r6, 3
+8:	stbu	r3, 1(r6)
+	bdnz	8b
+	blr
+
+7:	cmpwi	cr0, r4, 0
+	beqlr
+	mtctr	r4
+	addi	r6, r10, -1
+9:	stbu	r3, 1(r6)
+	bdnz	9b
+	blr
+
+90:	mr	r3, r4
+	blr
+91:	add	r3, r10, r4
+	subf	r3, r6, r3
+	blr
+
+	EX_TABLE(11b, 90b)
+	EX_TABLE(4b, 91b)
+	EX_TABLE(10b, 91b)
+	EX_TABLE(1b, 91b)
+	EX_TABLE(8b, 91b)
+	EX_TABLE(9b, 91b)
+
+EXPORT_SYMBOL(__clear_user)
-- 
2.13.3
