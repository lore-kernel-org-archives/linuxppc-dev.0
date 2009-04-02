Return-Path: <mlcreech@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 79F37DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 07:02:57 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c38so464017ana.39
	for <linuxppc-dev@ozlabs.org>; Thu, 02 Apr 2009 13:02:55 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Apr 2009 16:02:55 -0400
Message-ID: <5ee96a840904021302s152a46a4udc61d672acffde45@mail.gmail.com>
Subject: [PATCH] net/gianfar: fix RMII mode detection
From: "Matthew L. Creech" <mlcreech@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On MPC8313, the TSEC flags ECNTRL_REDUCED_MODE (for RGMII) and
ECNTRL_REDUCED_MII_MODE (for RMII) are mutually exclusive (15-32 of
the 8313 reference manual).  The current gianfar driver only checks
for RMII when RGMII is enabled, so plain RMII is never detected.  This
patch makes the flags independent.

Signed-off-by: Matthew Creech <mlcreech@gmail.com>
---
 gianfar.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff -purN orig/drivers/net/gianfar.c linux-2.6.29/drivers/net/gianfar.c
--- orig/drivers/net/gianfar.c	2009-04-02 15:36:16.000000000 -0400
+++ linux-2.6.29/drivers/net/gianfar.c	2009-04-02 15:38:18.000000000 -0400
@@ -628,21 +628,20 @@ static phy_interface_t gfar_get_interfac
 			return PHY_INTERFACE_MODE_TBI;
 	}

+	if (ecntrl & ECNTRL_REDUCED_MII_MODE)
+		return PHY_INTERFACE_MODE_RMII;
+
 	if (ecntrl & ECNTRL_REDUCED_MODE) {
-		if (ecntrl & ECNTRL_REDUCED_MII_MODE)
-			return PHY_INTERFACE_MODE_RMII;
-		else {
-			phy_interface_t interface = priv->interface;
-
-			/*
-			 * This isn't autodetected right now, so it must
-			 * be set by the device tree or platform code.
-			 */
-			if (interface == PHY_INTERFACE_MODE_RGMII_ID)
-				return PHY_INTERFACE_MODE_RGMII_ID;
+		phy_interface_t interface = priv->interface;

-			return PHY_INTERFACE_MODE_RGMII;
-		}
+		/*
+		 * This isn't autodetected right now, so it must
+		 * be set by the device tree or platform code.
+		 */
+		if (interface == PHY_INTERFACE_MODE_RGMII_ID)
+			return PHY_INTERFACE_MODE_RGMII_ID;
+
+		return PHY_INTERFACE_MODE_RGMII;
 	}

 	if (priv->device_flags & FSL_GIANFAR_DEV_HAS_GIGABIT)

-- 
Matthew L. Creech
