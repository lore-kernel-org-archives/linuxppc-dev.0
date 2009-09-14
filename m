Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9DCC6B7B3E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 23:57:51 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 2D213DDD04
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 23:57:50 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	DB38531A663
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 15:57:45 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.207.169])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KPY00L8NS49RVY0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 14 Sep 2009 15:57:45 +0200 (CEST)
Date: Mon, 14 Sep 2009 16:12:20 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board uc101
In-reply-to: <fa686aa40909140638r422db79aj7568f492163c5d96@mail.gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4AAE4F44.7080300@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4AADF94C.9040502@denx.de>
	<fa686aa40909140638r422db79aj7568f492163c5d96@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Grant,

Grant Likely wrote:
> Thanks for the patch.  Comments below.
> 
> g.
> 
> On Mon, Sep 14, 2009 at 2:05 AM, Heiko Schocher <hs@denx.de> wrote:
>> - serial Console on PSC1
>> - 64MB SDRAM
>> - MTD CFI Flash
>> - Ethernet FEC
>> - I2C with PCF8563 and Temp. Sensor ADM9240
>> - IDE support
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>> - based on:
>>  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next
>>
>> - checked with:
>>
>> $ ./scripts/checkpatch.pl 0001-mpc5200-support-for-the-MAN-mpc5200-based-board-uc1.patch
>> total: 0 errors, 0 warnings, 1622 lines checked
>>
>> 0001-mpc5200-support-for-the-MAN-mpc5200-based-board-uc1.patch has no obvious style problems and is ready for submission.
>> $
>>
>>  arch/powerpc/boot/dts/uc101.dts              |  312 ++++++
>>  arch/powerpc/configs/52xx/uc101_defconfig    | 1303 ++++++++++++++++++++++++++
> 
> I generally don't like board specific defconfigs unless there is a
> really compelling reason why it should be in the kernel tree.  Please
> add the stuff you need (as modules!) to mpc5200_defconfig.

OK, thanks for spotting this. I take a look how this works.

