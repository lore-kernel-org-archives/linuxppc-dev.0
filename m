Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80Y2mWszF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:49 +1000 (AEST)
Message-Id: <ca05e12efcf3c274c97a4813e304db28f0ee6c92.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 10/14] powerpc: fix includes in asm/processor.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:45 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove superflous includes and add missing ones

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hw_breakpoint.h | 1 +
 arch/powerpc/include/asm/processor.h     | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 8e7b09703ca4..3637588d3f6d 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -55,6 +55,7 @@ struct arch_hw_breakpoint {
 struct perf_event;
 struct pmu;
 struct perf_sample_data;
+struct task_struct;
 
 #define HW_BREAKPOINT_ALIGN 0x7
 
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index c4b36a494a63..74ed654928f0 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -39,10 +39,9 @@
 #endif /* CONFIG_PPC64 */
 
 #ifndef __ASSEMBLY__
-#include <linux/compiler.h>
-#include <linux/cache.h>
+#include <linux/types.h>
+#include <asm/thread_info.h>
 #include <asm/ptrace.h>
-#include <asm/types.h>
 #include <asm/hw_breakpoint.h>
 
 /* We do _not_ want to define new machine types at all, those must die
-- 
2.13.3
