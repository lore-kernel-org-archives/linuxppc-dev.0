Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTXrD5kG5zDqfM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 01:00:12 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5EEsVOB143971
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:11 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jfks2w6e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 11:00:10 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 12:00:07 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 31B8B1DC006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 10:59:58 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5EF05Td5062810
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:05 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5EF04dA019632
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 12:00:05 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v2 9/9] powerpc: Add purgatory for kexec_file_load
 implementation.
Date: Tue, 14 Jun 2016 11:59:09 -0300
In-Reply-To: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1465916349-3398-10-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This purgatory implementation comes from kexec-tools, almost unchanged.

The only changes were that the sha256_regions global variable was
renamed to sha_regions to match what kexec_file_load expects, and to
use the sha256.c file from x86's purgatory to avoid adding yet another
SHA-256 implementation.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/Makefile                     |   4 +
 arch/powerpc/purgatory/.gitignore         |   2 +
 arch/powerpc/purgatory/Makefile           |  36 +++++++
 arch/powerpc/purgatory/console-ppc64.c    |  43 ++++++++
 arch/powerpc/purgatory/crashdump-ppc64.h  |  42 ++++++++
 arch/powerpc/purgatory/crashdump_backup.c |  40 +++++++
 arch/powerpc/purgatory/crtsavres.S        |   5 +
 arch/powerpc/purgatory/hvCall.S           |  27 +++++
 arch/powerpc/purgatory/hvCall.h           |   8 ++
 arch/powerpc/purgatory/kexec-sha256.h     |  11 ++
 arch/powerpc/purgatory/ppc64_asm.h        |  18 ++++
 arch/powerpc/purgatory/printf.c           | 171 ++++++++++++++++++++++++++++++
 arch/powerpc/purgatory/purgatory-ppc64.c  |  46 ++++++++
 arch/powerpc/purgatory/purgatory-ppc64.h  |   6 ++
 arch/powerpc/purgatory/purgatory.c        |  66 ++++++++++++
 arch/powerpc/purgatory/purgatory.h        |  11 ++
 arch/powerpc/purgatory/sha256.c           |   6 ++
 arch/powerpc/purgatory/sha256.h           |   1 +
 arch/powerpc/purgatory/string.S           |   1 +
 arch/powerpc/purgatory/v2wrap.S           | 139 ++++++++++++++++++++++++
 20 files changed, 683 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 709a22a3e824..293322855cce 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -249,6 +249,7 @@ core-y				+= arch/powerpc/kernel/ \
 core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
+core-$(CONFIG_KEXEC_FILE)	+= arch/powerpc/purgatory/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 
@@ -370,6 +371,9 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
 archprepare: checkbin
