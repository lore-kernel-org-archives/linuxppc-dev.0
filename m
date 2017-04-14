Return-Path: <javier@osg.samsung.com>
Received: from osg.samsung.com
 (ec2-52-27-115-49.us-west-2.compute.amazonaws.com [52.27.115.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 3w3zy20XTZzDqBP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 11:06:33 +1000 (AEST)
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 devicetree@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 17/21] powerpc/5200: Add generic compatible string for I2C
 EEPROM
Date: Thu, 13 Apr 2017 22:04:41 -0300
Message-Id: <20170414010445.21727-18-javier@osg.samsung.com>
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
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

Changes in v3: None
Changes in v2: None

 arch/powerpc/boot/dts/digsy_mtc.dts | 2 +-
 arch/powerpc/boot/dts/pcm030.dts    | 2 +-
 arch/powerpc/boot/dts/pcm032.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 955bff629df3..0acb6ff7fc22 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -73,7 +73,7 @@
 
 		i2c@3d00 {
 			eeprom@50 {
-				compatible = "at,24c08";
+				compatible = "at,24c08", "atmel,24c08";
 				reg = <0x50>;
 			};
 
diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 192e66af0001..836e47cc4bed 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -71,7 +71,7 @@
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "catalyst,24c32";
+				compatible = "catalyst,24c32", "atmel,24c32";
 				reg = <0x52>;
 				pagesize = <32>;
 			};
diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index 96b139bf50e9..576249bf2fb9 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -75,7 +75,7 @@
 				reg = <0x51>;
 			};
 			eeprom@52 {
-				compatible = "catalyst,24c32";
+				compatible = "catalyst,24c32", "atmel,24c32";
 				reg = <0x52>;
 				pagesize = <32>;
 			};
-- 
2.9.3
