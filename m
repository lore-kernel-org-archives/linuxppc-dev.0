Return-Path: <oohall@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404PQ03D64zF1cG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 16:14:47 +1100 (AEDT)
Received: by mail-pl0-x242.google.com with SMTP id 9-v6so9586891ple.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2018 22:14:47 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 1/5] powerpc/zImage: Remove #ifdef in opal.c
Date: Mon, 19 Mar 2018 16:13:59 +1100
Message-Id: <20180319051403.23275-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This file is only ever compiled if CONFIG_PPC64_BOOT_WRAPPER is set
so this check is unnecessary.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/opal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 0272570d02de..dfb199ef5b94 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -13,8 +13,6 @@
 #include <libfdt.h>
 #include "../include/asm/opal-api.h"
 
-#ifdef CONFIG_PPC64_BOOT_WRAPPER
-
 /* Global OPAL struct used by opal-call.S */
 struct opal {
 	u64 base;
@@ -101,9 +99,3 @@ int opal_console_init(void *devp, struct serial_console_data *scdp)
 
 	return 0;
 }
-#else
-int opal_console_init(void *devp, struct serial_console_data *scdp)
-{
-	return -1;
-}
-#endif /* __powerpc64__ */
-- 
2.9.5
