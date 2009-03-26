Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 478AEDDDA2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 07:02:46 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 9so433416ywe.39
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 13:02:45 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1238093075.5262.0@antares>
References: <1238093075.5262.0@antares>
Date: Thu, 26 Mar 2009 15:02:42 -0500
Message-ID: <ed82fe3e0903261302r4644188ar9860899ccaa125fc@mail.gmail.com>
Subject: Re: Q: define i2c nodes in device tree?
From: Timur Tabi <timur@freescale.com>
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/3/26 Albrecht Dre=DF <albrecht.dress@arcor.de>:

> and some other like "gpio-controller" instead of "gpio" but (surprise) it
> doesn't work - dmesg says that the driver is registered, but nothing else
> shows up. =A0Unfortunately, I couldn't find documentation about the namin=
g
> conventions of the i2c child nodes.

You need to have a "gpio I2C" device driver that registers the same
name as what's in the DTS, like this:

cs4270:codec@4f {
	compatible =3D "cirrus,cs4270";
	reg =3D <0x4f>;
	/* MCLK source is a stand-alone oscillator */
	clock-frequency =3D <12288000>;
};

...

static struct i2c_device_id cs4270_id[] =3D {
	{"cs4270", 0},
	{}
};
MODULE_DEVICE_TABLE(i2c, cs4270_id);

> As I actually want to use the chips as parallel io (not separate gpio's) =
and
> thus would need to write my own driver I wonder if I really have to decla=
re
> it in the device tree? =A0Would the simple way -just load the kernel modu=
le as
> with arm/intel- also work? =A0Would it be possible to use additional reso=
urces
> like an interrupt pin on the '5200 without the device tree?

No, the only acceptable way to do this is on PowerPC is with a device
tree entry and a driver that registers itself properly.

--=20
Timur Tabi
Linux kernel developer at Freescale
