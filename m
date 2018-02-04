Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zYz7p0wjxzDr6n
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Feb 2018 16:00:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v4.4 backport 02/16] powerpc/64: Fix flush_(d|i)cache_range()
 called from modules
Date: Sun,  4 Feb 2018 15:59:56 +1100
Message-Id: <20180204050010.13669-3-mpe@ellerman.id.au>
In-Reply-To: <20180204050010.13669-1-mpe@ellerman.id.au>
References: <20180204050010.13669-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Oliver O'Halloran <oohall@gmail.com>

commit 8f5f525d5b83f7d76a6baf9c4e94d4bf312ea7f6 upstream.

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

[mpe: We can't use _GLOBAL_TOC() in 4.4 for flush_icache_range() because
 the function needs to be in the .kprobes.text section, which is done by the
 _KPROBE() macro. So we have to add a _KPROBE_TOC() macro, which does the TOC
 setup and also puts the function in the .kprobes.text section]

Fixes: 721aeaa9fdf3 ("powerpc: Build little endian ppc64 kernel with ABIv2")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc_asm.h | 12 ++++++++++++
 arch/powerpc/kernel/misc_64.S      |  4 ++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index dd0fc18d8103..160bb2311bbb 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -224,6 +224,16 @@ name: \
 	.globl name; \
 name:
 
+#define _KPROBE_TOC(name)			\
+	.section ".kprobes.text","a";		\
+	.align 2 ;				\
+	.type name,@function;			\
+	.globl name;				\
+name:						\
+0:	addis r2,r12,(.TOC.-0b)@ha;		\
+	addi r2,r2,(.TOC.-0b)@l;		\
+	.localentry name,.-name
+
 #define DOTSYM(a)	a
 
 #else
@@ -261,6 +271,8 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define _KPROBE_TOC(n)	_KPROBE(n)
+
 #define DOTSYM(a)	GLUE(.,a)
 
 #endif
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index db475d41b57a..415e58565745 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -66,7 +66,7 @@ PPC64_CACHES:
  *   flush all bytes from start through stop-1 inclusive
  */
 
-_KPROBE(flush_icache_range)
+_KPROBE_TOC(flush_icache_range)
 BEGIN_FTR_SECTION
 	PURGE_PREFETCHED_INS
 	blr
@@ -117,7 +117,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
  *
  *    flush all bytes from start to stop-1 inclusive
  */
-_GLOBAL(flush_dcache_range)
+_GLOBAL_TOC(flush_dcache_range)
 
 /*
  * Flush the data cache to memory 
-- 
2.14.1
