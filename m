Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 30 Mar 2006 17:13:01 +1100
Subject: [PATCH 4/5] powerpc: Use flush_icache_range() in create_instruction()
In-Reply-To: <1143699173.339118.857634197021.qpush@concordia>
Message-Id: <20060330061314.582B967A5F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that ppc64_caches is setup with default values, we can call
flush_icache_range() from create_instruction() rather than using our own
asm version.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/util.h |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: to-merge/include/asm-powerpc/util.h
===================================================================
--- to-merge.orig/include/asm-powerpc/util.h
+++ to-merge/include/asm-powerpc/util.h
@@ -5,12 +5,14 @@
 #ifndef _ASM_POWERPC_UTIL_H
 #define _ASM_POWERPC_UTIL_H
 
+#include <asm/cacheflush.h>
+
 static inline void create_instruction(unsigned long addr, unsigned int instr)
 {
 	unsigned int *p;
 	p  = (unsigned int *)addr;
 	*p = instr;
-	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" : : "r" (p));
+	flush_icache_range(addr, addr + 4);
 }
 
 /* Flags for create_branch:
