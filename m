Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDdRj6FvxzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:42:57 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sDdRj1cmzz9sRB
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2016 15:42:56 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 02/10] powerpc: Move {d, i,
 u}cache_bsize definitions to a common place
Date: Wed, 17 Aug 2016 15:39:09 +1000
Message-Id: <1471412357-3477-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
References: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
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
2.7.4
