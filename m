Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id 094082C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 486/493] powerpc: remove use of __devexit
Date: Mon, 19 Nov 2012 13:27:15 -0500
Message-Id: <1353349642-3677-486-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
index a055991..1441b35 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -540,7 +540,7 @@ static int mpc52xx_lpbfifo_probe(struct platform_device *op)
 }
 
 
-static int __devexit mpc52xx_lpbfifo_remove(struct platform_device *op)
+static int mpc52xx_lpbfifo_remove(struct platform_device *op)
 {
 	if (lpbfifo.dev != &op->dev)
 		return 0;
diff --git a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
index e4be690..5f33cc6 100644
--- a/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
+++ b/arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c
@@ -188,7 +188,7 @@ err:
 	return ret;
 }
 
-static int __devexit mcu_remove(struct i2c_client *client)
+static int mcu_remove(struct i2c_client *client)
 {
 	struct mcu *mcu = i2c_get_clientdata(client);
 	int ret;
diff --git a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
index d06bfa1..8cf93f0 100644
--- a/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
+++ b/arch/powerpc/sysdev/fsl_85xx_l2ctlr.c
@@ -160,7 +160,7 @@ static int mpc85xx_l2ctlr_of_probe(struct platform_device *dev)
 	return 0;
 }
 
-static int __devexit mpc85xx_l2ctlr_of_remove(struct platform_device *dev)
+static int mpc85xx_l2ctlr_of_remove(struct platform_device *dev)
 {
 	BUG_ON(!l2ctlr);
 
-- 
1.8.0
