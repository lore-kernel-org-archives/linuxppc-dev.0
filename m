Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/13] Split low-level OF-related bootloader code into separate
	files
In-Reply-To: <20070613045031.GD16148@localhost.localdomain>
Message-Id: <20070613045254.6C178DDE32@ozlabs.org>
Date: Wed, 13 Jun 2007 14:52:54 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, all OF-related code in the bootloader is contained in of.c.
of.c also provides the platform specific things necessary to boot on
an OF platform.

However, there are platforms (such as PReP) which can include an OF
implementation, but are not bootable as pure OF systems.  For use by
such platforms, this patch splits out the low-level parts of the OF
code (call_prom() and various wrappers thereof) into a new oflib.c
file.  In addition, the code related to bootwrapper console output via
OF are moved to a new ofconsole.c file.  Both these files are included
in the wrapper.a library where they can be used by both full-OF and
partial OF platforms.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---

 arch/powerpc/boot/Makefile    |    2 
 arch/powerpc/boot/of.c        |  188 +-----------------------------------------
 arch/powerpc/boot/of.h        |   15 +++
 arch/powerpc/boot/ofconsole.c |   45 ++++++++++
 arch/powerpc/boot/oflib.c     |  172 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 240 insertions(+), 182 deletions(-)

Index: working-2.6/arch/powerpc/boot/of.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/of.h	2007-05-29 16:40:25.000000000 +1000
@@ -0,0 +1,15 @@
+#ifndef _PPC_BOOT_OF_H_
+#define _PPC_BOOT_OF_H_
+
+typedef void *phandle;
+typedef void *ihandle;
+
+void of_init(void *promptr);
+int of_call_prom(const char *service, int nargs, int nret, ...);
+void *of_claim(unsigned long virt, unsigned long size, unsigned long align);
+void of_exit(void);
+
+/* Console functions */
+void of_console_init(void);
+
+#endif /* _PPC_BOOT_OF_H_ */
Index: working-2.6/arch/powerpc/boot/oflib.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/oflib.c	2007-05-29 16:32:05.000000000 +1000
@@ -0,0 +1,172 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+#include "of.h"
+
+static int (*prom) (void *);
+
+void of_init(void *promptr)
+{
+	prom = (int (*)(void *))promptr;
+}
+
+int of_call_prom(const char *service, int nargs, int nret, ...)
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
+static int of_call_prom_ret(const char *service, int nargs, int nret,
+			    unsigned int *rets, ...)
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
+/* returns true if s2 is a prefix of s1 */
+static int string_match(const char *s1, const char *s2)
+{
+	for (; *s2; ++s2)
+		if (*s1++ != *s2)
+			return 0;
+	return 1;
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
+	memory = (ihandle) of_call_prom("open", 1, 1, "/memory");
+	if (memory == (ihandle) -1) {
+		memory = (ihandle) of_call_prom("open", 1, 1, "/memory@0");
+		if (memory == (ihandle) -1) {
+			printf("no memory node\n");
+			return 0;
+		}
+	}
+	printf("old OF detected\r\n");
+	return 1;
+}
+
+void *of_claim(unsigned long virt, unsigned long size, unsigned long align)
+{
+	int ret;
+	unsigned int result;
+
+	if (need_map < 0)
+		need_map = check_of_version();
+	if (align || !need_map)
+		return (void *) of_call_prom("claim", 3, 1, virt, size, align);
+
+	ret = of_call_prom_ret("call-method", 5, 2, &result, "claim", memory,
+			       align, size, virt);
+	if (ret != 0 || result == -1)
+		return (void *) -1;
+	ret = of_call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
+			       align, size, virt);
+	/* 0x12 == coherent + read/write */
+	ret = of_call_prom("call-method", 6, 1, "map", chosen_mmu,
+			   0x12, size, virt, virt);
+	return (void *) virt;
+}
+
+void of_exit(void)
+{
+	of_call_prom("exit", 0, 0);
+}
Index: working-2.6/arch/powerpc/boot/Makefile
===================================================================
--- working-2.6.orig/arch/powerpc/boot/Makefile	2007-05-29 16:32:01.000000000 +1000
+++ working-2.6/arch/powerpc/boot/Makefile	2007-05-29 16:40:25.000000000 +1000
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c elf_util.c $(zlib) devtree.c \
+		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c
Index: working-2.6/arch/powerpc/boot/of.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/of.c	2007-05-29 16:31:58.000000000 +1000
+++ working-2.6/arch/powerpc/boot/of.c	2007-05-29 16:40:25.000000000 +1000
@@ -15,8 +15,7 @@
 #include "page.h"
 #include "ops.h"
 
