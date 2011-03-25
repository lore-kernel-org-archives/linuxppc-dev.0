Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail2.matrix-vision.com (mail2.matrix-vision.com
	[85.214.244.251])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "template", Issuer "template" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7CB5E100800
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2011 20:36:32 +1100 (EST)
Message-ID: <4D8C603F.6060501@matrix-vision.de>
Date: Fri, 25 Mar 2011 10:28:31 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: How to define an I2C-to-SPI bridge device ?
References: <1283502979.17812.22.camel@swa-m460>	<20100903120858.GA19380@oksana.dev.rtsoft.ru>	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
In-Reply-To: <c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant, Anton,

>>> we're about to get new MPC8377 based hardware with various peripherals.
>>>> There are two I2C-to-SPI bridge devices (NXP SC18IS602) and I'm not sure
>>>> how to define a proper dts...
>>>>
>>>> Of course it's an easy thing creating 2 child nodes on the CPU's I2C
>>>> device - but how can I represent the created SPI bus ?
>>> Um.. the same as the other SPI buses? I.e.
>>>
>>> i2c-controller {  /* SOC I2C controller */
>>> 	spi-controller {  /* The I2C-to-SPI bridge */
>>> 		spi-device@0 {
>>> 		};
>>> 		spi-device@1 {
>>> 		};
>>> 	};
>>> };
>>>
>> ok , thanks - looks straight forward.
>> Is this any more than plain definition, i.e. will this trigger any I2C
>> or SPI device registration/linking ?
>>>> Is the (possibly) required driver (of_sc18is60x_spi ?) supposed to be an
>>>> I2C slave or an SPI host driver ?
>>> It should be an I2C driver that registers an SPI master (i.e.
>>> calls spi_alloc_master() and spi_register_master()).
>> hmm - ok. Will have to do it manually then ...
> Yes, but this is the case for non-of drivers too.  The i2c to spi device driver must always create (and trigger population of) the spi bus instance.
>

I've kicked that I2C-to-SPI stuff completely because it's been too slow.
We've connected the SPI busses to the FPGA controlling almost everything 
now.

Unfortunately there are some questions left :

Following Anton's suggestion I've had a look at /drivers/mfd (sm501.c) 
and implemented a pci driver for the FPGA using
subdevices for additional functionality it exports - besides others we 
now have 2 SPI masters.

For both SPI masters I have created and registered a platform_device.
pdev->dev is then fed into spi_alloc_master() and the resulting master 
goes into spi_register_master().

master->bus_num is set to 0 and 1, i.e. no dynamic numbering.
master->chipselect = 8;

Since I can probe the SPI device using FPGA intrinsic information I 
decided to register the client
devices on runtime using a "struct spi_board_info" which is fed into 
spi_new_device().

The current design has 2 clients on SPI-0 and 5 clients on SPI-1.

static struct spi_board_info mergerbox_spi_boardinfo[] = {
         {       .bus_num = 0,
                 .chip_select = 0,
                 .max_speed_hz = 4<<20, },
         {       .bus_num = 0,
                 .chip_select = 1,
                 .max_speed_hz = 4<<20, },
         {       .bus_num = 1,
                 .chip_select = 0,
                 .max_speed_hz = 4<<20, },
.....


After loading my module I get :

#> ls /sys/devices/platform/AlteraSPI.0/
/sys/devices/platform/AlteraSPI.0/modalias
/sys/devices/platform/AlteraSPI.0/spi0.0/
/sys/devices/platform/AlteraSPI.0/spi0.1/
/sys/devices/platform/AlteraSPI.0/spi_master/
/sys/devices/platform/AlteraSPI.0/subsystem/
/sys/devices/platform/AlteraSPI.0/uevent

#> ls /sys/devices/platform/AlteraSPI.1/
/sys/devices/platform/AlteraSPI.1/modalias
/sys/devices/platform/AlteraSPI.1/spi1.0/
/sys/devices/platform/AlteraSPI.1/spi1.1/
/sys/devices/platform/AlteraSPI.1/spi1.2/
/sys/devices/platform/AlteraSPI.1/spi1.3/
/sys/devices/platform/AlteraSPI.1/spi1.4/
/sys/devices/platform/AlteraSPI.1/spi_master/
/sys/devices/platform/AlteraSPI.1/subsystem/
/sys/devices/platform/AlteraSPI.1/uevent

What I'm missing are the /dev/spi* entries.

There's also a spi_mpc8xxx driver using the CPU's SPI controller.
It is configured by dts (2 devices) and uses dynamic bus numbering:

#> ls /sys/bus/spi/devices/
spi0.0      spi1.0      spi1.2      spi1.4      spi32766.1
spi0.1      spi1.1      spi1.3      spi32766.0

This devices are processed by spidev and proper entries are created 
ready for use :

#> ls /dev/spi*
/dev/spidev32766.0  /dev/spidev32766.1


Am I missing somehting obvious ?

Since there's no driver registration we don't have a probe function - is 
this a problem regarding device binding ?

Do I need to use the .modalias in "struct spi_board_info" ?


Any help is welcome.

Regards,
André

MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
