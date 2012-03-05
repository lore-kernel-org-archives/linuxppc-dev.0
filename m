Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64606B6F9D
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 13:52:45 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Mon, 5 Mar 2012 02:36:07 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q252kpSG1679594
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:46:54 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q252qPMI006009
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Mar 2012 13:52:26 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/13] powerpc: Use the same interrupt prolog for perfmon as
 other interrupts
Date: Mon,  5 Mar 2012 13:51:20 +1100
Message-Id: <1330915891-19523-3-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
References: <1330915891-19523-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The perfmon interrupt is the sole user of a special variant of the
interrupt prolog which differs from the one used by external and timer
interrupts in that it saves the non-volatile GPRs and doesn't turn the
runlatch on.

The former is unnecessary and the later is arguably incorrect, so
let's clean that up by using the same prolog. While at it we rename
that prolog to use the _ASYNC prefix.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |   17 +++--------------
 arch/powerpc/kernel/exceptions-64s.S     |    6 +++---
 2 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index cc2bcf4..041b222 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -297,21 +297,10 @@ label##_common:						\
 
 /*
  * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
- * in the idle task and therefore need the special idle handling.
+ * in the idle task and therefore need the special idle handling
+ * (finish nap and runlatch)
  */
-#define STD_EXCEPTION_COMMON_IDLE(trap, label, hdlr)	\
-	.align	7;					\
-	.globl label##_common;				\
-label##_common:						\
-	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
-	FINISH_NAP;					\
-	DISABLE_INTS;					\
-	bl	.save_nvgprs;				\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
-	bl	hdlr;					\
-	b	.ret_from_except
-
-#define STD_EXCEPTION_COMMON_LITE(trap, label, hdlr)	\
+#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)	\
 	.align	7;					\
 	.globl label##_common;				\
 label##_common:						\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index fea8a69..2240d4e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -458,15 +458,15 @@ machine_check_common:
 	bl	.machine_check_exception
 	b	.ret_from_except
 
-	STD_EXCEPTION_COMMON_LITE(0x500, hardware_interrupt, do_IRQ)
-	STD_EXCEPTION_COMMON_LITE(0x900, decrementer, .timer_interrupt)
+	STD_EXCEPTION_COMMON_ASYNC(0x500, hardware_interrupt, do_IRQ)
+	STD_EXCEPTION_COMMON_ASYNC(0x900, decrementer, .timer_interrupt)
 	STD_EXCEPTION_COMMON(0xa00, trap_0a, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xb00, trap_0b, .unknown_exception)
 	STD_EXCEPTION_COMMON(0xd00, single_step, .single_step_exception)
 	STD_EXCEPTION_COMMON(0xe00, trap_0e, .unknown_exception)
         STD_EXCEPTION_COMMON(0xe40, emulation_assist, .program_check_exception)
         STD_EXCEPTION_COMMON(0xe60, hmi_exception, .unknown_exception)
-	STD_EXCEPTION_COMMON_IDLE(0xf00, performance_monitor, .performance_monitor_exception)
+	STD_EXCEPTION_COMMON_ASYNC(0xf00, performance_monitor, .performance_monitor_exception)
 	STD_EXCEPTION_COMMON(0x1300, instruction_breakpoint, .instruction_breakpoint_exception)
 #ifdef CONFIG_ALTIVEC
 	STD_EXCEPTION_COMMON(0x1700, altivec_assist, .altivec_assist_exception)
-- 
1.7.9
