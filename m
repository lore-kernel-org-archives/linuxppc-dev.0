Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHmxW1SYxzF0hG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 13:32:46 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc: Remove useless EXC_COMMON_HV
Date: Fri, 12 Jan 2018 13:28:48 +1100
Message-Id: <20180112022849.30899-4-benh@kernel.crashing.org>
In-Reply-To: <20180112022849.30899-1-benh@kernel.crashing.org>
References: <20180112022849.30899-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only difference between EXC_COMMON_HV and EXC_COMMON is that the
former adds "2" to the trap number which is supposed to represent the
fact that this is an "HV" interrupt which uses HSRR0/1.

However KVM is the only one who cares and it has its own separate macros.

In fact, we only have one user of EXC_COMMON_HV and it's for an
unknown interrupt case. All the other ones already using EXC_COMMON.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/head-64.h   | 7 +------
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/head-64.h b/arch/powerpc/include/asm/head-64.h
index fdcff76e9a25..0a663dfc28b5 100644
--- a/arch/powerpc/include/asm/head-64.h
+++ b/arch/powerpc/include/asm/head-64.h
@@ -178,7 +178,7 @@ end_##sname:
  * TRAMP_REAL_*   - real, unrelocated helpers (virt can call these)
  * TRAMP_VIRT_*   - virt, unreloc helpers (in practice, real can use)
  * TRAMP_KVM      - KVM handlers that get put into real, unrelocated
- * EXC_COMMON_*   - virt, relocated common handlers
+ * EXC_COMMON     - virt, relocated common handlers
  *
  * The EXC handlers are given a name, and branch to name_common, or the
  * appropriate KVM or masking function. Vector handler verieties are as
@@ -211,7 +211,6 @@ end_##sname:
  * EXC_COMMON_BEGIN/END - used to open-code the handler
  * EXC_COMMON
  * EXC_COMMON_ASYNC
- * EXC_COMMON_HV
  *
  * TRAMP_REAL and TRAMP_VIRT can be used with BEGIN/END. KVM
  * and OOL handlers are implemented as types of TRAMP and TRAMP_VIRT handlers.
@@ -413,10 +412,6 @@ end_##sname:
 	EXC_COMMON_BEGIN(name);						\
 	STD_EXCEPTION_COMMON_ASYNC(realvec, name, hdlr);		\
 
-#define EXC_COMMON_HV(name, realvec, hdlr)				\
-	EXC_COMMON_BEGIN(name);						\
-	STD_EXCEPTION_COMMON(realvec + 0x2, name, hdlr);		\
-
 #endif /* __ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_HEAD_64_H */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e441b469dc8f..175891c6909c 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1318,7 +1318,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	b	.
 #endif
 
-EXC_COMMON_HV(denorm_common, 0x1500, unknown_exception)
+EXC_COMMON(denorm_common, 0x1500, unknown_exception)
 
 
 #ifdef CONFIG_CBE_RAS
-- 
2.14.3
