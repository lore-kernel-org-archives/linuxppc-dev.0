Return-Path: <emillbrandt@norco.coldhaus.com>
Received: from norco.coldhaus.com (norco.coldhaus.com [64.32.230.18])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "norco.coldhaus.com",
 Issuer "StartCom Class 1 Primary Intermediate Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 594792C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2012 00:37:33 +1000 (EST)
From: Eric Millbrandt <emillbrandt@dekaresearch.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Liam Girdwood <lrg@ti.com>, Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 1/3] ASoC: fsl: add PPC_MPC52xx dependency to
 SND_POWERPC_SOC
Date: Thu, 20 Sep 2012 10:36:43 -0400
Message-Id: <1348151805-93991-1-git-send-email-emillbrandt@dekaresearch.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc52xx socs do not define FSL_SOC but need SND_POWERPC_SOC defined to build
ASoC drivers.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---
Changes since v1:
Patch was "powerpc/52xx: define FSL_SOC"
Changed from defining FSL_SOC for PPC_MPC52xx to adding PPC_MPC52xx as a
dependency of SND_POWERPC_SOC as per Anatolij Gustschin's comment.

 sound/soc/fsl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d701330..4563b28 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -6,7 +6,7 @@ config SND_SOC_FSL_UTILS
 
 menuconfig SND_POWERPC_SOC
 	tristate "SoC Audio for Freescale PowerPC CPUs"
-	depends on FSL_SOC
+	depends on FSL_SOC || PPC_MPC52xx
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the PowerPC CPUs.
-- 
1.7.2.5
