Return-Path: <yifei_wang@hotmail.com>
Received: from bay0-omc4-s6.bay0.hotmail.com (bay0-omc4-s6.bay0.hotmail.com
	[65.54.190.208]) by ozlabs.org (Postfix) with ESMTP id D94ABB70E5
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 02:03:38 +1100 (EST)
Message-ID: <BAY158-ds774A2E0B753853E1C0CF0F5550@phx.gbl>
From: WANG YiFei <yifei_wang@hotmail.com>
To: "'tiejun.chen'" <tiejun.chen@windriver.com>
References: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
	<4CB522D1.5090802@windriver.com>
	<BAY158-ds2BEE228C7E27E7CE0C28BF5550@phx.gbl>
	<4CB56496.7040809@windriver.com>
In-Reply-To: <4CB56496.7040809@windriver.com>
Subject: RE: ppc405 + MCP23S17
Date: Wed, 13 Oct 2010 23:03:38 +0800
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

I saw you name in \arch\powerpc\boot\cuboot-kilauea.c,
I think I found right person for help, since our board
is based on Kilauea evaluation board, and currently I
used 40x/kilauea_defconfig to config kernel. Also I used
Kilauea.dts as starting point to modify as shown in my
previous email.
As you know, Kilauea board doesn't have any spi devices
on spi bus, however, our board has an mcp23s17 on it. So
far, I didn't add/change kernel/driver code. Looking at
mcp23s08.c's probe() routine:

static int mcp23s08_probe(struct spi_device *spi)
{
	struct mcp23s08_platform_data	*pdata;
	unsigned			addr;
	unsigned			chips =3D 0;
	struct mcp23s08_driver_data	*data;
	int				status;
	unsigned			base;

	pdata =3D spi->dev.platform_data;
	if (!pdata || !gpio_is_valid(pdata->base)) {
		dev_dbg(&spi->dev, "invalid or missing platform data\n");
		return -EINVAL;
	}
......

Obviously, if I don't pass any platform_data to mcp23s08 device,
it will always fail. That means this mcp23s08 driver always needs
a platform_data to associate with, I don't know if this is the correct
behavior. Anyway, so my question is: is my modified dts files(as in
previous email) correct? what info else do I need to add in to support
platform_data in dts file? Or if this dts is correct, then where is the
right place(which .c file) to set/pass platform_data to?


Regards,
YiFei


-----Original Message-----
From: tiejun.chen [mailto:tiejun.chen@windriver.com]=20
Sent: Wednesday, 13 October, 2010 3:50 PM
To: WANG YiFei
Cc: linuxppc-dev@ozlabs.org
Subject: Re: ppc405 + MCP23S17

WANG YiFei wrote:
> Hi TieJun,
>=20
> Thanks a lot for your reply.
> So far, I can get ppc405 spi to initialize, however
> failed at MCP23S17's probe() routine, I checked the
> code, it's due to un-initialized platform data. Here
> is my part of dts:
>=20
> 	spi@ef600600 {
> 		device_type =3D "spi";
> 		compatible =3D "ibm,ppc4xx-spi", "ibm,spi";
> 		reg =3D <0xef600600 0x7>;
> 		interrupt-parent =3D <0x2>;
> 		interrupts =3D <0x8 0x4>;
> 		#address-cells =3D <0x1>;
> 		#size-cells =3D <0x0>;
> 		gpios =3D <0>;    	/* cs */
> 	=09
> 		spi_gpio@0 {
> 			compatible =3D "mcp,mcp23s08";
> 			spi-max-frequency =3D <1000000>;
> 			reg =3D <0>;
> 		};
> 	};
>=20
> I don't know how to provide platform data from dts although
> I understand the concept from code. Do I only need to modify
> dts OR I need to write some code to supply platform data? Do
> you have any URL or sample code to show passing of platform
> data?

Often you SPI bus driver should call spi_register_master() to register =
your SPI
master controller. Then please go to the following path:
=3D=3D=3D=3D=3D=3D
spi_register_master()
	|
	+ scan_boardinfo()
		|
		+ spi_new_device()
			^
			Here refer to the function,
------
struct spi_device *spi_new_device(struct spi_master *master,
                                  struct spi_board_info *chip)
{
	struct spi_device       *proxy;
	......
	proxy->dev.platform_data =3D (void *) chip->platform_data;
	......
	status =3D spi_add_device(proxy);
	......

And as I previously comment 'spi->dev.platform_data' would be passed to =
your
platform_data resided in your probe hook within your spi device driver.

So firstly you should register call spi_register_board_info() to =
register one
given spi_board_info by parsing your device nodes from your dts.

I think you can refer to the file, =
arch/powerpc/platforms/83xx/mpc832x_rdb.c.

>=20
> Anyway, thanks a lot for guiding me.

You're welcome :)

Tiejun

> YiFei
>=20
> -----Original Message-----
> From: tiejun.chen [mailto:tiejun.chen@windriver.com]=20
> Sent: Wednesday, October 13, 2010 11:09 AM
> To: WANG YiFei
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: ppc405 + MCP23S17
>=20
> WANG YiFei wrote:
>> Hi,
>>
>> =20
>>
>> I'm a newbie for linux device driver development.
>>
>> We have a custom ppc405 board which has MCP23S17
>>
>> (16-Bit I/O Expander with SPI Interface) on it.
>>
>> I noticed that current kernel has MCP23S08 driver
>>
>> support, I'd like to know:
>>
>> 1. if passing platform data to MCP23S08 driver, can it make
>>
>>    MCP23S17 work?
>>
>=20
> These chips should be same vendor product so I think 16-bit mcp23s17 =
may be
> compatible to 8-bit modes. But you have to check the data sheet to =
confirm this
> and track how to configure that as 8-bit mode. After that it's =
possible to run
> mcp23s17 with mcp23s08.c.
>=20
>> 2. Generally, I'd like to know how to pass platform data to
>>
>>    a particular device driver. In my mind, platform data should
>>
>>    not be in driver code, right? However, I don't know where is
>=20
> Firstly you should define this on your dts. Then parse that to =
register
> corresponding of_platform_device or platform_device when you setup =
your target
> on <your target>.c.
>=20
> When spi_register_driver prober successfully, you can get the =
platform_data from
> associated spi device.
>=20
>>    the suitable place to pass platform data to driver.
>>
>> 3. How to describe this in dts file?
>>
>=20
> You can get more from the file, =
Documentation/powerpc/dts-bindings/spi-bus.txt.
> Or refer to those existed spi nodes on other platform dts.
>=20
> Tiejun
>=20
>> =20
>>
>> Thanks in advance,
>>
>> YiFei
>>
>>
>>
>>
