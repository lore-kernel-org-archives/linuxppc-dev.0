Return-Path: <qiang.zhao@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0100.outbound.protection.outlook.com [65.55.169.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZ1FY3SDTzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 17:33:52 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <tglx@linutronix.de>
CC: <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <oss@buserror.net>,
 <xiaobo.xie@nxp.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH] fsl/qe_ic: move qe_ic to drivers/irqchip
Date: Tue, 29 Mar 2016 14:24:38 +0800
Message-ID: <1459232678-12939-1-git-send-email-qiang.zhao@nxp.com>
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

qe_ic was put in drivers/soc/fsl/qe, but it should be in
drivers/irqchip.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/irqchip/Makefile                | 1 +
 drivers/{soc/fsl/qe => irqchip}/qe_ic.c | 0
 drivers/{soc/fsl/qe => irqchip}/qe_ic.h | 0
 drivers/soc/fsl/qe/Makefile             | 2 +-
 4 files changed, 2 insertions(+), 1 deletion(-)
 rename drivers/{soc/fsl/qe => irqchip}/qe_ic.c (100%)
 rename drivers/{soc/fsl/qe => irqchip}/qe_ic.h (100%)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 18caacb..2977a89 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -59,3 +59,4 @@ obj-$(CONFIG_ARCH_SA1100)		+= irq-sa11x0.o
 obj-$(CONFIG_INGENIC_IRQ)		+= irq-ingenic.o
 obj-$(CONFIG_IMX_GPCV2)			+= irq-imx-gpcv2.o
 obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
+obj-$(CONFIG_QUICC_ENGINE)		+= qe_ic.o
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/irqchip/qe_ic.c
similarity index 100%
rename from drivers/soc/fsl/qe/qe_ic.c
rename to drivers/irqchip/qe_ic.c
diff --git a/drivers/soc/fsl/qe/qe_ic.h b/drivers/irqchip/qe_ic.h
similarity index 100%
rename from drivers/soc/fsl/qe/qe_ic.h
rename to drivers/irqchip/qe_ic.h
diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
index 2031d38..51e4726 100644
--- a/drivers/soc/fsl/qe/Makefile
+++ b/drivers/soc/fsl/qe/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_ic.o qe_io.o
+obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_io.o
 obj-$(CONFIG_CPM)	+= qe_common.o
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
-- 
2.1.0.27.g96db324
