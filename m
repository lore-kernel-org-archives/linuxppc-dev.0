Return-Path: <jwboyer@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.248])
	by ozlabs.org (Postfix) with ESMTP id 96F38DDF33
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 22:47:32 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so168458hsz.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2008 05:47:30 -0700 (PDT)
Message-Id: <7b05824ec3f0594c4ff4bbb03f896d9c8d434927.1222864484.git.jwboyer@linux.vnet.ibm.com>
In-Reply-To: <cover.1222864484.git.jwboyer@linux.vnet.ibm.com>
References: <cover.1222864484.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Thu, 18 Sep 2008 12:47:52 +0000
Subject: [PATCH 1/3] powerpc/44x: Add AMCC Arches eval board support
To: Victor Gallardo <vgallardo@amcc.com>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for the AMCC Dual PowerPC 460GT Arches
eval board.

Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/44x/Kconfig         |   22 ++++++++++++++++++----
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index f8ef279..41a95c6 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -89,6 +89,10 @@ config CANYONLANDS
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_TAH
 	help
 	  This option enables support for the AMCC PPC460EX evaluation board.
 
@@ -100,6 +104,20 @@ config GLACIER
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
+	select IBM_NEW_EMAC_TAH
+	help
+	  This option enables support for the AMCC PPC460GT evaluation board.
+
+config ARCHES
+	bool "Arches"
+	depends on 44x
+	default n
+	select 460EX
+	select IBM_NEW_EMAC_EMAC4
+	select IBM_NEW_EMAC_TAH
 	help
 	  This option enables support for the AMCC PPC460GT evaluation board.
 
@@ -194,10 +212,6 @@ config 440SPe
 config 460EX
 	bool
 	select PPC_FPU
-	select IBM_NEW_EMAC_EMAC4
-	select IBM_NEW_EMAC_RGMII
-	select IBM_NEW_EMAC_ZMII
-	select IBM_NEW_EMAC_TAH
 
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 57e7120..39f0eff 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -53,6 +53,7 @@ static char *board[] __initdata = {
 	"amcc,bamboo",
 	"amcc,cayonlands",
 	"amcc,glacier",
+	"amcc,arches",
 	"ibm,ebony",
 	"amcc,katmai",
 	"amcc,rainier",
-- 
1.5.5.1
