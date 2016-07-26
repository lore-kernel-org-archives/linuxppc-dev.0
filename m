Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz4t317sszDqdj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:30:18 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hh10so12589118pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 21:30:18 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc: mpc85xx_mds: Select PHYLIB only if NETDEVICES is
 enabled
Date: Mon, 25 Jul 2016 21:30:09 -0700
Message-Id: <1469507410-6112-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PHYLIB depends on NETDEVICES, so to avoid unmet dependencies warning
from Kconfig it needs to be selected conditionally.

Also add checks if PHYLIB is built-in to avoid undefined references to
PHYLIB's symbols.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/powerpc/platforms/85xx/Kconfig       | 2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index e626461..3da35bc 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -72,7 +72,7 @@ config MPC85xx_CDS
 config MPC85xx_MDS
 	bool "Freescale MPC85xx MDS"
 	select DEFAULT_UIMAGE
-	select PHYLIB
+	select PHYLIB if NETDEVICES
 	select HAS_RAPIDIO
 	select SWIOTLB
 	help
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index dbcb467..71aff5e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -63,6 +63,8 @@
 #define DBG(fmt...)
 #endif
 
+#if IS_BUILTIN(CONFIG_PHYLIB)
+
 #define MV88E1111_SCR	0x10
 #define MV88E1111_SCR_125CLK	0x0010
 static int mpc8568_fixup_125_clock(struct phy_device *phydev)
@@ -152,6 +154,8 @@ static int mpc8568_mds_phy_fixups(struct phy_device *phydev)
 	return err;
 }
 
+#endif
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -313,6 +317,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 	swiotlb_detect_4g();
 }
 
+#if IS_BUILTIN(CONFIG_PHYLIB)
 
 static int __init board_fixups(void)
 {
@@ -342,9 +347,12 @@ static int __init board_fixups(void)
 
 	return 0;
 }
+
 machine_arch_initcall(mpc8568_mds, board_fixups);
 machine_arch_initcall(mpc8569_mds, board_fixups);
 
+#endif
+
 static int __init mpc85xx_publish_devices(void)
 {
 	if (machine_is(mpc8568_mds))
@@ -435,4 +443,3 @@ define_machine(p1021_mds) {
 	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 };
-
-- 
2.5.5
