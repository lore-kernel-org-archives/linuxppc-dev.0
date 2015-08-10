Return-Path: <B48286@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0121.outbound.protection.outlook.com [65.55.169.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD6451A0BEF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:59:24 +1000 (AEST)
From: Zhiqiang Hou <B48286@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>,
 <scottwood@freescale.com>
CC: <Mingkai.Hu@freescale.com>, <Dongsheng.Wang@freescale.com>, Hou Zhiqiang
 <B48286@freescale.com>
Subject: [PATCH V2] powerpc/85xx: Remove unused pci fixup hooks on c293pcie
Date: Mon, 10 Aug 2015 17:39:45 +0800
Message-ID: <1439199585-37464-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hou Zhiqiang <B48286@freescale.com>

The c293pcie board is an endpoint device and it doesn't need PM,
so remove hooks pcibios_fixup_phb and pcibios_fixup_bus.

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
Test on c293pcie board:
V2:
    Rename the title of this patch.
    Remove pcibios_fixup_bus that isn't used in EP.

 arch/powerpc/platforms/85xx/c293pcie.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
index 84476b6..61bc851 100644
--- a/arch/powerpc/platforms/85xx/c293pcie.c
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -66,10 +66,6 @@ define_machine(c293_pcie) {
 	.probe			= c293_pcie_probe,
 	.setup_arch		= c293_pcie_setup_arch,
 	.init_IRQ		= c293_pcie_pic_init,
-#ifdef CONFIG_PCI
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
-#endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
 	.calibrate_decr		= generic_calibrate_decr,
-- 
2.1.0.27.g96db324
