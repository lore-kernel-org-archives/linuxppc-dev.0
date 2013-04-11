Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 991172C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 11:32:44 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/85xx: enable coreint for all the 64bit boards
Date: Thu, 11 Apr 2013 09:32:34 +0800
Message-ID: <1365643954-20798-3-git-send-email-haokexin@gmail.com>
In-Reply-To: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
References: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the patch 7230c564 (powerpc: Rework lazy-interrupt handling),
it seems that the coreint works pretty well on the 85xx 64bit kernel.
So use the coreint by default for these boards.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/platforms/85xx/p5020_ds.c  | 5 -----
 arch/powerpc/platforms/85xx/p5040_ds.c  | 5 -----
 arch/powerpc/platforms/85xx/t4240_qds.c | 5 -----
 3 files changed, 15 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p5020_ds.c b/arch/powerpc/platforms/85xx/p5020_ds.c
index 753a42c..39cfa40 100644
--- a/arch/powerpc/platforms/85xx/p5020_ds.c
+++ b/arch/powerpc/platforms/85xx/p5020_ds.c
@@ -75,12 +75,7 @@ define_machine(p5020_ds) {
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
-/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
-#ifdef CONFIG_PPC64
-	.get_irq		= mpic_get_irq,
-#else
 	.get_irq		= mpic_get_coreint_irq,
-#endif
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/85xx/p5040_ds.c b/arch/powerpc/platforms/85xx/p5040_ds.c
index 1138185..f70e74c 100644
--- a/arch/powerpc/platforms/85xx/p5040_ds.c
+++ b/arch/powerpc/platforms/85xx/p5040_ds.c
@@ -66,12 +66,7 @@ define_machine(p5040_ds) {
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
-/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
-#ifdef CONFIG_PPC64
-	.get_irq		= mpic_get_irq,
-#else
 	.get_irq		= mpic_get_coreint_irq,
-#endif
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
diff --git a/arch/powerpc/platforms/85xx/t4240_qds.c b/arch/powerpc/platforms/85xx/t4240_qds.c
index 5998e9f..91ead6b 100644
--- a/arch/powerpc/platforms/85xx/t4240_qds.c
+++ b/arch/powerpc/platforms/85xx/t4240_qds.c
@@ -75,12 +75,7 @@ define_machine(t4240_qds) {
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #endif
-/* coreint doesn't play nice with lazy EE, use legacy mpic for now */
-#ifdef CONFIG_PPC64
-	.get_irq		= mpic_get_irq,
-#else
 	.get_irq		= mpic_get_coreint_irq,
-#endif
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-- 
1.8.1.4
