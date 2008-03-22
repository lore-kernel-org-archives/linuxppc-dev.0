Return-Path: <grant@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 4B2C8DDFEE
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 14:25:25 +1100 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JY4006TJ46CTW00@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 21 Mar 2008 21:25:24 -0600 (MDT)
Received: from pn2ml4so.prod.shaw.ca ([10.0.121.148])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JY400AMD46BGU20@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 21 Mar 2008 21:25:24 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JY400G1G463N660@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 21 Mar 2008 21:25:23 -0600 (MDT)
Date: Fri, 21 Mar 2008 21:25:15 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] [POWERPC] mpc5200: fix incorrect compatible string for the
	mdio node
In-reply-to: <>
To: linux-kernel@vger.kernel.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Message-id: <1206156315-4734-1-git-send-email-grant.likely@secretlab.ca>
References: <>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The MDIO node in the lite5200b.dts file needs to also claim compatibility
with the older mpc5200 chip.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
Paul, this one should also go in for .26

 arch/powerpc/boot/dts/lite5200b.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 30eaeab..001c955 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -270,7 +270,7 @@
 		mdio@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "fsl,mpc5200b-mdio";
+			compatible = "fsl,mpc5200b-mdio", "fsl,mpc5200-mdio";
 			reg = <0x3000 0x400>;	// fec range, since we need to setup fec interrupts
 			interrupts = <2 5 0>;	// these are for "mii command finished", not link changes & co.
 			interrupt-parent = <&mpc5200_pic>;
-- 
1.5.4.3
