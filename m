Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40y80B5zxZzDrpC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 01:49:30 +1000 (AEST)
Message-Id: <f3eb20560df1df7fdf2322b370419bcf2de9da2b.1527868006.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 01/14] powerpc: remove kdump.h from page.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  1 Jun 2018 15:49:27 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

page.h doesn't need kdump.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/page.h     | 1 -
 arch/powerpc/kernel/crash.c         | 1 -
 arch/powerpc/kernel/machine_kexec.c | 1 +
 arch/powerpc/kernel/setup_32.c      | 1 +
 4 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index db7be0779d55..a9fbefaacf10 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -17,7 +17,6 @@
 #include <asm/types.h>
 #endif
 #include <asm/asm-compat.h>
-#include <asm/kdump.h>
 
 /*
  * On regular PPC32 page size is 4K (but we support 4K/16K/64K/256K pages
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 17c8b99680f2..43a3ce2301e8 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -23,7 +23,6 @@
 #include <asm/processor.h>
 #include <asm/machdep.h>
 #include <asm/kexec.h>
-#include <asm/kdump.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/setjmp.h>
diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 936c7e2d421e..e530cbd48995 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/ftrace.h>
 
+#include <asm/kdump.h>
 #include <asm/machdep.h>
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 74457485574b..ef747a5a30b9 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,6 +40,7 @@
 #include <asm/code-patching.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/kdump.h>
 
 #define DBG(fmt...)
 
-- 
2.13.3
