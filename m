Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61143C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:42:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88EF2080D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88EF2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v2jx22WHzDqLb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:42:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2Vs4LhXzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:32:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43v2Vs32GFz9s4V; Tue,  5 Feb 2019 22:32:37 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2Vs277xz9sNM; Tue,  5 Feb 2019 22:32:37 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v16 03/21] powerpc: Avoid circular header inclusion in
 mmu-hash.h
Date: Tue,  5 Feb 2019 22:32:01 +1100
Message-Id: <20190205113219.17903-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205113219.17903-1-mpe@ellerman.id.au>
References: <20190205113219.17903-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h includes
asm/current.h. This generates a circular dependency. To avoid that,
asm/processor.h shall not be included in mmu-hash.h.

In order to do that, this patch moves into a new header called
asm/task_size_64/32.h all the TASK_SIZE related constants, which can
then be included in mmu-hash.h directly.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
[mpe: Split out all the TASK_SIZE constants not just 64-bit ones]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   2 +-
 arch/powerpc/include/asm/processor.h          | 100 +-----------------
 arch/powerpc/include/asm/task_size_32.h       |  21 ++++
 arch/powerpc/include/asm/task_size_64.h       |  79 ++++++++++++++
 arch/powerpc/kvm/book3s_hv_hmi.c              |   1 +
 5 files changed, 107 insertions(+), 96 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size_32.h
 create mode 100644 arch/powerpc/include/asm/task_size_64.h

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 12e522807f9f..a28a28079edb 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -23,7 +23,7 @@
  */
 #include <asm/book3s/64/pgtable.h>
 #include <asm/bug.h>
-#include <asm/processor.h>
+#include <asm/task_size_64.h>
 #include <asm/cpu_has_feature.h>
 
 /*
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index ee58526cb6c2..d9b1503ba0f0 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -77,105 +77,15 @@ extern int _chrp_type;
 
 #ifdef __KERNEL__
 
-struct task_struct;
-void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);
-void release_thread(struct task_struct *);
-
-#ifdef CONFIG_PPC32
-
-#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
-#error User TASK_SIZE overlaps with KERNEL_START address
-#endif
-#define TASK_SIZE	(CONFIG_TASK_SIZE)
-
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 8 * 3)
-#endif
-
 #ifdef CONFIG_PPC64
-/*
- * 64-bit user address space can have multiple limits
- * For now supported values are:
- */
-#define TASK_SIZE_64TB  (0x0000400000000000UL)
-#define TASK_SIZE_128TB (0x0000800000000000UL)
-#define TASK_SIZE_512TB (0x0002000000000000UL)
-#define TASK_SIZE_1PB   (0x0004000000000000UL)
-#define TASK_SIZE_2PB   (0x0008000000000000UL)
-/*
- * With 52 bits in the address we can support
- * upto 4PB of range.
- */
-#define TASK_SIZE_4PB   (0x0010000000000000UL)
-
-/*
- * For now 512TB is only supported with book3s and 64K linux page size.
- */
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
-/*
- * Max value currently used:
- */
-#define TASK_SIZE_USER64		TASK_SIZE_4PB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
-#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
-#else
-#define TASK_SIZE_USER64		TASK_SIZE_64TB
-#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
-/*
- * We don't need to allocate extended context ids for 4K page size, because
- * we limit the max effective address on this config to 64TB.
- */
-#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
-#endif
-
-/*
- * 32-bit user address space is 4GB - 1 page
- * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
- */
-#define TASK_SIZE_USER32 (0x0000000100000000UL - (1*PAGE_SIZE))
-
-#define TASK_SIZE_OF(tsk) (test_tsk_thread_flag(tsk, TIF_32BIT) ? \
-		TASK_SIZE_USER32 : TASK_SIZE_USER64)
-#define TASK_SIZE	  TASK_SIZE_OF(current)
-/* This decides where the kernel will search for a free chunk of vm
- * space during mmap's.
- */
-#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
-#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
-
-#define TASK_UNMAPPED_BASE ((is_32bit_task()) ? \
-		TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64 )
-#endif
-
-/*
- * Initial task size value for user applications. For book3s 64 we start
- * with 128TB and conditionally enable upto 512TB
- */
-#ifdef CONFIG_PPC_BOOK3S_64
-#define DEFAULT_MAP_WINDOW	((is_32bit_task()) ?			\
-				 TASK_SIZE_USER32 : DEFAULT_MAP_WINDOW_USER64)
+#include <asm/task_size_64.h>
 #else
-#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#include <asm/task_size_32.h>
 #endif
 
