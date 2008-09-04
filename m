Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 3A698474C4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:25:50 +1000 (EST)
Received: by gxk14 with SMTP id 14so6180050gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 05:25:48 -0700 (PDT)
Date: Thu, 4 Sep 2008 08:25:07 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [RFC] adding hwmon support to sequoia device tree
Message-ID: <20080904122507.GB12867@yoda.jdub.homelinux.org>
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809041155.02927.matthias.fuchs@esd-electronics.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 11:55:02AM +0200, Matthias Fuchs wrote:
>Hi,
>
>I added support for the Sequoia on-board I2C temperature sensor to the device.
>I am not sure if there is any node naming convention for such devices.
>The needed I2C driver can be found under drivers/hwmon in the kernel sources,
>so I found "hwmon" suitable for the node.
>
>Do we want to add this to the sequoia dts file? If this is how it should be done,
>I will commit a proper patch.

See comments below.  Out of curiosity, do you have a working driver and
setup with this?

>diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
>index 72d15f0..82fdfdf 100644
>--- a/arch/powerpc/boot/dts/sequoia.dts
>+++ b/arch/powerpc/boot/dts/sequoia.dts
>@@ -246,13 +246,23 @@
>                        };
>
>                        IIC0: i2c@ef600700 {
>+                               #address-cells = <1>;
>+                               #size-cells = <0>;
>                                compatible = "ibm,iic-440epx", "ibm,iic";
>                                reg = <0xef600700 0x00000014>;
>                                interrupt-parent = <&UIC0>;
>                                interrupts = <0x2 0x4>;
>+
>+                               hwmon@48 {
>+                                       device_type = "hwmon";

We don't need device_type.  Particularly not a new one like this.

>+                                       compatible = "analog,ad7414";

Perhaps 'compatible = "analog,ad7417", "amcc,hwmon-440epx";'

josh
