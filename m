Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRXcM46RhzDqs7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:44:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/xive: Fix section mismatch warnings
Date: Tue,  8 Aug 2017 21:44:14 +1000
Message-Id: <1502192654-1167-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Both xive_core_init() and xive_native_init() are called from and call
__init routines, so they should also be __init.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/sysdev/xive/common.c | 4 ++--
 arch/powerpc/sysdev/xive/native.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 6595462b1fc8..739ce590fa9d 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1395,8 +1395,8 @@ void xive_shutdown(void)
 	xive_ops->shutdown();
 }
 
-bool xive_core_init(const struct xive_ops *ops, void __iomem *area, u32 offset,
-		    u8 max_prio)
+bool __init xive_core_init(const struct xive_ops *ops, void __iomem *area, u32 offset,
+			   u8 max_prio)
 {
 	xive_tima = area;
 	xive_tima_offset = offset;
diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 0f95476b01f6..1dbf782c9239 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -531,7 +531,7 @@ u32 xive_native_default_eq_shift(void)
 }
 EXPORT_SYMBOL_GPL(xive_native_default_eq_shift);
 
-bool xive_native_init(void)
+bool __init xive_native_init(void)
 {
 	struct device_node *np;
 	struct resource r;
-- 
2.7.4
