Return-Path: <kari.davidsson@marel.is>
Received: from mail.marel.com (mail.marel.is [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id 0353BDDE39
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jul 2007 22:02:59 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: OF devices and non OF devices
Date: Wed, 4 Jul 2007 12:00:31 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB020D3DE8@is-hdq-exchange.marel.net>
In-Reply-To: <4b73d43f0707030931v42aefc72x2598546e48ae87e8@mail.gmail.com>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.is>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John, thank you for your answare.

Enabling CONFIG_FSL_SOC only enabled the execution of the init function =
(fsl_i2c_init())
of the fsl-i2c driver (i2c-mpc.c). The .probe function of the driver was =
never called
until I converted the driver to the OF model and added the .match_table =
to the driver structure.

Then I get the .probe function (fsl_i2c_probe()) called and the i2c bus =
set up.

Similar thing happens for the i2c device PCF8563 i.e., the init functin =
of the driver (pcf8563_init())
is called the driver is registered with the kernel, but the .probe =
(pcf8563_probe()) is never called.

The driver pcf8563 has _NO_ exported structures or functions so I =
basically have no handle on it
that I can utilize in board specific setup.

The way I suspect this is supposed to work is that from the board settup =
files I would do
rtc_dev =3D platform_device_register_simple("pcf8563", -1, NULL, 0);
which should later trigger the calling of the pcf8563_probe() function.

This is doing things in the same way as the fsl i2c code, i.e.
i2c_dev =3D platform_device_register_simple("i2c", i, r, 2);
which by the way does not work untill I have converted the fsl_i2c =
(i2c-mpc.c) driver to the OF structure.

So still the method of gluing together the OF drivers and non OF drivers =
eludes me.

rg
kd

P.S. I did check the 2.6.21-RC7-git3 and found that the i2c-mpc.c and =
the rtc-pcf85763.c are basically the same
as what I am working with in 2.6.20+=20
________________________________

From: John Rigby [mailto:jcrigby@gmail.com]=20
Sent: 3. j=FAl=ED 2007 16:31
To: K=E1ri Dav=ED=F0sson
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: OF devices and non OF devices


One place to find binding between OF devices and non OF devices is in =
arch/powerpc/sysdev/fsl_soc.c
The typical pattern is:
    if of_find_compatible_node "of-device-name"
        platform_device_register_simple ""platform-device-name"=20
        platform_device_add_data ...

 =20

On 7/3/07, K=E1ri Dav=ED=F0sson <kari.davidsson@marel.is> wrote:=20

	Hi,
=09
	I am attempting to get some non OF devices working for an mpc 5200 =
board, in particular=20
	PCF8563 RTC.
=09
	This device has an non OF device interface which I believe is correct. =
After all it should work
	on non OF platforms.
=09
	I have managed to get the board to run the i2c initialization (and =
probe) for the fsl-mpc i2c driver by=20
	converting the fsl-mpc i2c driver to OF driver (I found some patch here =
that I based this work on).


fsl-i2c is one of the devices handled by fsl_soc.c so you shouldn't need =
to change anything to=20
make it work in the latest kernel.  CONFIG_FSL_SOC was only added to =
lite5200_defconfig recently so=20
that may explain why it's not on in your kernel.



	Since the PCF8563 driver is not OF driver only its initaliziation code =
is run but the .probe function
	of the driver is never run. Basically (as far as I can understand) the =
.probe is never run because the
	driver is not an OF driver.=20
=09
	I could convert the PCF8563 driver to OF driver and make it work for =
our puposes but I feel this is
	1) Wrong
	2) therefore wasted work.


Since the driver must run on non OF platforms then it should not be =
converted.  You just need to add a platform_device_register somewhere.=20
I don't think fsl_soc.c is  the right place since it is not part of an =
freescale SOC.
You could probably put it in a board specific startup routine.



	What seems to elude me is some glue that glues together the OF part of =
the driver space to the non OF part
	of the driver space.
=09
	Any hints or pointers on where to find this glue?
=09
	Regards,
	kd
=09
	P.S. Kernel is post 2.6.20.
=09
	--
	K=E1ri Dav=ED=F0sson                   | kari.davidsson@marel.is
	Hugb=FAna=F0arger=F0                   | www.marel.com
	Tel: 563-8156 Fax: +354 563 8001=20
	Iceland
	_______________________________________________
	Linuxppc-embedded mailing list
	Linuxppc-embedded@ozlabs.org
	https://ozlabs.org/mailman/listinfo/linuxppc-embedded
=09
