Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37EF61A056B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 15:55:49 +1100 (AEDT)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2/5 v2] powerpc/boot/fdt: Add little-endian support to libfdt
 wrappers
Message-Id: <1423630544.752438.317337864668.2.gpush@pablo>
In-Reply-To: <1423630544.752188.889982625387.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 11 Feb 2015 12:55:44 +0800
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For epapr-style boot, we may be little-endian. This change implements
the proper conversion for fdt*_to_cpu and cpu_to_fdt*. We also need the
full cpu_to_* and *_to_cpu macros for this.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/boot/libfdt_env.h |   14 ++++++++------
 arch/powerpc/boot/of.h         |    8 ++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index c89fdb1..8dcd744 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -4,15 +4,17 @@
 #include <types.h>
 #include <string.h>
 
+#include "of.h"
+
 typedef u32 uint32_t;
 typedef u64 uint64_t;
 typedef unsigned long uintptr_t;
 
-#define fdt16_to_cpu(x)		(x)
-#define cpu_to_fdt16(x)		(x)
-#define fdt32_to_cpu(x)		(x)
-#define cpu_to_fdt32(x)		(x)
-#define fdt64_to_cpu(x)		(x)
-#define cpu_to_fdt64(x)		(x)
+#define fdt16_to_cpu(x)		be16_to_cpu(x)
+#define cpu_to_fdt16(x)		cpu_to_be16(x)
+#define fdt32_to_cpu(x)		be32_to_cpu(x)
+#define cpu_to_fdt32(x)		cpu_to_be32(x)
+#define fdt64_to_cpu(x)		be64_to_cpu(x)
+#define cpu_to_fdt64(x)		cpu_to_be64(x)
 
 #endif /* _ARCH_POWERPC_BOOT_LIBFDT_ENV_H */
diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index c8c1750..5603320 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -24,11 +24,19 @@ void of_console_init(void);
 typedef u32			__be32;
 
 #ifdef __LITTLE_ENDIAN__
+#define cpu_to_be16(x) swab16(x)
+#define be16_to_cpu(x) swab16(x)
 #define cpu_to_be32(x) swab32(x)
 #define be32_to_cpu(x) swab32(x)
+#define cpu_to_be64(x) swab64(x)
+#define be64_to_cpu(x) swab64(x)
 #else
+#define cpu_to_be16(x) (x)
+#define be16_to_cpu(x) (x)
 #define cpu_to_be32(x) (x)
 #define be32_to_cpu(x) (x)
+#define cpu_to_be64(x) (x)
+#define be64_to_cpu(x) (x)
 #endif
 
 #define PROM_ERROR (-1u)
