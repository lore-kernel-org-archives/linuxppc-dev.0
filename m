Return-Path: <matteo.facchinetti@sirius-es.it>
Received: from mx.vmgattei.com (mx.vmgattei.com [77.223.18.35])
 by ozlabs.org (Postfix) with ESMTP id 1E4C92C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 21:24:18 +1100 (EST)
Received: from localhost (mx.vmgattei.com [127.0.0.1])
 by mx.vmgattei.com (Postfix) with ESMTP id 8999722E4E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2013 11:24:13 +0100 (CET)
Received: from mx.vmgattei.com ([127.0.0.1])
 by localhost (mx.vmgattei.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tRRk++7ALYS for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 19 Dec 2013 11:24:13 +0100 (CET)
From: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/512x: dts: disable MPC5125 usb module
Date: Thu, 19 Dec 2013 11:23:59 +0100
Message-Id: <1387448639-11050-1-git-send-email-matteo.facchinetti@sirius-es.it>
Cc: gsi@denx.de, agust@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

USB controller pin-muxing is not initialized correctly and when system boot,
causes a kernel panic.
USB controller is also connected with a USB3320 ulpi tranciever and
DTS should be includes the correct dependency for initialize and activate
this component.

Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
---
 arch/powerpc/boot/dts/mpc5125twr.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
index 806479f..85452a7 100644
--- a/arch/powerpc/boot/dts/mpc5125twr.dts
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -230,6 +230,9 @@
 		};
 
 		usb@3000 {
+			/* TODO correct pinmux config and fix USB3320 ulpi dependency */
+			status = "disabled";
+
 			compatible = "fsl,mpc5121-usb2-dr";
 			reg = <0x3000 0x400>;
 			#address-cells = <1>;
-- 
1.8.3.2
