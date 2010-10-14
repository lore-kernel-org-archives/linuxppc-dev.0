Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id AA224B6EF7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 16:01:09 +1100 (EST)
Message-ID: <4CB68F14.8070804@windriver.com>
Date: Thu, 14 Oct 2010 13:03:16 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: WANG YiFei <yifei_wang@hotmail.com>
Subject: Re: ppc405 + MCP23S17
References: <BAY158-ds7DB18D88ED851794F4E19F5540@phx.gbl>
	<4CB522D1.5090802@windriver.com>
	<BAY158-ds2BEE228C7E27E7CE0C28BF5550@phx.gbl>
	<4CB56496.7040809@windriver.com>
	<BAY158-ds774A2E0B753853E1C0CF0F5550@phx.gbl>
In-Reply-To: <BAY158-ds774A2E0B753853E1C0CF0F5550@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

WANG YiFei wrote:
> Hi TieJun,
> 
> I saw you name in \arch\powerpc\boot\cuboot-kilauea.c,
> I think I found right person for help, since our board

Unfortunately I'm not do anything for SPI resided on Kilauea.

> is based on Kilauea evaluation board, and currently I
> used 40x/kilauea_defconfig to config kernel. Also I used
> Kilauea.dts as starting point to modify as shown in my
> previous email.
> As you know, Kilauea board doesn't have any spi devices
> on spi bus, however, our board has an mcp23s17 on it. So
> far, I didn't add/change kernel/driver code. Looking at
> mcp23s08.c's probe() routine:
> 
> static int mcp23s08_probe(struct spi_device *spi)
> {
> 	struct mcp23s08_platform_data	*pdata;
> 	unsigned			addr;
> 	unsigned			chips = 0;
> 	struct mcp23s08_driver_data	*data;
> 	int				status;
> 	unsigned			base;
> 
> 	pdata = spi->dev.platform_data;
> 	if (!pdata || !gpio_is_valid(pdata->base)) {
> 		dev_dbg(&spi->dev, "invalid or missing platform data\n");
> 		return -EINVAL;
> 	}
> ......
> 
> Obviously, if I don't pass any platform_data to mcp23s08 device,
> it will always fail. That means this mcp23s08 driver always needs
> a platform_data to associate with, I don't know if this is the correct
> behavior. Anyway, so my question is: is my modified dts files(as in
> previous email) correct? what info else do I need to add in to support

The dts should be depended what are used for mcp23s07 at last.

Actually I think you can register spi_board_info with some corresponding
information firstly to begin debugging your driver. When you can run your spi
driver successfully, then generate the real dts according to those appropriate
parameters and implement one parsing hook converted dts info to
spi_board_info/platform_data.

> platform_data in dts file? Or if this dts is correct, then where is the

You should provide one struct mcp23s08_platform_data. But maybe some fields are
not necessary so you should check what are needed by pdata of your mcp23s08_probe().

> right place(which .c file) to set/pass platform_data to?

You can create the file, arch/powerpc/sysdev/ppc4xx_spi.c, like ppc4xx_gpio.c.
As I pointed previously you should check the example file, I think you can refer
to the file, arch/powerpc/platforms/83xx/mpc832x_rdb.c. There is one example to
show how to parse dts to register spi_board_info.

Tiejun

> 
> 
> Regards,
> YiFei
> 
> 
> -----Original Message-----
> From: tiejun.chen [mailto:tiejun.chen@windriver.com] 
> Sent: Wednesday, 13 October, 2010 3:50 PM
> To: WANG YiFei
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: ppc405 + MCP23S17
> 
> WANG YiFei wrote:
>> Hi TieJun,
>>
>> Thanks a lot for your reply.
>> So far, I can get ppc405 spi to initialize, however
>> failed at MCP23S17's probe() routine, I checked the
>> code, it's due to un-initialized platform data. Here
>> is my part of dts:
>>
>> 	spi@ef600600 {
>> 		device_type = "spi";
>> 		compatible = "ibm,ppc4xx-spi", "ibm,spi";
>> 		reg = <0xef600600 0x7>;
>> 		interrupt-parent = <0x2>;
>> 		interrupts = <0x8 0x4>;
>> 		#address-cells = <0x1>;
>> 		#size-cells = <0x0>;
>> 		gpios = <0>;    	/* cs */
>> 		
>> 		spi_gpio@0 {
>> 			compatible = "mcp,mcp23s08";
>> 			spi-max-frequency = <1000000>;
>> 			reg = <0>;
>> 		};
>> 	};
>>
>> I don't know how to provide platform data from dts although
>> I understand the concept from code. Do I only need to modify
>> dts OR I need to write some code to supply platform data? Do
>> you have any URL or sample code to show passing of platform
>> data?
> 
> Often you SPI bus driver should call spi_register_master() to register your SPI
> master controller. Then please go to the following path:
> ======
> spi_register_master()
> 	|
> 	+ scan_boardinfo()
> 		|
> 		+ spi_new_device()
> 			^
> 			Here refer to the function,
> ------
> struct spi_device *spi_new_device(struct spi_master *master,
>                                   struct spi_board_info *chip)
> {
> 	struct spi_device       *proxy;
> 	......
> 	proxy->dev.platform_data = (void *) chip->platform_data;
> 	......
> 	status = spi_add_device(proxy);
> 	......
> 
> And as I previously comment 'spi->dev.platform_data' would be passed to your
> platform_data resided in your probe hook within your spi device driver.
> 
> So firstly you should register call spi_register_board_info() to register one
> given spi_board_info by parsing your device nodes from your dts.
> 
> I think you can refer to the file, arch/powerpc/platforms/83xx/mpc832x_rdb.c.
> 
>> Anyway, thanks a lot for guiding me.
> 
> You're welcome :)
> 
> Tiejun
> 
>> YiFei
>>
>> -----Original Message-----
>> From: tiejun.chen [mailto:tiejun.chen@windriver.com] 
>> Sent: Wednesday, October 13, 2010 11:09 AM
>> To: WANG YiFei
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: ppc405 + MCP23S17
>>
>> WANG YiFei wrote:
>>> Hi,
>>>
>>>  
>>>
>>> I'm a newbie for linux device driver development.
>>>
>>> We have a custom ppc405 board which has MCP23S17
>>>
>>> (16-Bit I/O Expander with SPI Interface) on it.
>>>
>>> I noticed that current kernel has MCP23S08 driver
>>>
>>> support, I'd like to know:
>>>
>>> 1. if passing platform data to MCP23S08 driver, can it make
>>>
>>>    MCP23S17 work?
>>>
>> These chips should be same vendor product so I think 16-bit mcp23s17 may be
>> compatible to 8-bit modes. But you have to check the data sheet to confirm this
>> and track how to configure that as 8-bit mode. After that it's possible to run
>> mcp23s17 with mcp23s08.c.
>>
>>> 2. Generally, I'd like to know how to pass platform data to
>>>
>>>    a particular device driver. In my mind, platform data should
>>>
>>>    not be in driver code, right? However, I don't know where is
>> Firstly you should define this on your dts. Then parse that to register
>> corresponding of_platform_device or platform_device when you setup your target
>> on <your target>.c.
>>
>> When spi_register_driver prober successfully, you can get the platform_data from
>> associated spi device.
>>
>>>    the suitable place to pass platform data to driver.
>>>
>>> 3. How to describe this in dts file?
>>>
>> You can get more from the file, Documentation/powerpc/dts-bindings/spi-bus.txt.
>> Or refer to those existed spi nodes on other platform dts.
>>
>> Tiejun
>>
>>>  
>>>
>>> Thanks in advance,
>>>
>>> YiFei
>>>
>>>
>>>
>>>
> 
> 
