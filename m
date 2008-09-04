Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 732BCDDE45
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:53:31 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] adding hwmon support to sequoia device tree
Date: Thu, 4 Sep 2008 14:50:16 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<20080904122507.GB12867@yoda.jdub.homelinux.org>
In-Reply-To: <20080904122507.GB12867@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809041450.16857.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 September 2008, Josh Boyer wrote:
> >Do we want to add this to the sequoia dts file? If this is how it should
> > be done, I will commit a proper patch.
>
> See comments below.  Out of curiosity, do you have a working driver and
> setup with this?

Sure, it did hit mainline with 2.6.27:

drivers/hwmon/ad7414.c

> >diff --git a/arch/powerpc/boot/dts/sequoia.dts
> > b/arch/powerpc/boot/dts/sequoia.dts index 72d15f0..82fdfdf 100644
> >--- a/arch/powerpc/boot/dts/sequoia.dts
> >+++ b/arch/powerpc/boot/dts/sequoia.dts
> >@@ -246,13 +246,23 @@
> >                        };
> >
> >                        IIC0: i2c@ef600700 {
> >+                               #address-cells = <1>;
> >+                               #size-cells = <0>;
> >                                compatible = "ibm,iic-440epx", "ibm,iic";
> >                                reg = <0xef600700 0x00000014>;
> >                                interrupt-parent = <&UIC0>;
> >                                interrupts = <0x2 0x4>;
> >+
> >+                               hwmon@48 {
> >+                                       device_type = "hwmon";
>
> We don't need device_type.  Particularly not a new one like this.
>
> >+                                       compatible = "analog,ad7414";
>
> Perhaps 'compatible = "analog,ad7417", "amcc,hwmon-440epx";'

I don't think we need any amcc and/or 440epx here. Its a common chip from 
Analog.

Best regards,
Stefan
