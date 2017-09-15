Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xtds16Dv2zDrYW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 12:00:20 +1000 (AEST)
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/3] RTC: rv3029: fix vendor string
Date: Fri, 15 Sep 2017 04:00:02 +0200
Message-Id: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The vendor string for Microcrystal is microcrystal.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 2 +-
 drivers/rtc/rtc-rv3029c2.c                            | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index af284fbd4d23..aae37352c574 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -72,7 +72,6 @@ isil,isl29030		Intersil ISL29030 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
-mc,rv3029c2		Real Time Clock Module with I2C-Bus
 mcube,mc3230		mCube 3-axis 8-bit digital accelerometer
 memsic,mxc6225		MEMSIC 2-axis 8-bit digital accelerometer
 microchip,mcp4531-502	Microchip 7-bit Single I2C Digital Potentiometer (5k)
@@ -141,6 +140,7 @@ microchip,mcp4662-503	Microchip 8-bit Dual I2C Digital Potentiometer with NV Mem
 microchip,mcp4662-104	Microchip 8-bit Dual I2C Digital Potentiometer with NV Memory (100k)
 microchip,tc654		PWM Fan Speed Controller With Fan Fault Detection
 microchip,tc655		PWM Fan Speed Controller With Fan Fault Detection
+microcrystal,rv3029	Real Time Clock Module with I2C-Bus
 miramems,da226		MiraMEMS DA226 2-axis 14-bit digital accelerometer
 miramems,da280		MiraMEMS DA280 3-axis 14-bit digital accelerometer
 miramems,da311		MiraMEMS DA311 3-axis 12-bit digital accelerometer
diff --git a/drivers/rtc/rtc-rv3029c2.c b/drivers/rtc/rtc-rv3029c2.c
index aa09771de04f..cfe3aece51d1 100644
--- a/drivers/rtc/rtc-rv3029c2.c
+++ b/drivers/rtc/rtc-rv3029c2.c
@@ -876,6 +876,8 @@ static const struct i2c_device_id rv3029_id[] = {
 MODULE_DEVICE_TABLE(i2c, rv3029_id);
 
 static const struct of_device_id rv3029_of_match[] = {
+	{ .compatible = "microcrystal,rv3029" },
+	/* Backward compatibility only, do not use compatibles below: */
 	{ .compatible = "rv3029" },
 	{ .compatible = "rv3029c2" },
 	{ .compatible = "mc,rv3029c2" },
-- 
2.14.1
