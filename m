Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1642F2C014B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 06:25:23 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Sat, 26 Oct 2013 05:25:20 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DBD6C2BB0044
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 06:25:12 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9PJ7u2a61341796
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 06:07:56 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9PJPCDK009409
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Oct 2013 06:25:12 +1100
From: Robert C Jennings <rcj@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: Move local setup.h declarations to arch includes
Date: Fri, 25 Oct 2013 14:25:07 -0500
Message-Id: <1382729107-13560-3-git-send-email-rcj@linux.vnet.ibm.com>
In-Reply-To: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
References: <1382729107-13560-1-git-send-email-rcj@linux.vnet.ibm.com>
Cc: Robert C Jennings <rcj@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the few declarations from arch/powerpc/kernel/setup.h
into arch/powerpc/include/asm/setup.h.  This resolves a
sparse warning for arch/powerpc/mm/numa.c which defines
do_init_bootmem() but can't include the setup.h header
in the prior path.

Resolves:
arch/powerpc/mm/numa.c:998:13:
        warning: symbol 'do_init_bootmem' was not declared.
                 Should it be static?

Signed-off-by: Robert C Jennings <rcj@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/setup.h   | 5 +++++
 arch/powerpc/kernel/module.c       | 3 +--
 arch/powerpc/kernel/module_32.c    | 3 +--
 arch/powerpc/kernel/module_64.c    | 3 +--
 arch/powerpc/kernel/setup-common.c | 2 --
 arch/powerpc/kernel/setup.h        | 9 ---------
 arch/powerpc/kernel/setup_32.c     | 2 --
 arch/powerpc/kernel/setup_64.c     | 2 --
 arch/powerpc/kernel/vdso.c         | 3 +--
 9 files changed, 9 insertions(+), 23 deletions(-)
 delete mode 100644 arch/powerpc/kernel/setup.h

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index d3ca855..5e24df0 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -23,6 +23,11 @@ extern void reloc_got2(unsigned long);
 
 #define PTRRELOC(x)	((typeof(x)) add_reloc_offset((unsigned long)(x)))
 
+extern void check_for_initrd(void);
+extern void do_init_bootmem(void);
+extern void setup_panic(void);
+extern int do_early_xmon;
+
 #endif /* !__ASSEMBLY__ */
 
 #endif	/* _ASM_POWERPC_SETUP_H */
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 2d27570..9547381 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -25,8 +25,7 @@
 #include <asm/uaccess.h>
 #include <asm/firmware.h>
 #include <linux/sort.h>
-
-#include "setup.h"
+#include <asm/setup.h>
 
 LIST_HEAD(module_bug_list);
 
diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 2e3200c..6cff040 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -26,8 +26,7 @@
 #include <linux/cache.h>
 #include <linux/bug.h>
 #include <linux/sort.h>
-
-#include "setup.h"
+#include <asm/setup.h>
 
 #if 0
 #define DEBUGP printk
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6ee59a0..da082e8 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -26,8 +26,7 @@
 #include <asm/firmware.h>
 #include <asm/code-patching.h>
 #include <linux/sort.h>
-
-#include "setup.h"
+#include <asm/setup.h>
 
 /* FIXME: We don't do .init separately.  To do this, we'd need to have
    a separate r2 value in the init and core section, and stub between
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 3d261c0..febc804 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -62,8 +62,6 @@
 #include <mm/mmu_decl.h>
 #include <asm/fadump.h>
 
-#include "setup.h"
-
 #ifdef DEBUG
 #include <asm/udbg.h>
 #define DBG(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
deleted file mode 100644
index 4c67ad7..0000000
--- a/arch/powerpc/kernel/setup.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef _POWERPC_KERNEL_SETUP_H
-#define _POWERPC_KERNEL_SETUP_H
-
-void check_for_initrd(void);
-void do_init_bootmem(void);
-void setup_panic(void);
-extern int do_early_xmon;
-
-#endif /* _POWERPC_KERNEL_SETUP_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a4bbcae..b903dc5 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -40,8 +40,6 @@
 #include <asm/mmu_context.h>
 #include <asm/epapr_hcalls.h>
 
-#include "setup.h"
-
 #define DBG(fmt...)
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 278ca93..4085aaa 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -68,8 +68,6 @@
 #include <asm/hugetlb.h>
 #include <asm/epapr_hcalls.h>
 
-#include "setup.h"
-
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
 #else
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 1d9c926..094e45c 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -34,8 +34,7 @@
 #include <asm/firmware.h>
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
-
-#include "setup.h"
+#include <asm/setup.h>
 
 #undef DEBUG
 
-- 
1.8.1.2
