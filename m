Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHgCR29YzzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 18:14:10 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id d28so5881471pfe.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 00:14:10 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 1/2] powerpc/lib: Implement PMEM API
Date: Thu, 19 Oct 2017 18:13:54 +1100
Message-Id: <20171019071355.15324-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement the architecture specific cache maintence functions that make
up the "PMEM API". Currently the writeback and invalidate functions
are the same since the function of the DCBST (data cache block store)
instruction is typically interpreted as "writeback to the point of
coherency" rather than to memory. As a result implementing the API
requires a full cache flush rather than just a cache write back. This
will probably change in the not-too-distant future.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/Kconfig      |  1 +
 arch/powerpc/lib/Makefile |  2 +-
 arch/powerpc/lib/pmem.c   | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/lib/pmem.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 809c468edab1..0996add8a572 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -138,6 +138,7 @@ config PPC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 50d5bf954cff..7aa237d10546 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -23,7 +23,7 @@ endif
 
 obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
 	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
-	   memcpy_64.o memcmp_64.o
+	   memcpy_64.o memcmp_64.o pmem.o
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
diff --git a/arch/powerpc/lib/pmem.c b/arch/powerpc/lib/pmem.c
new file mode 100644
index 000000000000..0fa09262ca13
--- /dev/null
+++ b/arch/powerpc/lib/pmem.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright(c) 2017 IBM Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+
+#include <linux/string.h>
+#include <linux/export.h>
+
+#include <asm/cacheflush.h>
+
+/*
+ * CONFIG_ARCH_HAS_PMEM_API symbols
+ */
+void arch_wb_cache_pmem(void *addr, size_t size)
+{
+	unsigned long start = (unsigned long) addr;
+	flush_inval_dcache_range(start, start + size);
+}
+EXPORT_SYMBOL(arch_wb_cache_pmem);
+
+void arch_invalidate_pmem(void *addr, size_t size)
+{
+	unsigned long start = (unsigned long) addr;
+	flush_inval_dcache_range(start, start + size);
+}
+EXPORT_SYMBOL(arch_invalidate_pmem);
-- 
2.9.5
