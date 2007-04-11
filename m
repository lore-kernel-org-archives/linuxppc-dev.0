Return-Path: <miltonm@sullivan.realtime.net>
Date: Wed, 11 Apr 2007 03:34:06 -0500 (CDT)
Subject: [PATCH 7/8] bootwrapper: rtas support
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: linuxppc-dev@ozlabs.org
Message-Id: <boot-4-07.miltonm@bga.com>
In-Reply-To: <boot-4-00.miltonm@bga.com>
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

This code provides a console write that calls rtas for the
put-term-char service.

To avoid PIC relocation of the absolute rtas addresses, hide
the actual call in assembly and declare all variables as int.

An instantiated rtas will be protected by a reserve range in
the device tree, so no explicit call to add_occupied_range here.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
I considered making this a client of the serial code, but there are
no hooks to init that layer other than through the stdout property
pointing to a serial type node with a compatable property, which
doesn't match the /rtas node.  

Index: kernel/arch/powerpc/boot/rtas.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kernel/arch/powerpc/boot/rtas.c	2007-04-09 00:56:09.000000000 -0500
@@ -0,0 +1,152 @@
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
+ * Copyright (C) 2007 IBM Corporation.
+ *
+ * Authors: Milton Miller <miltonm@bga.com>
+ *
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "flatdevtree.h"
+
+void call_rtas(int args[], int base, int entry);
+
+static void __attribute__((noinline)) use_call_rtas(void)
+{
+	/*
+	 * PIC relocation of function pointers happens at call time,
+	 * We have an absolute out-of-image address.   So tell C they
+	 * are just integers, and hide the call as an out-of-file
+	 * function.
+	 */
+	__asm__ __volatile__(
+			"	b 1f \n"
+			"	.globl call_rtas\n"
+			"	call_rtas: mtctr 5\n"
+			"	bctr\n"
+			"1:");
+}
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
+static int put_term_char;
+
+static void rtas_put_term_write(char *buf, int len)
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
+	use_call_rtas();
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
+	use_call_rtas();
+	console_ops.write = rtas_put_term_write;
+}
Index: kernel/arch/powerpc/boot/ops.h
===================================================================
--- kernel.orig/arch/powerpc/boot/ops.h	2007-04-09 00:55:09.000000000 -0500
+++ kernel/arch/powerpc/boot/ops.h	2007-04-09 00:56:09.000000000 -0500
@@ -87,6 +87,8 @@ void *simple_alloc_init(char *base, u32 
 		u32 max_allocs);
 void flush_cache(void *, unsigned long);
 void kexec_platform_init(struct boot_param_header *dt_blob);
+int rtas_console_init(void);
+void use_rtas_console(int entry, int base, int tc);
 
 /* marshal slave cpus around to kernel */
 void move_slaves_up(void);
Index: kernel/arch/powerpc/boot/kexec.c
===================================================================
--- kernel.orig/arch/powerpc/boot/kexec.c	2007-04-09 00:55:09.000000000 -0500
+++ kernel/arch/powerpc/boot/kexec.c	2007-04-09 00:56:09.000000000 -0500
@@ -33,6 +33,9 @@ static void find_console_from_tree(void)
 {
 	int rc;
 
+	rc = rtas_console_init();
+	if (!rc)
+		return;
 	rc = serial_console_init();
 	if (rc) {
 		/* no console, oh well */
Index: kernel/arch/powerpc/boot/Makefile
===================================================================
--- kernel.orig/arch/powerpc/boot/Makefile	2007-04-09 00:55:09.000000000 -0500
+++ kernel/arch/powerpc/boot/Makefile	2007-04-09 00:56:09.000000000 -0500
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		flatdevtree_conv.c marshal.c memranges.c misc64.S \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c $(zlib) kexec.c
+		gunzip_util.c $(zlib) kexec.c rtas.c
 src-plat := of.c
 src-plat += crt0_kexec.S
 
