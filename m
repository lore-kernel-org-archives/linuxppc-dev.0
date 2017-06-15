Return-Path: <javier@dowhile0.org>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpXkG3DTZzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 04:55:02 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id f90so1281480wmh.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:55:02 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh@kernel.org>,
 Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [RESEND PATCH v5 16/16] powerpc/44x: Add generic compatible string
 for I2C EEPROM
Date: Thu, 15 Jun 2017 20:54:18 +0200
Message-Id: <20170615185418.13980-17-javier@dowhile0.org>
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

Changes in v5: None
Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3: None
Changes in v2: None

 arch/powerpc/boot/dts/warp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/warp.dts b/arch/powerpc/boot/dts/warp.dts
index e576ee85c42f..ea9053ef4819 100644
--- a/arch/powerpc/boot/dts/warp.dts
+++ b/arch/powerpc/boot/dts/warp.dts
@@ -238,7 +238,7 @@
 
 				/* This will create 52 and 53 */
 				at24@52 {
-					compatible = "at,24c04";
+					compatible = "atmel,24c04";
 					reg = <0x52>;
 				};
 			};
-- 
2.9.3
