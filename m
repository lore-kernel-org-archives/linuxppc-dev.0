Return-Path: <kernelfans@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421rd01sqnzF38S
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 17:31:00 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id j26-v6so5108104pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 00:31:00 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH 2/2] powerpc/kexec: avoid hard coding when automatically
 allocating mem for crashkernel
Date: Fri, 31 Aug 2018 15:30:23 +0800
Message-Id: <1535700623-23750-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1535700623-23750-1-git-send-email-kernelfans@gmail.com>
References: <1535700623-23750-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If no start address is specified for crashkernel, the current program hard
code as: crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
This limits the candidate memory region, and may cause failure while there
is enough mem for crashkernel. This patch suggests to find a suitable mem
chunk by memblock_find_in_range()

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/machine_kexec.c | 24 +++++++++++++++---------
 arch/powerpc/kernel/prom.c          |  7 +++++--
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 63f5a93..78005bf 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -22,6 +22,9 @@
 #include <asm/pgalloc.h>
 #include <asm/prom.h>
 #include <asm/sections.h>
+#include <asm/mmu.h>
+
+#include "setup.h"
 
 void machine_kexec_mask_interrupts(void) {
 	unsigned int i;
@@ -117,6 +120,7 @@ void machine_kexec(struct kimage *image)
 void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base;
+	phys_addr_t start, up_boundary;
 	int ret;
 
 	/* use common parsing */
@@ -146,22 +150,24 @@ void __init reserve_crashkernel(void)
 #else
 	if (!crashk_res.start) {
 #ifdef CONFIG_PPC64
-		/*
-		 * On 64bit we split the RMO in half but cap it at half of
-		 * a small SLB (128MB) since the crash kernel needs to place
-		 * itself and some stacks to be in the first segment.
-		 */
-		crashk_res.start = min(0x8000000ULL, (ppc64_rma_size / 2));
+		up_boundary = min(ppc64_bolted_size(), ppc64_rma_size);
+		start = memblock_find_in_range(KDUMP_KERNELBASE, up_boundary,
+				crash_size, PAGE_SIZE);
+		if (start == 0) {
+			pr_err("Failed to reserve memory for crashkernel!\n");
+			crashk_res.start = crashk_res.end = 0;
+			return;
+		} else
+			crashk_res.start = start;
 #else
 		crashk_res.start = KDUMP_KERNELBASE;
 #endif
 	}
 
-	crash_base = PAGE_ALIGN(crashk_res.start);
-	if (crash_base != crashk_res.start) {
+	if (crashk_res.start != PAGE_ALIGN(crashk_res.start)) {
 		printk("Crash kernel base must be aligned to 0x%lx\n",
 				PAGE_SIZE);
-		crashk_res.start = crash_base;
+		crashk_res.start = PAGE_ALIGN(crashk_res.start);
 	}
 
 #endif
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index cae4a78..8b2ab99 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -688,6 +688,7 @@ static void tm_init(void) { }
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
+	bool fadump_enabled = false;
 
 	DBG(" -> early_init_devtree(%p)\n", params);
 
@@ -737,9 +738,9 @@ void __init early_init_devtree(void *params)
 	 * If we fail to reserve memory for firmware-assisted dump then
 	 * fallback to kexec based kdump.
 	 */
-	if (fadump_reserve_mem() == 0)
+	if (fadump_reserve_mem() == 1)
+		fadump_enabled = true;
 #endif
-		reserve_crashkernel();
 	early_reserve_mem();
 
 	/* Ensure that total memory size is page-aligned. */
@@ -761,6 +762,8 @@ void __init early_init_devtree(void *params)
 
 	dt_cpu_ftrs_scan();
 	mmu_early_init_devtree();
+	if (!fadump_enabled)
+		reserve_crashkernel();
 
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
-- 
2.7.4