> g.
> 
>> diff --git a/arch/powerpc/boot/dts/uc101.dts b/arch/powerpc/boot/dts/uc101.dts
>> new file mode 100644
>> index 0000000..28e1c90
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/uc101.dts
>> @@ -0,0 +1,312 @@
>> +/*
>> + * uc101 board Device Tree Source
>> + *
>> + * Copyright (C) 2009 DENX Software Engineering GmbH
>> + * Heiko Schocher <hs@denx.de>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/ {
>> +       model = "man,uc101";
>> +       compatible = "man,uc101";
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       interrupt-parent = <&mpc5200_pic>;
>> +
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               PowerPC,5200@0 {
>> +                       device_type = "cpu";
>> +                       reg = <0>;
>> +                       d-cache-line-size = <32>;
>> +                       i-cache-line-size = <32>;
>> +                       d-cache-size = <0x4000>;        // L1, 16K
>> +                       i-cache-size = <0x4000>;        // L1, 16K
>> +                       timebase-frequency = <0>;       // from bootloader
>> +                       bus-frequency = <0>;            // from bootloader
>> +                       clock-frequency = <0>;          // from bootloader
>> +               };
>> +       };
>> +
>> +       memory {
>> +               device_type = "memory";
>> +               reg = <0x00000000 0x04000000>;  // 64MB
>> +       };
>> +
>> +       soc5200@f0000000 {
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               compatible = "fsl,mpc5200-immr";
>> +               ranges = <0 0xf0000000 0x0000c000>;
>> +               reg = <0xf0000000 0x00000100>;
>> +               bus-frequency = <0>;            // from bootloader
>> +               system-frequency = <0>;         // from bootloader
>> +
>> +               cdm@200 {
>> +                       compatible = "fsl,mpc5200-cdm";
>> +                       reg = <0x200 0x38>;
>> +               };
>> +
>> +               mpc5200_pic: interrupt-controller@500 {
>> +                       // 5200 interrupts are encoded into two levels;
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <3>;
>> +                       compatible = "fsl,mpc5200-pic";
>> +                       reg = <0x500 0x80>;
>> +                       interrupts = <0 0 3>;
>> +               };
>> +
>> +               gpt1: timer@610 {       // General Purpose Timer 1 in GPIO mode
>> +                       compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
>> +                       reg = <0x610 0x10>;
>> +                       interrupts = <1 10 0>;
>> +                       gpio-controller;
>> +               };
>> +
>> +               gpt2: timer@620 {       // General Purpose Timer 2 in GPIO mode
>> +                       compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
>> +                       reg = <0x620 0x10>;
>> +                       interrupts = <1 11 0>;
>> +                       gpio-controller;
>> +               };
>> +
>> +               gpt3: timer@630 {       // General Purpose Timer 3 in GPIO mode
>> +                       compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
>> +                       reg = <0x630 0x10>;
>> +                       interrupts = <1 12 0>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +               };
>> +
>> +               gpio_simple: gpio@b00 {
>> +                       compatible = "fsl,mpc5200-gpio";
>> +                       reg = <0xb00 0x40>;
>> +                       interrupts = <1 7 0>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +               };
>> +
>> +               gpio_wkup: gpio@c00 {
>> +                       compatible = "fsl,mpc5200-gpio-wkup";
>> +                       reg = <0xc00 0x40>;
>> +                       interrupts = <1 8 0 0 3 0>;
>> +                       gpio-controller;
>> +                       #gpio-cells = <2>;
>> +               };
>> +
>> +               dma-controller@1200 {
>> +                       device_type = "dma-controller";
>> +                       compatible = "fsl,mpc5200-bestcomm";
>> +                       reg = <0x1200 0x80>;
>> +                       interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
>> +                                     3 4 0  3 5 0  3 6 0  3 7 0
>> +                                     3 8 0  3 9 0  3 10 0  3 11 0
>> +                                     3 12 0  3 13 0  3 14 0  3 15 0>;
>> +               };
>> +
>> +               xlb@1f00 {
>> +                       compatible = "fsl,mpc5200-xlb";
>> +                       reg = <0x1f00 0x100>;
>> +               };
>> +
>> +               serial@2000 {           // PSC1
>> +                       compatible = "fsl,mpc5200-psc-uart";
>> +                       reg = <0x2000 0x100>;
>> +                       interrupts = <2 1 0>;
>> +               };
>> +
>> +               serial@2200 {           // PSC2
>> +                       compatible = "fsl,mpc5200-psc-uart";
>> +                       reg = <0x2200 0x100>;
>> +                       interrupts = <2 2 0>;
>> +               };
>> +
>> +               serial@2c00 {           // PSC6
>> +                       compatible = "fsl,mpc5200-psc-uart";
>> +                       reg = <0x2c00 0x100>;
>> +                       interrupts = <2 6 0>;
>> +               };
>> +
>> +               ethernet@3000 {
>> +                       compatible = "fsl,mpc5200-fec";
>> +                       reg = <0x3000 0x400>;
>> +                       local-mac-address = [ 00 00 00 00 00 00 ];
>> +                       interrupts = <2 5 0>;
>> +                       phy-handle = <&phy0>;
>> +               };
>> +
>> +               mdio@3000 {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "fsl,mpc5200-mdio";
>> +                       reg = <0x3000 0x400>;       // fec range, since we need to setup fec interrupts
>> +                       interrupts = <2 5 0>;   // these are for "mii command finished", not link changes & co.
>> +
>> +                       phy0: ethernet-phy@0 {
>> +                               reg = <0>;
> 
> For completeness, you should have a compatible property for the PHY
> here in the form "<vendor>,<part number>"

Ok, fix this.

>> +                       };
>> +               };
>> +
>> +               ata@3a00 {
>> +                       compatible = "fsl,mpc5200-ata";
>> +                       reg = <0x3a00 0x100>;
>> +                       interrupts = <2 7 0>;
>> +               };
>> +
>> +               i2c@3d40 {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       compatible = "fsl,mpc5200-i2c","fsl-i2c";
>> +                       reg = <0x3d40 0x40>;
>> +                       interrupts = <2 16 0>;
>> +                       fsl5200-clocking;
> 
> I believe fsl5200-clocking is no longer required.  There is a patch
> pending which removes this property from the other .dts files.

Ok, fix this.

>> +
>> +                       hwmon@2c {
>> +                               compatible = "ad,adm9240";
>> +                               reg = <0x2c>;
>> +                       };
>> +                       rtc@51 {
>> +                               compatible = "rtc,pcf8563";
>> +                               reg = <0x51>;
>> +                       };
>> +               };
>> +
>> +               sram@8000 {
>> +                       compatible = "fsl,mpc5200-sram";
>> +                       reg = <0x8000 0x4000>;
>> +               };
>> +
>> +       };
>> +
>> +       localbus {
>> +               compatible = "fsl,mpc5200-lpb","simple-bus";
>> +               #address-cells = <2>;
>> +               #size-cells = <1>;
>> +               ranges = <0 0 0xff800000 0x00800000
>> +                         1 0 0x80000000 0x00800000
>> +                         3 0 0x80000000 0x00800000>;
>> +
>> +               flash@0,0 {
>> +                       compatible = "cfi-flash";
>> +                       reg = <0 0 0x00800000>;
>> +                       bank-width = <2>;
>> +                       device-width = <2>;
>> +                       #size-cells = <1>;
>> +                       #address-cells = <1>;
>> +                       partition@0 {
>> +                               label = "DTS";
>> +                               reg = <0x0 0x00100000>;
>> +                       };
>> +                       partition@100000 {
>> +                               label = "Kernel";
>> +                               reg = <0x100000 0x00200000>;
>> +                       };
>> +                       partition@300000 {
>> +                               label = "RootFS";
>> +                               reg = <0x00300000 0x00200000>;
>> +                       };
>> +
>> +                       partition@500000 {
>> +                               label = "user";
>> +                               reg = <0x00500000 0x00200000>;
>> +                       };
>> +                       partition@700000 {
>> +                               label = "U-Boot";
>> +                               reg = <0x00700000 0x00040000>;
>> +                       };
>> +                       partition@740000 {
>> +                               label = "Env";
>> +                               reg = <0x00740000 0x00010000>;
>> +                       };
>> +                       partition@750000 {
>> +                               label = "red. Env";
>> +                               reg = <0x00750000 0x00010000>;
>> +                       };
>> +                       partition@760000 {
>> +                               label = "reserve";
>> +                               reg = <0x00760000 0x000a0000>;
>> +                       };
>> +               };
>> +
>> +               sram@1,0 {
>> +                       compatible = "sram";
>> +                       reg = <1 0x100000 0x100000>;
>> +               };
>> +
>> +               gpio-controller-100@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
> 
> Here I see "manroland", but the top level model and compatible
> properties use "man".  Which should it be (I suspect "manroland" is a
> better choice).

You are right, I change this too "manroland".

>> +                               reg = <3 0x00600100 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-104@3,0 {
> 
> These names should be:
> gpio-controller@3,600100
> gpio-controller@3,600104
> gpio-controller@3,600201
> 
> etc.

OK, fix this.

>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600104 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-200@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600200 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-201@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600201 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-202@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600202 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-203@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600203 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-204@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600204 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-206@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600206 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-207@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x00600207 0x1>;
>> +                               gpio-controller;
>> +               };
>> +               gpio-controller-20f@3,0 {
>> +                               #gpio-cells = <2>;
>> +                               compatible = "manroland,mucmc52-aux-gpio";
>> +                               reg = <3 0x0060020f 0x1>;
>> +                               gpio-controller;
>> +               };
>> +
>> +               display@3,0 {
> 
> similarly, this should be display@3,600000

Ok.

>> +                               device_type = "pdsp-display";
> 
> Drop device_type

Ok.

>> +                               compatible = "pdsp-display";
> 
> No vendor prefix?

I take a look at this.

>> +                               reg = <3 0x00600000 0x1000>;
>> +               };
>> +       };
>> +
>> +};

Thanks for reviewing this patch

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