-typedef void *ihandle;
-typedef void *phandle;
+#include "of.h"
 
 extern char _end[];
 
@@ -25,154 +24,10 @@ extern char _end[];
 #define RAM_END		(512<<20)	/* Fixme: use OF */
 #define	ONE_MB		0x100000
 
-int (*prom) (void *);
 
 
 static unsigned long claim_base;
 
-static int call_prom(const char *service, int nargs, int nret, ...)
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
-static int call_prom_ret(const char *service, int nargs, int nret,
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
-static void *claim(unsigned long virt, unsigned long size, unsigned long align)
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
-
 static void *of_try_claim(unsigned long size)
 {
 	unsigned long addr = 0;
@@ -184,7 +39,7 @@ static void *of_try_claim(unsigned long 
 #ifdef DEBUG
 		printf("    trying: 0x%08lx\n\r", claim_base);
 #endif
-		addr = (unsigned long)claim(claim_base, size, 0);
+		addr = (unsigned long)of_claim(claim_base, size, 0);
 		if ((void *)addr != (void *)-1)
 			break;
 	}
@@ -218,52 +73,24 @@ static void *of_vmlinux_alloc(unsigned l
 	return p;
 }
 
-static void of_exit(void)
-{
-	call_prom("exit", 0, 0);
-}
-
 /*
  * OF device tree routines
  */
 static void *of_finddevice(const char *name)
 {
-	return (phandle) call_prom("finddevice", 1, 1, name);
+	return (phandle) of_call_prom("finddevice", 1, 1, name);
 }
 
 static int of_getprop(const void *phandle, const char *name, void *buf,
 		const int buflen)
 {
-	return call_prom("getprop", 4, 1, phandle, name, buf, buflen);
+	return of_call_prom("getprop", 4, 1, phandle, name, buf, buflen);
 }
 
 static int of_setprop(const void *phandle, const char *name, const void *buf,
 		const int buflen)
 {
-	return call_prom("setprop", 4, 1, phandle, name, buf, buflen);
-}
-
-/*
- * OF console routines
- */
-static void *of_stdout_handle;
-
-static int of_console_open(void)
-{
-	void *devp;
-
-	if (((devp = finddevice("/chosen")) != NULL)
-			&& (getprop(devp, "stdout", &of_stdout_handle,
-				sizeof(of_stdout_handle))
-				== sizeof(of_stdout_handle)))
-		return 0;
-
-	return -1;
-}
-
-static void of_console_write(char *buf, int len)
-{
-	call_prom("write", 3, 1, of_stdout_handle, buf, len);
+	return of_call_prom("setprop", 4, 1, phandle, name, buf, buflen);
 }
 
 void platform_init(unsigned long a1, unsigned long a2, void *promptr)
@@ -277,10 +104,9 @@ void platform_init(unsigned long a1, uns
 	dt_ops.getprop = of_getprop;
 	dt_ops.setprop = of_setprop;
 
-	console_ops.open = of_console_open;
-	console_ops.write = of_console_write;
+	of_console_init();
 
-	prom = (int (*)(void *))promptr;
+	of_init(promptr);
 	loader_info.promptr = promptr;
 	if (a1 && a2 && a2 != 0xdeadbeef) {
 		loader_info.initrd_addr = a1;
Index: working-2.6/arch/powerpc/boot/ofconsole.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ working-2.6/arch/powerpc/boot/ofconsole.c	2007-05-29 16:40:25.000000000 +1000
@@ -0,0 +1,45 @@
+/*
+ * OF console routines
+ *
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+
+#include "of.h"
+
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
+	of_call_prom("write", 3, 1, of_stdout_handle, buf, len);
+}
+
+void of_console_init(void)
+{
+	console_ops.open = of_console_open;
+	console_ops.write = of_console_write;
+}
