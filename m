Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 16:39:55 +1100
Subject: [PATCH 2/9] powerpc: Fix asm EMIT_BUG_ENTRY with !CONFIG_BUG
In-Reply-To: <1228714789.103940.266501677728.qpush@grosgo>
Message-Id: <20081208054046.9B42EDDE19@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Instead of not defining it at all, this defines the macro as
being empty, thus avoiding ifdef's in call sites when CONFIG_BUG
is not set.

Also removes an extra whitespace in the existing definition

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/bug.h |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/include/asm/bug.h	2008-12-08 14:37:16.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/bug.h	2008-12-08 15:14:21.000000000 +1100
@@ -3,6 +3,7 @@
 #ifdef __KERNEL__
 
 #include <asm/asm-compat.h>
+
 /*
  * Define an illegal instr to trap on the bug.
  * We don't use 0 because that marks the end of a function
@@ -14,6 +15,7 @@
 #ifdef CONFIG_BUG
 
 #ifdef __ASSEMBLY__
+#include <asm/asm-offsets.h>
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 .macro EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"a"
@@ -26,7 +28,7 @@
 	 .previous
 .endm
 #else
- .macro EMIT_BUG_ENTRY addr,file,line,flags
+.macro EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"a"
 5001:	 PPC_LONG \addr
 	 .short \flags
@@ -113,6 +115,13 @@
 #define HAVE_ARCH_BUG_ON
 #define HAVE_ARCH_WARN_ON
 #endif /* __ASSEMBLY __ */
+#else
+#ifdef __ASSEMBLY__
+.macro EMIT_BUG_ENTRY addr,file,line,flags
+.endm
+#else /* !__ASSEMBLY__ */
+#define _EMIT_BUG_ENTRY
+#endif
 #endif /* CONFIG_BUG */
 
 #include <asm-generic/bug.h>
