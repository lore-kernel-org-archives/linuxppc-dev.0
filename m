Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id EC0772C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:37:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 382/493] powerpc: remove use of __devinitconst
Date: Mon, 19 Nov 2012 13:25:31 -0500
Message-Id: <1353349642-3677-382-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinitconst is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Anatolij Gustschin <agust@denx.de> 
Cc: Kumar Gala <galak@kernel.crashing.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 arch/powerpc/kernel/io-workarounds.c          | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | 2 +-
 arch/powerpc/platforms/85xx/corenet_ds.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/io-workarounds.c b/arch/powerpc/kernel/io-workarounds.c
index 34b909c..b6a37a9 100644
--- a/arch/powerpc/kernel/io-workarounds.c
+++ b/arch/powerpc/kernel/io-workarounds.c
@@ -118,7 +118,7 @@ static void iowa_##name at					\
 #undef DEF_PCI_AC_RET
 #undef DEF_PCI_AC_NORET
 
-static const struct ppc_pci_io __devinitconst iowa_pci_io = {
+static const struct ppc_pci_io iowa_pci_io = {
 
 #define DEF_PCI_AC_RET(name, ret, at, al, space, aa)	.name = iowa_##name,
 #define DEF_PCI_AC_NORET(name, at, al, space, aa)	.name = iowa_##name,
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index b89e02f..a055991 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -564,7 +564,7 @@ static int __devexit mpc52xx_lpbfifo_remove(struct platform_device *op)
 	return 0;
 }
 
-static struct of_device_id mpc52xx_lpbfifo_match[] __devinitconst = {
+static struct of_device_id mpc52xx_lpbfifo_match[] = {
 	{ .compatible = "fsl,mpc5200-lpbfifo", },
 	{},
 };
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index ed69c92..6f355d8 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -64,7 +64,7 @@ void __init corenet_ds_setup_arch(void)
 	pr_info("%s board from Freescale Semiconductor\n", ppc_md.name);
 }
 
-static const struct of_device_id of_device_ids[] __devinitconst = {
+static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "simple-bus"
 	},
-- 
1.8.0
