Return-Path: <albert_herranz@yahoo.es>
Received: from smtp125.mail.ukl.yahoo.com (smtp125.mail.ukl.yahoo.com
	[77.238.184.56]) by ozlabs.org (Postfix) with SMTP id 0432D1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 10:09:52 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 1/3] powerpc: udbg: add early remap hook
Date: Tue,  1 Dec 2009 00:09:48 +0100
Message-Id: <f1b232fa379a108d7f97102c261d3ecfc0372500.1259609263.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
In-Reply-To: <cover.1259609263.git.albert_herranz@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The udbg facility provides an early debug extension that can be enabled
using CONFIG_PPC_EARLY_DEBUG.
In some cases, this early debugging facility cannot be used after
MMU_init runs (and the MMU is loaded and enabled with the definitive
mappings) because the early mappings are not valid anymore.

This patch provides a udbg hook called udbg_early_remap that gets called
at the end of MMU_init and can be used by a low level udbg driver
to accomplish several goals, like:
- extending the early debugging life by configuring and using a new
  valid I/O mapping
- safely disabling the early debugging

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/udbg.h |    3 +++
 arch/powerpc/kernel/udbg.c      |    3 +++
 arch/powerpc/mm/init_32.c       |   10 ++++++++++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/udbg.h b/arch/powerpc/include/asm/udbg.h
index cd21e5e..9dfedec 100644
--- a/arch/powerpc/include/asm/udbg.h
+++ b/arch/powerpc/include/asm/udbg.h
@@ -18,6 +18,9 @@ extern void (*udbg_putc)(char c);
 extern void (*udbg_flush)(void);
 extern int (*udbg_getc)(void);
 extern int (*udbg_getc_poll)(void);
+#ifdef CONFIG_PPC_EARLY_DEBUG
+extern void (*udbg_early_remap)(void);
+#endif
 
 extern void udbg_puts(const char *s);
 extern int udbg_write(const char *s, int n);
diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index fc9af47..2711050 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -21,6 +21,9 @@ void (*udbg_putc)(char c);
 void (*udbg_flush)(void);
 int (*udbg_getc)(void);
 int (*udbg_getc_poll)(void);
+#ifdef CONFIG_PPC_EARLY_DEBUG
+void (*udbg_early_remap)(void);
+#endif
 
 /*
  * Early debugging facilities. You can enable _one_ of these via .config,
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 9ddcfb4..066e4ff 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -43,6 +43,7 @@
 #include <asm/tlb.h>
 #include <asm/sections.h>
 #include <asm/system.h>
+#include <asm/udbg.h>
 
 #include "mmu_decl.h"
 
@@ -180,6 +181,15 @@ void __init MMU_init(void)
 #ifdef CONFIG_BOOTX_TEXT
 	btext_unmap();
 #endif
+#ifdef CONFIG_PPC_EARLY_DEBUG
+	/*
+	 * This hook can be used by a low level early udbg driver to either
+	 * provide a new valid I/O mapping to be used after MMU_init
+	 * or just to safely disable actual udbg I/O from now on.
+	 */
+	if (udbg_early_remap)
+		udbg_early_remap();
+#endif
 }
 
 /* This is only called until mem_init is done. */
-- 
1.6.3.3
