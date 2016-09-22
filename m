Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfnLM25fVzDsjN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 16:55:07 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hi10so3256178pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 23:55:07 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 6/6] powerpc/boot: Add support for XZ compression
Date: Thu, 22 Sep 2016 16:54:34 +1000
Message-Id: <1474527274-10897-7-git-send-email-oohall@gmail.com>
In-Reply-To: <1474527274-10897-1-git-send-email-oohall@gmail.com>
References: <1474527274-10897-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds an option to use XZ compression for the kernel image.
Currently this is only enabled for PPC64 targets since the bulk of the
32bit platforms produce uboot images which do not use the wrapper.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/Makefile             |  3 +++
 arch/powerpc/boot/decompress.c         |  5 +++++
 arch/powerpc/boot/stdbool.h            | 15 +++++++++++++
 arch/powerpc/boot/stdint.h             | 13 ++++++++++++
 arch/powerpc/boot/types.h              | 14 ++++++++++++
 arch/powerpc/boot/xz_config.h          | 39 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 7 files changed, 90 insertions(+)
 create mode 100644 arch/powerpc/boot/stdbool.h
 create mode 100644 arch/powerpc/boot/stdint.h
 create mode 100644 arch/powerpc/boot/xz_config.h

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 9fb451d0586e..eae2dc8bc218 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -20,6 +20,7 @@
 all: $(obj)/zImage
 
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
+compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
@@ -226,6 +227,7 @@ endif
 endif
 
 compressor-$(CONFIG_KERNEL_GZIP) := gz
+compressor-$(CONFIG_KERNEL_XZ)   := xz
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
@@ -433,6 +435,7 @@ clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 # clean up files cached by wrapper
 clean-kernel-base := vmlinux.strip vmlinux.bin
 clean-kernel := $(addsuffix .gz,$(clean-kernel-base))
+clean-kernel += $(addsuffix .xz,$(clean-kernel-base))
 # If not absolute clean-files are relative to $(obj).
 clean-files += $(addprefix $(objtree)/, $(clean-kernel))
 
diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
index 60fc6fb26867..8f32ea4289af 100644
--- a/arch/powerpc/boot/decompress.c
+++ b/arch/powerpc/boot/decompress.c
@@ -37,6 +37,11 @@
 #	include "decompress_inflate.c"
 #endif
 
+#ifdef CONFIG_KERNEL_XZ
+#	include "xz_config.h"
+#	include "../../../lib/decompress_unxz.c"
+#endif
+
 /* globals for tracking the state of the decompression */
 static unsigned long decompressed_bytes;
 static unsigned long limit;
diff --git a/arch/powerpc/boot/stdbool.h b/arch/powerpc/boot/stdbool.h
new file mode 100644
index 000000000000..2ebcfa53b4c7
--- /dev/null
+++ b/arch/powerpc/boot/stdbool.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) IBM Corporation 2016.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This file is only necessary because some of the pre-boot decompressors
+ * expect stdbool.h to be available.
+ *
+ */
+
+#include "types.h"
+
diff --git a/arch/powerpc/boot/stdint.h b/arch/powerpc/boot/stdint.h
new file mode 100644
index 000000000000..c1c853be7490
--- /dev/null
+++ b/arch/powerpc/boot/stdint.h
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) IBM Corporation 2016.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * This file is only necessary because some of the pre-boot decompressors
+ * expect stdint.h to be available.
+ */
+
+#include "types.h"
diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
index 85565a89bcc2..af6b66b842c4 100644
--- a/arch/powerpc/boot/types.h
+++ b/arch/powerpc/boot/types.h
@@ -1,6 +1,8 @@
 #ifndef _TYPES_H_
 #define _TYPES_H_
 
+#include <stdbool.h>
+
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
 typedef unsigned char		u8;
@@ -34,4 +36,16 @@ typedef s64 int64_t;
 	(void) (&_x == &_y);	\
 	_x > _y ? _x : _y; })
 
+#define min_t(type, a, b) min(((type) a), ((type) b))
+#define max_t(type, a, b) max(((type) a), ((type) b))
+
+typedef int bool;
+
+#ifndef true
+#define true 1
+#endif
+
+#ifndef false
+#define false 0
+#endif
 #endif /* _TYPES_H_ */
diff --git a/arch/powerpc/boot/xz_config.h b/arch/powerpc/boot/xz_config.h
new file mode 100644
index 000000000000..5c6afdbca642
--- /dev/null
+++ b/arch/powerpc/boot/xz_config.h
@@ -0,0 +1,39 @@
+#ifndef __XZ_CONFIG_H__
+#define __XZ_CONFIG_H__
+
+/*
+ * most of this is copied from lib/xz/xz_private.h, we can't use their defines
+ * since the boot wrapper is not built in the same environment as the rest of
+ * the kernel.
+ */
+
+#include "types.h"
+#include "swab.h"
+
+static inline uint32_t swab32p(void *p)
+{
+	uint32_t *q = p;
+
+	return swab32(*q);
+}
+
+#ifdef __LITTLE_ENDIAN__
+#define get_le32(p) (*((uint32_t *) (p)))
+#else
+#define get_le32(p) swab32p(p)
+#endif
+
+#define memeq(a, b, size) (memcmp(a, b, size) == 0)
+#define memzero(buf, size) memset(buf, 0, size)
+
+/* prevent the inclusion of the xz-preboot MM headers */
+#define DECOMPR_MM_H
+#define memmove memmove
+#define XZ_EXTERN static
+
+/* xz.h needs to be included directly since we need enum xz_mode */
+#include "../../../include/linux/xz.h"
+
+#undef XZ_EXTERN
+
+#endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f32edec13fd1..d5da55b01027 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -2,6 +2,7 @@ config PPC64
 	bool "64-bit kernel"
 	default n
 	select ZLIB_DEFLATE
+	select HAVE_KERNEL_XZ
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
-- 
2.5.5
