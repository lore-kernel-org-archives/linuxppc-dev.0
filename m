Return-Path: <albert_herranz@yahoo.es>
Received: from smtp145.mail.ukl.yahoo.com (smtp145.mail.ukl.yahoo.com
	[77.238.184.76]) by ozlabs.org (Postfix) with SMTP id 9BCDEB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Nov 2009 06:44:06 +1100 (EST)
Message-ID: <4B0AE603.9050208@yahoo.es>
Date: Mon, 23 Nov 2009 20:44:03 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
In-Reply-To: <fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
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
>> Add a device tree source file for the Nintendo GameCube video game console.
>>
>> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
> 
> Mostly looks good.  A few comments below.  Biggest comment is you need
> to add a brief blurb for every new "compatible" property value that
> you've added to Documentation/powerpc/dts-bindings.  General agreement
> is that we don't merge drivers with new OF tree bindings unless the
> binding is also documented.  It doesn't need to be long, it just needs
> to state what the device is, and what properties are expected.  If you
> define new properties, then you need to state what they are used for.
> 
> Once the comments below are addressed...
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 

Thanks. I'll add the documentation for the new compatible properties.

>> ---
>>  arch/powerpc/boot/dts/gamecube.dts |  135 ++++++++++++++++++++++++++++++++++++
>>  1 files changed, 135 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/gamecube.dts
>>
>> diff --git a/arch/powerpc/boot/dts/gamecube.dts b/arch/powerpc/boot/dts/gamecube.dts
>> new file mode 100644
>> index 0000000..941a2c4
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/gamecube.dts
>> @@ -0,0 +1,135 @@
>> +/*
>> + * arch/powerpc/boot/dts/gamecube.dts
>> + *
>> + * Nintendo GameCube platform device tree source
>> + * Copyright (C) 2007-2009 The GameCube Linux Team
>> + * Copyright (C) 2007,2008,2009 Albert Herranz
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
>> +/ {
>> +       model = "NintendoGameCube";
>> +       compatible = "nintendo,gamecube";
> 
> To date, we've been using the same form for both the model and
> compatible properties.  Specifically the <vendor>,<model> form to
> maintain the namespace.
> 

Ok, I'll change model to "nintendo,gamecube".

>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +
>> +       chosen {
>> +               bootargs = "root=/dev/gcnsda2 rootwait udbg-immortal";
>> +               linux,stdout-path = &USBGECKO0;
>> +       };
>> +
>> +       aliases {
>> +               ugecon = &USBGECKO0;
>> +       };
>> +
>> +       memory {
>> +               device_type = "memory";
>> +               /* 24M minus framebuffer memory area (640*576*2*2) */
>> +               reg = <0x00000000 0x01698000>;
>> +       };
>> +
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               PowerPC,gekko@0 {
>> +                       device_type = "cpu";
>> +                       reg = <0>;
>> +                       clock-frequency = <486000000>; /* 486MHz */
>> +                       bus-frequency = <162000000>; /* 162MHz core-to-bus 3x */
>> +                       timebase-frequency = <40500000>; /* 162MHz / 4 */
>> +                       i-cache-line-size = <32>;
>> +                       d-cache-line-size = <32>;
>> +                       i-cache-size = <32768>;
>> +                       d-cache-size = <32768>;
>> +               };
>> +       };
>> +
>> +       /* devices contained int the flipper chipset */
>> +       soc {
> 
> It would be better to rename this as IMMR or the bus type.  This node
> doesn't actually describe the entire chip, but describes the internal
> memory mapped registers.
> 

Can you please elaborate more on this or point me to documentation?
The soc node here tries to represent the big multi-function chip that integrates most of the devices of the video game consoles ("Flipper" on the Nintendo GameCube and "Hollywood" on the Wii).

>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               #interrupt-cells = <1>;
>> +               model = "flipper";
> 
> Drop the model property
> 

Ok, I'll fix that.

>> +               compatible = "nintendo,flipper";
>> +               clock-frequency = <162000000>; /* 162MHz */
>> +               ranges = <0x0c000000 0x0c000000 0x00010000>;
> 
> Since you're only doing 1:1 mappings; you could replace this with an
> empty "ranges;" property instead.
> 

Nice, didn't know about this. I'll do that.

>> +
>> +               video@0c002000 {
>> +                       compatible = "nintendo,flipper-video";
>> +                       reg = <0x0c002000 0x100>;
>> +                       interrupts = <8>;
>> +                       interrupt-parent = <&pic>;
> 
> Hint:  If you move the interrupt-parent property up to the root node,
> then you don't need to specify it in every single device node; it will
> just inherit from the parent.
> 

Got it. This makes a lot of sense here with a single interrupt controller.

>> +                       /* XFB is the eXternal FrameBuffer */
>> +                       xfb-start = <0x01698000>; /* end-of-ram - xfb-size */
>> +                       xfb-size = <0x168000>;
> 
> Can 'xfb' be made a second tuple to the 'reg' property so that all the
> address mapping code works on it?  ie:
> 
> reg = <0x0c002000 0x100
>        0x01698000 0x168000>;
> 
> At the very least, it is wise to adopt the same form as the reg
> property when describing address ranges instead of splitting it into
> multiple properties.
> 

I'll look into moving xfb-* into the reg property.

>> +               };
>> +
>> +               pic: pic@0c003000 {
>> +                       #interrupt-cells = <1>;
>> +                       compatible = "nintendo,flipper-pic";
>> +                       reg = <0x0c003000 0x8>;
>> +                       interrupt-controller;
>> +               };
>> +
>> +               resetswitch@0c003000 {
>> +                       compatible = "nintendo,flipper-resetswitch";
>> +                       reg = <0x0c003000 0x4>;
>> +                       interrupts = <1>;
>> +                       interrupt-parent = <&pic>;
>> +               };
>> +
>> +               auxram@0c005000 {
>> +                       compatible = "nintendo,flipper-auxram";
>> +                       reg = <0x0c005000 0x200>;       /* DSP */
>> +                       interrupts = <6>;
>> +                       interrupt-parent = <&pic>;
>> +               };
>> +
>> +               audio@0c005000 {
>> +                       compatible = "nintendo,flipper-audio";
>> +                       reg = <0x0c005000 0x200         /* DSP */
>> +                              0x0c006c00 0x20>;        /* AI */
>> +                       interrupts = <6>;
>> +                       interrupt-parent = <&pic>;
>> +               };
>> +
>> +               disk@0c006000 {
>> +                       compatible = "nintendo,flipper-disk";
>> +                       reg = <0x0c006000 0x40>;
>> +                       interrupts = <2>;
>> +                       interrupt-parent = <&pic>;
>> +               };
>> +
>> +               serial@0c006400 {
>> +                       compatible = "nintendo,flipper-serial";
>> +                       reg = <0x0c006400 0x100>;
>> +                       interrupts = <3>;
>> +                       interrupt-parent = <&pic>;
>> +               };
>> +
>> +               /* External Interface bus */
>> +               exi@0c006800 {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       compatible = "nintendo,flipper-exi";
>> +                       reg = <0x0c006800 0x40>;
>> +                       interrupts = <4>;
>> +                       interrupt-parent = <&pic>;
>> +
>> +                       USBGECKO0: usbgecko@0c006814 {
>> +                               compatible = "usbgecko,usbgecko";
>> +                               reg = <0x0c006814 0x14>;
>> +                               virtual-reg = <0xcc006814>;
>> +                       };
>> +               };
>> +        };
>> +};
>> +

Cheers,
Albert
