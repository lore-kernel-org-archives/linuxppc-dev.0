Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 3C2EADDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jul 2007 21:13:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: OF devices and non OF devices
Date: Wed, 18 Jul 2007 11:13:52 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB0211E4D2@is-hdq-exchange.marel.net>
In-Reply-To: <4b73d43f0707051020o67e671dft1d3b3816776d8eb7@mail.gmail.com>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.is>
To: "John Rigby" <jcrigby@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes there was indeed.

Combination of my misunderstanding, device trees and board specific =
initialization.

Things are working now.

Thanks,
kd


________________________________

From: John Rigby [mailto:jcrigby@gmail.com]=20
Sent: 5. j=FAl=ED 2007 17:21
To: K=E1ri Dav=ED=F0sson
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: OF devices and non OF devices


There must be something else wrong with your configuration.
On my Lite5200B fsl_i2c_probe gets called with no changes to the driver.

The kernel version is 2.6.22-rc7

The relevant part of my device tree is:=20

        i2c@3d00 {
            device_type =3D "i2c";
            compatible =3D "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
            cell-index =3D <0>;
            reg =3D <3d00 40>;=20
            interrupts =3D <2 f 0>;
            interrupt-parent =3D <&mpc5200_pic>;
            fsl5200-clocking;
        };

        i2c@3d40 {
            device_type =3D "i2c";=20
            compatible =3D "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
            cell-index =3D <1>;
            reg =3D <3d40 40>;
            interrupts =3D <2 10 0>;
            interrupt-parent =3D <&mpc5200_pic>;=20
            fsl5200-clocking;
        };

I turned on DEBUG in drivers/base/dd.c and a call to pr_debug in the =
probe routine
and here are the relevant log messages:

[   27.258245] platform: Matched Device fsl-i2c.0 with Driver fsl-i2c
[   27.258269] platform: Probing driver fsl-i2c with device fsl-i2c.0
[   27.258299] I2C: here in fsl_i2c_probe
[   27.258732] bound device 'fsl-i2c.0' to driver 'fsl-i2c'=20
[   27.258756] platform: Bound Device fsl-i2c.0 to Driver fsl-i2c
[   27.258776] platform: Matched Device fsl-i2c.1 with Driver fsl-i2c
[   27.258789] platform: Probing driver fsl-i2c with device fsl-i2c.1
[   27.258821] I2C: here in fsl_i2c_probe
[   27.259269] bound device 'fsl-i2c.1' to driver 'fsl-i2c'
[   27.259293] platform: Bound Device fsl-i2c.1 to Driver fsl-i2c

John


On 7/5/07, John Rigby <jcrigby@gmail.com> wrote:=20

	kd,
=09
	Ok, obviously It doesn't work the way I thought.  Hopefully someone who =
does
	understand this will comment.
=09
	John=20
=09
=09
=09
	On 7/4/07, K=E1ri Dav=ED=F0sson <kari.davidsson@marel.is> wrote:=20

		John, thank you for your answare.
	=09
		Enabling CONFIG_FSL_SOC only enabled the execution of the init =
function (fsl_i2c_init())
		of the fsl-i2c driver (i2c-mpc.c). The .probe function of the driver =
was never called
		until I converted the driver to the OF model and added the =
.match_table to the driver structure.
	=09
		Then I get the .probe function (fsl_i2c_probe()) called and the i2c =
bus set up.
	=09
		Similar thing happens for the i2c device PCF8563 i.e., the init =
functin of the driver (pcf8563_init())
		is called the driver is registered with the kernel, but the .probe =
(pcf8563_probe()) is never called.
	=09
		The driver pcf8563 has _NO_ exported structures or functions so I =
basically have no handle on it=20
		that I can utilize in board specific setup.
	=09
		The way I suspect this is supposed to work is that from the board =
settup files I would do
		rtc_dev =3D platform_device_register_simple("pcf8563", -1, NULL, 0);=20
		which should later trigger the calling of the pcf8563_probe() =