-#ifdef __powerpc64__
-
-#define STACK_TOP_USER64 DEFAULT_MAP_WINDOW_USER64
-#define STACK_TOP_USER32 TASK_SIZE_USER32
-
-#define STACK_TOP (is_32bit_task() ? \
-		   STACK_TOP_USER32 : STACK_TOP_USER64)
-
-#define STACK_TOP_MAX TASK_SIZE_USER64
-
-#else /* __powerpc64__ */
-
-#define STACK_TOP TASK_SIZE
-#define STACK_TOP_MAX	STACK_TOP
-
-#endif /* __powerpc64__ */
+struct task_struct;
+void start_thread(struct pt_regs *regs, unsigned long fdptr, unsigned long sp);
+void release_thread(struct task_struct *);
 
 typedef struct {
 	unsigned long seg;
diff --git a/arch/powerpc/include/asm/task_size_32.h b/arch/powerpc/include/asm/task_size_32.h
new file mode 100644
index 000000000000..de7290ee770f
--- /dev/null
+++ b/arch/powerpc/include/asm/task_size_32.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_TASK_SIZE_32_H
+#define _ASM_POWERPC_TASK_SIZE_32_H
+
+#if CONFIG_TASK_SIZE > CONFIG_KERNEL_START
+#error User TASK_SIZE overlaps with KERNEL_START address
+#endif
+
+#define TASK_SIZE (CONFIG_TASK_SIZE)
+
+/*
+ * This decides where the kernel will search for a free chunk of vm space during
+ * mmap's.
+ */
+#define TASK_UNMAPPED_BASE (TASK_SIZE / 8 * 3)
+
+#define DEFAULT_MAP_WINDOW TASK_SIZE
+#define STACK_TOP TASK_SIZE
+#define STACK_TOP_MAX STACK_TOP
+
+#endif /* _ASM_POWERPC_TASK_SIZE_32_H */
diff --git a/arch/powerpc/include/asm/task_size_64.h b/arch/powerpc/include/asm/task_size_64.h
new file mode 100644
index 000000000000..eab4779f6b84
--- /dev/null
+++ b/arch/powerpc/include/asm/task_size_64.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_TASK_SIZE_64_H
+#define _ASM_POWERPC_TASK_SIZE_64_H
+
+/*
+ * 64-bit user address space can have multiple limits
+ * For now supported values are:
+ */
+#define TASK_SIZE_64TB  (0x0000400000000000UL)
+#define TASK_SIZE_128TB (0x0000800000000000UL)
+#define TASK_SIZE_512TB (0x0002000000000000UL)
+#define TASK_SIZE_1PB   (0x0004000000000000UL)
+#define TASK_SIZE_2PB   (0x0008000000000000UL)
+
+/*
+ * With 52 bits in the address we can support up to 4PB of range.
+ */
+#define TASK_SIZE_4PB   (0x0010000000000000UL)
+
+/*
+ * For now 512TB is only supported with book3s and 64K linux page size.
+ */
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
+/*
+ * Max value currently used:
+ */
+#define TASK_SIZE_USER64		TASK_SIZE_4PB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
+#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
+#else
+#define TASK_SIZE_USER64		TASK_SIZE_64TB
+#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
+
+/*
+ * We don't need to allocate extended context ids for 4K page size, because we
+ * limit the max effective address on this config to 64TB.
+ */
+#define TASK_CONTEXT_SIZE TASK_SIZE_64TB
+#endif
+
+/*
+ * 32-bit user address space is 4GB - 1 page
+ * (this 1 page is needed so referencing of 0xFFFFFFFF generates EFAULT
+ */
+#define TASK_SIZE_USER32 (0x0000000100000000UL - (1 * PAGE_SIZE))
+
+#define TASK_SIZE_OF(tsk)						\
+	(test_tsk_thread_flag(tsk, TIF_32BIT) ? TASK_SIZE_USER32 :	\
+						TASK_SIZE_USER64)
+
+#define TASK_SIZE TASK_SIZE_OF(current)
+
+#define TASK_UNMAPPED_BASE_USER32 (PAGE_ALIGN(TASK_SIZE_USER32 / 4))
+#define TASK_UNMAPPED_BASE_USER64 (PAGE_ALIGN(DEFAULT_MAP_WINDOW_USER64 / 4))
+
+/*
+ * This decides where the kernel will search for a free chunk of vm space during
+ * mmap's.
+ */
+#define TASK_UNMAPPED_BASE	\
+	((is_32bit_task()) ? TASK_UNMAPPED_BASE_USER32 : TASK_UNMAPPED_BASE_USER64)
+
+/*
+ * Initial task size value for user applications. For book3s 64 we start
+ * with 128TB and conditionally enable upto 512TB
+ */
+#ifdef CONFIG_PPC_BOOK3S_64
+#define DEFAULT_MAP_WINDOW	\
+	((is_32bit_task()) ? TASK_SIZE_USER32 : DEFAULT_MAP_WINDOW_USER64)
+#else
+#define DEFAULT_MAP_WINDOW	TASK_SIZE
+#endif
+
+#define STACK_TOP_USER64 DEFAULT_MAP_WINDOW_USER64
+#define STACK_TOP_USER32 TASK_SIZE_USER32
+#define STACK_TOP_MAX TASK_SIZE_USER64
+#define STACK_TOP (is_32bit_task() ? STACK_TOP_USER32 : STACK_TOP_USER64)
+
+#endif /* _ASM_POWERPC_TASK_SIZE_64_H */
diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
index e3f738eb1cac..64b5011475c7 100644
--- a/arch/powerpc/kvm/book3s_hv_hmi.c
+++ b/arch/powerpc/kvm/book3s_hv_hmi.c
@@ -24,6 +24,7 @@
 #include <linux/compiler.h>
 #include <asm/paca.h>
 #include <asm/hmi.h>
+#include <asm/processor.h>
 
 void wait_for_subcore_guest_exit(void)
 {
-- 
2.20.1

