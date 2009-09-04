Return-Path: <roland.lezuo@chello.at>
Received: from viefep19-int.chello.at (viefep19-int.chello.at [62.179.121.39])
	by bilbo.ozlabs.org (Postfix) with ESMTP id D42F8B6EDE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  4 Sep 2009 20:41:46 +1000 (EST)
Received: from edge01.upc.biz ([192.168.13.236]) by viefep16-int.chello.at
	(InterMail vM.7.09.01.00 201-2219-108-20080618) with ESMTP
	id <20090904103126.IIDT9540.viefep16-int.chello.at@edge01.upc.biz>
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Sep 2009 12:31:26 +0200
Message-ID: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
Date: Fri, 4 Sep 2009 12:31:25 +0200
From: Roland Lezuo <roland.lezuo@chello.at>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch is needed to correctly assign the IRQs for the gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped as well as the interrupt lines for the two devices.

Signed-off-by: Roland Lezuo <roland.lezuo@chello.at>

---
 arch/powerpc/boot/dts/mpc8313erdb.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 761faa7..907a445 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -188,7 +188,7 @@
 			compatible = "gianfar";
 			reg = <0x24000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <37 0x8 36 0x8 35 0x8>;
+			interrupts = <32 0x8 33 0x8 34 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = < &tbi0 >;
 			/* Vitesse 7385 isn't on the MDIO bus */
@@ -223,7 +223,7 @@
 			reg = <0x25000 0x1000>;
 			ranges = <0x0 0x25000 0x1000>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
-			interrupts = <34 0x8 33 0x8 32 0x8>;
+			interrupts = <35 0x8 36 0x8 37 0x8>;
 			interrupt-parent = <&ipic>;
 			tbi-handle = < &tbi1 >;
 			phy-handle = < &phy4 >;
-- 
1.6.0.4

Regards
Roland Lezuo
please CC personally as I'm not subscribed.
