Return-Path: <baruch@tkos.co.il>
Received: from tango.tkos.co.il (tango.tkos.co.il [62.219.50.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DCA03B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 17:16:47 +1000 (EST)
From: Baruch Siach <baruch@tkos.co.il>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix build when CONFIG_BOOKE_WDT is enabled
Date: Thu, 19 Apr 2012 09:32:06 +0300
Message-Id: <4c2709df9123c32681503972be3707026c9dab74.1334816894.git.baruch@tkos.co.il>
Cc: David Howells <dhowells@redhat.com>, Baruch Siach <baruch@tkos.co.il>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit ae3a197e (Disintegrate asm/system.h for PowerPC) broke build of
assembly files when CONFIG_BOOKE_WDT is enabled as follows:

  AS      arch/powerpc/lib/string.o
/home/baruch/git/stable/arch/powerpc/include/asm/reg_booke.h: Assembler messages:
/home/baruch/git/stable/arch/powerpc/include/asm/reg_booke.h:19: Error: Unrecognized opcode: `extern'
/home/baruch/git/stable/arch/powerpc/include/asm/reg_booke.h:20: Error: Unrecognized opcode: `extern'

Since setup_32.c is the only user of the booke_wdt configuration variables, move
the declarations there.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/powerpc/include/asm/reg_booke.h |    5 -----
 arch/powerpc/kernel/setup_32.c       |    5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index b86faa9..8a97aa7 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -15,11 +15,6 @@
 #ifndef __ASM_POWERPC_REG_BOOKE_H__
 #define __ASM_POWERPC_REG_BOOKE_H__
 
-#ifdef CONFIG_BOOKE_WDT
-extern u32 booke_wdt_enabled;
-extern u32 booke_wdt_period;
-#endif /* CONFIG_BOOKE_WDT */
-
 /* Machine State Register (MSR) Fields */
 #define MSR_GS		(1<<28) /* Guest state */
 #define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 9825f29..a9b8be5 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -61,6 +61,11 @@ unsigned long vgacon_remap_base;
 EXPORT_SYMBOL(vgacon_remap_base);
 #endif
 
+#ifdef CONFIG_BOOKE_WDT
+extern u32 booke_wdt_enabled;
+extern u32 booke_wdt_period;
+#endif /* CONFIG_BOOKE_WDT */
+
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
  * for each elf executable being started.
-- 
1.7.9.5
