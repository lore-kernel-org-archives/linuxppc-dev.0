Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxHYN5PKyzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 13:25:28 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 81so26739692pgh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 02 Apr 2017 20:25:28 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/misc: fix exported functions that reference the TOC
Date: Mon,  3 Apr 2017 13:25:12 +1000
Message-Id: <20170403032512.22085-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the kernel is compiled to use 64bit ABIv2 the _GLOBAL() macro does not
include a global entry point. A function's global entry point is used when the
function is called from a different TOC context and in the kernel this
typically means a call from a module into the vmlinux (or vis-a-vis).

There are a few exported ASM functions declared with _GLOBAL() and calling
them from a module will module will likely crash the kernel since any TOC
relative load will yield garbage.

To fix this use _GLOBAL_TOC() for exported asm functions rather than _GLOBAL()
and some documentation about when to use each.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/include/asm/ppc_asm.h | 12 ++++++++++++
 arch/powerpc/kernel/misc_64.S      |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c443..3abf8c3 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -198,6 +198,18 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 
 #ifdef PPC64_ELF_ABI_v2
 
+/*
+ * When to use _GLOBAL_TOC() instead of _GLOBAL():
+ *
+ * a) The function is exported using EXPORT_SYMBOL_*()
+ *          *and*
+ * b) The function, or any function that it calls, references the TOC.
+ *
+ * In this situation _GLOBAL_TOC() is required because exported functions are
+ * callable from modules which may a different TOC to the kernel proper and the
+ * _GLOBAL() macro skips the TOC setup which is required on ELF ABIv2.
+ */
+
 #define _GLOBAL(name) \
 	.align 2 ; \
 	.type name,@function; \
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index ec94aef..d18da8c 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -67,7 +67,7 @@ PPC64_CACHES:
  *   flush all bytes from start through stop-1 inclusive
  */
 
-_GLOBAL(flush_icache_range)
+_GLOBAL_TOC(flush_icache_range)
 BEGIN_FTR_SECTION
 	PURGE_PREFETCHED_INS
 	blr
@@ -120,7 +120,7 @@ EXPORT_SYMBOL(flush_icache_range)
  *
  *    flush all bytes from start to stop-1 inclusive
  */
-_GLOBAL(flush_dcache_range)
+_GLOBAL_TOC(flush_dcache_range)
 
 /*
  * Flush the data cache to memory 
-- 
2.9.3
