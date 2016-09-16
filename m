Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0061.outbound.protection.outlook.com [104.47.34.61])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbFls4l4RzDsfJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 23:01:29 +1000 (AEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>, Scott Wood <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, Roy Pledge <roy.pledge@nxp.com>
Subject: [PATCH 5/5] arch/powerpc: Add CONFIG_FSL_DPAA to
 corenetXX_smp_defconfig
Date: Fri, 16 Sep 2016 16:00:32 +0300
Message-ID: <1474030832-20611-6-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1474030832-20611-1-git-send-email-claudiu.manoil@nxp.com>
References: <1474030832-20611-1-git-send-email-claudiu.manoil@nxp.com>
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

Enable the drivers on the powerpc arch.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 arch/powerpc/Makefile            | 4 ++--
 arch/powerpc/configs/dpaa.config | 1 +
 drivers/soc/Kconfig              | 1 +
 drivers/soc/fsl/Makefile         | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/configs/dpaa.config

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1934707..f36347c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -325,12 +325,12 @@ mpc85xx_smp_defconfig:
 PHONY += corenet32_smp_defconfig
 corenet32_smp_defconfig:
 	$(call merge_into_defconfig,corenet_basic_defconfig,\
-		85xx-32bit 85xx-smp 85xx-hw fsl-emb-nonhw)
+		85xx-32bit 85xx-smp 85xx-hw fsl-emb-nonhw dpaa)
 
 PHONY += corenet64_smp_defconfig
 corenet64_smp_defconfig:
 	$(call merge_into_defconfig,corenet_basic_defconfig,\
-		85xx-64bit 85xx-smp altivec 85xx-hw fsl-emb-nonhw)
+		85xx-64bit 85xx-smp altivec 85xx-hw fsl-emb-nonhw dpaa)
 
 PHONY += mpc86xx_defconfig
 mpc86xx_defconfig:
diff --git a/arch/powerpc/configs/dpaa.config b/arch/powerpc/configs/dpaa.config
new file mode 100644
index 0000000..efa99c0
--- /dev/null
+++ b/arch/powerpc/configs/dpaa.config
@@ -0,0 +1 @@
+CONFIG_FSL_DPAA=y
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index fe42a2f..e6e90e8 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,6 +1,7 @@
 menu "SOC (System On Chip) specific Drivers"
 
 source "drivers/soc/bcm/Kconfig"
+source "drivers/soc/fsl/qbman/Kconfig"
 source "drivers/soc/fsl/qe/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 203307f..75e1f53 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -2,5 +2,6 @@
 # Makefile for the Linux Kernel SOC fsl specific device drivers
 #
 
+obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
-- 
1.7.11.7
