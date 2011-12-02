Return-Path: <afleming@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2CB4FB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 18:05:59 +1100 (EST)
From: Andy Fleming <afleming@freescale.com>
To: David Miller <davem@davemloft.net>, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] pq3: Add default tbi address
Date: Fri, 2 Dec 2011 01:05:49 -0600
Message-ID: <1322809549-32622-2-git-send-email-afleming@freescale.com>
In-Reply-To: <1322809549-32622-1-git-send-email-afleming@freescale.com>
References: <1322809549-32622-1-git-send-email-afleming@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MDIO driver has been changed so that it no longer supports
scanning the MDIO bus for a free address for the TBI PHY. This
feature was fragile, and required scanning the bus before the bus
was fully up and registered. The intended way for FSL devices to
specify the TBI PHY's address is via a tbi node in the device tree.
All of the device trees had such a node, except for the recent p1/p2
trees. Rather than hand-fixing all of those boards, set a default
value (most boards were using 0x11, anyway), and any board which
wants to change it from that default can then override it in its
board dts file.

This fixes an issue where p1/p2 boards would fail to bring up
Ethernet, due to not finding a tbi node.

Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi |    5 +++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
index a1979ae..0a42e21 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
@@ -50,4 +50,9 @@ mdio@24520 {
 	#size-cells = <0>;
 	compatible = "fsl,gianfar-mdio";
 	reg = <0x24520 0x20>;
+
+	tbi-phy@11 {
+		device-type = "tbi-phy";
+		reg = <0x11>;
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
index 1382fec..964670a 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
@@ -38,6 +38,11 @@ mdio@24000 {
 	#size-cells = <0>;
 	compatible = "fsl,etsec2-mdio";
 	reg = <0x24000 0x1000 0xb0030 0x4>;
+
+	tbi-phy@11 {
+		device-type = "tbi-phy";
+		reg = <0x11>;
+	};
 };
 
 ethernet@b0000 {
-- 
1.7.3.4
