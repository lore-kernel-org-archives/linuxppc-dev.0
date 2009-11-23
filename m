Return-Path: <albert_herranz@yahoo.es>
Received: from smtp107.mail.ukl.yahoo.com (smtp107.mail.ukl.yahoo.com
	[77.238.184.39]) by ozlabs.org (Postfix) with SMTP id E932DB6F09
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:54:15 +1100 (EST)
Message-ID: <4B0AE865.4030502@yahoo.es>
Date: Mon, 23 Nov 2009 20:54:13 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
In-Reply-To: <fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Sun, Nov 22, 2009 at 3:01 PM, Albert Herranz <albert_herranz@yahoo.es> wrote:
>> Add a device tree source file for the Nintendo Wii video game console.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> 
> Same comments apply here as for the gamecube.dts file, plus a few more below.
> 

Ok, I'll try to address them too here.

>> ---
>>  arch/powerpc/boot/dts/wii.dts |  244 +++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 244 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/wii.dts
>>
>> diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
>> new file mode 100644
>> index 0000000..a30a804
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/wii.dts
>> @@ -0,0 +1,244 @@
>> +/*
>> + * arch/powerpc/boot/dts/wii.dts
>> + *
>> + * Nintendo Wii platform device tree source
>> + * Copyright (C) 2008-2009 The GameCube Linux Team
>> + * Copyright (C) 2008,2009 Albert Herranz
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/memreserve/ 0x01800000 0xe800000;     /* memory hole (includes I/O area) */
>> +/memreserve/ 0x10000000 0x0004000;     /* DSP RAM */
> 
> This bothers me... see below.
> 
>> +
>> +/ {
>> +       model = "NintendoWii";
>> +       compatible = "nintendo,wii";
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       chosen {
>> +               /* root filesystem on 2nd partition of SD card */
>> +               bootargs = "nobats root=/dev/mmcblk0p2 rootwait udbg-immortal";
>> +               linux,stdout-path = &USBGECKO0;
>> +       };
>> +
>> +       aliases {
>> +               ugecon = &USBGECKO0;
>> +               hw_gpio = &gpio1;
>> +       };
>> +
>> +       /*
>> +        * The Nintendo Wii has two discontiguous RAM memory areas called
>> +        * MEM1 and MEM2.
>> +        * MEM1 starts at 0x00000000 and contains 24MB of 1T-SRAM.
>> +        * MEM2 starts at 0x10000000 and contains 64MB of DDR2 RAM.
>> +        * Between both memory address ranges there is an address space
>> +        * where memory-mapped I/O registers are found.
>> +        *
>> +        * Currently, Linux 32-bit PowerPC does not support RAM in
>> +        * discontiguous memory address spaces. Thus, in order to use
>> +        * both RAM areas, we declare as RAM the range from the start of
>> +        * MEM1 to the end of useable MEM2 and exclude the needed parts
>> +        * with /memreserve/ statements, at the expense of wasting a bit
>> +        * of memory.
> 
> Hmmm.  It's not great practice to lie about hardware in the device
> tree.  Better to describe the memory correctly here, and if you have
> to work around Linux deficiencies, then do so in the platform support
> code (arch/platforms/*).  I won't NAK the patch over it (feel free to
> add my Acked-by line) because it doesn't impact other platforms, but
> it should be fixed.
> 

I'll try to workaround the limitation via a fixups function in the bootwrapper instead.

>> +               i2c-video {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "virtual,i2c-gpio";
> 
> There isn't a documented binding for this.  Is there a driver for it?
> 

I have a driver for it. But it isn't yet published.

This is the documentation I wrote so far for the bindings.
Is there a standard for this?

Documentation/powerpc/dts-bindings/gpio/i2c.txt

GPIO-based I2C

Required properties:
- compatible : should be "virtual,i2c-gpio".
- gpios : should specify GPIOs used for SDA and SCL lines, in that order.
- sda-is-open-drain : should be non-zero if SDA gpio is open-drain.
- sda-enforce-dir : should be non-zero if SDA gpio must be configured for
                    input before reading and for output before writing.
- scl-is-open-drain : should be non-zero if SCL gpio is open-drain.
- scl-is-output-only : should be non-zero if SCL is an output gpio only.
- udelay : signal toggle delay. SCL frequency is (500 / udelay) kHz
- timeout : clock stretching timeout in milliseconds.

Example:

gpio0: hollywood-gpio@0d8000c0 {
        compatible = "nintendo,hollywood-gpio";
        reg = <0x0d8000c0 0x20>;
        gpio-controller;
        #gpio-cells = <2>;
 };

i2c-video {
        #address-cells = <1>;
        #size-cells = <0>;
        compatible = "virtual,i2c-gpio";

        gpios = <&gpio0 16 0    /* SDA line */
                 &gpio0 17 0    /* SCL line */
                >;
        sda-is-open-drain = <1>;
        sda-enforce-dir = <1>;
        scl-is-open-drain = <1>;
        scl-is-output-only = <1>;
        udelay = <2>;

        audio-video-encoder {
                compatible = "nintendo,wii-ave-rvl";
                reg = <0x70>;
        };
};

>> +
>> +                       gpios = <&gpio0  16 0 /* 31-15 */
>> +                                &gpio0  17 0 /* 31-14 */
>> +                               >;
>> +                       sda-is-open-drain = <1>;
>> +                       sda-enforce-dir = <1>;
>> +                       scl-is-open-drain = <1>;
>> +                       scl-is-output-only = <1>;
>> +                       udelay = <2>;
>> +
>> +                       audio-video-encoder {
>> +                               compatible = "nintendo,wii-ave-rvl";
>> +                               reg = <0x70>;
>> +                       };
>> +               };
>> +       };
>> +};
>> +

Cheers,
Albert