+ifeq ($(CONFIG_KEXEC_FILE),y)
+	$(Q)$(MAKE) $(build)=arch/powerpc/purgatory arch/powerpc/purgatory/kexec-purgatory.c
+endif
 
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
diff --git a/arch/powerpc/purgatory/.gitignore b/arch/powerpc/purgatory/.gitignore
new file mode 100644
index 000000000000..e9e66f178a6d
--- /dev/null
+++ b/arch/powerpc/purgatory/.gitignore
@@ -0,0 +1,2 @@
+kexec-purgatory.c
+purgatory.ro
diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
new file mode 100644
index 000000000000..63daf95e5703
--- /dev/null
+++ b/arch/powerpc/purgatory/Makefile
@@ -0,0 +1,36 @@
+purgatory-y := purgatory.o printf.o string.o v2wrap.o hvCall.o \
+		purgatory-ppc64.o console-ppc64.o crashdump_backup.o \
+		crtsavres.o sha256.o
+
+targets += $(purgatory-y)
+PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
+
+LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostartfiles \
+			-nostdlib -nodefaultlibs
+targets += purgatory.ro
+
+# Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
+# in turn leaves some undefined symbols like __fentry__ in purgatory and not
+# sure how to relocate those. Like kexec-tools, use custom flags.
+
+KBUILD_CFLAGS := -Wall -Wstrict-prototypes -fno-strict-aliasing \
+		-fno-zero-initialized-in-bss -fno-builtin -ffreestanding \
+		-fno-PIC -fno-PIE -fno-stack-protector  -fno-exceptions \
+		-msoft-float -MD -Os
+KBUILD_CFLAGS += -m$(CONFIG_WORD_SIZE)
+
+$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+		$(call if_changed,ld)
+
+targets += kexec-purgatory.c
+
+CMD_BIN2C = $(objtree)/scripts/basic/bin2c
+quiet_cmd_bin2c = BIN2C   $@
+      cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
+
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+	$(call if_changed,bin2c)
+	@:
+
+
+obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
diff --git a/arch/powerpc/purgatory/console-ppc64.c b/arch/powerpc/purgatory/console-ppc64.c
new file mode 100644
index 000000000000..a52e043b4813
--- /dev/null
+++ b/arch/powerpc/purgatory/console-ppc64.c
@@ -0,0 +1,43 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by: Mohan Kumar M (mohan@in.ibm.com)
+ *
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * Code taken from kexec-tools.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "hvCall.h"
+#include <asm/byteorder.h>
+
+extern int debug;
+
+void putchar(int c)
+{
+	char buff[8];
+	unsigned long *lbuf = (unsigned long *)buff;
+
+	if (!debug) /* running on non pseries */
+		return;
+
+	if (c == '\n')
+		putchar('\r');
+
+	buff[0] = c;
+	plpar_hcall_norets(H_PUT_TERM_CHAR, 0, 1, __cpu_to_be64(*lbuf), 0);
+	return;
+}
diff --git a/arch/powerpc/purgatory/crashdump-ppc64.h b/arch/powerpc/purgatory/crashdump-ppc64.h
new file mode 100644
index 000000000000..90064b49ebfe
--- /dev/null
+++ b/arch/powerpc/purgatory/crashdump-ppc64.h
@@ -0,0 +1,42 @@
+#ifndef CRASHDUMP_PPC64_H
+#define CRASHDUMP_PPC64_H
+
+#include <linux/types.h>
+
+struct kexec_info;
+int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
+				uint64_t max_addr, unsigned long min_base);
+void add_usable_mem_rgns(unsigned long long base, unsigned long long size);
+
+#define PAGE_OFFSET     0xC000000000000000ULL
+#define KERNELBASE      PAGE_OFFSET
+#define VMALLOCBASE     0xD000000000000000ULL
+
+#define __pa(x)         ((unsigned long)(x)-PAGE_OFFSET)
+#define MAXMEM          (-KERNELBASE-VMALLOCBASE)
+
+#define COMMAND_LINE_SIZE       512 /* from kernel */
+/* Backup Region, First 64K of System RAM. */
+#define BACKUP_SRC_START    0x0000
+#define BACKUP_SRC_END      0xffff
+#define BACKUP_SRC_SIZE     (BACKUP_SRC_END - BACKUP_SRC_START + 1)
+
+#define KDUMP_BACKUP_LIMIT	BACKUP_SRC_SIZE
+
+#define KERNEL_RUN_AT_ZERO_MAGIC 0x72756e30	/* "run0" */
+
+extern uint64_t crash_base;
+extern uint64_t crash_size;
+extern uint64_t memory_limit;
+extern unsigned int rtas_base;
+extern unsigned int rtas_size;
+extern uint64_t opal_base;
+extern uint64_t opal_size;
+
+uint64_t lmb_size;
+unsigned int num_of_lmbs;
+
+#define DRCONF_ADDR	0
+#define DRCONF_FLAGS	20
+
+#endif /* CRASHDUMP_PPC64_H */
diff --git a/arch/powerpc/purgatory/crashdump_backup.c b/arch/powerpc/purgatory/crashdump_backup.c
new file mode 100644
index 000000000000..e8491617527a
--- /dev/null
+++ b/arch/powerpc/purgatory/crashdump_backup.c
@@ -0,0 +1,40 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by: Mohan Kumar M (mohan@in.ibm.com)
+ *
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * Code taken from kexec-tools.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "../boot/string.h"
+#include "crashdump-ppc64.h"
+
+extern unsigned long backup_start;
+
+/* Backup first 32KB of memory to backup region reserved by kexec */
+void crashdump_backup_memory(void)
+{
+	void *dest, *src;
+
+	src = (void *)BACKUP_SRC_START;
+
+	if (backup_start) {
+		dest = (void *)(backup_start);
+		memcpy(dest, src, BACKUP_SRC_SIZE);
+	}
+}
diff --git a/arch/powerpc/purgatory/crtsavres.S b/arch/powerpc/purgatory/crtsavres.S
new file mode 100644
index 000000000000..5d17e1c0d575
--- /dev/null
+++ b/arch/powerpc/purgatory/crtsavres.S
@@ -0,0 +1,5 @@
+#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
+#define CONFIG_CC_OPTIMIZE_FOR_SIZE 1
+#endif
+
+#include "../lib/crtsavres.S"
diff --git a/arch/powerpc/purgatory/hvCall.S b/arch/powerpc/purgatory/hvCall.S
new file mode 100644
index 000000000000..a96c4898f1d8
--- /dev/null
+++ b/arch/powerpc/purgatory/hvCall.S
@@ -0,0 +1,27 @@
+/*
+ * This file contains the generic function to perform a call to the
+ * pSeries LPAR hypervisor.
+ *
+ * Taken from linux/arch/powerpc/platforms/pseries/hvCall.S
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "ppc64_asm.h"
+
+#define HVSC	.long 0x44000022
+.text
+	.machine ppc64
+.globl DOTSYM(plpar_hcall_norets)
+DOTSYM(plpar_hcall_norets):
+	or	6,6,6			# medium low priority
+        mfcr	0
+        stw	0,8(1)
+
+        HVSC 				/* invoke the hypervisor */
+
+        lwz	0,8(1)
+        mtcrf	0xff,0
+        blr                             /* return r3 = status */
diff --git a/arch/powerpc/purgatory/hvCall.h b/arch/powerpc/purgatory/hvCall.h
new file mode 100644
index 000000000000..187e24d8b964
--- /dev/null
+++ b/arch/powerpc/purgatory/hvCall.h
@@ -0,0 +1,8 @@
+#ifndef HVCALL_H
+#define HVCALL_H
+
+#define H_PUT_TERM_CHAR	0x58
+
+long plpar_hcall_norets(unsigned long opcode, ...);
+
+#endif
diff --git a/arch/powerpc/purgatory/kexec-sha256.h b/arch/powerpc/purgatory/kexec-sha256.h
new file mode 100644
index 000000000000..4418ed02c052
--- /dev/null
+++ b/arch/powerpc/purgatory/kexec-sha256.h
@@ -0,0 +1,11 @@
+#ifndef KEXEC_SHA256_H
+#define KEXEC_SHA256_H
+
+struct kexec_sha_region {
+	unsigned long start;
+	unsigned long len;
+};
+
+#define SHA256_REGIONS 16
+
+#endif /* KEXEC_SHA256_H */
diff --git a/arch/powerpc/purgatory/ppc64_asm.h b/arch/powerpc/purgatory/ppc64_asm.h
new file mode 100644
index 000000000000..3410cf66ae35
--- /dev/null
+++ b/arch/powerpc/purgatory/ppc64_asm.h
@@ -0,0 +1,18 @@
+/*
+ * ppc64_asm.h - common defines for PPC64 assembly parts
+ *
+ * Code taken from kexec-tools.
+ *
+ * This source code is licensed under the GNU General Public License,
+ * Version 2.  See the file COPYING for more details.
+ */
+
+/*
+ * ABIv1 requires dot symbol while ABIv2 does not.
+ */
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define DOTSYM(a)	a
+#else
+#define GLUE(a,b)	a##b
+#define DOTSYM(a)	GLUE(.,a)
+#endif
diff --git a/arch/powerpc/purgatory/printf.c b/arch/powerpc/purgatory/printf.c
new file mode 100644
index 000000000000..73c85f251ae6
--- /dev/null
+++ b/arch/powerpc/purgatory/printf.c
@@ -0,0 +1,171 @@
+/*
+ * Code taken from kexec-tools.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <stdarg.h>
+#include "purgatory.h"
+#include "../boot/string.h"
+
+#define CHAR_BIT 8
+
+/*
+ * Output
+ * =============================================================================
+ */
+
+#define LONG_LONG_SHIFT  ((int)((sizeof(unsigned long long)*CHAR_BIT) - 4))
+#define LONG_SHIFT  ((int)((sizeof(unsigned long)*CHAR_BIT) - 4))
+#define INT_SHIFT   ((int)((sizeof(unsigned int)*CHAR_BIT) - 4))
+#define SHRT_SHIFT  ((int)((sizeof(unsigned short)*CHAR_BIT) - 4))
+#define CHAR_SHIFT  ((int)((sizeof(unsigned char)*CHAR_BIT) - 4))
+
+/**************************************************************************
+PRINTF and friends
+
+	Formats:
+		%x	- 4 bytes int (8 hex digits, lower case)
+		%X	- 4 bytes int (8 hex digits, upper case)
+		%lx     - 8 bytes long (16 hex digits, lower case)
+		%lX     - 8 bytes long (16 hex digits, upper case)
+		%hx	- 2 bytes int (4 hex digits, lower case)
+		%hX	- 2 bytes int (4 hex digits, upper case)
+		%hhx	- 1 byte int (2 hex digits, lower case)
+		%hhX	- 1 byte int (2 hex digits, upper case)
+			- optional # prefixes 0x or 0X
+		%d	- decimal int
+		%c	- char
+		%s	- string
+	Note: width specification not supported
+**************************************************************************/
+void vsprintf(char *buffer, const char *fmt, va_list args)
+{
+	char *p;
+	for ( ; *fmt != '\0'; ++fmt) {
+		if (*fmt != '%') {
+			if (buffer)
+				*buffer++ = *fmt;
+			else
+				putchar(*fmt);
+			continue;
+		}
+		if (*++fmt == 's') {
+			for(p = va_arg(args, char *); *p != '\0'; p++)
+				if (buffer)
+					*buffer++ = *p;
+				else
+					putchar(*p);
+		}
+		else {	/* Length of item is bounded */
+			char tmp[40], *q = tmp;
+			int shift = INT_SHIFT;
+			if (*fmt == 'L') {
+				shift = LONG_LONG_SHIFT;
+				fmt++;
+			}
+			else if (*fmt == 'l') {
+				shift = LONG_SHIFT;
+				fmt++;
+			}
+			else if (*fmt == 'h') {
+				shift = SHRT_SHIFT;
+				fmt++;
+				if (*fmt == 'h') {
+					shift = CHAR_SHIFT;
+					fmt++;
+				}
+			}
+
+			/*
+			 * Before each format q points to tmp buffer
+			 * After each format q points past end of item
+			 */
+			if ((*fmt | 0x20) == 'x') {
+				/* With x86 gcc, sizeof(long) == sizeof(int) */
+				unsigned long long h;
+				int ncase;
+				if (shift > LONG_SHIFT) {
+					h = va_arg(args, unsigned long long);
+				}
+				else if (shift > INT_SHIFT) {
+					h = va_arg(args, unsigned long);
+				} else {
+					h = va_arg(args, unsigned int);
+				}
+				ncase = (*fmt & 0x20);
+				for ( ; shift >= 0; shift -= 4)
+					*q++ = "0123456789ABCDEF"[(h >> shift) & 0xF] | ncase;
+			}
+			else if (*fmt == 'd') {
+				char *r;
+				long i;
+				if (shift > LONG_SHIFT) {
+					i = va_arg(args, long long);
+				}
+				else if (shift > INT_SHIFT) {
+					i = va_arg(args, long);
+				} else {
+					i = va_arg(args, int);
+				}
+				if (i < 0) {
+					*q++ = '-';
+					i = -i;
+				}
+				p = q;		/* save beginning of digits */
+				do {
+					*q++ = '0' + (i % 10);
+					i /= 10;
+				} while (i);
+				/* reverse digits, stop in middle */
+				r = q;		/* don't alter q */
+				while (--r > p) {
+					i = *r;
+					*r = *p;
+					*p++ = i;
+				}
+			}
+			else if (*fmt == 'c')
+				*q++ = va_arg(args, int);
+			else
+				*q++ = *fmt;
+			/* now output the saved string */
+			for (p = tmp; p < q; ++p)
+				if (buffer)
+					*buffer++ = *p;
+				else
+					putchar(*p);
+		}
+	}
+	if (buffer)
+		*buffer = '\0';
+}
+
+void sprintf(char *buffer, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsprintf(buffer, fmt, args);
+	va_end(args);
+}
+
+void printf(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsprintf(0, fmt, args);
+	va_end(args);
+}
diff --git a/arch/powerpc/purgatory/purgatory-ppc64.c b/arch/powerpc/purgatory/purgatory-ppc64.c
new file mode 100644
index 000000000000..01145d9ff4c1
--- /dev/null
+++ b/arch/powerpc/purgatory/purgatory-ppc64.c
@@ -0,0 +1,46 @@
+/*
+ * kexec: Linux boots Linux
+ *
+ * Created by: Mohan Kumar M (mohan@in.ibm.com)
+ *
+ * Copyright (C) IBM Corporation, 2005. All rights reserved
+ *
+ * Code taken from kexec-tools.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "purgatory.h"
+#include "purgatory-ppc64.h"
+
+unsigned int panic_kernel = 0;
+unsigned long backup_start = 0;
+unsigned long stack = 0;
+unsigned long dt_offset = 0;
+unsigned long my_toc = 0;
+unsigned long kernel = 0;
+unsigned int debug = 0;
+unsigned long opal_base = 0;
+unsigned long opal_entry = 0;
+
+void setup_arch(void)
+{
+	return;
+}
+
+void post_verification_setup_arch(void)
+{
+	if (panic_kernel)
+		crashdump_backup_memory();
+}
diff --git a/arch/powerpc/purgatory/purgatory-ppc64.h b/arch/powerpc/purgatory/purgatory-ppc64.h
new file mode 100644
index 000000000000..52eaf4394c48
--- /dev/null
+++ b/arch/powerpc/purgatory/purgatory-ppc64.h
@@ -0,0 +1,6 @@
+#ifndef PURGATORY_PPC64_H
+#define PURGATORY_PPC64_H
+
+void crashdump_backup_memory(void);
+
+#endif /* PURGATORY_PPC64_H */
diff --git a/arch/powerpc/purgatory/purgatory.c b/arch/powerpc/purgatory/purgatory.c
new file mode 100644
index 000000000000..7d2d83466e4c
--- /dev/null
+++ b/arch/powerpc/purgatory/purgatory.c
@@ -0,0 +1,66 @@
+/*
+ * Code taken from kexec-tools.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation (version 2 of the License).
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "purgatory.h"
+#include "sha256.h"
+#include "../boot/string.h"
+#include "kexec-sha256.h"
+
+struct kexec_sha_region sha_regions[SHA256_REGIONS] = {};
+u8 sha256_digest[SHA256_DIGEST_SIZE] = { 0 };
+
+int verify_sha256_digest(void)
+{
+	struct kexec_sha_region *ptr, *end;
+	u8 digest[SHA256_DIGEST_SIZE];
+	size_t i;
+	struct sha256_state sctx;
+
+	sha256_init(&sctx);
+	end = &sha_regions[sizeof(sha_regions)/sizeof(sha_regions[0])];
+	for (ptr = sha_regions; ptr < end; ptr++)
+		sha256_update(&sctx, (uint8_t *)(ptr->start), ptr->len);
+	sha256_final(&sctx, digest);
+
+	if (memcmp(digest, sha256_digest, sizeof(digest)) != 0) {
+		printf("sha256 digests do not match :(\n");
+		printf("       digest: ");
+		for(i = 0; i < sizeof(digest); i++)
+			printf("%hhx ", digest[i]);
+		printf("\n");
+
+		printf("sha256_digest: ");
+		for(i = 0; i < sizeof(sha256_digest); i++)
+			printf("%hhx ", sha256_digest[i]);
+
+		printf("\n");
+		return 1;
+	}
+	return 0;
+}
+
+void purgatory(void)
+{
+	printf("I'm in purgatory\n");
+	setup_arch();
+	if (verify_sha256_digest()) {
+		/* loop forever */
+		for(;;)
+			;
+	}
+	post_verification_setup_arch();
+}
diff --git a/arch/powerpc/purgatory/purgatory.h b/arch/powerpc/purgatory/purgatory.h
new file mode 100644
index 000000000000..788ce4930a30
--- /dev/null
+++ b/arch/powerpc/purgatory/purgatory.h
@@ -0,0 +1,11 @@
+#ifndef PURGATORY_H
+#define PURGATORY_H
+
+void putchar(int ch);
+void sprintf(char *buffer, const char *fmt, ...)
+	__attribute__ ((format (printf, 2, 3)));
+void printf(const char *fmt, ...) __attribute__ ((format (printf, 1, 2)));
+void setup_arch(void);
+void post_verification_setup_arch(void);
+
+#endif /* PURGATORY_H */
diff --git a/arch/powerpc/purgatory/sha256.c b/arch/powerpc/purgatory/sha256.c
new file mode 100644
index 000000000000..6abee1877d56
--- /dev/null
+++ b/arch/powerpc/purgatory/sha256.c
@@ -0,0 +1,6 @@
+#include "../boot/string.h"
+
+/* Avoid including x86's boot/string.h in sha256.c. */
+#define BOOT_STRING_H
+
+#include "../../x86/purgatory/sha256.c"
diff --git a/arch/powerpc/purgatory/sha256.h b/arch/powerpc/purgatory/sha256.h
new file mode 100644
index 000000000000..72818f3a207e
--- /dev/null
+++ b/arch/powerpc/purgatory/sha256.h
@@ -0,0 +1 @@
+#include "../../x86/purgatory/sha256.h"
diff --git a/arch/powerpc/purgatory/string.S b/arch/powerpc/purgatory/string.S
new file mode 100644
index 000000000000..3a1e23ff4017
--- /dev/null
+++ b/arch/powerpc/purgatory/string.S
@@ -0,0 +1 @@
+#include "../boot/string.S"
diff --git a/arch/powerpc/purgatory/v2wrap.S b/arch/powerpc/purgatory/v2wrap.S
new file mode 100644
index 000000000000..c7791819c0c6
--- /dev/null
+++ b/arch/powerpc/purgatory/v2wrap.S
@@ -0,0 +1,139 @@
+#
+#  kexec: Linux boots Linux
+#
+#  Copyright (C) 2004 - 2005, Milton D Miller II, IBM Corporation
+#  Copyright (C) 2006, Mohan Kumar M (mohan@in.ibm.com), IBM Corporation
+#
+# Code taken from kexec-tools.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation (version 2 of the License).
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+#
+
+#include "ppc64_asm.h"
+
+# v2wrap.S
+# a wrapper to call purgatory code to backup first
+# 32kB of first kernel into the backup region
+# reserved by kexec-tools.
+# Invokes ppc64 kernel with the expected arguments
+# of kernel(device-tree, phys-offset, 0)
+
+#
+# calling convention:
+#   r3 = physical number of this cpu (all cpus)
+#   r4 = address of this chunk (master only)
+# master enters at purgatory_start (aka first byte of this chunk)
+# slaves (additional cpus), if any, enter a copy of the
+# first 0x100 bytes of this code relocated to 0x0
+#
+# in other words,
+#   a copy of the first 0x100 bytes of this code is copied to 0
+#   and the slaves are sent to address 0x60
+#   with r3 = their physical cpu number.
+
+#define LOADADDR(rn,name) \
+	lis     rn,name##@highest;      \
+	ori     rn,rn,name##@higher;    \
+	rldicr  rn,rn,32,31;            \
+	oris    rn,rn,name##@h;         \
+	ori     rn,rn,name##@l
+
+	.machine ppc64
+	.align 8
+	.globl purgatory_start
+purgatory_start:	b	master
+	.org purgatory_start + 0x5c     # ABI: possible run_at_load flag at 0x5c
+	.globl run_at_load
+run_at_load:
+	.long 0
+	.size run_at_load, . - run_at_load
+	.org purgatory_start + 0x60     # ABI: slaves start at 60 with r3=phys
+slave:	b $
+	.org purgatory_start + 0x100    # ABI: end of copied region
+	.size purgatory_start, . - purgatory_start
+
+#
+# The above 0x100 bytes at purgatory_start are replaced with the
+# code from the kernel (or next stage) by kexec/arch/ppc64/kexec-elf-ppc64.c
+#
+
+master:
+	or	1,1,1		# low priority to let other threads catchup
+	isync
+	mr      17,3            # save cpu id to r17
+	mr      15,4            # save physical address in reg15
+
+	LOADADDR(6,my_toc)
+	ld      2,0(6)          #setup toc
+
+	LOADADDR(6,stack)
+	ld      1,0(6)          #setup stack
+
+	subi    1,1,112
+	bl      DOTSYM(purgatory)
+	nop
+
+	or	3,3,3		# ok now to high priority, lets boot
+	lis	6,0x1
+	mtctr	6		# delay a bit for slaves to catch up
+83:	bdnz	83b		# before we overwrite 0-100 again
+
+	LOADADDR(16, dt_offset)
+	ld      3,0(16)         # load device-tree address
+	mr      16,3            # save dt address in reg16
+#ifdef __BIG_ENDIAN__
+	lwz     6,20(3)         # fetch version number
+#else
+	li	4,20
+	lwbrx	6,3,4		# fetch BE version number
+#endif
+	cmpwi   0,6,2           # v2 ?
+	blt     80f
+#ifdef __BIG_ENDIAN__
+	stw     17,28(3)        # save my cpu number as boot_cpu_phys
+#else
+	li	4,28
+	stwbrx	17,3,4		# Store my cpu as BE value
+#endif
+80:
+	LOADADDR(6,opal_base)	# For OPAL early debug
+	ld      8,0(6)          # load the OPAL base address in r8
+	LOADADDR(6,opal_entry)	# For OPAL early debug
+	ld      9,0(6)          # load the OPAL entry address in r9
+	LOADADDR(6,kernel)
+	ld      4,0(6)          # load the kernel address
+	LOADADDR(6,run_at_load) # the load flag
+	lwz	7,0(6)		# possibly patched by kexec-elf-ppc64
+	stw	7,0x5c(4)	# and patch it into the kernel
+	mr      3,16            # restore dt address
+
+	mfmsr	5
+	andi.	10,5,1		# test MSR_LE
+	bne	little_endian
+
+	li	5,0		# r5 will be 0 for kernel
+	mtctr	4		# prepare branch to
+	bctr			# start kernel
+
+little_endian:			# book3s-only
+	mtsrr0	4		# prepare branch to
+
+	clrrdi	5,5,1		# clear MSR_LE
+	mtsrr1	5
+
+	li	5,0		# r5 will be 0 for kernel
+
+				# skip cache flush, do we care?
+
+	rfid			# update MSR and start kernel
-- 
1.9.1
