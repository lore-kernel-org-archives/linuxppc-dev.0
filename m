Return-Path: <rmcguire@videopresence.com>
Received: from smtpauth23.prod.mesa1.secureserver.net
	(smtpauth23.prod.mesa1.secureserver.net [64.202.165.47])
	by ozlabs.org (Postfix) with SMTP id 0C560DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jul 2008 08:01:14 +1000 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kim Phillips'" <kim.phillips@freescale.com>
References: <2FE8E39946EE489FBAFC327EC9154EAF@absolutdaddy><20080711124604.caf199e9.kim.phillips@freescale.com>
	<20080717120155.efdef031.kim.phillips@freescale.com>
Subject: [PATCH]: Freescale UCC_GETH Half Duplex
Date: Thu, 17 Jul 2008 15:01:05 -0700
Message-ID: <64C0D186E4EA49148AF433F744D72E2D@absolutdaddy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20080717120155.efdef031.kim.phillips@freescale.com>
Cc: chuck@ThePTRGroup.com, linuxppc-embedded@ozlabs.org
Reply-To: rmcguire@videopresence.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

All,

This fix is for UCC_GETH, in the manual only TWO modes allow half duplex
setting, and this is for MII and RMII.  All other modes are disallowed
because it is not supported in the Freescale MAC interface, and will throw
the QE engines into unknown states. 

For all other modes other than MII and RMII, this doesn't mean that half
duplex doesn't work, it just means the bit can't be set, apparently <though
unclear in the manual>?, in Gigabit modes, like RGMII and GMII the MAC will
auto-detect if half duplex is in effect. Hence why we leave it set to dull
duplex.


Signed-off-by: Russell McGuire <rmcguire@videopresence.com>

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 9a38dfe..5900847 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1533,10 +1698,17 @@ static void adjust_link(struct net_device *dev)
 		 * If not, we operate in half-duplex mode. */
 		if (phydev->duplex != ugeth->oldduplex) {
 			new_state = 1;
-			if (!(phydev->duplex))
-				tempval &= ~(MACCFG2_FDX);
-			else
-				tempval |= MACCFG2_FDX;
+			/* Can only set half duplex for these two modes!! */
+			if ((ugeth->phy_interface == PHY_INTERFACE_MODE_MII)
||
+			  (ugeth->phy_interface == PHY_INTERFACE_MODE_RMII))
{
+				if (!(phydev->duplex))
+					tempval &= ~(MACCFG2_FDX);
+				else
+					tempval |= MACCFG2_FDX;
+			} else {
+				/* Always set for other modes */
+				tempval |= MACCFG2_FDX; 
+			}
 			ugeth->oldduplex = phydev->duplex;
 		}
