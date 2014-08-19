Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72B831A054C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 08:00:13 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Subject: [PATCH 5/6] powerpc: Move lib symbol exports into
 arch/powerpc/lib/ppc_ksyms.c
Date: Wed, 20 Aug 2014 08:00:04 +1000
Message-Id: <1408485605-10490-5-git-send-email-anton@samba.org>
In-Reply-To: <1408485605-10490-1-git-send-email-anton@samba.org>
References: <1408485605-10490-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the lib symbol exports closer to their function definitions

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/ppc_ksyms.c | 32 --------------------------------
 arch/powerpc/lib/Makefile       |  2 +-
 arch/powerpc/lib/ppc_ksyms.c    | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 33 deletions(-)
 create mode 100644 arch/powerpc/lib/ppc_ksyms.c

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index ab4f0bc..aba41f3 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -55,24 +55,6 @@ EXPORT_SYMBOL(DMA_MODE_WRITE);
 EXPORT_SYMBOL(_mcount);
 #endif
 
-EXPORT_SYMBOL(strcpy);
-EXPORT_SYMBOL(strncpy);
-EXPORT_SYMBOL(strcat);
-EXPORT_SYMBOL(strlen);
-EXPORT_SYMBOL(strcmp);
-EXPORT_SYMBOL(strncmp);
-
-#ifndef CONFIG_GENERIC_CSUM
-EXPORT_SYMBOL(csum_partial);
-EXPORT_SYMBOL(csum_partial_copy_generic);
-EXPORT_SYMBOL(ip_fast_csum);
-EXPORT_SYMBOL(csum_tcpudp_magic);
-#endif
-
-EXPORT_SYMBOL(__copy_tofrom_user);
-EXPORT_SYMBOL(__clear_user);
-EXPORT_SYMBOL(copy_page);
-
 #if defined(CONFIG_PCI) && defined(CONFIG_PPC32)
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
@@ -122,17 +104,10 @@ EXPORT_SYMBOL(__cmpdi2);
 #endif
 long long __bswapdi2(long long);
 EXPORT_SYMBOL(__bswapdi2);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memmove);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memchr);
 
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
-EXPORT_SYMBOL(cacheable_memcpy);
-EXPORT_SYMBOL(cacheable_memzero);
 #endif
 
 #ifdef CONFIG_PPC32
@@ -156,13 +131,6 @@ EXPORT_SYMBOL(__mfdcr);
 #endif
 EXPORT_SYMBOL(empty_zero_page);
 
-#ifdef CONFIG_PPC64
-EXPORT_SYMBOL(__arch_hweight8);
-EXPORT_SYMBOL(__arch_hweight16);
-EXPORT_SYMBOL(__arch_hweight32);
-EXPORT_SYMBOL(__arch_hweight64);
-#endif
-
 #ifdef CONFIG_EPAPR_PARAVIRT
 EXPORT_SYMBOL(epapr_hypercall_start);
 #endif
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 59fa2de..9f342f1 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -10,7 +10,7 @@ CFLAGS_REMOVE_code-patching.o = -pg
 CFLAGS_REMOVE_feature-fixups.o = -pg
 
 obj-y			:= string.o alloc.o \
-			   crtsavres.o
+			   crtsavres.o ppc_ksyms.o
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
diff --git a/arch/powerpc/lib/ppc_ksyms.c b/arch/powerpc/lib/ppc_ksyms.c
new file mode 100644
index 0000000..f993959
--- /dev/null
+++ b/arch/powerpc/lib/ppc_ksyms.c
@@ -0,0 +1,39 @@
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/bitops.h>
+#include <net/checksum.h>
+
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(memchr);
+#ifdef CONFIG_PPC32
+EXPORT_SYMBOL(cacheable_memcpy);
+EXPORT_SYMBOL(cacheable_memzero);
+#endif
+
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strncpy);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
+
+#ifndef CONFIG_GENERIC_CSUM
+EXPORT_SYMBOL(csum_partial);
+EXPORT_SYMBOL(csum_partial_copy_generic);
+EXPORT_SYMBOL(ip_fast_csum);
+EXPORT_SYMBOL(csum_tcpudp_magic);
+#endif
+
+EXPORT_SYMBOL(__copy_tofrom_user);
+EXPORT_SYMBOL(__clear_user);
+EXPORT_SYMBOL(copy_page);
+
+#ifdef CONFIG_PPC64
+EXPORT_SYMBOL(__arch_hweight8);
+EXPORT_SYMBOL(__arch_hweight16);
+EXPORT_SYMBOL(__arch_hweight32);
+EXPORT_SYMBOL(__arch_hweight64);
+#endif
-- 
1.9.1
