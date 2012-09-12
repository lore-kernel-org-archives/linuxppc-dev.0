Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 580382C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 18:42:12 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v4][PATCH 2/4] powerpc/ppc32: make copy_and_flush() as global
Date: Wed, 12 Sep 2012 16:42:03 +0800
Message-ID: <1347439325-5563-2-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1347439325-5563-1-git-send-email-tiejun.chen@windriver.com>
References: <1347439325-5563-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Somewhere we need this simple copy_and_flush().

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/kernel/entry_32.S |   27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/head_32.S  |   26 --------------------------
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index ead5016..1536d2c 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -32,6 +32,7 @@
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
 #include <asm/ptrace.h>
+#include <asm/cache.h>
 
 #undef SHOW_SYSCALLS
 #undef SHOW_SYSCALLS_TASK
@@ -1265,6 +1266,32 @@ ee_restarts:
 	.previous
 
 /*
+ * Copy routine used to copy the kernel to start at physical address 0
+ * and flush and invalidate the caches as needed.
+ * r3 = dest addr, r4 = source addr, r5 = copy limit, r6 = start offset
+ * on exit, r3, r4, r5 are unchanged, r6 is updated to be >= r5.
+ */
+_GLOBAL(copy_and_flush)
+	addi	r5,r5,-4
+	addi	r6,r6,-4
+4:	li	r0,L1_CACHE_BYTES/4
+	mtctr	r0
+3:	addi	r6,r6,4			/* copy a cache line */
+	lwzx	r0,r6,r4
+	stwx	r0,r6,r3
+	bdnz	3b
+	dcbst	r6,r3			/* write it to memory */
+	sync
+	icbi	r6,r3			/* flush the icache line */
+	cmplw	0,r6,r5
+	blt	4b
+	sync				/* additional sync needed on g4 */
+	isync
+	addi	r5,r5,4
+	addi	r6,r6,4
+	blr
+
+/*
  * PROM code for specific machines follows.  Put it
  * here so it's easy to add arch-specific sections later.
  * -- Cort
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index dc0488b..14ea361 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -777,32 +777,6 @@ relocate_kernel:
 	bl	copy_and_flush		/* copy the rest */
 	b	turn_on_mmu
 
-/*
- * Copy routine used to copy the kernel to start at physical address 0
- * and flush and invalidate the caches as needed.
- * r3 = dest addr, r4 = source addr, r5 = copy limit, r6 = start offset
- * on exit, r3, r4, r5 are unchanged, r6 is updated to be >= r5.
- */
-_ENTRY(copy_and_flush)
-	addi	r5,r5,-4
-	addi	r6,r6,-4
-4:	li	r0,L1_CACHE_BYTES/4
-	mtctr	r0
-3:	addi	r6,r6,4			/* copy a cache line */
-	lwzx	r0,r6,r4
-	stwx	r0,r6,r3
-	bdnz	3b
-	dcbst	r6,r3			/* write it to memory */
-	sync
-	icbi	r6,r3			/* flush the icache line */
-	cmplw	0,r6,r5
-	blt	4b
-	sync				/* additional sync needed on g4 */
-	isync
-	addi	r5,r5,4
-	addi	r6,r6,4
-	blr
-
 #ifdef CONFIG_SMP
 	.globl __secondary_start_mpc86xx
 __secondary_start_mpc86xx:
-- 
1.7.9.5
