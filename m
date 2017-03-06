Return-Path: <me@tobin.cc>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcCZ85YFqzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 19:26:56 +1100 (AEDT)
From: "Tobin C. Harding" <me@tobin.cc>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: [PATCH] powerpc: fix sparse warning, include kernel header
Date: Mon,  6 Mar 2017 19:25:31 +1100
Message-Id: <1488788731-2537-1-git-send-email-me@tobin.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Spares emits two symbol not declared warnings. The two functions in
question are declared already in a kernel header.

Add include directive to include kernel header.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

github issue: #37 Fix sparse errors

 arch/powerpc/kernel/swsusp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/swsusp.c b/arch/powerpc/kernel/swsusp.c
index 6ae9bd5..0050b2d 100644
--- a/arch/powerpc/kernel/swsusp.c
+++ b/arch/powerpc/kernel/swsusp.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/suspend.h>
 #include <asm/current.h>
 #include <asm/mmu_context.h>
 #include <asm/switch_to.h>
-- 
2.7.4
