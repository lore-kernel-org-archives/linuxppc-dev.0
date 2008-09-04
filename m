Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1AD18DDF01
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 20:00:05 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by comm-neu.esd (Postfix) with ESMTP id B866A108049
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 11:55:14 +0200 (CEST)
Received: from comm-neu.esd ([127.0.0.1])
	by localhost (comm [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 30228-02-2 for <linuxppc-dev@ozlabs.org>;
	Thu,  4 Sep 2008 11:55:06 +0200 (CEST)
Received: from debby.esd (debby.esd [10.0.0.190])
	by comm-neu.esd (Postfix) with ESMTP id 3739E10801C
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 11:55:06 +0200 (CEST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] adding hwmon support to sequoia device tree
Date: Thu, 4 Sep 2008 11:55:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809041155.02927.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I added support for the Sequoia on-board I2C temperature sensor to the device.
I am not sure if there is any node naming convention for such devices.
The needed I2C driver can be found under drivers/hwmon in the kernel sources,
so I found "hwmon" suitable for the node.

Do we want to add this to the sequoia dts file? If this is how it should be done,
I will commit a proper patch.


diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 72d15f0..82fdfdf 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -246,13 +246,23 @@
                        };

                        IIC0: i2c@ef600700 {
+                               #address-cells = <1>;
+                               #size-cells = <0>;
                                compatible = "ibm,iic-440epx", "ibm,iic";
                                reg = <0xef600700 0x00000014>;
                                interrupt-parent = <&UIC0>;
                                interrupts = <0x2 0x4>;
+
+                               hwmon@48 {
+                                       device_type = "hwmon";
+                                       compatible = "analog,ad7414";
+                                       reg = <0x48>;
+                               };
                        };

                        IIC1: i2c@ef600800 {
+                               #address-cells = <1>;
+                               #size-cells = <0>;
(prepare for adding devices on the 2nd I2C also)

                                compatible = "ibm,iic-440epx", "ibm,iic";
                                reg = <0xef600800 0x00000014>;
                                interrupt-parent = <&UIC0>;


Matthias
