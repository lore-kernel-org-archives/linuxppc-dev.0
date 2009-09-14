Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27E68B7B6D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 00:18:23 +1000 (EST)
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id 5A0E3DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 00:18:22 +1000 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by b.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	764FC31A3F3
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 16:18:20 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.207.169])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KPY00LXFT2KRTY0@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 14 Sep 2009 16:18:20 +0200 (CEST)
Date: Mon, 14 Sep 2009 16:32:54 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] mpc5200: support for the MAN mpc5200 based board mucmc52
In-reply-to: <fa686aa40909140643j3183e181x49be002941ae5c36@mail.gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4AAE5416.3040908@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4AADF93C.3030604@denx.de>
	<fa686aa40909140643j3183e181x49be002941ae5c36@mail.gmail.com>
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
> Comments below.
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
>>
>>  arch/powerpc/boot/dts/mucmc52.dts            |  231 ++++
>>  arch/powerpc/configs/52xx/mucmc52_defconfig  | 1476 ++++++++++++++++++++++++++
> 
> Same comment as on your other patch.  Drop the defconfig and add the
> needed bits to mpc5200_defconfig (in a separate patch, and add drivers
> as modules).

Yep, thanks. I look, how this works.

>> diff --git a/arch/powerpc/boot/dts/mucmc52.dts b/arch/powerpc/boot/dts/mucmc52.dts
>> new file mode 100644
>> index 0000000..a4a7a20
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/mucmc52.dts
>> @@ -0,0 +1,231 @@
>> +/*
>> + * mucmc52 board Device Tree Source
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
>> +       model = "man,mucmc52";
>> +       compatible = "man,mucmc52";
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
> 
> Does this board use the older and rarer non-'B' mpc5200 part?  If not,
> then fsl,mpc5200b-immr also needs to be in this list.

OK, I add this too

Thanks

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
