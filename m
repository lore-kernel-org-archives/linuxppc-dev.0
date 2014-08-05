Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B3B1A0192
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 14:54:59 +1000 (EST)
Date: Tue, 5 Aug 2014 14:55:00 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 paulmck@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc: Hard disable interrupts in xmon
Message-ID: <20140805145500.773004e9@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xmon only soft disables interrupts. This seems like a bad idea - we
certainly don't want decrementer and PMU exceptions going off when
we are debugging something inside xmon.

This issue was uncovered when the hard lockup detector went off
inside xmon. To ensure we wont get a spurious hard lockup warning,
I also call touch_nmi_watchdog() when exiting xmon.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/xmon/xmon.c
===================================================================
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/bug.h>
+#include <linux/nmi.h>
 
 #include <asm/ptrace.h>
 #include <asm/string.h>
@@ -374,6 +375,7 @@ static int xmon_core(struct pt_regs *reg
 #endif
 
 	local_irq_save(flags);
+	hard_irq_disable();
 
 	bp = in_breakpoint_table(regs->nip, &offset);
 	if (bp != NULL) {
@@ -558,6 +560,7 @@ static int xmon_core(struct pt_regs *reg
 #endif
 	insert_cpu_bpts();
 
+	touch_nmi_watchdog();
 	local_irq_restore(flags);
 
 	return cmd != 'X' && cmd != EOF;
