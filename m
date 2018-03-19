Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404qQ56ctQzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 08:46:21 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 404qQ53fnbz9sVm
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2018 08:46:21 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc: Book E: Remove unused CPU_FTR_L2CSR bit
Date: Tue, 20 Mar 2018 08:46:12 +1100
Message-Id: <1521495973-3237-3-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1521495973-3237-1-git-send-email-paulus@ozlabs.org>
References: <1521495973-3237-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_FTR_L2CSR bit is never tested anywhere, so let's reclaim the bit.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/cputable.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 052db18..761b99c 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -139,7 +139,6 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_TAU			ASM_CONST(0x00000010)
 #define CPU_FTR_CAN_DOZE		ASM_CONST(0x00000020)
 #define CPU_FTR_USE_RTC			ASM_CONST(0x00000040)
-#define CPU_FTR_L2CSR			ASM_CONST(0x00000080)
 #define CPU_FTR_601			ASM_CONST(0x00000100)
 #define CPU_FTR_DBELL			ASM_CONST(0x00000200)
 #define CPU_FTR_CAN_NAP			ASM_CONST(0x00000400)
@@ -385,18 +384,18 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500MC	(CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
 /*
  * e5500/e6500 erratum A-006958 is a timebase bug that can use the
  * same workaround as CPU_FTR_CELL_TB_BUG.
  */
 #define CPU_FTRS_E5500	(CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_CELL_TB_BUG)
 #define CPU_FTRS_E6500	(CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
 	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT)
-- 
2.7.4
