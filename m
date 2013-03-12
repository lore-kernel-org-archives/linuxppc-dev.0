Return-Path: <B29983@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BC782C0292
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Mar 2013 18:17:28 +1100 (EST)
From: <Yuantian.Tang@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH][V3] powerpc: remove the PPC_CLOCK dependency
Date: Tue, 12 Mar 2013 14:43:03 +0800
Message-ID: <1363070583-23197-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, R58472@freescale.com,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

Config FSL_SOC does not depend on PPC_CLOCK anymore since the following
commit got merged: 93abe8e (clk: add non CONFIG_HAVE_CLK routines)
Config CPM does not use PPC_CLOCK either currently. So remove them.

PPC_CLOCK also keeps Freescale PowerPC archtecture from supporting COMMON_CLK.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v3: modified the description
v2: correct the title

 arch/powerpc/Kconfig           |    1 -
 arch/powerpc/platforms/Kconfig |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 352f416..383485b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -655,7 +655,6 @@ config SBUS
 config FSL_SOC
 	bool
 	select HAVE_CAN_FLEXCAN if NET && CAN
-	select PPC_CLOCK
 
 config FSL_PCI
  	bool
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index e7a896a..aba81cd 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -343,7 +343,6 @@ config FSL_ULI1575
 
 config CPM
 	bool
-	select PPC_CLOCK
 
 config OF_RTC
 	bool
-- 
1.7.0.4
