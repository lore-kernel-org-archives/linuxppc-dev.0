Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from mx.vmgattei.com (mx.vmgattei.com [77.223.18.35])
 by ozlabs.org (Postfix) with ESMTP id 4EE292C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 20:17:19 +1100 (EST)
Received: from localhost (mx.vmgattei.com [127.0.0.1])
 by mx.vmgattei.com (Postfix) with ESMTP id C4D2020D60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 10:17:15 +0100 (CET)
Received: from mx.vmgattei.com ([127.0.0.1])
 by localhost (mx.vmgattei.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2Q-SfHbC9M-a for <linuxppc-dev@lists.ozlabs.org>;
 Fri, 20 Dec 2013 10:17:15 +0100 (CET)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/512x: dts: disable MPC5125 usb module
Date: Fri, 20 Dec 2013 10:16:22 +0100
Message-Id: <1387530982-6115-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: gsi@denx.de, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At the moment the USB controller's pin muxing is not setup
correctly and causes a kernel panic upon system startup, so
disable the USB1 device tree node in the MPC5125 tower board
dts file.

The USB controller is connected to an USB3320 ULPI transceiver
and the device tree should receive an update to reflect correct
dependencies and required initialization data before the USB1
node can get re-enabled.

Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
v2:
* improve the text of the commit as suggested by Gerhard Sittig <gsi@denx.de>
* put the 'status = "disabled"' to the last line in the list of properties
* rewiew the comment related to USB1 device tree node
---
 arch/powerpc/boot/dts/mpc5125twr.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
index 806479f..2fa1d17 100644
--- a/arch/powerpc/boot/dts/mpc5125twr.dts
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -229,6 +229,10 @@
 			reg = <0xA000 0x1000>;
 		};
 
+		// disable USB1 port
+		// TODO:
+		// correct pinmux config and fix USB3320 ulpi dependency
+		// before re-enable it
 		usb@3000 {
 			compatible = "fsl,mpc5121-usb2-dr";
 			reg = <0x3000 0x400>;
@@ -239,6 +243,7 @@
 			phy_type = "ulpi";
 			clocks = <&clks MPC512x_CLK_USB1>;
 			clock-names = "ipg";
+			status = "disabled";
 		};
 
 		// 5125 PSCs are not 52xx or 5121 PSC compatible
-- 
1.8.3.2
