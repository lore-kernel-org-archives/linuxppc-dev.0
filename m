Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKfjD4LxqzDvsv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 11:57:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/lib: Fix randconfig build failure in sstep.c
Date: Fri, 18 Nov 2016 11:57:18 +1100
Message-Id: <1479430638-4186-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Under some configs we need to explicitly include cpu_has_feature.h,
otherwise we fail with:

  arch/powerpc/lib/sstep.c:1992:7: error: implicit declaration of function 'cpu_has_feature'

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/sstep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index b64287c6793f..9c78a9c102c3 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -15,6 +15,7 @@
 #include <asm/sstep.h>
 #include <asm/processor.h>
 #include <asm/uaccess.h>
+#include <asm/cpu_has_feature.h>
 #include <asm/cputable.h>
 
 extern char system_call_common[];
-- 
2.7.4
