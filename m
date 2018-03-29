Return-Path: <ran.wang_1@nxp.com>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0048.outbound.protection.outlook.com [104.47.42.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BYrp02jHzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 16:55:49 +1100 (AEDT)
From: Ran Wang <ran.wang_1@nxp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Scott Wood
 <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>, Li Yang
 <leoyang.li@nxp.com>
CC: Zhao Chenhui <chenhui.zhao@freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, Ran
 Wang <ran.wang_1@nxp.com>
Subject: [PATCH 1/5] powerpc/pm: Fix suspend=n in menuconfig for e500mc
 platforms.
Date: Thu, 29 Mar 2018 09:31:39 +0800
Message-ID: <20180329013143.22527-1-ran.wang_1@nxp.com>
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

Also, unselect FSL_PMC which is for older platfroms instead.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 arch/powerpc/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd..ed60c83 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -316,7 +316,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
+		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
 config PPC_DCR_NATIVE
@@ -940,8 +940,6 @@ config FSL_PCI
 
 config FSL_PMC
 	bool
-	default y
-	depends on SUSPEND && (PPC_85xx || PPC_86xx)
 	help
 	  Freescale MPC85xx/MPC86xx power management controller support
 	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
-- 
1.7.1
