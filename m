Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id A99ED2C00A7
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Apr 2013 16:24:27 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add an in memory udbg console
Date: Mon, 29 Apr 2013 16:24:22 +1000
Message-Id: <1367216662-16872-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a new udbg early debug console which utilises
statically defined input and output buffers stored within the kernel
BSS. It is primarily designed to assist with bring up of new hardware
which may not have a working console but which has a method of
reading/writing kernel memory.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/Kconfig.debug         |   23 ++++++++++
 arch/powerpc/include/asm/udbg.h    |    1 +
 arch/powerpc/kernel/udbg.c         |    3 ++
 arch/powerpc/sysdev/Makefile       |    2 +
 arch/powerpc/sysdev/udbg_memcons.c |   85 ++++++++++++++++++++++++++++++++++++
 5 files changed, 114 insertions(+)
 create mode 100644 arch/powerpc/sysdev/udbg_memcons.c

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 5416e28..863d877 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -262,8 +262,31 @@ config PPC_EARLY_DEBUG_OPAL_HVSI
 	  Select this to enable early debugging for the PowerNV platform
 	  using an "hvsi" console
 
+config PPC_EARLY_DEBUG_MEMCONS
+	bool "In memory console"
+	help
+	  Select this to enable early debugging using an in memory console.
+	  This console provides input and output buffers stored within the
+	  kernel BSS and should be safe to select on any system. A debugger
+	  can then be used to read kernel output or send input to the console.
 endchoice
 
+config PPC_MEMCONS_OUTPUT_SIZE
+	int "In memory console output buffer size"
+	depends on PPC_EARLY_DEBUG_MEMCONS
+	default 4096
+	help
+	  Selects the size of the output buffer (in bytes) of the in memory
+	  console.
+
+config PPC_MEMCONS_INPUT_SIZE
+	int "In memory console input buffer size"
+	depends on PPC_EARLY_DEBUG_MEMCONS
+	default 128
+	help
+	  Selects the size of the input buffer (in bytes) of the in memory
+	  console.
+
 config PPC_EARLY_DEBUG_OPAL
 	def_bool y
 	depends on PPC_EARLY_DEBUG_OPAL_RAW || PPC_EARLY_DEBUG_OPAL_HVSI
diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index 5a7510e..dc59091 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -52,6 +52,7 @@ extern void __init udbg_init_40x_realmode(void);
 extern void __init udbg_init_cpm(void);
 extern void __init udbg_init_usbgecko(void);
 extern void __init udbg_init_wsp(void);
+extern void __init udbg_init_memcons(void);
 extern void __init udbg_init_ehv_bc(void);
 extern void __init udbg_init_ps3gelic(void);
 extern void __init udbg_init_debug_opal_raw(void);
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index f974849..efa5c93 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -64,6 +64,9 @@ void __init udbg_early_init(void)
 	udbg_init_usbgecko();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_WSP)
 	udbg_init_wsp();
+#elif defined(CONFIG_PPC_EARLY_DEBUG_MEMCONS)
+	/* In memory console */
+	udbg_init_memcons();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_EHV_BC)
 	udbg_init_ehv_bc();
 #elif defined(CONFIG_PPC_EARLY_DEBUG_PS3GELIC)
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index b0a518e..99464a7 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -64,6 +64,8 @@ endif
 
 obj-$(CONFIG_PPC_SCOM)		+= scom.o
 
+obj-$(CONFIG_PPC_EARLY_DEBUG_MEMCONS)	+= udbg_memcons.o
+
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-$(CONFIG_PPC_XICS)		+= xics/
diff --git a/arch/powerpc/sysdev/udbg_memcons.c b/arch/powerpc/sysdev/udbg_memcons.c
new file mode 100644
index 0000000..36f5c44
--- /dev/null
+++ b/arch/powerpc/sysdev/udbg_memcons.c
@@ -0,0 +1,85 @@
+/*
+ * A udbg backend which logs messages and reads input from in memory
+ * buffers.
+ *
+ * Copyright (C) 2003-2005 Anton Blanchard and Milton Miller, IBM Corp
+ * Copyright (C) 2013 Alistair Popple, IBM Corp
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/udbg.h>
+
+struct memcons {
+	char *output_start;
+	char *output_pos;
+	char *output_end;
+	char *input_start;
+	char *input_pos;
+	char *input_end;
+};
+
+static char memcons_output[CONFIG_PPC_MEMCONS_OUTPUT_SIZE];
+static char memcons_input[CONFIG_PPC_MEMCONS_INPUT_SIZE];
+
+struct memcons memcons = {
+	.output_start = memcons_output,
+	.output_pos = memcons_output,
+	.output_end = &memcons_output[CONFIG_PPC_MEMCONS_OUTPUT_SIZE],
+	.input_start = memcons_input,
+	.input_pos = memcons_input,
+	.input_end = &memcons_input[CONFIG_PPC_MEMCONS_INPUT_SIZE],
+};
+
+void memcons_putc(char c)
+{
+	*memcons.output_pos++ = c;
+	if (memcons.output_pos >= memcons.output_end)
+		memcons.output_pos = memcons.output_start;
+}
+
+int memcons_getc_poll(void)
+{
+	char c;
+
+	if (*memcons.input_pos) {
+		c = *memcons.input_pos;
+		*memcons.input_pos++ = 0;
+
+		if (*memcons.input_pos == '\0' || memcons.input_pos >= memcons.input_end)
+			memcons.input_pos = memcons.input_start;
+
+		return c;
+	}
+
+	return -1;
+}
+
+int memcons_getc(void)
+{
+	int c;
+
+	while (1) {
+		c = memcons_getc_poll();
+		if (c == -1)
+			cpu_relax();
+		else
+			break;
+	}
+
+	return c;
+}
+
+void udbg_init_memcons(void)
+{
+	udbg_putc = memcons_putc;
+	udbg_getc = memcons_getc;
+	udbg_getc_poll = memcons_getc_poll;
+}
-- 
1.7.10.4
