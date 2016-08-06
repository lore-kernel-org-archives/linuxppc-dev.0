Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6Jrw3pThzDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 08:54:24 +1000 (AEST)
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>, Kevin Hao <haokexin@gmail.com>
Subject: [PATCH] powerpc: vdso: Add missing include file
Date: Sat,  6 Aug 2016 15:54:12 -0700
Message-Id: <1470524052-27133-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some powerpc builds fail with the following buld error.

In file included from ./arch/powerpc/include/asm/mmu_context.h:11:0,
                 from arch/powerpc/kernel/vdso.c:28:
arch/powerpc/include/asm/cputhreads.h: In function 'get_tensr':
arch/powerpc/include/asm/cputhreads.h:101:2: error:
	implicit declaration of function 'cpu_has_feature'

Fixes: b92a226e5284 ("powerpc: Move cpu_has_feature() to a separate file")
Cc: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
My apologies for the noise if already reported/fixed.

 arch/powerpc/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 6767605ea8da..4111d30badfa 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -22,6 +22,7 @@
 #include <linux/security.h>
 #include <linux/memblock.h>
 
+#include <asm/cpu_has_feature.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/mmu.h>
-- 
2.5.0
