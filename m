Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42B9G84XHLzF1RG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 06:28:32 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so10775990ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 13:28:32 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Frank Rowand <frowand.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/3] libfdt: Ensure INT_MAX is defined in libfdt_env.h
Date: Thu, 13 Sep 2018 15:28:26 -0500
Message-Id: <20180913202828.15372-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The next update of libfdt has a new dependency on INT_MAX. Update the
instances of libfdt_env.h in the kernel to either include the necessary
header with the definition or define it locally.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/compressed/libfdt_env.h | 2 ++
 arch/powerpc/boot/libfdt_env.h        | 2 ++
 include/linux/libfdt_env.h            | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/compressed/libfdt_env.h b/arch/arm/boot/compressed/libfdt_env.h
index 07437816e098..b36c0289a308 100644
--- a/arch/arm/boot/compressed/libfdt_env.h
+++ b/arch/arm/boot/compressed/libfdt_env.h
@@ -6,6 +6,8 @@
 #include <linux/string.h>
 #include <asm/byteorder.h>
 
+#define INT_MAX			((int)(~0U>>1))
+
 typedef __be16 fdt16_t;
 typedef __be32 fdt32_t;
 typedef __be64 fdt64_t;
diff --git a/arch/powerpc/boot/libfdt_env.h b/arch/powerpc/boot/libfdt_env.h
index 2a0c8b1bf147..2abc8e83b95e 100644
--- a/arch/powerpc/boot/libfdt_env.h
+++ b/arch/powerpc/boot/libfdt_env.h
@@ -5,6 +5,8 @@
 #include <types.h>
 #include <string.h>
 
+#define INT_MAX			((int)(~0U>>1))
+
 #include "of.h"
 
 typedef unsigned long uintptr_t;
diff --git a/include/linux/libfdt_env.h b/include/linux/libfdt_env.h
index c6ac1fe7ec68..edb0f0c30904 100644
--- a/include/linux/libfdt_env.h
+++ b/include/linux/libfdt_env.h
@@ -2,6 +2,7 @@
 #ifndef LIBFDT_ENV_H
 #define LIBFDT_ENV_H
 
+#include <linux/kernel.h>	/* For INT_MAX */
 #include <linux/string.h>
 
 #include <asm/byteorder.h>
-- 
2.17.1
