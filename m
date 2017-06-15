Return-Path: <javier@dowhile0.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpXk541nSzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 04:54:53 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id 70so1278833wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:54:53 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [RESEND PATCH v5 12/16] powerpc/5200: Add generic compatible string
 for I2C EEPROM
Date: Thu, 15 Jun 2017 20:54:14 +0200
Message-Id: <20170615185418.13980-13-javier@dowhile0.org>
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
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

Changes in v5:
- Only replace atmel variant but keep other EEPROM vendors (Geert Uytterhoeven).

Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3: None
Changes in v2: None

 arch/powerpc/boot/dts/digsy_mtc.dts | 2 +-
 arch/powerpc/boot/dts/pcm030.dts    | 2 +-
 arch/powerpc/boot/dts/pcm032.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 955bff629df3..c280e75c86bf 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -73,7 +73,7 @@
 
 		i2c@3d00 {
 			eeprom@50 {
-				compatible = "at,24c08";
+				compatible = "atmel,24c08";
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
