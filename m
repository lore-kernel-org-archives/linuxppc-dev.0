Return-Path: <miltonm@sullivan.realtime.net>
Date: Tue, 10 Jul 2007 17:11:15 -0500 (CDT)
Subject: [PATCH 9/15] bootwrapper: rtas support
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-6-09.miltonm@bga.com>
In-Reply-To: <boot-6-00.miltonm@bga.com>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This code provides a console write that calls put-term-char.

To avoid PIC relocation of the absolute rtas addresses, hide the
actual call to rtas in assembly and declare all variables as int.

An instantiated rtas will be protected by a reserved range in the
device tree, so no explicit call to add_occupied_range is needed
here.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
Removed use_call_rtas(); instead put asm() at the file level.

Index: work.git/arch/powerpc/boot/rtas.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ work.git/arch/powerpc/boot/rtas.c	2007-07-10 04:39:43.000000000 -0500
@@ -0,0 +1,146 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ *
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "flatdevtree.h"
+
+static int rtas_entry;
+static int rtas_base;
+static int rtas_size;
+
+static void find_rtas(void)
+{
+	int rc;
+	void *devp;
+	char *str;
+
+	devp = finddevice("/rtas");
+	if (! devp)
+		return;
+
+	str = "linux,rtas-entry";
+	rc = getprop(devp, str, &rtas_entry, sizeof(rtas_entry));
+	if (rc < 0)
+		return;
+	if (rc != sizeof(rtas_entry))
+		goto fail;
+
+	str = "rtas-size";
+	rc = getprop(devp, str, &rtas_size, sizeof(rtas_size));
+	if (rc < 0)
+		return;
+	if (rc != sizeof(rtas_size))
+		goto fail;
+
+	str = "linux,rtas-base";
+	rc = getprop(devp, str, &rtas_base, sizeof(rtas_base));
+	if (rc < 0) {
+		printf("rtas-size but no linux,rtas-base in /rtas.  "
+			"disabling wrapper rtas interface\n\r");
+		rtas_entry = 0;
+		return;
+	}
+
+	if (rc != sizeof(rtas_base))
+		goto fail;
+
+	return;
+
+
+fail:
+	printf("Unexpected length %d of %s property in /rtas.\n\r"
+			"disabling wrapper rtas interface\n\r", rc, str);
+	rtas_entry = 0;
+	return;
+}
+
+/*
+ * PIC relocation of function pointers happens at call time.
+ * We have an absolute out-of-image address.   So tell C they
+ * are just integers, and hide the call as an out-of-file
+ * function.
+ */
+__asm__ (
+		"	.globl call_rtas\n"
+		"	call_rtas: mtctr 5\n"
+		"	bctr\n"
+		);
+
+void call_rtas(int args[], int base, int entry);
+
+
+static int put_term_char;
+
+static void rtas_put_term_write(const char *buf, int len)
+{
+	int i, args[5];
+
+	args[0] = put_term_char;
+	args[1] = 1;	/* num inputs */
+	args[2] = 1;	/* num outputs */
+
+	for (i=0; i < len; ) {
+		args[3] = buf[i];
+		args[4] = 0;
+
+		call_rtas(args, rtas_base, rtas_entry);
+		if (args[4] == 0)		/* SUCCESS */
+			i++;
+		else if (args[4] == -1)		/* HARDWARE_ERROR */
+			break;
+		/* else retry */
+	}
+}
+
+int rtas_console_init(void)
+{
+	void *devp;
+	int rc;
+
+
+	devp = finddevice("/rtas");
+	if (!devp)
+		return -1;
+
+	if (!rtas_entry)
+		find_rtas();
+	if (!rtas_entry)
+		return -1;
+
+	rc = getprop(devp, "put-term-char", &put_term_char,
+			sizeof(put_term_char));
+	if (rc == sizeof(put_term_char))
+		console_ops.write = rtas_put_term_write;
+	else
+		put_term_char = -1;
+
+	return put_term_char == -1 ? -1 : 0;
+}
+
+/* for debug, hard code */
+void use_rtas_console(int entry, int base, int tc)
+{
+	rtas_entry = entry;
+	rtas_base = base;
+	put_term_char = tc;
+	console_ops.write = rtas_put_term_write;
+}
Index: work.git/arch/powerpc/boot/ops.h
===================================================================
--- work.git.orig/arch/powerpc/boot/ops.h	2007-07-10 04:39:43.000000000 -0500
+++ work.git/arch/powerpc/boot/ops.h	2007-07-10 04:40:11.000000000 -0500
@@ -94,6 +94,8 @@ void flush_cache(void *, unsigned long);
 int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr);
 void kexec_platform_init(struct boot_param_header *dt_blob);
+int rtas_console_init(void);
+void use_rtas_console(int entry, int base, int tc);
 
 /* marshal slave cpus around to kernel */
 void move_slaves_up(void);
Index: work.git/arch/powerpc/boot/kexec.c
===================================================================
--- work.git.orig/arch/powerpc/boot/kexec.c	2007-07-10 04:39:43.000000000 -0500
+++ work.git/arch/powerpc/boot/kexec.c	2007-07-10 04:40:11.000000000 -0500
@@ -33,6 +33,9 @@ static void find_console_from_tree(void)
 {
 	int rc = -1;
 
+	rc = rtas_console_init();
+	if (!rc)
+		return;
 	if (rc) {
 		/* no console, oh well */
 	}
Index: work.git/arch/powerpc/boot/Makefile
===================================================================
--- work.git.orig/arch/powerpc/boot/Makefile	2007-07-10 04:39:43.000000000 -0500
+++ work.git/arch/powerpc/boot/Makefile	2007-07-10 04:40:11.000000000 -0500
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) gunzip_util.
 
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		flatdevtree_conv.c marshal.c memranges.c kexec.c \
-		ns16550.c serial.c simple_alloc.c div64.S util.S \
+		ns16550.c serial.c simple_alloc.c div64.S util.S rtas.c \
 		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
 		44x.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c crt0_kexec.S \
