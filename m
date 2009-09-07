Return-Path: <mohan@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 744C6B7B8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Sep 2009 15:14:30 +1000 (EST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2AA3DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2009 15:14:28 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id n875EQjq030621
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2009 15:14:26 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n875EQdh324024
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2009 15:14:26 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n875EPjo015377
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2009 15:14:26 +1000
Date: Mon, 7 Sep 2009 10:44:07 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
To: horms@verge.net.au, kexec@lists.infradead.org
Subject: [RFC] [PATCH] Write to HVC terminal from purgatory code
Message-ID: <20090907051407.GA2990@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, miltonm@bga.com
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Write to HVC terminal from purgatory code

Current x86/x86-64 kexec-tools print the message "I'm in purgatory" to
serial console/VGA while executing the purgatory code.  Implement this
feature for POWERPC pseries platform by using the H_PUT_TERM_CHAR
hypervisor call by printng to hvc console.


Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
---
 kexec/arch/ppc64/fs2dt.c               |   47 +++++++++++++++++++++++++++++++-
 kexec/arch/ppc64/kexec-elf-ppc64.c     |    7 +++++
 kexec/arch/ppc64/kexec-ppc64.h         |    1 +
 purgatory/arch/ppc64/Makefile          |    1 +
 purgatory/arch/ppc64/console-ppc64.c   |   14 +++++++++
 purgatory/arch/ppc64/hvCall.S          |   28 +++++++++++++++++++
 purgatory/arch/ppc64/hvCall.h          |    8 +++++
 purgatory/arch/ppc64/purgatory-ppc64.c |    1 +
 8 files changed, 106 insertions(+), 1 deletions(-)
 create mode 100644 purgatory/arch/ppc64/hvCall.S
 create mode 100644 purgatory/arch/ppc64/hvCall.h

diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
index b01ff86..bd9d36c 100644
--- a/kexec/arch/ppc64/fs2dt.c
+++ b/kexec/arch/ppc64/fs2dt.c
@@ -434,6 +434,9 @@ static void putnode(void)
 	if (!strcmp(basename,"/chosen/")) {
 		size_t cmd_len = 0;
 		char *param = NULL;
+		char filename[MAXPATH];
+		char buff[64];
+		int fd;
 
 		cmd_len = strlen(local_cmdline);
 		if (cmd_len != 0) {
@@ -446,7 +449,6 @@ static void putnode(void)
 
 		/* ... if not, grab root= from the old command line */
 		if (!param) {
-			char filename[MAXPATH];
 			FILE *fp;
 			char *last_cmdline = NULL;
 			char *old_param;
@@ -483,8 +485,51 @@ static void putnode(void)
 		dt += (cmd_len + 3)/4;
 
 		fprintf(stderr, "Modified cmdline:%s\n", local_cmdline);
+
+		/*
+		 * Determine the platform type/stdout type, so that purgatory
+		 * code can print 'I'm in purgatory' message. Currently only
+		 * pseries/hvcterminal is supported.
+		 */
+		strcpy(filename, pathname);
+		strcat(filename, "linux,stdout-path");
+		fd = open(filename, O_RDONLY);
+		if (fd == -1) {
+			printf("Unable to find linux,stdout-path, printing"
+					" from purgatory is diabled\n");
+			goto no_debug;
+		}
+		if (fstat(fd, &statbuf)) {
+			printf("Unable to stat linux,stdout-path, printing"
+					" from purgatory is diabled\n");
+			close(fd);
+			goto no_debug;
+		}
+		read(fd, buff, statbuf.st_size);
+		close(fd);
+		strcpy(filename, "/proc/device-tree/");
+		strcat(filename, buff);
+		strcat(filename, "/compatible");
+		fd = open(filename, O_RDONLY);
+		if (fd == -1) {
+			printf("Unable to find linux,stdout-path/compatible, "
+				" printing from purgatory is diabled\n");
+			goto no_debug;
+		}
+		if (fstat(fd, &statbuf)) {
+			printf("Unable to stat linux,stdout-path/compatible, "
+				" printing from purgatory is diabled\n");
+			close(fd);
+			goto no_debug;
+		}
+		read(fd, buff, statbuf.st_size);
+		if (!strcmp(buff, "hvterm1") ||
+					!strcmp(buff, "hvterm-protocol"))
+			my_debug = 1;
+		close(fd);
 	}
 
+no_debug:
 	for (i=0; i < numlist; i++) {
 		dp = namelist[i];
 		strcpy(dn, dp->d_name);
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 21533cb..65fc42f 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -41,6 +41,8 @@
 uint64_t initrd_base, initrd_size;
 unsigned char reuse_initrd = 0;
 const char *ramdisk;
+/* Used for enabling printing message from purgatory code */
+int my_debug = 0;
 
 int elf_ppc64_probe(const char *buf, off_t len)
 {
@@ -296,6 +298,8 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	toc_addr = my_r2(&info->rhdr);
 	elf_rel_set_symbol(&info->rhdr, "my_toc", &toc_addr, sizeof(toc_addr));
 
+	/* Set debug */
+	elf_rel_set_symbol(&info->rhdr, "debug", &my_debug, sizeof(my_debug));
 #ifdef DEBUG
 	my_kernel = 0;
 	my_dt_offset = 0;
@@ -304,6 +308,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	my_stack = 0;
 	toc_addr = 0;
 	my_run_at_load = 0;
+	my_debug = 0;
 
 	elf_rel_get_symbol(&info->rhdr, "kernel", &my_kernel, sizeof(my_kernel));
 	elf_rel_get_symbol(&info->rhdr, "dt_offset", &my_dt_offset,
@@ -317,6 +322,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	elf_rel_get_symbol(&info->rhdr, "stack", &my_stack, sizeof(my_stack));
 	elf_rel_get_symbol(&info->rhdr, "my_toc", &toc_addr,
 				sizeof(toc_addr));
+	elf_rel_get_symbol(&info->rhdr, "debug", &my_debug, sizeof(my_debug));
 
 	fprintf(stderr, "info->entry is %p\n", info->entry);
 	fprintf(stderr, "kernel is %llx\n", (unsigned long long)my_kernel);
@@ -329,6 +335,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	fprintf(stderr, "stack is %llx\n", (unsigned long long)my_stack);
 	fprintf(stderr, "toc_addr is %llx\n", (unsigned long long)toc_addr);
 	fprintf(stderr, "purgatory size is %zu\n", purgatory_size);
+	fprintf(stderr, "debug is %d\n", my_debug);
 #endif
 
 	for (i = 0; i < info->nr_segments; i++)
diff --git a/kexec/arch/ppc64/kexec-ppc64.h b/kexec/arch/ppc64/kexec-ppc64.h
index 920ac46..838c6da 100644
--- a/kexec/arch/ppc64/kexec-ppc64.h
+++ b/kexec/arch/ppc64/kexec-ppc64.h
@@ -20,6 +20,7 @@ unsigned long my_r2(const struct mem_ehdr *ehdr);
 extern uint64_t initrd_base, initrd_size;
 extern int max_memory_ranges;
 extern unsigned char reuse_initrd;
+extern int my_debug;
 
 /* boot block version 2 as defined by the linux kernel */
 struct bootblock {
diff --git a/purgatory/arch/ppc64/Makefile b/purgatory/arch/ppc64/Makefile
index aaa4046..40a9e99 100644
--- a/purgatory/arch/ppc64/Makefile
+++ b/purgatory/arch/ppc64/Makefile
@@ -3,6 +3,7 @@
 #
 
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/v2wrap.S
+ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/hvCall.S
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/purgatory-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/console-ppc64.c
 ppc64_PURGATORY_SRCS += purgatory/arch/ppc64/crashdump_backup.c
diff --git a/purgatory/arch/ppc64/console-ppc64.c b/purgatory/arch/ppc64/console-ppc64.c
index d6da7b3..78a233b 100644
--- a/purgatory/arch/ppc64/console-ppc64.c
+++ b/purgatory/arch/ppc64/console-ppc64.c
@@ -20,8 +20,22 @@
  */
 
 #include <purgatory.h>
+#include "hvCall.h"
+
+extern int debug;
 
 void putchar(int c)
 {
+	char buff[16];
+	unsigned long *lbuf = (unsigned long *)buff;
+
+	if (!debug) /* running on non pseries */
+		return;
+
+	if (c == '\n')
+		putchar('\r');
+
+	buff[0] = c;
+	plpar_hcall_norets(H_PUT_TERM_CHAR, 0, 1, lbuf[0], lbuf[1]);
 	return;
 }
diff --git a/purgatory/arch/ppc64/hvCall.S b/purgatory/arch/ppc64/hvCall.S
new file mode 100644
index 0000000..e401f81
--- /dev/null
+++ b/purgatory/arch/ppc64/hvCall.S
@@ -0,0 +1,28 @@
+/*
+ * This file contains the generic function to perform a call to the
+ * pSeries LPAR hypervisor.
+ *
+ * Created by M. Mohan Kumar (mohan@in.ibm.com)
+ * Copyright (C) IBM Corporation
+ * Taken from linux/arch/powerpc/platforms/pseries/hvCall.S
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define HVSC	.long 0x44000022
+.text
+	.machine ppc64
+.globl .plpar_hcall_norets
+.plpar_hcall_norets:
+	or	6,6,6			# medium low priority
+        mfcr	0
+        stw	0,8(1)
+
+        HVSC 				/* invoke the hypervisor */
+
+        lwz	0,8(1)
+        mtcrf	0xff,0
+        blr                             /* return r3 = status */
diff --git a/purgatory/arch/ppc64/hvCall.h b/purgatory/arch/ppc64/hvCall.h
new file mode 100644
index 0000000..187e24d
--- /dev/null
+++ b/purgatory/arch/ppc64/hvCall.h
@@ -0,0 +1,8 @@
+#ifndef HVCALL_H
+#define HVCALL_H
+
+#define H_PUT_TERM_CHAR	0x58
+
+long plpar_hcall_norets(unsigned long opcode, ...);
+
+#endif
diff --git a/purgatory/arch/ppc64/purgatory-ppc64.c b/purgatory/arch/ppc64/purgatory-ppc64.c
index 93f28d2..0b6d326 100644
--- a/purgatory/arch/ppc64/purgatory-ppc64.c
+++ b/purgatory/arch/ppc64/purgatory-ppc64.c
@@ -28,6 +28,7 @@ unsigned long stack = 0;
 unsigned long dt_offset = 0;
 unsigned long my_toc = 0;
 unsigned long kernel = 0;
+unsigned int debug = 0;
 
 void setup_arch(void)
 {
-- 
1.6.2.5
