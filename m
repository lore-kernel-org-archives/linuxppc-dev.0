Return-Path: <gerickson@nuovations.com>
Received: from relay02.pair.com (relay02.pair.com [209.68.5.16])
	by ozlabs.org (Postfix) with SMTP id 4AFFADDF64
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 01:03:15 +1000 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] ibm_newemac: Add MII mode support to the EMAC RGMII bridge.
Date: Tue,  8 Jul 2008 08:03:06 -0700
Message-Id: <1215529386-12749-1-git-send-email-gerickson@nuovations.com>
In-Reply-To: <C497F939.104DB%gerickson@nuovations.com>
References: <C497F939.104DB%gerickson@nuovations.com>
Cc: sr@denx.de, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support to the RGMII handler in the EMAC driver for
the MII PHY mode such that device tree entries of the form `phy-mode = "mii";'
are recognized and handled appropriately.

While logically, in software, "gmii" and "mii" modes are the same,
they are wired differently, so it makes sense to allow DTS authors to
specify each explicitly.

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
 drivers/net/ibm_newemac/rgmii.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
index e32da3d..5acb006 100644
--- a/drivers/net/ibm_newemac/rgmii.c
+++ b/drivers/net/ibm_newemac/rgmii.c
@@ -39,6 +39,7 @@
 #define RGMII_FER_RGMII(idx)	(0x5 << ((idx) * 4))
 #define RGMII_FER_TBI(idx)	(0x6 << ((idx) * 4))
 #define RGMII_FER_GMII(idx)	(0x7 << ((idx) * 4))
+#define RGMII_FER_MII(idx)	RGMII_FER_GMII(idx)
 
 /* RGMIIx_SSR */
 #define RGMII_SSR_MASK(idx)	(0x7 << ((idx) * 8))
@@ -49,6 +50,7 @@
 static inline int rgmii_valid_mode(int phy_mode)
 {
 	return  phy_mode == PHY_MODE_GMII ||
+		phy_mode == PHY_MODE_MII ||
 		phy_mode == PHY_MODE_RGMII ||
 		phy_mode == PHY_MODE_TBI ||
 		phy_mode == PHY_MODE_RTBI;
@@ -63,6 +65,8 @@ static inline const char *rgmii_mode_name(int mode)
 		return "TBI";
 	case PHY_MODE_GMII:
 		return "GMII";
+	case PHY_MODE_MII:
+		return "MII";
 	case PHY_MODE_RTBI:
 		return "RTBI";
 	default:
@@ -79,6 +83,8 @@ static inline u32 rgmii_mode_mask(int mode, int input)
 		return RGMII_FER_TBI(input);
 	case PHY_MODE_GMII:
 		return RGMII_FER_GMII(input);
+	case PHY_MODE_MII:
+		return RGMII_FER_MII(input);
 	case PHY_MODE_RTBI:
 		return RGMII_FER_RTBI(input);
 	default:
--
1.5.4.3
