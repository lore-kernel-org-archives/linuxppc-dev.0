Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34A761A01E7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 21:04:13 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 21 Apr 2015 16:34:10 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 77CEAE0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 16:36:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3LB3wow32178408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 16:33:59 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3LB3nKr000665
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 16:33:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH RFC] powerpc/ftrace: add powerpc timebase as a trace clock
 source
Date: Tue, 21 Apr 2015 16:33:36 +0530
Message-Id: <1429614216-30538-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
Cc: paulus@samba.org, rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a new powerpc-specific trace clock using the timebase register,
similar to x86-tsc. This gives us a fast, monotonic, cross-cpu clock
for trace entries and can be used to correlate events across cpus as
well as across hypervisor and guest (assuming it is not a migrated guest
with a non-zero tb_offset).

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
I have followed the approach used by x86-tsc here, but we could get rid of
trace_clock.c if we directly use get_tb() with perhaps the notrace annotation.
Would that be preferable?

Thanks,
Naveen


 Documentation/trace/ftrace.txt         |  5 +++++
 arch/powerpc/include/asm/Kbuild        |  1 -
 arch/powerpc/include/asm/trace_clock.h | 27 +++++++++++++++++++++++++++
 arch/powerpc/kernel/Makefile           |  1 +
 arch/powerpc/kernel/trace_clock.c      | 15 +++++++++++++++
 5 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/trace_clock.h
 create mode 100644 arch/powerpc/kernel/trace_clock.c

diff --git a/Documentation/trace/ftrace.txt b/Documentation/trace/ftrace.txt
index 572ca92..689f61a 100644
--- a/Documentation/trace/ftrace.txt
+++ b/Documentation/trace/ftrace.txt
@@ -346,6 +346,11 @@ of ftrace. Here is a list of some of the key files:
 	  x86-tsc: Architectures may define their own clocks. For
 	  	   example, x86 uses its own TSC cycle clock here.
 
+	  ppc-tb: This uses the powerpc timebase register value.
+		  This is in sync across CPUs and can also be used
+		  to correlate events across hypervisor/guest if
+		  tb_offset is known.
+
 	To set a clock, simply echo the clock name into this file.
 
 	  echo global > trace_clock
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 382b28e..5041c66 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,5 +5,4 @@ generic-y += mcs_spinlock.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += scatterlist.h
-generic-y += trace_clock.h
 generic-y += vtime.h
diff --git a/arch/powerpc/include/asm/trace_clock.h b/arch/powerpc/include/asm/trace_clock.h
new file mode 100644
index 0000000..0b0d094
--- /dev/null
+++ b/arch/powerpc/include/asm/trace_clock.h
@@ -0,0 +1,27 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
+ */
+
+#ifndef _ASM_PPC_TRACE_CLOCK_H
+#define _ASM_PPC_TRACE_CLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_TRACE_CLOCK
+
+extern u64 notrace trace_clock_ppc_tb(void);
+
+#define ARCH_TRACE_CLOCKS { trace_clock_ppc_tb, "ppc-tb", 0 },
+
+#else
+
+#define ARCH_TRACE_CLOCKS
+
+#endif /* CONFIG_TRACE_CLOCK */
+
+#endif  /* _ASM_PPC_TRACE_CLOCK_H */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 502cf69..f9936f3 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -118,6 +118,7 @@ obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
+obj-$(CONFIG_TRACE_CLOCK)	+= trace_clock.o
 
 ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
 obj-y				+= iomap.o
diff --git a/arch/powerpc/kernel/trace_clock.c b/arch/powerpc/kernel/trace_clock.c
new file mode 100644
index 0000000..4917069
--- /dev/null
+++ b/arch/powerpc/kernel/trace_clock.c
@@ -0,0 +1,15 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
+ */
+
+#include <asm/trace_clock.h>
+#include <asm/time.h>
+
+u64 notrace trace_clock_ppc_tb(void)
+{
+	return get_tb();
+}
-- 
2.3.5
