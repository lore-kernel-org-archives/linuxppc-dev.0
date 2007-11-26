Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 360FBDDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 01:29:31 +1100 (EST)
To: Jeff Garzik <jeff@garzik.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 3/3] [POWERPC] MPC8349E-mITX: Vitesse 7385 PHY is not
	connected to the MDIO bus
Date: Mon, 26 Nov 2007 17:29:22 +0300
Message-ID: <20071126142922.19642.47964.stgit@localhost.localdomain>
In-Reply-To: <20071126142906.19642.45540.stgit@localhost.localdomain>
References: <20071126142906.19642.45540.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
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
index 5072f6d..e2d00f1 100644
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
+			fixed-link = <1 1 d#1000>;
 			linux,network-index = <1>;
 		};
 
