Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 0232ADDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 23:07:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Oops: of_platform_serial_probe
Date: Tue, 20 Nov 2007 13:05:47 +0100
References: <474193B8.9060007@anagramm.de> <200711191756.55165.arnd@arndb.de>
	<4742BC57.7020305@anagramm.de>
In-Reply-To: <4742BC57.7020305@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200711201305.47753.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 20 November 2007, Clemens Koller wrote:
> The device tree is the default one which comes with the kernel:
> paulus.git/arch/powerpc/boot/dts/mpc8540ads.dts
> which contains:
>=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial@4500 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "seria=
l";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ns1655=
0";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <4500 100>; =
=A0 =A0 =A0 // reg base, size
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <0=
>; =A0// should we fill in in uboot?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2a 2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <=
&mpic>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial@4600 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_type =3D "seria=
l";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "ns1655=
0";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <4600 100>; =
=A0 =A0 =A0 // reg base, size
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clock-frequency =3D <0=
>; =A0// should we fill in in uboot?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2a 2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D <=
&mpic>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>=20
> =A0> One potential problem that I can see is a missing 'current-speed'
> =A0> property in your tree, which would cause this behavior.
>=20
> That's correct. Should be fixed in all .dts' ?
=20
It depends a lot on how the systems are used. current-speed only makes
sense if there is a boot loader that also does some serial I/O at a
speed it sets up itself.


> =A0> It looks
> =A0> like many device trees set this, but it is not required by all
> =A0> bindings.
>=20
> How should someone know, when it's really needed and when not?

The point of current-speed is that the kernel can tell what bitrate
was used by the boot loader and set up the same speed so that your
terminal emulation does not get garbled output when changing from
boot loader messages to kernel messages.

> =A0> If that's the case, the patch below should fix your
> =A0> problem, but you probably want to set the current-speed anyway,
> =A0> according to your boot loader settings.
>=20
> I think there was no need to set it again, because of: console=3DttyS0,11=
5200
> But I'll verify...

When current-speed is set, you don't need to override the speed at the
command line.

> @@ -36,6 +36,10 @@ static int __devinit of_platform_serial_setup(struct o=
f_device *ofdev,
> =A0=A0=A0=A0=A0=A0=A0=A0memset(port, 0, sizeof *port);
> =A0=A0=A0=A0=A0=A0=A0=A0spd =3D of_get_property(np, "current-speed", NULL=
);
> =A0=A0=A0=A0=A0=A0=A0=A0clk =3D of_get_property(np, "clock-frequency", NU=
LL);
> +=A0=A0=A0=A0=A0=A0=A0if (!spd) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_warn(&ofdev->dev, "no c=
urrent-speed property set\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> +=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0if (!clk) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_warn(&ofdev->dev, "no=
 clock-frequency property set\n");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;

This looks wrong. Since the current-speed property is not mandated by open =
firmware,
we should not error out here, but simply use the setting from the command l=
ine
or whatever other defaults can be used. Not setting port->custom_divisor at=
 all
should do the job.

	Arnd <><
