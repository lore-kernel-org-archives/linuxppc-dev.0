Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 3391DDDF26
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 14:04:16 +1000 (EST)
Received: from thor (localhost [127.0.0.1])
	by pythia.bakeyournoodle.com (Postfix) with ESMTP id 7FDFF13BB3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 12:04:15 +0800 (WST)
To: <linuxppc-dev@ozlabs.org>
From: Tony Breeds <tony@bakeyournoodle.com>
Date: Wed, 04 Jul 2007 14:04:31 +1000
Subject: [PATCH 3/3] Initial cut to add __read_mostly support for powerpc.
In-Reply-To: <1183521871.36329.499255149967.qpush@thor>
Message-Id: <20070704040431.1ED7832C46E@thor>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
This didn't get musch feedback the first time I posted it, so it's either
perfect ;P or it got missed.

 arch/powerpc/kernel/vmlinux.lds.S |    6 ++++++
 include/asm-powerpc/cache.h       |    2 ++
 2 files changed, 8 insertions(+)

Index: working/arch/powerpc/kernel/vmlinux.lds.S
===================================================================
--- working.orig/arch/powerpc/kernel/vmlinux.lds.S
+++ working/arch/powerpc/kernel/vmlinux.lds.S
@@ -7,6 +7,7 @@
 #define PROVIDE32(x)	PROVIDE(x)
 #endif
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
 
 ENTRY(_stext)
 
@@ -211,6 +212,11 @@ SECTIONS
 		*(.data.cacheline_aligned)
 	}
 
+	. = ALIGN(L1_CACHE_BYTES);
+	.data.read_mostly : {
+		*(.data.read_mostly)
+	}
+
 	. = ALIGN(PAGE_SIZE);
 	__data_nosave : {
 		__nosave_begin = .;
Index: working/include/asm-powerpc/cache.h
===================================================================
--- working.orig/include/asm-powerpc/cache.h
+++ working/include/asm-powerpc/cache.h
@@ -34,5 +34,9 @@ struct ppc64_caches {
 extern struct ppc64_caches ppc64_caches;
 #endif /* __powerpc64__ && ! __ASSEMBLY__ */
 
+#if !defined(__ASSEMBLY__)
+#define __read_mostly __attribute__((__section__(".data.read_mostly")))
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_CACHE_H */
