Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vykdm35MZzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Apr 2017 21:49:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org,
	oohall@gmail.com
Subject: [PATCH v2] powerpc/64: Fix flush_(d|i)cache_range() called from
 modules
Date: Wed,  5 Apr 2017 21:49:09 +1000
Message-Id: <1491392949-6879-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Oliver O'Halloran <oohall@gmail.com>

When the kernel is compiled to use 64bit ABIv2 the _GLOBAL() macro does
not include a global entry point. A function's global entry point is
used when the function is called from a different TOC context and in the
kernel this typically means a call from a module into the vmlinux (or
vice-versa).

There are a few exported asm functions declared with _GLOBAL() and
calling them from a module will likely crash the kernel since any TOC
relative load will yield garbage.

flush_icache_range() and flush_dcache_range() are both exported to
modules, and use the TOC, so must use _GLOBAL_TOC().

Fixes: 721aeaa9fdf3 ("powerpc: Build little endian ppc64 kernel with ABIv2")
Cc: stable@vger.kernel.org # v3.16+
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/misc_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

v2: mpe: Drop the big comment, for easier backporting, and because we'll fix
this differently in the medium term to avoid using _GLOBAL_TOC() entirely.

diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index ae179cb1bb3c..c119044cad0d 100644
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
2.7.4
