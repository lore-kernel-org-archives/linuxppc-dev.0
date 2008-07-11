Return-Path: <rmcguire@videopresence.com>
Received: from smtpout09.prod.mesa1.secureserver.net
	(smtpout09-04.prod.mesa1.secureserver.net [64.202.165.17])
	by ozlabs.org (Postfix) with SMTP id 9346CDDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jul 2008 10:30:18 +1000 (EST)
From: "Russell McGuire" <rmcguire@videopresence.com>
To: "'Kim Phillips'" <kim.phillips@freescale.com>
Subject: Freescale UCC_GETH Half Duplex Patch
Date: Thu, 10 Jul 2008 17:23:31 -0700
Message-ID: <2FE8E39946EE489FBAFC327EC9154EAF@absolutdaddy>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0013_01C8E2B1.ACC7E790"
Cc: linuxppc-embedded@ozlabs.org
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

This is a multi-part message in MIME format.

------=_NextPart_000_0013_01C8E2B1.ACC7E790
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Kim, ALL

Here is a fix up for the UCC_GETH driver supporting half duplex mode for
some specific modes.

I have tested this quiet extensively and the link now comes up and works,
however not sure if there are other issues that need to be looked at, since
10BaseT connectivity provides VERY ERRATIC throughput, but at least it works
now with RGMII and GMII modes.

There was a lot more in my patch, but I removed a lot of the code for
submission. Let me know if for any reason this patch file is improperly
formatted.

Russell McGuire
Senior Systems Engineer
rmcguire@videopresence.com
503.888.0968


------=_NextPart_000_0013_01C8E2B1.ACC7E790
Content-Type: application/octet-stream;
	name="ucc_geth.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ucc_geth.patch"

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c=0A=
index 9a38dfe..5900847 100644=0A=
--- a/drivers/net/ucc_geth.c=0A=
+++ b/drivers/net/ucc_geth.c=0A=
@@ -1533,10 +1698,17 @@ static void adjust_link(struct net_device *dev)=0A=
 		 * If not, we operate in half-duplex mode. */=0A=
 		if (phydev->duplex !=3D ugeth->oldduplex) {=0A=
 			new_state =3D 1;=0A=
-			if (!(phydev->duplex))=0A=
-				tempval &=3D ~(MACCFG2_FDX);=0A=
-			else=0A=
-				tempval |=3D MACCFG2_FDX;=0A=
+			/* Can only use half duplex for these two modes!! */=0A=
+			if ((ugeth->phy_interface =3D=3D PHY_INTERFACE_MODE_MII) ||=0A=
+			  (ugeth->phy_interface =3D=3D PHY_INTERFACE_MODE_RMII)) {	=0A=
+				if (!(phydev->duplex))=0A=
+					tempval &=3D ~(MACCFG2_FDX);=0A=
+				else=0A=
+					tempval |=3D MACCFG2_FDX;=0A=
+			} else {=0A=
+				/* Always set for other modes */=0A=
+				tempval |=3D MACCFG2_FDX; =0A=
+			}=0A=
 			ugeth->oldduplex =3D phydev->duplex;=0A=
 		}=0A=

------=_NextPart_000_0013_01C8E2B1.ACC7E790--
