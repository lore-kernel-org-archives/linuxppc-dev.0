Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED911DDF0C
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 04:21:41 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l44ILdfQ028640
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 14:21:39 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l44ILc7j186796
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:21:38 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l44ILcnS023538
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:21:38 -0600
Received: from [9.10.86.166] (zod.rchland.ibm.com [9.10.86.166])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l44ILci7023490
	for <linuxppc-dev@ozlabs.org>; Fri, 4 May 2007 12:21:38 -0600
Subject: [PATCH 4/4] Holly bootwrapper
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1178302414.3026.202.camel@zod.rchland.ibm.com>
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Fri, 04 May 2007 13:16:43 -0500
Message-Id: <1178302603.3026.212.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add Holly/Hickory bootwrapper

Signed-off-by: Stephen Winiecki <stevewin@us.ibm.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/boot/Makefile |    9 ++++++++-
 arch/powerpc/boot/holly.c  |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -43,7 +43,7 @@ $(addprefix $(obj)/,$(zlib) main.o): $(a
 src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		gunzip_util.c elf_util.c $(zlib) devtree.c
-src-plat := of.c cuboot-83xx.c cuboot-85xx.c
+src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -131,6 +131,7 @@ image-$(CONFIG_PPC_EFIKA)		+= zImage.chr
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
+image-$(CONFIG_HOLLY)			+= zImage.holly-elf
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
@@ -161,6 +162,12 @@ $(obj)/zImage.ps3: vmlinux
 $(obj)/zImage.initrd.ps3: vmlinux
 	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
 
+$(obj)/zImage.holly-elf: vmlinux $(wrapperbits)
+	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,)
+
+$(obj)/zImage.initrd.holly-elf: vmlinux $(wrapperbits) $(obj)/ramdisk.image.gz
+	$(call if_changed,wrap,holly,$(obj)/dts/holly.dts,,$(obj)/ramdisk.image.gz)
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call if_changed,wrap,uboot)
 
--- /dev/null
+++ linux-2.6/arch/powerpc/boot/holly.c
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2007 IBM Corporation
+ *
+ * Stephen Winiecki <stevewin@us.ibm.com>
+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
+ *
+ * Based on earlier code:
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "io.h"
+
+extern char _start[];
+extern char _end[];
+extern char _dtb_start[];
+extern char _dtb_end[];
+
+BSS_STACK(4096);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32 heapsize = 0x8000000 - (u32)_end; /* 128M */
+
+	simple_alloc_init(_end, heapsize, 32, 64);
+	ft_init(_dtb_start, 0, 4);
+	serial_console_init();
+}
