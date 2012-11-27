Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 01/16] powerpc: Add new CPU feature bit for transactional
 memory
Date: Tue, 27 Nov 2012 13:47:53 +1100
Message-Id: <1353984488-1283-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index fc4d2c5..f2163da 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -171,6 +171,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
 #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
+#define CPU_FTR_TM			LONG_ASM_CONST(0x4000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -216,6 +217,13 @@ extern const char *powerpc_base_platform;
 #define PPC_FEATURE_HAS_EFP_DOUBLE_COMP 0
 #endif
 
+/* We only set the TM feature if the kernel was compiled with TM supprt */
+#ifdef CONFIG_TRANSACTIONAL_MEM
+#define CPU_FTR_TM_COMP		CPU_FTR_TM
+#else
+#define CPU_FTR_TM_COMP		0
+#endif
+
 /* We need to mark all pages as being coherent if we're SMP or we have a
  * 74[45]x and an MPC107 host bridge. Also 83xx and PowerQUICC II
  * require it for PCI "streaming/prefetch" to work properly.
-- 
1.7.9.5
