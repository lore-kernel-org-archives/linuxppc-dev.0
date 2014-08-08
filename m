Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E312E1A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 09:41:13 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/4] powerpc/fsl-pci: Limit ZONE_DMA32 to 2GiB on 64-bit
 platforms
Date: Fri, 8 Aug 2014 18:40:45 -0500
Message-ID: <1407541245-27617-4-git-send-email-scottwood@freescale.com>
In-Reply-To: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
References: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSL PCI cannot directly address the whole lower 4 GiB due to
conflicts with PCICSRBAR and outbound windows.  By the time
max_direct_dma_addr is set to the precise limit, it will be too late to
alter the zone limits, but we should always have at least 2 GiB mapped
(unless RAM is smaller than that).

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/platforms/85xx/corenet_generic.c | 11 +++++++++++
 arch/powerpc/platforms/85xx/qemu_e500.c       | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index d22dd85..c2adb00 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -20,6 +20,7 @@
 #include <asm/time.h>
 #include <asm/machdep.h>
 #include <asm/pci-bridge.h>
+#include <asm/pgtable.h>
 #include <asm/ppc-pci.h>
 #include <mm/mmu_decl.h>
 #include <asm/prom.h>
@@ -67,6 +68,16 @@ void __init corenet_gen_setup_arch(void)
 
 	swiotlb_detect_4g();
 
+#if defined(CONFIG_FSL_PCI) && defined(CONFIG_ZONE_DMA32)
+	/*
+	 * Inbound windows don't cover the full lower 4 GiB
+	 * due to conflicts with PCICSRBAR and outbound windows,
+	 * so limit the DMA32 zone to 2 GiB, to allow consistent
+	 * allocations to succeed.
+	 */
+	limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT));
+#endif
+
 	pr_info("%s board\n", ppc_md.name);
 
 	mpc85xx_qe_init();
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index 7f26732..8ad2fe6 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/of_fdt.h>
 #include <asm/machdep.h>
+#include <asm/pgtable.h>
 #include <asm/time.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
@@ -44,6 +45,15 @@ static void __init qemu_e500_setup_arch(void)
 
 	fsl_pci_assign_primary();
 	swiotlb_detect_4g();
+#if defined(CONFIG_FSL_PCI) && defined(CONFIG_ZONE_DMA32)
+	/*
+	 * Inbound windows don't cover the full lower 4 GiB
+	 * due to conflicts with PCICSRBAR and outbound windows,
+	 * so limit the DMA32 zone to 2 GiB, to allow consistent
+	 * allocations to succeed.
+	 */
+	limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT));
+#endif
 	mpc85xx_smp_init();
 }
 
-- 
1.9.1
