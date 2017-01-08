Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3txZM915CjzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2017 10:32:20 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/9] powerpc: Move {d, i,
 u}cache_bsize definitions to a common place
Date: Sun,  8 Jan 2017 17:31:43 -0600
Message-Id: <20170108233150.15353-2-benh@kernel.crashing.org>
In-Reply-To: <20170108233150.15353-1-benh@kernel.crashing.org>
References: <20170108233150.15353-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The variables are defined twice in setup_32.c and setup_64.c, do it
once in setup-common.c instead

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 9 +++++++++
 arch/powerpc/kernel/setup_32.c     | 8 --------
 arch/powerpc/kernel/setup_64.c     | 8 --------
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index dba265c..e0eeed4 100644
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
index 24ec3ea..3b81742 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -53,14 +53,6 @@ unsigned int DMA_MODE_READ;
 unsigned int DMA_MODE_WRITE;
 
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
index 7ac8e6e..6263e0d 100644
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
2.9.3
