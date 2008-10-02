Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 16683DDE08
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 16:29:11 +1000 (EST)
From: Victor Gallardo <vgallardo@amcc.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: [PATCH 1/3 v3] Add AMCC Arches eval board support to platforms/44x
Date: Wed,  1 Oct 2008 23:29:06 -0700
Message-Id: <1222928946-10129-1-git-send-email-vgallardo@amcc.com>
Cc: linuxppc-dev@ozlabs.org, Victor Gallardo <vgallardo@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Arches Evaluation board is based on the AMCC 460GT SoC chip.
This board is a dual processor board with each processor providing
independent resources for Rapid IO, Gigabit Ethernet, and serial
communications.  Each 460GT has it's own 512MB DDR2 memory, 32MB NOR FLASH,
UART, EEPROM and temperature sensor, along with a shared debug port.
The two 460GT's will communicate with each other via shared memory,
Gigabit Ethernet and x1 PCI-Express.

Signed-off-by: Victor Gallardo <vgallardo@amcc.com>
---
 v2:
 - remove arches.c and instead use canyonlands.c
 - remove reference to IBM_NEW_EMAC_RGMII for ARCHES config
 - remove reference to IBM_NEW_EMAC_ZMII for ARCHES config
 - moved reference to IBM_NEW_EMAC_RGMII under CANYONLANDS config
 - moved reference to IBM_NEW_EMAC_ZMII under CANYONLANDS config

 v3:
 - sync up with new file structure ppc4xx_simple.c

 arch/powerpc/platforms/44x/Kconfig         |   17 +++++++++++++++--
 arch/powerpc/platforms/44x/ppc44x_simple.c |    3 ++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index f8ef279..79c1154 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -81,6 +81,17 @@ config WARP
 	  See http://www.pikatechnologies.com/ and follow the "PIKA for Computer
 	  Telephony Developers" link for more information.
 
+config ARCHES
+	bool "Arches"
+	depends on 44x
+	default n
+	select PPC44x_SIMPLE
+	select 460EX # Odd since it uses 460GT but the effects are the same
+	select PCI
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the AMCC Dual PPC460GT evaluation board.
+
 config CANYONLANDS
 	bool "Canyonlands"
 	depends on 44x
@@ -89,6 +100,8 @@ config CANYONLANDS
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
 	help
 	  This option enables support for the AMCC PPC460EX evaluation board.
 
@@ -100,6 +113,8 @@ config GLACIER
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
 	select PPC4xx_PCI_EXPRESS
+	select IBM_NEW_EMAC_RGMII
+	select IBM_NEW_EMAC_ZMII
 	help
 	  This option enables support for the AMCC PPC460GT evaluation board.
 
@@ -195,8 +210,6 @@ config 460EX
 	bool
 	select PPC_FPU
 	select IBM_NEW_EMAC_EMAC4
-	select IBM_NEW_EMAC_RGMII
-	select IBM_NEW_EMAC_ZMII
 	select IBM_NEW_EMAC_TAH
 
 # 44x errata/workaround config symbols, selected by the CPU models above
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/platforms/44x/ppc44x_simple.c
index 57e7120..2967126 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -50,8 +50,9 @@ machine_device_initcall(ppc44x_simple, ppc44x_device_probe);
  * board.c file for it rather than adding it to this list.
  */
 static char *board[] __initdata = {
+	"amcc,arches",
 	"amcc,bamboo",
-	"amcc,cayonlands",
+	"amcc,canyonlands",
 	"amcc,glacier",
 	"ibm,ebony",
 	"amcc,katmai",
-- 
1.5.5
