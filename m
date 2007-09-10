Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 774E4DDEC2
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 07:32:31 +1000 (EST)
Date: Mon, 10 Sep 2007 16:32:17 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.23'
Message-ID: <Pine.LNX.4.64.0709101631550.30743@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.23' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.23

to receive the following updates:

 arch/powerpc/platforms/85xx/mpc8544_ds.c   |    2 ++
 arch/powerpc/platforms/85xx/mpc85xx_cds.c  |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 ++
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 ++
 arch/powerpc/platforms/Kconfig             |    1 +
 arch/powerpc/sysdev/cpm2_common.c          |    2 +-
 arch/ppc/kernel/head_8xx.S                 |    2 --
 7 files changed, 9 insertions(+), 4 deletions(-)

Jochen Friedrich (1):
      [PPC] 8xx: Fix r3 trashing due to 8MB TLB page instantiation

Kumar Gala (2):
      [POWERPC] 8{5,6}xx: Fix build issue with !CONFIG_PCI
      [POWERPC] Enable GENERIC_ISA_DMA if FSL_ULI1575

Scott Wood (1):
      [POWERPC] cpm2: Fix off-by-one error in setbrg().

commit 8fb427e656e2379f295d18134ef1f2cc924e994c
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Sep 10 14:57:34 2007 -0500

    [POWERPC] Enable GENERIC_ISA_DMA if FSL_ULI1575

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 83fcdb4b352f74a8a74737aedeaf622c37140c73
Author: Scott Wood <scottwood@freescale.com>
Date:   Wed Sep 5 14:29:10 2007 -0500

    [POWERPC] cpm2: Fix off-by-one error in setbrg().

    The hardware adds one to the BRG value to get the divider, so it must
    be subtracted by software.  Without this patch, characters will occasionally
    be corrupted.

    Signed-off-by: Scott Wood <scottwood@freescale.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 36c50f729b77144cae8d43457fefca66a4eeff6a
Author: Jochen Friedrich <jochen@scram.de>
Date:   Tue Aug 28 13:20:48 2007 +0200

    [PPC] 8xx: Fix r3 trashing due to 8MB TLB page instantiation

    Instantiation of 8MB pages on the TLB cache for the kernel static
    mapping trashes r3 register on !CONFIG_8xx_CPU6 configurations.
    This ensures r3 gets saved and restored.

    This has been posted to linuxppc-embedded by Marcelo Tosatti
    <marcelo@kvack.org>, but only an incomplete version of the patch
    has been applied in c51e078f82096a7d35ac8ec2416272e843a0e1c4.
    This patch adds the rest of the fix.

    Signed-off-by: Jochen Friedrich <jochen@scram.de>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 2af8569dc9f29c303bf4aa012d991afcfaeed0c3
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Mon Sep 10 14:30:33 2007 -0500

    [POWERPC] 8{5,6}xx: Fix build issue with !CONFIG_PCI

    We needed some ifdef CONFIG_PCI protection for pcibios_fixup so we
    can build !CONFIG_PCI.

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/arch/powerpc/platforms/85xx/mpc8544_ds.c b/arch/powerpc/platforms/85xx/mpc8544_ds.c
index 0f834d8..48983bc 100644
--- a/arch/powerpc/platforms/85xx/mpc8544_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8544_ds.c
@@ -178,7 +178,9 @@ define_machine(mpc8544_ds) {
 	.probe			= mpc8544_ds_probe,
 	.setup_arch		= mpc8544_ds_setup_arch,
 	.init_IRQ		= mpc8544_ds_pic_init,
+#ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
 	.get_irq		= mpic_get_irq,
 	.restart		= mpc85xx_restart,
 	.calibrate_decr		= generic_calibrate_decr,
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6a171e9..2d4cb78 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -351,10 +351,10 @@ define_machine(mpc85xx_cds) {
 	.get_irq	= mpic_get_irq,
 #ifdef CONFIG_PCI
 	.restart	= mpc85xx_cds_restart,
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #else
 	.restart	= mpc85xx_restart,
 #endif
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 };
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index be25ecd..7ca7e67 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -207,5 +207,7 @@ define_machine(mpc85xx_mds) {
 	.restart	= mpc85xx_restart,
 	.calibrate_decr	= generic_calibrate_decr,
 	.progress	= udbg_progress,
+#ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
 };
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 56b27ca..47aafa7 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -250,5 +250,7 @@ define_machine(mpc86xx_hpcn) {
 	.time_init		= mpc86xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
+#ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
 };
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index cfc2497..19d4628 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -285,6 +285,7 @@ config AXON_RAM
 config FSL_ULI1575
 	bool
 	default n
+	select GENERIC_ISA_DMA
 	help
 	  Supports for the ULI1575 PCIe south bridge that exists on some
 	  Freescale reference boards. The boards all use the ULI in pretty
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 9244129..c827715 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -102,7 +102,7 @@ cpm_setbrg(uint brg, uint rate)
 		brg -= 4;
 	}
 	bp += brg;
-	*bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
+	out_be32(bp, (((BRG_UART_CLK / rate) - 1) << 1) | CPM_BRG_EN);

 	cpm2_unmap(bp);
 }
diff --git a/arch/ppc/kernel/head_8xx.S b/arch/ppc/kernel/head_8xx.S
index 944c35c..eb8d26f 100644
--- a/arch/ppc/kernel/head_8xx.S
+++ b/arch/ppc/kernel/head_8xx.S
@@ -495,9 +495,7 @@ LoadLargeDTLB:
 	lwz	r11, 4(r0)

 	lwz	r12, 16(r0)
-#ifdef CONFIG_8xx_CPU6
 	lwz	r3, 8(r0)
-#endif
 	rfi

 /* This is the data TLB error on the MPC8xx.  This could be due to
