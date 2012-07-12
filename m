Return-Path: <dev@snitselaar.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 24E002C0205
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 17:05:49 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so3402087pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 00:05:47 -0700 (PDT)
From: Gerard Snitselaar <dev@snitselaar.org>
To: linux-next@vger.kernel.org
Subject: [PATCH] powerpc: remove rejected merge file from arch/powerpc/kernel
 in linux-next
Date: Thu, 12 Jul 2012 00:05:34 -0700
Message-Id: <1342076734-30996-1-git-send-email-dev@snitselaar.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stuart.yoder@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 9778b696 (powerpc: Use CURRENT_THREAD_INFO instead of open
coded assembly) got a rejected merge file iommu.c.rej committed with
it.

Signed-off-by: Gerard Snitselaar <dev@snitselaar.org>
---
 arch/powerpc/kernel/iommu.c.rej | 22 ----------------------
 1 file changed, 22 deletions(-)
 delete mode 100644 arch/powerpc/kernel/iommu.c.rej

diff --git a/arch/powerpc/kernel/iommu.c.rej b/arch/powerpc/kernel/iommu.c.rej
deleted file mode 100644
index 9d10d34..0000000
--- a/arch/powerpc/kernel/iommu.c.rej
+++ /dev/null
@@ -1,22 +0,0 @@
---- arch/powerpc/kernel/iommu.c	2012-06-08 09:01:02.785709100 +1000
-+++ arch/powerpc/kernel/iommu.c	2012-06-08 09:01:07.489784856 +1000
-@@ -33,7 +33,9 @@
- #include <linux/bitmap.h>
- #include <linux/iommu-helper.h>
- #include <linux/crash_dump.h>
-+#include <linux/fault-inject.h>
- #include <asm/io.h>
-+#include <asm/vio.h>
- #include <asm/prom.h>
- #include <asm/iommu.h>
- #include <asm/pci-bridge.h>
-@@ -171,6 +261,9 @@
- 		return DMA_ERROR_CODE;
- 	}
- 
-+	if (should_fail_iommu(dev))
-+		return DMA_ERROR_CODE;
-+
- 	if (handle && *handle)
- 		start = *handle;
- 	else
-- 
1.7.11.1.165.g299666c
