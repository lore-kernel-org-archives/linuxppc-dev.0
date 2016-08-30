Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNh6r2yF9zDrmy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 18:11:16 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id i6so792657pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 01:11:16 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 6/6] powerpc/boot: Add support for XZ compression
Date: Tue, 30 Aug 2016 18:10:36 +1000
Message-Id: <1472544636-7837-7-git-send-email-oohall@gmail.com>
In-Reply-To: <1472544636-7837-1-git-send-email-oohall@gmail.com>
References: <1472544636-7837-1-git-send-email-oohall@gmail.com>
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
 arch/powerpc/boot/Makefile             |  2 ++
 arch/powerpc/boot/decompress.c         |  5 +++++
 arch/powerpc/boot/types.h              | 10 +++++++++
 arch/powerpc/boot/xz_config.h          | 39 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 5 files changed, 57 insertions(+)
 create mode 100644 arch/powerpc/boot/xz_config.h

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 482bac2af1ff..de36806c1a73 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -20,6 +20,7 @@
 all: $(obj)/zImage
 
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
+compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
@@ -213,6 +214,7 @@ endif
 endif
 
 compressor-$(CONFIG_KERNEL_GZIP) := gz
+compressor-$(CONFIG_KERNEL_XZ)   := xz
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
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
diff --git a/arch/powerpc/boot/types.h b/arch/powerpc/boot/types.h
index 85565a89bcc2..0362a262a299 100644
--- a/arch/powerpc/boot/types.h
+++ b/arch/powerpc/boot/types.h
@@ -34,4 +34,14 @@ typedef s64 int64_t;
 	(void) (&_x == &_y);	\
 	_x > _y ? _x : _y; })
 
+#define min_t(type, a, b) min(((type) a), ((type) b))
+#define max_t(type, a, b) max(((type) a), ((type) b))
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
