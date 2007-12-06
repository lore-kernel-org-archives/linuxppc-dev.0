Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A970BDDF4E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 09:51:48 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 3/3] [POWERPC] MPC8349E-mITX: Vitesse 7385 PHY is not
	connected to the MDIO bus
Date: Fri, 07 Dec 2007 01:51:39 +0300
Message-ID: <20071206225139.31080.18384.stgit@localhost.localdomain>
In-Reply-To: <20071206225121.31080.86606.stgit@localhost.localdomain>
References: <20071206225121.31080.86606.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: netdev@vger.kernel.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


...thus use fixed-link to register proper "Fixed PHY"

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/boot/dts/mpc8349emitx.dts |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)


diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 5072f6d..877ee6d 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -115,14 +115,6 @@
 				reg = <1c>;
 				device_type = "ethernet-phy";
 			};
-
-			/* Vitesse 7385 */
-			phy1f: ethernet-phy@1f {
-				interrupt-parent = < &ipic >;
-				interrupts = <12 8>;
-				reg = <1f>;
-				device_type = "ethernet-phy";
-			};
 		};
 
 		ethernet@24000 {
@@ -159,7 +151,8 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <23 8 24 8 25 8>;
 			interrupt-parent = < &ipic >;
-			phy-handle = < &phy1f >;
+			/* Vitesse 7385 isn't on the MDIO bus */
+			fixed-link = <1 1 d#1000 0 0>;
 			linux,network-index = <1>;
 		};
 
