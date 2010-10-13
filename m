Return-Path: <yifei_wang@hotmail.com>
Received: from bay0-omc4-s8.bay0.hotmail.com (bay0-omc4-s8.bay0.hotmail.com
	[65.54.190.210]) by ozlabs.org (Postfix) with ESMTP id BDE83B70A5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 17:17:36 +1100 (EST)
Message-ID: <BAY158-ds2BEE228C7E27E7CE0C28BF5550@phx.gbl>
From: WANG YiFei <yifei_wang@hotmail.com>
To: "'tiejun.chen'" <tiejun.chen@windriver.com>
References: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
	<4CB522D1.5090802@windriver.com>
In-Reply-To: <4CB522D1.5090802@windriver.com>
Subject: RE: ppc405 + MCP23S17
Date: Wed, 13 Oct 2010 14:23:30 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi TieJun,

Thanks a lot for your reply.
So far, I can get ppc405 spi to initialize, however
failed at MCP23S17's probe() routine, I checked the
code, it's due to un-initialized platform data. Here
is my part of dts:

	spi@ef600600 {
		device_type =3D "spi";
		compatible =3D "ibm,ppc4xx-spi", "ibm,spi";
		reg =3D <0xef600600 0x7>;
		interrupt-parent =3D <0x2>;
		interrupts =3D <0x8 0x4>;
		#address-cells =3D <0x1>;
		#size-cells =3D <0x0>;
		gpios =3D <0>;    	/* cs */
	=09
		spi_gpio@0 {
			compatible =3D "mcp,mcp23s08";
			spi-max-frequency =3D <1000000>;
			reg =3D <0>;
		};
	};

I don't know how to provide platform data from dts although
I understand the concept from code. Do I only need to modify
dts OR I need to write some code to supply platform data? Do
you have any URL or sample code to show passing of platform
data?

Anyway, thanks a lot for guiding me.
YiFei

-----Original Message-----
From: tiejun.chen [mailto:tiejun.chen@windriver.com]=20
Sent: Wednesday, October 13, 2010 11:09 AM
To: WANG YiFei
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ppc405 + MCP23S17

WANG YiFei wrote:
> Hi,
>=20
> =20
>=20
> I'm a newbie for linux device driver development.
>=20
> We have a custom ppc405 board which has MCP23S17
>=20
> (16-Bit I/O Expander with SPI Interface) on it.
>=20
> I noticed that current kernel has MCP23S08 driver
>=20
> support, I'd like to know:
>=20
> 1. if passing platform data to MCP23S08 driver, can it make
>=20
>    MCP23S17 work?
>=20

These chips should be same vendor product so I think 16-bit mcp23s17 may =
be
compatible to 8-bit modes. But you have to check the data sheet to =
confirm this
and track how to configure that as 8-bit mode. After that it's possible =
to run
mcp23s17 with mcp23s08.c.

> 2. Generally, I'd like to know how to pass platform data to
>=20
>    a particular device driver. In my mind, platform data should
>=20
>    not be in driver code, right? However, I don't know where is

Firstly you should define this on your dts. Then parse that to register
corresponding of_platform_device or platform_device when you setup your =
target
on <your target>.c.

When spi_register_driver prober successfully, you can get the =
platform_data from
associated spi device.

>=20
>    the suitable place to pass platform data to driver.
>=20
> 3. How to describe this in dts file?
>=20

You can get more from the file, =
Documentation/powerpc/dts-bindings/spi-bus.txt.
Or refer to those existed spi nodes on other platform dts.

Tiejun

> =20
>=20
> Thanks in advance,
>=20
> YiFei
>=20
>=20
>=20
>=20
> =
------------------------------------------------------------------------
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
