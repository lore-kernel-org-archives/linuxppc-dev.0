Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsW564B7dzDqfv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:50:34 +1000 (AEST)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Scott Wood <oss@buserror.net>
Date: Sat, 16 Jul 2016 21:50:22 -0500
Message-Id: <1468723822-30457-6-git-send-email-oss@buserror.net>
In-Reply-To: <1468723822-30457-1-git-send-email-oss@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
Subject: [PATCH v11 5/5] powerpc/fsl-pci: Use fsl_guts_get_svr()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Establish an initial user of fsl_guts_get_svr(), so that the code gets
some test coverage until users outside arch/powerpc can get converted.

Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/Kconfig          | 1 +
 arch/powerpc/sysdev/fsl_pci.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fcfe533..765df81 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -777,6 +777,7 @@ config FSL_PCI
  	bool
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
+	select FSL_GUTS
 
 config FSL_PMC
 	bool
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 0fd1895..9ba570cf 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/fsl/edac.h>
+#include <linux/fsl/guts.h>
 #include <linux/fsl/svr.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -529,7 +530,10 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	struct device_node *dev;
 	struct ccsr_pci __iomem *pci;
 	u16 temp;
-	u32 svr = mfspr(SPRN_SVR);
+	u32 svr;
+
+	fsl_guts_init();
+	svr = fsl_guts_get_svr();
 
 	dev = pdev->dev.of_node;
 
-- 
2.7.4