function.
	=09
		This is doing things in the same way as the fsl i2c code, i.e.
		i2c_dev =3D platform_device_register_simple("i2c", i, r, 2);
		which by the way does not work untill I have converted the fsl_i2c =
(i2c-mpc.c) driver to the OF structure.
	=09
		So still the method of gluing together the OF drivers and non OF =
drivers eludes me.
	=09
		rg
		kd
	=09
		P.S. I did check the 2.6.21-RC7-git3 and found that the i2c-mpc.c and =
the rtc-pcf85763.c are basically the same
		as what I am working with in 2.6.20+
		________________________________
	=09
		From: John Rigby [mailto: jcrigby@gmail.com]
		Sent: 3. j=FAl=ED 2007 16:31
		To: K=E1ri Dav=ED=F0sson
		Cc: linuxppc-embedded@ozlabs.org=20
		Subject: Re: OF devices and non OF devices
	=09
	=09
		One place to find binding between OF devices and non OF devices is in =
arch/powerpc/sysdev/fsl_soc.c=20
		The typical pattern is:
		    if of_find_compatible_node "of-device-name"
		        platform_device_register_simple ""platform-device-name"
		        platform_device_add_data ...
	=09
	=09
	=09
		On 7/3/07, K=E1ri Dav=ED=F0sson <kari.davidsson@marel.is> wrote:
	=09
		        Hi,
	=09
		        I am attempting to get some non OF devices working for an mpc =
5200 board, in particular=20
		        PCF8563 RTC.
	=09
		        This device has an non OF device interface which I believe is =
correct. After all it should work
		        on non OF platforms.
	=09
		        I have managed to get the board to run the i2c initialization =
(and probe) for the fsl-mpc i2c driver by=20
		        converting the fsl-mpc i2c driver to OF driver (I found some =
patch here that I based this work on).
	=09
	=09
		fsl-i2c is one of the devices handled by fsl_soc.c so you shouldn't =
need to change anything to=20
		make it work in the latest kernel.  CONFIG_FSL_SOC was only added to =
lite5200_defconfig recently so
		that may explain why it's not on in your kernel.
	=09
	=09
	=09
		        Since the PCF8563 driver is not OF driver only its =
initaliziation code is run but the .probe function=20
		        of the driver is never run. Basically (as far as I can =
understand) the .probe is never run because the
		        driver is not an OF driver.
	=09
		        I could convert the PCF8563 driver to OF driver and make it =
work for our puposes but I feel this is=20
		        1) Wrong
		        2) therefore wasted work.
	=09
	=09
		Since the driver must run on non OF platforms then it should not be =
converted.  You just need to add a platform_device_register somewhere.
		I don't think fsl_soc.c is  the right place since it is not part of an =
freescale SOC.=20
		You could probably put it in a board specific startup routine.
	=09
	=09
	=09
		        What seems to elude me is some glue that glues together the OF =
part of the driver space to the non OF part
		        of the driver space.=20
	=09
		        Any hints or pointers on where to find this glue?
	=09
		        Regards,
		        kd
	=09
		        P.S. Kernel is post 2.6.20.
	=09
		        --
		        K=E1ri Dav=ED=F0sson                   | =
kari.davidsson@marel.is
		        Hugb=FAna=F0arger=F0                   | www.marel.com
		        Tel: 563-8156 Fax: +354 563 8001=20
		        Iceland
		        _______________________________________________=20
		        Linuxppc-embedded mailing list
		        Linuxppc-embedded@ozlabs.org
		         https://ozlabs.org/mailman/listinfo/linuxppc-embedded =
<https://ozlabs.org/mailman/listinfo/linuxppc-embedded>=20
	=09
	=09
	=09
		_______________________________________________
		Linuxppc-embedded mailing list
		Linuxppc-embedded@ozlabs.org
		https://ozlabs.org/mailman/listinfo/linuxppc-embedded
	=09


=09
