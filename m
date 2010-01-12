Return-Path: <anton@ozlabs.org>
Date: Tue, 12 Jan 2010 21:50:14 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Mark some variables in the page fault path
	__read_mostly
Message-ID: <20100112105014.GH12666@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Using perf to trace L1 dcache misses and dumping data addresses I found a few
variables taking a lot of misses. Since they are almost never written, they
should go into the __read_mostly section.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/xmon/xmon.c	2010-01-12 14:40:35.436777033 +1100
+++ linux-cpumask/arch/powerpc/xmon/xmon.c	2010-01-12 14:41:30.576726874 +1100
@@ -61,7 +61,7 @@ static int xmon_owner;
 static int xmon_gate;
 #endif /* CONFIG_SMP */
 
-static unsigned long in_xmon = 0;
+static unsigned long in_xmon __read_mostly = 0;
 
 static unsigned long adrs;
 static int size = 1;
Index: linux-cpumask/arch/powerpc/kernel/traps.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/kernel/traps.c	2010-01-12 14:40:29.614225983 +1100
+++ linux-cpumask/arch/powerpc/kernel/traps.c	2010-01-12 14:41:30.576726874 +1100
@@ -60,13 +60,13 @@
 #endif
 
 #if defined(CONFIG_DEBUGGER) || defined(CONFIG_KEXEC)
-int (*__debugger)(struct pt_regs *regs);
-int (*__debugger_ipi)(struct pt_regs *regs);
-int (*__debugger_bpt)(struct pt_regs *regs);
-int (*__debugger_sstep)(struct pt_regs *regs);
-int (*__debugger_iabr_match)(struct pt_regs *regs);
-int (*__debugger_dabr_match)(struct pt_regs *regs);
-int (*__debugger_fault_handler)(struct pt_regs *regs);
+int (*__debugger)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_ipi)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_bpt)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_sstep)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_iabr_match)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_dabr_match)(struct pt_regs *regs) __read_mostly;
+int (*__debugger_fault_handler)(struct pt_regs *regs) __read_mostly;
 
 EXPORT_SYMBOL(__debugger);
 EXPORT_SYMBOL(__debugger_ipi);
