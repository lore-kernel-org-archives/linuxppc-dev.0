Return-Path: <qiang.zhao@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0064.outbound.protection.outlook.com [104.47.33.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlLdr4xRSzDr2g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 12:09:03 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@nxp.com>
To: <oss@buserror.net>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <xiaobo.xie@nxp.com>, Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH v2] irqchip/qeic: move qeic driver from drivers/soc/fsl/qe
Date: Thu, 7 Jul 2016 09:23:55 +0800
Message-ID: <1467854635-19208-1-git-send-email-qiang.zhao@nxp.com>
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

The driver stays the same.

Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- modify the subject and commit msg

 drivers/irqchip/Makefile                | 1 +
 drivers/{soc/fsl/qe => irqchip}/qe_ic.c | 0
 drivers/{soc/fsl/qe => irqchip}/qe_ic.h | 0
 drivers/soc/fsl/qe/Makefile             | 2 +-
 4 files changed, 2 insertions(+), 1 deletion(-)
 rename drivers/{soc/fsl/qe => irqchip}/qe_ic.c (100%)
 rename drivers/{soc/fsl/qe => irqchip}/qe_ic.h (100%)

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 38853a1..cef999d 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
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
