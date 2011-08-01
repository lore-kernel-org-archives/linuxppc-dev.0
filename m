Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id 7005FB70B1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 15:31:00 +1000 (EST)
Date: Mon, 01 Aug 2011 07:30:50 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 2/4] powerpc, mpc52xx: add a4m072 board support
In-reply-to: <20110731040819.GM24334@ponder.secretlab.ca>
To: Grant Likely <grant.likely@secretlab.ca>
Message-id: <4E363A0A.7040109@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <1308729311-15375-3-git-send-email-hs@denx.de>
	<1308739150-31527-1-git-send-email-hs@denx.de>
	<20110731040819.GM24334@ponder.secretlab.ca>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
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
> On Wed, Jun 22, 2011 at 12:39:10PM +0200, Heiko Schocher wrote:
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> cc: Grant Likely <grant.likely@secretlab.ca>
>> cc: devicetree-discuss@ozlabs.org
>> cc: Wolfgang Denk <wd@denx.de>
>> cc: Wolfram Sang <w.sang@pengutronix.de>
>> ---
>> For this patchseries following patch is needed:
>>
>> http://patchwork.ozlabs.org/patch/91919/
>>
>> Grant? Do you have some comments on that patch?
>>
>> changes for v2:
>>   add comment from Wolfram Sang:
>>   use mpc5200.dtsi
>>
>>  arch/powerpc/boot/dts/a4m072.dts             |  172 ++++++++++++++++++++++++++
>>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>>  2 files changed, 173 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/powerpc/boot/dts/a4m072.dts
>>
>> diff --git a/arch/powerpc/boot/dts/a4m072.dts b/arch/powerpc/boot/dts/a4m072.dts
>> new file mode 100644
>> index 0000000..adb6746
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/a4m072.dts
>> @@ -0,0 +1,172 @@
>> +/*
>> + * a4m072 board Device Tree Source
>> + *
>> + * Copyright (C) 2011 DENX Software Engineering GmbH
>> + * Heiko Schocher <hs@denx.de>
>> + *
>> + * Copyright (C) 2007 Semihalf
>> + * Marian Balakowicz <m8@semihalf.com>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +
>> +/include/ "mpc5200b.dtsi"
> 
> Ah, I missed this follow up patch.  Yes, this is better.

;-)

>> +
>> +/ {
>> +	model = "anonymous,a4m072";
>> +	compatible = "anonymous,a4m072";

The customer don;t want, that his name appear, so I decided here,
to use "anonymous" ... what name should used here?

>> +
>> +	soc5200@f0000000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "fsl,mpc5200b-immr";
>> +		ranges = <0 0xf0000000 0x0000c000>;
>> +		reg = <0xf0000000 0x00000100>;
>> +		bus-frequency = <0>; /* From boot loader */
>> +		system-frequency = <0>; /* From boot loader */
>> +
>> +		cdm@200 {
>> +			fsl,ext_48mhz_en = <0x0>;
>> +			fsl,fd_enable = <0x01>;
>> +			fsl,fd_counters = <0xbbbb>;
> 
> Are these new properties documented?  They need to be.  Also,
> convention is to use '-' instead of '_' in property names.

Yes, see patch here:

>> For this patchseries following patch is needed:
>>
>> http://patchwork.ozlabs.org/patch/91919/

>> +		};
>> +
>> +		timer@600 {
>> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
>> +			reg = <0x600 0x80>;
>> +			interrupts = <1 9 0>;
>> +			fsl,has-wdt;
>> +		};
> 
> Isn't this node already in the mpc5200b.dtsi file?

Yes, you are right, remove this.

> Otherwise, this patch looks pretty good.

Thanks for your review! I wait for a comment on patch
http://patchwork.ozlabs.org/patch/91919/ from you and rework this
2 patches.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
