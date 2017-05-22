Return-Path: <javier@dowhile0.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWgNQ0kPpzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 May 2017 00:03:02 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id g15so13833312wmc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 07:03:01 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 19/20] powerpc/83xx: Add generic compatible string for I2C
 EEPROM
Date: Mon, 22 May 2017 16:02:07 +0200
Message-Id: <20170522140208.24652-20-javier@dowhile0.org>
In-Reply-To: <20170522140208.24652-1-javier@dowhile0.org>
References: <20170522140208.24652-1-javier@dowhile0.org>
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

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

---

Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3: None
Changes in v2: None

 arch/powerpc/boot/dts/mpc8308_p1m.dts  | 2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts | 4 ++--
 arch/powerpc/boot/dts/mpc8377_rdb.dts  | 2 +-
 arch/powerpc/boot/dts/mpc8377_wlan.dts | 2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts  | 2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts  | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 57f86cdf9f36..702ab4fc5b4a 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -123,7 +123,7 @@
 			interrupt-parent = <&ipic>;
 			dfsrr;
 			fram@50 {
-				compatible = "ramtron,24c64";
+				compatible = "atmel,24c64";
 				reg = <0x50>;
 			};
 		};
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 90aed3ac2f69..f49d1cffd927 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -92,7 +92,7 @@
 			dfsrr;
 
 			eeprom: at24@50 {
-				compatible = "st,24c256";
+				compatible = "atmel,24c256";
 				reg = <0x50>;
 			};
 
@@ -130,7 +130,7 @@
 			};
 
 			spd: at24@51 {
-				compatible = "at24,spd";
+				compatible = "atmel,spd";
 				reg = <0x51>;
 			};
 
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index e32613963ab0..5e85d8c93bca 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -150,7 +150,7 @@
 				};
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "atmel,24c256";
 					reg = <0x50>;
 				};
 
diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
index c0c790168b96..fee15fcbb46f 100644
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
+++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -135,7 +135,7 @@
 				dfsrr;
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "atmel,24c256";
 					reg = <0x50>;
 				};
 
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 71842fcd621f..e973d61956b9 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -150,7 +150,7 @@
 				};
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "atmel,24c256";
 					reg = <0x50>;
 				};
 
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index e442a29b2fe0..ed5d12ff2ee0 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -148,7 +148,7 @@
 				};
 
 				at24@50 {
-					compatible = "at24,24c256";
+					compatible = "atmel,24c256";
 					reg = <0x50>;
 				};
 
-- 
2.9.3
