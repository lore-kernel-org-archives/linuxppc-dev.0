Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 57A501400E3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Apr 2014 09:07:38 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>
Subject: [PATCH 1/2] powerpc: drop return value from set_breakpoint as it is
 unused
Date: Tue, 29 Apr 2014 15:25:16 -0400
Message-ID: <1398799517-47879-2-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1398799517-47879-1-git-send-email-paul.gortmaker@windriver.com>
References: <1398799517-47879-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

None of the callers check the return value, so it might as
well not have one at all.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/include/asm/debug.h | 2 +-
 arch/powerpc/kernel/process.c    | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index d2516308ed1e..1d7f966d3b18 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -46,7 +46,7 @@ static inline int debugger_break_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
-int set_breakpoint(struct arch_hw_breakpoint *brk);
+void set_breakpoint(struct arch_hw_breakpoint *brk);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int signal_code, int brkpt);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 31d021506d21..c4e3d50e86f8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -495,14 +495,14 @@ static inline int set_dawr(struct arch_hw_breakpoint *brk)
 	return 0;
 }
 
-int set_breakpoint(struct arch_hw_breakpoint *brk)
+void set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	__get_cpu_var(current_brk) = *brk;
 
 	if (cpu_has_feature(CPU_FTR_DAWR))
-		return set_dawr(brk);
-
-	return set_dabr(brk);
+		set_dawr(brk);
+	else
+		set_dabr(brk);
 }
 
 #ifdef CONFIG_PPC64
-- 
1.9.0
