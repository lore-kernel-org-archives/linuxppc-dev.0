Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxhx105wvzDr3B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 20:29:09 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u62so3811241pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 03:29:08 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-nvdimm@lists.01.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [RFC 3/4] powerpc: Add pmem API support
Date: Tue, 27 Jun 2017 20:28:50 +1000
Message-Id: <20170627102851.15484-3-oohall@gmail.com>
In-Reply-To: <20170627102851.15484-1-oohall@gmail.com>
References: <20170627102851.15484-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds powerpc64 implementations of:

	memcpy_flushcache()
	arch_wb_cache_pmem()
	arch_invalidate_pmem()

Which form the architecture-specific portition of the persistent memory
API. These functions provide cache-management primitives for the DAX
drivers and libNVDIMM.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
This should go on to of the ZONE_DEVICE patches. If you want a full tree
there's one here that's based on next-20170626 with Dan's libnvdimm-pending
branch merged in: https://github.com/oohal/linux/tree/ppc-nvdimm-4.13
---
 arch/powerpc/Kconfig            |  1 +
 arch/powerpc/include/asm/pmem.h | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 arch/powerpc/include/asm/pmem.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4526c9ba09b6..f551f3a26130 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -127,6 +127,7 @@ config PPC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_PMEM_API                if PPC64
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
diff --git a/arch/powerpc/include/asm/pmem.h b/arch/powerpc/include/asm/pmem.h
new file mode 100644
index 000000000000..7b0282e420fc
--- /dev/null
+++ b/arch/powerpc/include/asm/pmem.h
@@ -0,0 +1,42 @@
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
+#ifndef __ASM_PMEM_H__
+#define __ASM_PMEM_H__
+
+#include <linux/string.h>
+#include <asm/cacheflush.h>
+
+#ifdef CONFIG_ARCH_HAS_PMEM_API
+static inline void arch_wb_cache_pmem(void *addr, size_t size)
+{
+	unsigned long start = (unsigned long) addr;
+	flush_inval_dcache_range(start, start + size);
+}
+
+static inline void arch_invalidate_pmem(void *addr, size_t size)
+{
+	unsigned long start = (unsigned long) addr;
+	flush_inval_dcache_range(start, start + size);
+}
+
+static inline void *memcpy_flushcache(void *dest, const void *src, size_t size)
+{
+	unsigned long start = (unsigned long) dest;
+
+	memcpy(dest, src, size);
+	flush_inval_dcache_range(start, start + size);
+
+	return dest;
+}
+#endif /* CONFIG_ARCH_HAS_PMEM_API */
+#endif /* __ASM_PMEM_H__ */
-- 
2.9.4
