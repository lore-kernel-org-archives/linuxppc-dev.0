Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7A517B7D5B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Feb 2010 06:33:02 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: mpc5121: correct DIU compatible property
Date: Tue, 16 Feb 2010 20:32:57 +0100
Message-Id: <1266348777-30665-1-git-send-email-agust@denx.de>
In-Reply-To: <fa686aa41002161011r29f5323clcbb1d89a9df6614@mail.gmail.com>
References: <fa686aa41002161011r29f5323clcbb1d89a9df6614@mail.gmail.com>
Cc: wd@denx.de, dzu@denx.de, Anatolij Gustschin <agust@denx.de>,
	kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The DIU driver should bind against "fsl,mpc5121-diu"
directly. Add this compatible property to the match
table and fix DTS and platform code accordingly.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/mpc5121ads.dts         |    2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c |    2 +-
 drivers/video/fsl-diu-fb.c                   |    5 +++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index d2b2db7..c9ef6bb 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -255,7 +255,7 @@
 		};
 
 		display@2100 {
-			compatible = "fsl,mpc5121-diu", "fsl,diu";
+			compatible = "fsl,mpc5121-diu";
 			reg = <0x2100 0x100>;
 			interrupts = <64 0x8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/platforms/512x/mpc512x_shared.c
index 1751c0d..3a5ff75 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -250,7 +250,7 @@ void __init mpc512x_init_diu(void)
 	unsigned long mode, pix_fmt, res, bpp;
 	unsigned long dst;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,diu");
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-diu");
 	if (!np) {
 		pr_err("No DIU node\n");
 		return;
diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 29c7f31..5db701b 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1663,6 +1663,11 @@ static int __init fsl_diu_setup(char *options)
 #endif
 
 static struct of_device_id fsl_diu_match[] = {
+#ifdef CONFIG_PPC_MPC512x
+	{
+		.compatible = "fsl,mpc5121-diu",
+	},
+#endif
 	{
 		.compatible = "fsl,diu",
 	},
-- 
1.6.3.3
