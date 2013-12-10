Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4A4782C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 20:51:29 +1100 (EST)
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v1 1/1] powerpc/512x: dts: remove misplaced IRQ spec from
 'soc' node (5125)
Date: Tue, 10 Dec 2013 10:51:08 +0100
Message-Id: <1386669068-2477-1-git-send-email-gsi@denx.de>
Cc: devicetree@vger.kernel.org, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the 'soc' node in the MPC5125 "tower" board .dts has an '#interrupt-cells'
property although this node is not an interrupt controller

remove this erroneously placed property because starting with v3.13-rc1
lookup and resolution of 'interrupts' specs for peripherals gets misled
(tries to use the 'soc' as the interrupt parent which fails), emits
'no irq domain found' WARN() messages and breaks the boot process

[ best viewed with 'git diff -U5' to have DT node names in the context ]

Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Gerhard Sittig <gsi@denx.de>

---

note that this is not a resend of the previous MPC5121 fix, but instead
is a fix for MPC5125 along the same lines of the MPC5121 fix
---
 arch/powerpc/boot/dts/mpc5125twr.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts b/arch/powerpc/boot/dts/mpc5125twr.dts
index 4177b62240c2..0a0fe92216ae 100644
--- a/arch/powerpc/boot/dts/mpc5125twr.dts
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -58,7 +58,6 @@
 		compatible = "fsl,mpc5121-immr";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		#interrupt-cells = <2>;
 		ranges = <0x0 0x80000000 0x400000>;
 		reg = <0x80000000 0x400000>;
 		bus-frequency = <66000000>;	// 66 MHz ips bus
-- 
1.7.10.4
