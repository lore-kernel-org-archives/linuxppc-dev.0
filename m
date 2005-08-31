Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E725F68144
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Aug 2005 14:30:59 +1000 (EST)
Date: Tue, 30 Aug 2005 21:30:56 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050831043056.GA15639@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: move 4xx PHY_MODE_XXX defines to ibm_ocp.h
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Move 4xx PHY_MODE_XXX defines to asm-ppc/ibm_ocp.h. This is 
a preparation step for the new EMAC driver.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 arch/ppc/platforms/4xx/bamboo.c |    7 -------
 arch/ppc/platforms/4xx/ebony.c  |    7 -------
 arch/ppc/platforms/4xx/luan.c   |    7 -------
 arch/ppc/platforms/4xx/ocotea.c |    7 -------
 include/asm-ppc/ibm_ocp.h       |   13 +++++++++++++
 5 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/arch/ppc/platforms/4xx/bamboo.c b/arch/ppc/platforms/4xx/bamboo.c
--- a/arch/ppc/platforms/4xx/bamboo.c
+++ b/arch/ppc/platforms/4xx/bamboo.c
@@ -52,13 +52,6 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
-/*
- * This is a horrible kludge, we eventually need to abstract this
- * generic PHY stuff, so the  standard phy mode defines can be
- * easily used from arch code.
- */
-#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
-
 bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
diff --git a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
--- a/arch/ppc/platforms/4xx/ebony.c
+++ b/arch/ppc/platforms/4xx/ebony.c
@@ -55,13 +55,6 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gp_common.h>
 
-/*
- * This is a horrible kludge, we eventually need to abstract this
- * generic PHY stuff, so the  standard phy mode defines can be
- * easily used from arch code.
- */
-#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
-
 bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -53,13 +53,6 @@
 #include <syslib/ibm440gx_common.h>
 #include <syslib/ibm440sp_common.h>
 
-/*
- * This is a horrible kludge, we eventually need to abstract this
- * generic PHY stuff, so the  standard phy mode defines can be
- * easily used from arch code.
- */
-#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
-
 bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
--- a/arch/ppc/platforms/4xx/ocotea.c
+++ b/arch/ppc/platforms/4xx/ocotea.c
@@ -53,13 +53,6 @@
 #include <syslib/gen550.h>
 #include <syslib/ibm440gx_common.h>
 
-/*
- * This is a horrible kludge, we eventually need to abstract this
- * generic PHY stuff, so the  standard phy mode defines can be
- * easily used from arch code.
- */
-#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
-
 bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
diff --git a/include/asm-ppc/ibm_ocp.h b/include/asm-ppc/ibm_ocp.h
--- a/include/asm-ppc/ibm_ocp.h
+++ b/include/asm-ppc/ibm_ocp.h
@@ -100,6 +100,19 @@ void ocp_show_emac_data(struct device *d
 	device_create_file(dev, &dev_attr_emac_phy_map);		\
 }
 
+/*
+ * PHY mode settings (EMAC <-> ZMII/RGMII bridge <-> PHY)
+ */
+#define PHY_MODE_NA	0
+#define PHY_MODE_MII	1
+#define PHY_MODE_RMII	2
+#define PHY_MODE_SMII	3
+#define PHY_MODE_RGMII	4
+#define PHY_MODE_TBI	5
+#define PHY_MODE_GMII	6
+#define PHY_MODE_RTBI	7
+#define PHY_MODE_SGMII	8
+
 #ifdef CONFIG_40x
 /*
  * Helper function to copy MAC addresses from the bd_t to OCP EMAC
