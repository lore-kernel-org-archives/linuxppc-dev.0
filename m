Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCJ6LW2zF27b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:32 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 1/8] powerpc: Add ppc_breakpoint_available()
Date: Tue, 27 Mar 2018 15:37:17 +1100
Message-Id: <20180327043724.13862-2-mikey@neuling.org>
In-Reply-To: <20180327043724.13862-1-mikey@neuling.org>
References: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ppc_breakpoint_available() to determine if a breakpoint is
available currently via the DAWR or DABR.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/debug.h |  1 +
 arch/powerpc/kernel/process.c    | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index fc97404de0..ce5da214ff 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -47,6 +47,7 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 
 void set_breakpoint(struct arch_hw_breakpoint *brk);
 void __set_breakpoint(struct arch_hw_breakpoint *brk);
+bool ppc_breakpoint_available(void);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int brkpt);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ec4f363ebb..24a591b4db 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -827,6 +827,18 @@ void set_breakpoint(struct arch_hw_breakpoint *brk)
 	preempt_enable();
 }
 
+/* Check if we have DAWR or DABR hardware */
+bool ppc_breakpoint_available(void)
+{
+	if (cpu_has_feature(CPU_FTR_DAWR))
+		return true; /* POWER8 DAWR */
+	if (cpu_has_feature(CPU_FTR_ARCH_207S))
+		return false; /* POWER9 with DAWR disabled */
+	/* DABR: Everything but POWER8 and POWER9 */
+	return true;
+}
+EXPORT_SYMBOL_GPL(ppc_breakpoint_available);
+
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
 #endif
-- 
2.14.1
