Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC9nc3RBJzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 06:53:23 +1000 (AEST)
From: Guenter Roeck <linux@roeck-us.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] powerpc: cputhreads: Add missing include file
Date: Sun, 14 Aug 2016 13:53:17 -0700
Message-Id: <1471207997-12119-1-git-send-email-linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Powerpc builds may fail with the following build error.

Error log:
In file included from ./arch/powerpc/include/asm/mmu_context.h:11:0,
                 from ./include/linux/mmu_context.h:4,
		 from mm/mmu_context.c:8:
./arch/powerpc/include/asm/cputhreads.h: In function 'get_tensr':
./arch/powerpc/include/asm/cputhreads.h:101:2: error:
	implicit declaration of function 'cpu_has_feature'

The problem can be triggered by configuring ppc64e_defconfig and selecting
CONFIG_TICK_CPU_ACCOUNTING instead of CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.

Fixes: b92a226e5284 ("powerpc: Move cpu_has_feature() to a separate file")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This is the second attempt to fix this problem. The first attempt was
with commit 546c4402c574 ("powerpc/vdso: Add missing include file"). This
was not complete because it added the include file to an affected source
file, not to the file where cpu_has_feature() was used.

Build tested all default configurations to ensure that this patch does not
introduce a regression.

 arch/powerpc/include/asm/cputhreads.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index 666bef4ebfae..9377bdf42eb8 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -3,6 +3,7 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
+#include <asm/cpu_has_feature.h>
 
 /*
  * Mapping of threads to cores
-- 
2.5.0
