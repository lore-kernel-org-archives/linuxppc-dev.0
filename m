Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 236AFB738D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:09:18 +1100 (EST)
Received: from mail80-tx2 (localhost [127.0.0.1])	by mail80-tx2-R.bigfish.com
 (Postfix) with ESMTP id 5B9EC2E013B	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:09:14 +0000 (UTC)
Received: from TX2EHSMHS022.bigfish.com (unknown [10.9.14.239])	by
 mail80-tx2.bigfish.com (Postfix) with ESMTP id 093DDE0097	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:09:12 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] powerpc/mpc8548: Add workaround for erratum NMG_SRIO135
Date: Tue, 6 Mar 2012 17:10:56 +0800
Message-ID: <1331025056-15983-4-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: chenhui zhao <chenhui.zhao@freescale.com>

Issue:
Applications using lwarx/stwcx instructions in the core to
compete for a software lock or semaphore with a device on
RapidIO using read atomic set, clr, inc, or dec in a similar
manner may falsely result in both masters seeing the lock
as "available". This could result in data corruption as
both masters try to modify the same piece of data protected
by the lock.

Workaround:
Set bits 13 and 29 of CCSR offset 0x01010 (EEBPCR register
of the ECM) during initialization and leave them set
indefinitely. This may slightly degrade overall system
performance.

Refer to SRIO39 in MPC8548 errata document.

Signed-off-by: Gong Chen <g.chen@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/fsl_rio.c |   44 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index a4c4f4a..78a0c3d 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -35,6 +35,8 @@
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <asm/machdep.h>
+#include <asm/mpc85xx.h>
+#include <sysdev/fsl_soc.h>
 
 #include "fsl_rio.h"
 
@@ -321,6 +323,37 @@ static inline void fsl_rio_info(struct device *dev, u32 ccsr)
 	}
 }
 
+#define CCSR_ECM_EEBPCR_OFF 0x10
+/*
+ * fixup_erratum_srio135 - Fix Serial RapidIO atomic operation erratum
+ */
+static int fixup_erratum_srio135(struct device *dev)
+{
+	struct device_node *np;
+	void __iomem *ecm;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc8548-ecm");
+	if (!np) {
+		dev_err(dev, "no ECM node found.\n");
+		return -ENODEV;
+	}
+
+	ecm = of_iomap(np, 0);
+	of_node_put(np);
+	if (!ecm) {
+		dev_err(dev, "failed to map ECM register base.\n");
+		return -ENODEV;
+	}
+	/*
+	 * Set bits 13 and 29 of the EEBPCR register in the ECM
+	 * during initialization and leave them set indefinitely.
+	 */
+	setbits32(ecm + CCSR_ECM_EEBPCR_OFF, 0x00040004);
+	iounmap(ecm);
+
+	return 0;
+}
+
 /**
  * fsl_rio_setup - Setup Freescale PowerPC RapidIO interface
  * @dev: platform_device pointer
@@ -358,6 +391,17 @@ int fsl_rio_setup(struct platform_device *dev)
 				dev->dev.of_node->full_name);
 		return -EFAULT;
 	}
+
+	/* Fix erratum NMG_SRIO135 */
+	if (fsl_svr_is(SVR_8548) || fsl_svr_is(SVR_8548_E)) {
+		rc = fixup_erratum_srio135(&dev->dev);
+		if (rc) {
+			dev_err(&dev->dev,
+				"Failed to fix the erratum NMG_SRIO135.");
+			return rc;
+		}
+	}
+
 	dev_info(&dev->dev, "Of-device full name %s\n",
 			dev->dev.of_node->full_name);
 	dev_info(&dev->dev, "Regs: %pR\n", &regs);
-- 
1.6.4.1
