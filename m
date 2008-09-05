Return-Path: <sean.maclennan@pikatech.com>
Received: from mail.pikatech.com (dns.pikatech.com [207.107.229.10])
	by ozlabs.org (Postfix) with ESMTP id A5515DDF13
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 00:49:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [RFC] adding hwmon support to sequoia device tree
Date: Fri, 5 Sep 2008 10:27:14 -0400
Message-ID: <67BFAF42E016FC40ADE4EE73E07B706001B4B646@pks00005.kanatek.com>
References: <200809041155.02927.matthias.fuchs@esd-electronics.com><20080904122507.GB12867@yoda.jdub.homelinux.org>
	<200809041628.29460.matthias.fuchs@esd-electronics.com>
From: "Sean MacLennan" <sean.maclennan@pikatech.com>
To: "Matthias Fuchs" <matthias.fuchs@esd-electronics.com>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes, the ad7414 driver was finally accepted into the kernel. The ad7414 =
is a generic temperature chip.

FWIW, the warp.dts uses ad7414@4c, not hwmon.

Cheers,
   Sean

-----Original Message-----
From:	linuxppc-dev-bounces+smaclennan=3Dpikatech.com@ozlabs.org on =
behalf of Matthias Fuchs
Sent:	Thu 9/4/2008 10:28 AM
To:	Josh Boyer
Cc:	linuxppc-dev@ozlabs.org
Subject:	Re: [RFC] adding hwmon support to sequoia device tree

Hi,=20

On Thursday 04 September 2008 14:25, Josh Boyer wrote:
> On Thu, Sep 04, 2008 at 11:55:02AM +0200, Matthias Fuchs wrote:
> >Hi,
> >
> >I added support for the Sequoia on-board I2C temperature sensor to =
the device.
> >I am not sure if there is any node naming convention for such =
devices.
> >The needed I2C driver can be found under drivers/hwmon in the kernel =
sources,
> >so I found "hwmon" suitable for the node.
> >
> >Do we want to add this to the sequoia dts file? If this is how it =
should be done,
> >I will commit a proper patch.
>=20
> See comments below.  Out of curiosity, do you have a working driver =
and
> setup with this?
Of course.=20

You need
	CONFIG_HWMON=3Dy
	CONFIG_SENSORS_AD7414=3Dy

Via sysfs you get:
sequoia:~# cat /sys/bus/i2c/devices/0-0048/temp1_input
34750
sequoia:~# cat /sys/class/hwmon/hwmon0/device/temp1_input
34750
sequoia:~#=20

34750 =3D 34.75=B0C

>=20
> >diff --git a/arch/powerpc/boot/dts/sequoia.dts =
b/arch/powerpc/boot/dts/sequoia.dts
> >index 72d15f0..82fdfdf 100644
> >--- a/arch/powerpc/boot/dts/sequoia.dts
> >+++ b/arch/powerpc/boot/dts/sequoia.dts
> >@@ -246,13 +246,23 @@
> >                        };
> >
> >                        IIC0: i2c@ef600700 {
> >+                               #address-cells =3D <1>;
> >+                               #size-cells =3D <0>;
> >                                compatible =3D "ibm,iic-440epx", =
"ibm,iic";
> >                                reg =3D <0xef600700 0x00000014>;
> >                                interrupt-parent =3D <&UIC0>;
> >                                interrupts =3D <0x2 0x4>;
> >+
> >+                               hwmon@48 {
> >+                                       device_type =3D "hwmon";
>=20
> We don't need device_type.  Particularly not a new one like this.
I will remove that.
>=20
> >+                                       compatible =3D =
"analog,ad7414";
>=20
> Perhaps 'compatible =3D "analog,ad7417", "amcc,hwmon-440epx";'
It has nothing to do with either AMCC or 440EPx.

Patch is on the way.

Matthias
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
