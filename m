Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 7C12AB6F16
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 09:32:38 +1100 (EST)
Received: by yxe8 with SMTP id 8so5971946yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 14:32:37 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B2FCF40.3050204@billgatliff.com>
References: <4B2FCF40.3050204@billgatliff.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Dec 2009 15:32:17 -0700
Message-ID: <fa686aa40912211432h606bb8bbh1dd61870a3348319@mail.gmail.com>
Subject: Re: Trouble specifying dts gpio-leds with GPIO expander chip
To: Bill Gatliff <bgat@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 21, 2009 at 12:40 PM, Bill Gatliff <bgat@billgatliff.com> wrote=
:
> Guys:
>
>
> I'm trying to come up with the right stuff for my dts file to assign a
> Linux "heartbeat" trigger to an I2C GPIO expansion device (MAX7314).
> I'm running on a platform that is very similar to the lite5200b, with
> linux-2.6.32. =A0I'm a bit new to the device tree concept, having come
> most recently from an ARM world, so please be gentle... =A0:)
>
> I have this so far:
>
> =A0 =A0 =A0 =A0soc5200@f0000000 {
> =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-immr","simple-bus";
> =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0 0xf0000000 0x0000c000>;
> =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xf0000000 0x00000100>;
> =A0 =A0 =A0 =A0 =A0 =A0bus-frequency =3D <0>; =A0 =A0 =A0 =A0// from boot=
loader
> =A0 =A0 =A0 =A0 =A0 =A0system-frequency =3D <0>; =A0 =A0 =A0 =A0// from b=
ootloader
> =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0i2c@3d40 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <0>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc5200b-i2c","fsl,mpc=
5200-i2c","fsl-i2c";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x3d40 0x40>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <2 16 0>;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lext20: max7314@20 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #gpio-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "maxim,max7314=
","phillips,pca953x";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x20>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 linux,phandle =3D <0x20>;

Drop the linux,phandle.  The phandle property is generated
automatically by the device tree compiler.  This could mess things up.

As Anton says, the 7314 driver doesn't register the GPIO in a way that
the of_gpio layer understands, so cannot translate.  What the of_gpio
infrastructure *should* be doing is to fetch the device tree node out
of the struct device and use that path to translate device tree GPIO
references to Linux GPIO numbers.  ie.
dev_archdata_get_node(gc->dev->archdata).  Then as long as the device
tree node pointer is set in the struct device (which it always should
be), then OF translations for GPIO numbers should work without driver
changes.

In other words; given a device tree node pointer; loop over all the
registered GPIO devices and look for a matching node pointer in the
struct device.  When a matching one is found; do the translation.
However, on further thought, this may require an additional hook added
to the gpio_chip registration to override the translation function if
necessary.

Anton, what are you thinking about to simplify OF GPIO registrations?

Bill, in the mean time you could do as Anton suggests and modify the
GPIO driver to have an of_gpio_chip allocation.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
