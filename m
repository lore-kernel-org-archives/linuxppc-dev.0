Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDZF3v0PzDqBm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:06:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/9] powerpc: Move {d, i,
 u}cache_bsize definitions to a common place
Date: Fri,  3 Feb 2017 22:05:52 +1100
Message-Id: <1486119959-21662-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
References: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

The variables are defined twice in setup_32.c and setup_64.c, do it
once in setup-common.c instead

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 9 +++++++++
 arch/powerpc/kernel/setup_32.c     | 8 --------
 arch/powerpc/kernel/setup_64.c     | 8 --------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f516ac508ae3..4697da895133 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -87,6 +87,15 @@ EXPORT_SYMBOL(machine_id);
 int boot_cpuid = -1;
 EXPORT_SYMBOL_GPL(boot_cpuid);
 
+/*
+ * These are used in binfmt_elf.c to put aux entries on the stack
+ * for each elf executable being started.
+ */
+int dcache_bsize;
+int icache_bsize;
+int ucache_bsize;
+
+
 unsigned long klimit = (unsigned long) _end;
 
 /*
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 7fcf1f7f01c1..2f88f6cf1a42 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -59,14 +59,6 @@ EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
 
 /*
- * These are used in binfmt_elf.c to put aux entries on the stack
- * for each elf executable being started.
- */
-int dcache_bsize;
-int icache_bsize;
-int ucache_bsize;
-
-/*
  * We're called here very early in the boot.
  *
  * Note that the kernel may be running at an address which is different
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 6824157e4d2e..ed3362bc9a2a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -88,14 +88,6 @@ struct ppc64_caches ppc64_caches = {
 };
 EXPORT_SYMBOL_GPL(ppc64_caches);
 
-/*
- * These are used in binfmt_elf.c to put aux entries on the stack
- * for each elf executable being started.
- */
-int dcache_bsize;
-int icache_bsize;
-int ucache_bsize;
-
 #if defined(CONFIG_PPC_BOOK3E) && defined(CONFIG_SMP)
 void __init setup_tlb_core_data(void)
 {
-- 
2.7.4
