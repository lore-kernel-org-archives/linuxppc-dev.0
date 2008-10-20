Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A718BDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 00:17:01 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix build issue with CONFIG_RELOCATABLE=y
Date: Mon, 20 Oct 2008 08:16:55 -0500
Message-Id: <1224508615-727-1-git-send-email-galak@kernel.crashing.org>
Cc: pbadari@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are two issues when we enable CONFIG_RELOCATABLE.  The first is due
to the fact that phys_addr_t is now defined in linux/types.h.  The second
is due to the fact that the DMA code changes expose memstart_addr to
prom_init.c

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/page.h        |    5 ++++-
 arch/powerpc/kernel/prom_init_check.sh |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 64e1445..120f4d4 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -12,7 +12,9 @@
 
 #include <asm/asm-compat.h>
 #include <asm/kdump.h>
-#include <asm/types.h>
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+#endif
 
 /*
  * On PPC32 page size is 4K. For PPC64 we support either 4K or 64K software
@@ -73,6 +75,7 @@
 
 #if defined(CONFIG_RELOCATABLE)
 #ifndef __ASSEMBLY__
+
 extern phys_addr_t memstart_addr;
 extern phys_addr_t kernstart_addr;
 #endif
diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
index 2c7e8e8..ea3a2ec 100644
--- a/arch/powerpc/kernel/prom_init_check.sh
+++ b/arch/powerpc/kernel/prom_init_check.sh
@@ -20,7 +20,7 @@ WHITELIST="add_reloc_offset __bss_start __bss_stop copy_and_flush
 _end enter_prom memcpy memset reloc_offset __secondary_hold
 __secondary_hold_acknowledge __secondary_hold_spinloop __start
 strcmp strcpy strlcpy strlen strncmp strstr logo_linux_clut224
-reloc_got2 kernstart_addr"
+reloc_got2 kernstart_addr memstart_addr"
 
 NM="$1"
 OBJ="$2"
-- 
1.5.5.1
