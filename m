Return-Path: <mgreer@mvista.com>
Date: Thu, 7 Sep 2006 20:36:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 2/6] bootwrapper: Add in OF operations (and rename to of.c)
Message-ID: <20060908033611.GB5203@mag.az.mvista.com>
References: <20060719230318.GC3887@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719230318.GC3887@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the operations necessary for the bootwrapper to run on
an OF platform.  This code used to be in prom.[ch] but was moved to of.c
because its a more accurate name (IMHO).

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

 arch/powerpc/boot/prom.c     |  165 ------------------------
 arch/powerpc/boot/prom.h     |   41 ------
 b/arch/powerpc/boot/Makefile |    5 
 b/arch/powerpc/boot/of.c     |  286 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 290 insertions(+), 207 deletions(-)
--

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index afc776f..c2bb541 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -36,7 +36,10 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S prom.c stdio.c main.c div64.S
+src-boot := crt0.S string.S stdio.c main.c div64.S
+ifeq ($(CONFIG_PPC_MULTIPLATFORM),y)
+src-boot += of.c
+endif
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
new file mode 100644
index 0000000..10fc108
--- /dev/null
+++ b/arch/powerpc/boot/of.c
@@ -0,0 +1,286 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+typedef void *ihandle;
+typedef void *phandle;
+
+extern char _end[];
+
+/* Value picked to match that used by yaboot */
+#define PROG_START	0x01400000	/* only used on 64-bit systems */
+#define RAM_END		(512<<20)	/* Fixme: use OF */
+#define	ONE_MB		0x100000
+
+int (*prom) (void *);
+
+
+static unsigned long claim_base;
+
+static int call_prom(const char *service, int nargs, int nret, ...)
+{
+	int i;
+	struct prom_args {
+		const char *service;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
+
+	va_start(list, nret);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
+
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
+
+	if (prom(&args) < 0)
+		return -1;
+
+	return (nret > 0)? args.args[nargs]: 0;
+}
+
+static int call_prom_ret(const char *service, int nargs, int nret,
+		  unsigned int *rets, ...)
+{
+	int i;
+	struct prom_args {
+		const char *service;
+		int nargs;
+		int nret;
+		unsigned int args[12];
+	} args;
+	va_list list;
+
+	args.service = service;
+	args.nargs = nargs;
+	args.nret = nret;
+
+	va_start(list, rets);
+	for (i = 0; i < nargs; i++)
+		args.args[i] = va_arg(list, unsigned int);
+	va_end(list);
+
+	for (i = 0; i < nret; i++)
+		args.args[nargs+i] = 0;
+
+	if (prom(&args) < 0)
+		return -1;
+
+	if (rets != (void *) 0)
+		for (i = 1; i < nret; ++i)
+			rets[i-1] = args.args[nargs+i];
+
+	return (nret > 0)? args.args[nargs]: 0;
+}
+
+/*
+ * Older OF's require that when claiming a specific range of addresses,
+ * we claim the physical space in the /memory node and the virtual
+ * space in the chosen mmu node, and then do a map operation to
+ * map virtual to physical.
+ */
+static int need_map = -1;
+static ihandle chosen_mmu;
+static phandle memory;
+
+/* returns true if s2 is a prefix of s1 */
+static int string_match(const char *s1, const char *s2)
+{
+	for (; *s2; ++s2)
+		if (*s1++ != *s2)
+			return 0;
+	return 1;
+}
+
+static int check_of_version(void)
+{
+	phandle oprom, chosen;
+	char version[64];
+
+	oprom = finddevice("/openprom");
+	if (oprom == (phandle) -1)
+		return 0;
+	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
+		return 0;
+	version[sizeof(version)-1] = 0;
+	printf("OF version = '%s'\r\n", version);
+	if (!string_match(version, "Open Firmware, 1.")
+	    && !string_match(version, "FirmWorks,3."))
+		return 0;
+	chosen = finddevice("/chosen");
+	if (chosen == (phandle) -1) {
+		chosen = finddevice("/chosen@0");
+		if (chosen == (phandle) -1) {
+			printf("no chosen\n");
+			return 0;
+		}
+	}
+	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
+		printf("no mmu\n");
+		return 0;
+	}
+	memory = (ihandle) call_prom("open", 1, 1, "/memory");
+	if (memory == (ihandle) -1) {
+		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
+		if (memory == (ihandle) -1) {
+			printf("no memory node\n");
+			return 0;
+		}
+	}
+	printf("old OF detected\r\n");
+	return 1;
+}
+
+static void *claim(unsigned long virt, unsigned long size, unsigned long align)
+{
+	int ret;
+	unsigned int result;
+
+	if (need_map < 0)
+		need_map = check_of_version();
+	if (align || !need_map)
+		return (void *) call_prom("claim", 3, 1, virt, size, align);
+
+	ret = call_prom_ret("call-method", 5, 2, &result, "claim", memory,
+			    align, size, virt);
+	if (ret != 0 || result == -1)
+		return (void *) -1;
+	ret = call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
+			    align, size, virt);
+	/* 0x12 == coherent + read/write */
+	ret = call_prom("call-method", 6, 1, "map", chosen_mmu,
+			0x12, size, virt, virt);
+	return (void *) virt;
+}
+
+static void *of_try_claim(u32 size)
+{
+	unsigned long addr = 0;
+	static u8 first_time = 1;
+
+	if (first_time) {
+		claim_base = _ALIGN_UP((unsigned long)_end, ONE_MB);
+#if defined(PROG_START)
+		/*
+		 * Maintain a "magic" minimum address. This keeps some older
+		 * firmware platforms running.
+		 */
+		if (claim_base < PROG_START)
+			claim_base = PROG_START;
+#endif
+		first_time = 0;
+	}
+
+	for(; claim_base < RAM_END; claim_base += ONE_MB) {
+#ifdef DEBUG
+		printf("    trying: 0x%08lx\n\r", claim_base);
+#endif
+		addr = (unsigned long)claim(claim_base, size, 0);
+		if ((void *)addr != (void *)-1)
+			break;
+	}
+	if (addr == 0)
+		return NULL;
+	claim_base = PAGE_ALIGN(claim_base + size);
+	return (void *)addr;
+}
+
+static void of_exit(void)
+{
+	call_prom("exit", 0, 0);
+}
+
+/*
+ * OF device tree routines
+ */
+static void *of_finddevice(const char *name)
+{
+	return (phandle) call_prom("finddevice", 1, 1, name);
+}
+
+static int of_getprop(const void *phandle, const char *name, void *buf,
+		const int buflen)
+{
+	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
+}
+
+static int of_setprop(const void *phandle, const char *name, const void *buf,
+		const int buflen)
+{
+	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
+}
+
+static void of_call_kernel(void *entry_addr, unsigned long a1, unsigned long a2,
+		void *promptr, void *sp)
+{
+	void (*kernel_entry)(unsigned long a1, unsigned long a2, void *promptr,
+			void *sp);
+
+	kernel_entry = entry_addr;
+	kernel_entry(a1, a2, promptr, sp);
+}
+
+/*
+ * OF console routines
+ */
+static void *of_stdout_handle;
+
+static int of_console_open(void)
+{
+	void *devp;
+
+	if (((devp = finddevice("/chosen")) != NULL)
+			&& (getprop(devp, "stdout", &of_stdout_handle,
+				sizeof(of_stdout_handle))
+				== sizeof(of_stdout_handle)))
+		return 0;
+
+	return -1;
+}
+
+static void of_console_write(char *buf, int len)
+{
+	call_prom("write", 3, 1, of_stdout_handle, buf, len);
+}
+
+int platform_init(void *promptr)
+{
+	platform_ops.fixups = NULL;
+	platform_ops.malloc = of_try_claim;
+	platform_ops.free = NULL;
+	platform_ops.exit = of_exit;
+
+	dt_ops.finddevice = of_finddevice;
+	dt_ops.getprop = of_getprop;
+	dt_ops.setprop = of_setprop;
+	dt_ops.translate_addr = NULL;
+	dt_ops.call_kernel = of_call_kernel;
+
+	console_ops.open = of_console_open;
+	console_ops.write = of_console_write;
+	console_ops.edit_cmdline = NULL;
+	console_ops.close = NULL;
+	console_ops.data = NULL;
+
+	prom = (int (*)(void *))promptr;
+	return 0;
+}
diff --git a/arch/powerpc/boot/prom.c b/arch/powerpc/boot/prom.c
deleted file mode 100644
index fa00577..0000000
--- a/arch/powerpc/boot/prom.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (C) Paul Mackerras 1997.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <stdarg.h>
-#include <stddef.h>
-#include "string.h"
-#include "stdio.h"
-#include "prom.h"
-
-int (*prom)(void *);
-phandle chosen_handle;
-ihandle stdout;
-
-int call_prom(const char *service, int nargs, int nret, ...)
-{
-	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
-	va_list list;
-
-	args.service = service;
-	args.nargs = nargs;
-	args.nret = nret;
-
-	va_start(list, nret);
-	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
-	va_end(list);
-
-	for (i = 0; i < nret; i++)
-		args.args[nargs+i] = 0;
-
-	if (prom(&args) < 0)
-		return -1;
-
-	return (nret > 0)? args.args[nargs]: 0;
-}
-
-int call_prom_ret(const char *service, int nargs, int nret,
-		  unsigned int *rets, ...)
-{
-	int i;
-	struct prom_args {
-		const char *service;
-		int nargs;
-		int nret;
-		unsigned int args[12];
-	} args;
-	va_list list;
-
-	args.service = service;
-	args.nargs = nargs;
-	args.nret = nret;
-
-	va_start(list, rets);
-	for (i = 0; i < nargs; i++)
-		args.args[i] = va_arg(list, unsigned int);
-	va_end(list);
-
-	for (i = 0; i < nret; i++)
-		args.args[nargs+i] = 0;
-
-	if (prom(&args) < 0)
-		return -1;
-
-	if (rets != (void *) 0)
-		for (i = 1; i < nret; ++i)
-			rets[i-1] = args.args[nargs+i];
-
-	return (nret > 0)? args.args[nargs]: 0;
-}
-
-int write(void *handle, void *ptr, int nb)
-{
-	return call_prom("write", 3, 1, handle, ptr, nb);
-}
-
-/*
- * Older OF's require that when claiming a specific range of addresses,
- * we claim the physical space in the /memory node and the virtual
- * space in the chosen mmu node, and then do a map operation to
- * map virtual to physical.
- */
-static int need_map = -1;
-static ihandle chosen_mmu;
-static phandle memory;
-
-/* returns true if s2 is a prefix of s1 */
-static int string_match(const char *s1, const char *s2)
-{
-	for (; *s2; ++s2)
-		if (*s1++ != *s2)
-			return 0;
-	return 1;
-}
-
-static int check_of_version(void)
-{
-	phandle oprom, chosen;
-	char version[64];
-
-	oprom = finddevice("/openprom");
-	if (oprom == (phandle) -1)
-		return 0;
-	if (getprop(oprom, "model", version, sizeof(version)) <= 0)
-		return 0;
-	version[sizeof(version)-1] = 0;
-	printf("OF version = '%s'\r\n", version);
-	if (!string_match(version, "Open Firmware, 1.")
-	    && !string_match(version, "FirmWorks,3."))
-		return 0;
-	chosen = finddevice("/chosen");
-	if (chosen == (phandle) -1) {
-		chosen = finddevice("/chosen@0");
-		if (chosen == (phandle) -1) {
-			printf("no chosen\n");
-			return 0;
-		}
-	}
-	if (getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
-		printf("no mmu\n");
-		return 0;
-	}
-	memory = (ihandle) call_prom("open", 1, 1, "/memory");
-	if (memory == (ihandle) -1) {
-		memory = (ihandle) call_prom("open", 1, 1, "/memory@0");
-		if (memory == (ihandle) -1) {
-			printf("no memory node\n");
-			return 0;
-		}
-	}
-	printf("old OF detected\r\n");
-	return 1;
-}
-
-void *claim(unsigned long virt, unsigned long size, unsigned long align)
-{
-	int ret;
-	unsigned int result;
-
-	if (need_map < 0)
-		need_map = check_of_version();
-	if (align || !need_map)
-		return (void *) call_prom("claim", 3, 1, virt, size, align);
-	
-	ret = call_prom_ret("call-method", 5, 2, &result, "claim", memory,
-			    align, size, virt);
-	if (ret != 0 || result == -1)
-		return (void *) -1;
-	ret = call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
-			    align, size, virt);
-	/* 0x12 == coherent + read/write */
-	ret = call_prom("call-method", 6, 1, "map", chosen_mmu,
-			0x12, size, virt, virt);
-	return (void *) virt;
-}
diff --git a/arch/powerpc/boot/prom.h b/arch/powerpc/boot/prom.h
deleted file mode 100644
index a57b184..0000000
--- a/arch/powerpc/boot/prom.h
+++ /dev/null
@@ -1,41 +0,0 @@
-#ifndef _PPC_BOOT_PROM_H_
-#define _PPC_BOOT_PROM_H_
-
-typedef void *phandle;
-typedef void *ihandle;
-
-extern int (*prom) (void *);
-extern phandle chosen_handle;
-extern ihandle stdout;
-
-int	call_prom(const char *service, int nargs, int nret, ...);
-int	call_prom_ret(const char *service, int nargs, int nret,
-		      unsigned int *rets, ...);
-
-extern int write(void *handle, void *ptr, int nb);
-extern void *claim(unsigned long virt, unsigned long size, unsigned long aln);
-
-static inline void exit(void)
-{
-	call_prom("exit", 0, 0);
-}
-
-static inline phandle finddevice(const char *name)
-{
-	return (phandle) call_prom("finddevice", 1, 1, name);
-}
-
-static inline int getprop(void *phandle, const char *name,
-			  void *buf, int buflen)
-{
-	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
-}
-
-
-static inline int setprop(void *phandle, const char *name,
-			  void *buf, int buflen)
-{
-	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
-}
-
-#endif				/* _PPC_BOOT_PROM_H_ */
