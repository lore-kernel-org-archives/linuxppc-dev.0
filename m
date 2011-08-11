Return-Path: <holt@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id C8043B7415
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 02:07:43 +1000 (EST)
From: Robin Holt <holt@sgi.com>
To: Robin Holt <holt@sgi.com>, Kumar Gala <galak@kernel.crashing.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	U Bhaskar-B22300 <B22300@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v11 6/6] powerpc: Add flexcan device support for p1010rdb.
Date: Thu, 11 Aug 2011 11:07:11 -0500
Message-Id: <1313078831-2511-7-git-send-email-holt@sgi.com>
In-Reply-To: <1313078831-2511-1-git-send-email-holt@sgi.com>
References: <1313078831-2511-1-git-send-email-holt@sgi.com>
Cc: , netdev@vger.kernel.org, U Bhaskar-B22300 <B22300@freescale.com>,
	socketcan-core@lists.berlios.de, Robin Holt <holt@sgi.com>,
	PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allow the p1010 processor to select the flexcan network driver.

Signed-off-by: Robin Holt <holt@sgi.com>
Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>,
Acked-by: Wolfgang Grandegger <wg@grandegger.com>,
Cc: U Bhaskar-B22300 <B22300@freescale.com>
Cc: socketcan-core@lists.berlios.de,
Cc: netdev@vger.kernel.org,
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p1010rdb.dts  |    8 ++++++++
 arch/powerpc/platforms/85xx/Kconfig |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dts b/arch/powerpc/boot/dts/p1010rdb.dts
index d6c669c..df89b60 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dts
+++ b/arch/powerpc/boot/dts/p1010rdb.dts
@@ -171,6 +171,14 @@
 			};
 		};
 
+		can@1c000 {
+			clock-frequency = <0x0bebc1fc>;
+		};
+
+		can1: can@1d000 {
+			clock-frequency = <0x0bebc1fc>;
+		};
+
 		usb@22000 {
 			phy_type = "utmi";
 		};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 498534c..c4304ae 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -70,6 +70,8 @@ config MPC85xx_RDB
 config P1010_RDB
 	bool "Freescale P1010RDB"
 	select DEFAULT_UIMAGE
+	select HAVE_CAN_FLEXCAN if NET && CAN
+	select PPC_CLOCK if CAN_FLEXCAN
 	help
 	  This option enables support for the MPC85xx RDB (P1010 RDB) board
 
-- 
1.7.2.1
