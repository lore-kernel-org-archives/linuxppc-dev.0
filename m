Return-Path: <javier@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w3qRg5vm6zDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 04:43:11 +1000 (AEST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 20/22] powerpc/83xx: Add generic compatible string for I2C
 EEPROM
Date: Thu, 13 Apr 2017 15:28:37 -0300
Message-Id: <20170413182839.25381-21-javier@osg.samsung.com>
In-Reply-To: <20170413182839.25381-1-javier@osg.samsung.com>
References: <20170413182839.25381-1-javier@osg.samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The at24 driver allows to register I2C EEPROM chips using different vendor
and devices, but the I2C subsystem does not take the vendor into account
when matching using the I2C table since it only has device entries.

But when matching using an OF table, both the vendor and device has to be
taken into account so the driver defines only a set of compatible strings
using the "atmel" vendor as a generic fallback for compatible I2C devices.

So add this generic fallback to the device node compatible string to make
the device to match the driver using the OF device ID table.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v2: None

 arch/powerpc/boot/dts/mpc8308_p1m.dts  | 2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts | 2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts  | 2 +-
 arch/powerpc/boot/dts/mpc8377_wlan.dts | 2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts  | 2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts  | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 57f86cdf9f36..f7803bec2873 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -123,7 +123,7 @@
 			interrupt-parent = <&ipic>;
 			dfsrr;
 			fram@50 {
-				compatible = "ramtron,24c64";
+				compatible = "ramtron,24c64","atmel,24c64";
 				reg = <0x50>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 90aed3ac2f69..7f759b9b9dc9 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -92,7 +92,7 @@
 			dfsrr;
 
 			eeprom: at24@50 {
-				compatible = "st,24c256";
+				compatible = "st,24c256","atmel,24c256";
 				reg = <0x50>;
 			};
 
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index e32613963ab0..0f8c53c69f83 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -150,7 +150,7 @@
 				};
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "at24,24c256","atmel,24c256";
 					reg = <0x50>;
 				};
 
diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
index c0c790168b96..1f04b4f99c8f 100644
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
+++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -135,7 +135,7 @@
 				dfsrr;
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "at24,24c256","atmel,24c256";
 					reg = <0x50>;
 				};
 
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 71842fcd621f..0f73f239370f 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -150,7 +150,7 @@
 				};
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "at24,24c256","atmel,24c256";
 					reg = <0x50>;
 				};
 
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index e442a29b2fe0..d7ee3089a0f9 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -148,7 +148,7 @@
 				};
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "at24,24c256","atmel,24c256";
 					reg = <0x50>;
 				};
 
-- 
2.9.3
