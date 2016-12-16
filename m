Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg9BY61tvzDwBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 23:49:57 +1100 (AEDT)
Subject: Re: [PATCH 3/3] powerpc/corenet: add support for the kmcent2 board
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "oss@buserror.net" <oss@buserror.net>
References: <1481808148-16840-1-git-send-email-valentin.longchamp@keymile.com>
 <1481808148-16840-4-git-send-email-valentin.longchamp@keymile.com>
 <1481810456.3878.18.camel@infinera.com>
From: Valentin Longchamp <valentin.longchamp@keymile.com>
Message-ID: <6434e151-6f35-d11c-c7aa-f221279fd6c8@keymile.com>
Date: Fri, 16 Dec 2016 13:49:43 +0100
MIME-Version: 1.0
In-Reply-To: <1481810456.3878.18.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15/12/16 15:00, Joakim Tjernlund wrote:
> On Thu, 2016-12-15 at 14:22 +0100, Valentin Longchamp wrote:
>> This board is built around Freescale's T1040 SoC.
>>
>> The peripherals used by this design are:
>> - DDR3 RAM with SPD support
>> - parallel NOR Flash as boot medium
>> - 1 PCIe bus (PCIe1 x1)
>> - 3 FMAN Ethernet devices (FMAN1 DTSEC1/2/5)
>> - 4 IFC bus devices:
>>   - NOR flash
>>   - NAND flash
>>   - QRIO reset/power mgmt CPLD
>>   - BFTIC chassis management CPLD
>> - 2 I2C buses
>> - 1 SPI bus
>> - HDLC bus with the QE's UCC1
>> - last but not least, the mandatory serial port
>>
>> The board can be used with the corenet32_smp_defconfig.
>>
>> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
>> ---
>>  arch/powerpc/boot/dts/fsl/kmcent2.dts         | 303 ++++++++++++++++++++++++++
>>  arch/powerpc/platforms/85xx/corenet_generic.c |   1 +
>>  2 files changed, 304 insertions(+)
>>  create mode 100644 arch/powerpc/boot/dts/fsl/kmcent2.dts
>>
>> diff --git a/arch/powerpc/boot/dts/fsl/kmcent2.dts b/arch/powerpc/boot/dts/fsl/kmcent2.dts
>> new file mode 100644
>> index 0000000..47afa43
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/fsl/kmcent2.dts
>> @@ -0,0 +1,303 @@
>> +/*
>> + * Keymile kmcent2 Device Tree Source, based on T1040RDB DTS
>> + *
>> + * (C) Copyright 2016
>> + * Valentin Longchamp, Keymile AG, valentin.longchamp@keymile.com
>> + *
>> + * Copyright 2014 - 2015 Freescale Semiconductor Inc.
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
> 
> [SNIP]
> 
>> +
>> +		ucc_hdlc: ucc@2000 {
>> +			device_type = "hdlc";
>> +			compatible = "fsl,ucc-hdlc";
>> +			rx-clock-name = "clk9";
>> +			tx-clock-name = "clk9";
> 
> Should it be clk9 on both tx and rx clock?
> 

Yeah, why not ? The bus clock is generated somewhere else and is connected to
the clk9 input. Or maybe have I not understood your question ?
