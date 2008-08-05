Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58DE5DE1A1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:13:47 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m75KDfkx008451
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:13:42 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-194.am.freescale.net
	[10.214.72.194])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m75KDeNA025312
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 15:13:41 -0500 (CDT)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias to MPC5121
	ADS device tree.
Date: Tue,  5 Aug 2008 14:13:38 -0600
Message-Id: <1217967220-30557-2-git-send-email-jrigby@freescale.com>
In-Reply-To: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So get_immrbase can function without a device_type = "soc"
property in the soc node.

The "soc" node should really be named "immr"
because it does not include the entire soc, however
u-boot currently looks up this node by name for
a clock fixup so leave it "soc" for now.  We will change
it later after 5121 u-boot uses the immr alias instead
of the node name.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index 1f9036c..c52c51d 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -19,6 +19,7 @@
 
 	aliases {
 		pci = &pci;
+		immr = &immr;
 	};
 
 	cpus {
@@ -135,7 +136,7 @@
 		};
 	};
 
-	soc@80000000 {
+	immr: soc@80000000 {
 		compatible = "fsl,mpc5121-immr";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
