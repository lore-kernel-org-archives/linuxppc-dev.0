Return-Path: <anton@ozlabs.org>
Date: Sun, 18 Oct 2009 22:13:00 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, mingo@elte.hu, paulus@samba.org,
	a.p.zijlstra@chello.nl
Subject: [PATCH 3/3] powerpc perf_event: Add alignment-faults and
	emulation-faults software events
Message-ID: <20091018111300.GM4808@kryten>
References: <20091018110929.GK4808@kryten> <20091018111126.GL4808@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091018111126.GL4808@kryten>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hook up the alignment-faults and emulation-faults events for powerpc.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/include/asm/emulated_ops.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/emulated_ops.h	2009-09-22 13:45:07.000000000 +1000
+++ linux.trees.git/arch/powerpc/include/asm/emulated_ops.h	2009-09-22 13:45:27.000000000 +1000
@@ -19,6 +19,7 @@
 #define _ASM_POWERPC_EMULATED_OPS_H
 
 #include <asm/atomic.h>
+#include <linux/perf_event.h>
 
 
 #ifdef CONFIG_PPC_EMULATED_STATS
@@ -71,7 +72,18 @@ extern void ppc_warn_emulated_print(cons
 
 #endif /* !CONFIG_PPC_EMULATED_STATS */
 
-#define PPC_WARN_EMULATED(type, regs)	__PPC_WARN_EMULATED(type)
-#define PPC_WARN_ALIGNMENT(type, regs)	__PPC_WARN_EMULATED(type)
+#define PPC_WARN_EMULATED(type, regs)					\
+	do {								\
+		perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS,		\
+			1, 0, regs, 0);					\
+		__PPC_WARN_EMULATED(type);				\
+	} while (0)
+
+#define PPC_WARN_ALIGNMENT(type, regs)					\
+	do {								\
+		perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS,		\
+			1, 0, regs, regs->dar);				\
+		__PPC_WARN_EMULATED(type);				\
+	} while (0)
 
 #endif /* _ASM_POWERPC_EMULATED_OPS_H */
