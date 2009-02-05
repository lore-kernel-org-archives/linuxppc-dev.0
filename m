Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 2FE6ADDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Feb 2009 07:10:34 +1100 (EST)
Date: Thu, 5 Feb 2009 23:10:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/83xx: Fix missing #{address,size}-cells in
	mpc8313erdb.dts
Message-ID: <20090205201032.GA3425@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

commit b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 ("gianfar: Convert
gianfar to an of_platform_driver") introduced a child node for
the ethernet@25000 controller, but no address and size cells
specifiers were added, and that makes dtc unhappy:

DTC: dts->dtb  on file "arch/powerpc/boot/dts/mpc8313erdb.dts"
Warning (reg_format): "reg" property in /soc8313@e0000000/ethernet@25000/mdio@25520 has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /soc8313@e0000000/ethernet@25000/mdio@25520
Warning (avoid_default_addr_size): Relying on default #size-cells value for /soc8313@e0000000/ethernet@25000/mdio@25520

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 909a89c..3f84cd0 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -219,6 +219,8 @@
 		};
 
 		enet1: ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
 			cell-index = <1>;
 			device_type = "network";
 			model = "eTSEC";
-- 
1.5.6.5
