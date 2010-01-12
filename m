Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [RFC,PATCH 2/7 v2] Generic support for fixed-rate clocks
Message-Id: <1263279511.160846.853659232765.2.gpush@pororo>
In-Reply-To: <1263279511.160127.576969496193.0.gpush@pororo>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Tue, 12 Jan 2010 17:58:31 +1100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since most platforms will need a fixed-rate clock, add one. This will
also serve as a basic example of an implementation of struct clk.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 include/linux/clk.h |   12 ++++++++++++
 kernel/Makefile     |    1 +
 kernel/clk.c        |   25 +++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/linux/clk.h b/include/linux/clk.h
index 1a6199e..8293421 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -97,6 +97,18 @@ static inline struct clk *clk_get_parent(struct clk *clk)
 	return ERR_PTR(-ENOSYS);
 }
 
+/* Simple fixed-rate clock */
+struct clk_fixed {
+	struct clk	clk;
+	unsigned long	rate;
+};
+
+extern struct clk_operations clk_fixed_operations;
+
+#define DEFINE_CLK_FIXED(r) { \
+	.clk = { .ops = &clk_fixed_operations }, \
+	.rate = (r) \
+};
 
 #else /* !CONFIG_USE_COMMON_STRUCT_CLK */
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 864ff75..f63d021 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SLOW_WORK_DEBUG) += slow-work-debugfs.o
 obj-$(CONFIG_PERF_EVENTS) += perf_event.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
+obj-$(CONFIG_USE_COMMON_STRUCT_CLK) += clk.o
 
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --git a/kernel/clk.c b/kernel/clk.c
new file mode 100644
index 0000000..353736c
--- /dev/null
+++ b/kernel/clk.c
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2010 Canonical Ltd <jeremy.kerr@canonical.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Standard functionality for the common clock API.
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+
+#define to_clk_fixed(clk) (container_of(clk, struct clk_fixed, clk))
+
+static unsigned long clk_fixed_get_rate(struct clk *clk)
+{
+	return to_clk_fixed(clk)->rate;
+}
+
+struct clk_operations clk_fixed_operations = {
+	.get_rate = clk_fixed_get_rate,
+};
+
+EXPORT_SYMBOL_GPL(clk_fixed_operations);
