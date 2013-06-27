Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B6982C02A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 12:01:24 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/fsl_booke: enable the relocatable for the kdump
 kernel
Date: Thu, 27 Jun 2013 10:00:34 +0800
Message-ID: <1372298434-20220-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1372298434-20220-1-git-send-email-haokexin@gmail.com>
References: <1372298434-20220-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For a relocatable kdump kernel, we may create a tlb map which is
beyond the real memory allocated to the kdump kernel. For example,
when the boot kernel reserve 32M memory for the kdump kernel by
using 'crashkernel=32M@64M', we will have to create a 256M tlb
entry in the kdump kernel. So define PPC_PIN_SIZE for fsl ppc32 bit,
this will make sure that we still get the right VMALLOC_START in
this case.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/Kconfig                  |  3 +--
 arch/powerpc/include/asm/mmu-book3e.h |  5 +++++
 arch/powerpc/mm/fsl_booke_mmu.c       | 30 +++++++++++++++++++++++++++---
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9eb97ac..ca237f5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -382,8 +382,7 @@ config KEXEC
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
-	select RELOCATABLE if PPC64 || 44x
-	select DYNAMIC_MEMSTART if FSL_BOOKE
+	select RELOCATABLE if PPC64 || 44x || FSL_BOOKE
 	help
 	  Build a kernel suitable for use as a kdump capture kernel.
 	  The same kernel binary can be used as production kernel and dump
diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
index 936db36..bf422db 100644
--- a/arch/powerpc/include/asm/mmu-book3e.h
+++ b/arch/powerpc/include/asm/mmu-book3e.h
@@ -214,6 +214,11 @@
 #define TLBILX_T_CLASS2			6
 #define TLBILX_T_CLASS3			7
 
+#ifdef CONFIG_PPC32
+/* The max size that one tlb can map in a 32bit kernel. */
+#define PPC_PIN_SIZE	(1 << 28)	/* 256M */
+#endif
+
 #ifndef __ASSEMBLY__
 #include <asm/bug.h>
 
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 07ba45b..59549b3 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -52,6 +52,7 @@
 #include <asm/smp.h>
 #include <asm/machdep.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #include "mmu_decl.h"
 
@@ -177,11 +178,34 @@ unsigned long map_mem_in_cams(unsigned long ram, int max_cam_idx)
 	unsigned long virt = PAGE_OFFSET;
 	phys_addr_t phys = memstart_addr;
 	unsigned long amount_mapped = 0;
-
+	unsigned long cam_sz;
+
+#if defined(CONFIG_RELOCATABLE) && defined(CONFIG_PPC32)
+	/*
+	 * For a relocatable kernel, we would not map from memstart_addr.
+	 * We first align to PPC_PIN_SIZE (256M), then map the PAGE_OFFSET
+	 * from there.
+	 */
+	phys &= ~(PPC_PIN_SIZE - 1);
+	ram += memstart_addr & (PPC_PIN_SIZE - 1);
+
+	/*
+	 * For a kdump kernel, we may use a memory area reserved by the boot
+	 * kernel by using a kernel option like this 'crashkernel=32M@64M'.
+	 * In this case, the ram is 96M. The kernel will try to map the first
+	 * 64M in the first tlb entry. The kernel will definitely get stuck,
+	 * since the kernel is running above the 64M. So we have to make sure
+	 * that the first tlb cover the current kernel running address at least.
+	 */
+	while (1) {
+		cam_sz = calc_cam_sz(ram, virt, phys);
+		if (cam_sz + phys > PHYSICAL_START + _end - _stext)
+			break;
+		ram = 1 << (ilog2(ram) + 1);
+	}
+#endif
 	/* Calculate CAM values */
 	for (i = 0; ram && i < max_cam_idx; i++) {
-		unsigned long cam_sz;
-
 		cam_sz = calc_cam_sz(ram, virt, phys);
 		settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, 0);
 
-- 
1.8.1.4
