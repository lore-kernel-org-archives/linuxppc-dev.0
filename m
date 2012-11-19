Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id E83F32C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:32:59 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 035/493] powerpc: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:19:44 -0500
Message-Id: <1353349642-3677-35-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Anatolij Gustschin <agust@denx.de> 
Cc: Kumar Gala <galak@kernel.crashing.org> 
Cc: linuxppc-dev@lists.ozlabs.org 
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c  | 2 +-
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 2 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 2351f9e..459fa49 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -576,7 +576,7 @@ static struct platform_driver mpc52xx_lpbfifo_driver = {
 		.of_match_table = mpc52xx_lpbfifo_match,
 	},
 	.probe = mpc52xx_lpbfifo_probe,
-	.remove = __devexit_p(mpc52xx_lpbfifo_remove),
+	.remove = mpc52xx_lpbfifo_remove,
 };
 
 /***********************************************************************
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index ef6537b..fe27e4a 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -228,7 +228,7 @@ static struct i2c_driver mcu_driver = {
 		.of_match_table = mcu_of_match_table,
 	},
 	.probe = mcu_probe,
-	.remove	= __devexit_p(mcu_remove),
+	.remove	= mcu_remove,
 	.id_table = mcu_ids,
 };
 
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index d131c8a..103c94a 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -213,7 +213,7 @@ static struct platform_driver mpc85xx_l2ctlr_of_platform_driver = {
 		.of_match_table	= mpc85xx_l2ctlr_of_match,
 	},
 	.probe		= mpc85xx_l2ctlr_of_probe,
-	.remove		= __devexit_p(mpc85xx_l2ctlr_of_remove),
+	.remove		= mpc85xx_l2ctlr_of_remove,
 };
 
 static __init int mpc85xx_l2ctlr_of_init(void)
-- 
1.8.0
