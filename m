Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49206DDEB9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 03:43:29 +1000 (EST)
To: Jeff Garzik <jeff@garzik.org>
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH 2/2] [POWERPC] Remove dummy network phy from MPC8313E-RDB
Date: Wed, 25 Jul 2007 21:43:20 +0400
Message-ID: <20070725174320.5818.91974.stgit@localhost.localdomain>
In-Reply-To: <20070725174312.5818.61155.stgit@localhost.localdomain>
References: <20070725174312.5818.61155.stgit@localhost.localdomain>
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


Cleaned up inexistent network phy from the target dts, added
necessary property to gianfar node there.

Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

---

 arch/powerpc/boot/dts/mpc8313erdb.dts |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a1533cc..b602a8b 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -98,12 +98,6 @@
 			reg = <24520 20>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			phy1: ethernet-phy@1 {
-				interrupt-parent = < &ipic >;
-				interrupts = <13 8>;
-				reg = <1>;
-				device_type = "ethernet-phy";
-			};
 			phy4: ethernet-phy@4 {
 				interrupt-parent = < &ipic >;
 				interrupts = <14 8>;
@@ -120,7 +114,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <25 8 24 8 23 8>;
 			interrupt-parent = < &ipic >;
-			phy-handle = < &phy1 >;
+			fixed_speed = <1 1000>;
 		};
 
 		ethernet@25000 {
