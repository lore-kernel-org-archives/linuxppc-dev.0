Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 081D0B7BAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 15:59:32 +1000 (EST)
Message-ID: <4A8E37F4.60806@windriver.com>
Date: Fri, 21 Aug 2009 14:00:20 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/405ex: provide necessary fixup function to
	support cuImage
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<1250562484-16415-2-git-send-email-tiejun.chen@windriver.com>
	<20090820132644.GE2530@zod.rchland.ibm.com>
In-Reply-To: <20090820132644.GE2530@zod.rchland.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, Aug 18, 2009 at 10:28:03AM +0800, Tiejun Chen wrote:
>> For cuImage format it's necessary to provide clock fixups since u-boot will
>> not pass necessary clock frequency into the dtb included into cuImage so we 
>> implement the clock fixups as defined in the technical documentation for the 
>> board and update header file with the basic register definitions. 
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>> arch/powerpc/boot/4xx.c |  142 +++++++++++++++++++++++++++++++++++++++++++++++
>> arch/powerpc/boot/4xx.h |    1 +
>> arch/powerpc/boot/dcr.h |   12 ++++
>> 3 files changed, 155 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
>> index 325b310..b5561b3 100644
>> --- a/arch/powerpc/boot/4xx.c
>> +++ b/arch/powerpc/boot/4xx.c
>> @@ -8,6 +8,10 @@
>>  *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
>>  *   Copyright (c) 2003, 2004 Zultys Technologies
>>  *
>> + * Copyright (C) 2009 Wind River Systems, Inc.
>> + *   Updated for supporting PPC405EX on Kilauea.
>> + *   Tiejun Chen <tiejun.chen@windriver.com>
>> + *
>>  * This program is free software; you can redistribute it and/or
>>  * modify it under the terms of the GNU General Public License
>>  * as published by the Free Software Foundation; either version
>> @@ -659,3 +663,141 @@ void ibm405ep_fixup_clocks(unsigned int sys_clk)
>> 	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
>> 	dt_fixup_clock("/plb/opb/serial@ef600400", uart1);
>> }
>> +
>> +static u8 fwdv_multi_bits[] = {
>> +	/* values for:  1 - 16 */
>> +	0x01, 0x02, 0x0e, 0x09, 0x04, 0x0b, 0x10, 0x0d, 0x0c, 0x05,
>> +	0x06, 0x0f, 0x0a, 0x07, 0x08, 0x03
>> +};
>> +
>> +u32 get_fwdva(unsigned long cpr_fwdv)
>> +{
>> +	u32 index;
>> +
>> +	for (index = 0; index < ARRAY_SIZE(fwdv_multi_bits); index++)
>> +		if (cpr_fwdv == (u32)fwdv_multi_bits[index])
>> +			return index + 1;
>> +
>> +	return 0;
>> +}
>> +
>> +static u8 fbdv_multi_bits[] = {
>> +	/* values for:  1 - 100 */
>> +	0x00, 0xff, 0x7e, 0xfd, 0x7a, 0xf5, 0x6a, 0xd5, 0x2a, 0xd4,
>> +	0x29, 0xd3, 0x26, 0xcc, 0x19, 0xb3, 0x67, 0xce, 0x1d, 0xbb,
>> +	0x77, 0xee, 0x5d, 0xba, 0x74, 0xe9, 0x52, 0xa5, 0x4b, 0x96,
>> +	0x2c, 0xd8, 0x31, 0xe3, 0x46, 0x8d, 0x1b, 0xb7, 0x6f, 0xde,
>> +	0x3d, 0xfb, 0x76, 0xed, 0x5a, 0xb5, 0x6b, 0xd6, 0x2d, 0xdb,
>> +	0x36, 0xec, 0x59, 0xb2, 0x64, 0xc9, 0x12, 0xa4, 0x48, 0x91,
>> +	0x23, 0xc7, 0x0e, 0x9c, 0x38, 0xf0, 0x61, 0xc2, 0x05, 0x8b,
>> +	0x17, 0xaf, 0x5f, 0xbe, 0x7c, 0xf9, 0x72, 0xe5, 0x4a, 0x95,
>> +	0x2b, 0xd7, 0x2e, 0xdc, 0x39, 0xf3, 0x66, 0xcd, 0x1a, 0xb4,
>> +	0x68, 0xd1, 0x22, 0xc4, 0x09, 0x93, 0x27, 0xcf, 0x1e, 0xbc,
>> +	/* values for:  101 - 200 */
>> +	0x78, 0xf1, 0x62, 0xc5, 0x0a, 0x94, 0x28, 0xd0, 0x21, 0xc3,
>> +	0x06, 0x8c, 0x18, 0xb0, 0x60, 0xc1, 0x02, 0x84, 0x08, 0x90,
>> +	0x20, 0xc0, 0x01, 0x83, 0x07, 0x8f, 0x1f, 0xbf, 0x7f, 0xfe,
>> +	0x7d, 0xfa, 0x75, 0xea, 0x55, 0xaa, 0x54, 0xa9, 0x53, 0xa6,
>> +	0x4c, 0x99, 0x33, 0xe7, 0x4e, 0x9d, 0x3b, 0xf7, 0x6e, 0xdd,
>> +	0x3a, 0xf4, 0x69, 0xd2, 0x25, 0xcb, 0x16, 0xac, 0x58, 0xb1,
>> +	0x63, 0xc6, 0x0d, 0x9b, 0x37, 0xef, 0x5e, 0xbd, 0x7b, 0xf6,
>> +	0x6d, 0xda, 0x35, 0xeb, 0x56, 0xad, 0x5b, 0xb6, 0x6c, 0xd9,
>> +	0x32, 0xe4, 0x49, 0x92, 0x24, 0xc8, 0x11, 0xa3, 0x47, 0x8e,
>> +	0x1c, 0xb8, 0x70, 0xe1, 0x42, 0x85, 0x0b, 0x97, 0x2f, 0xdf,
>> +	/* values for:  201 - 255 */
>> +	0x3e, 0xfc, 0x79, 0xf2, 0x65, 0xca, 0x15, 0xab, 0x57, 0xae,
>> +	0x5c, 0xb9, 0x73, 0xe6, 0x4d, 0x9a, 0x34, 0xe8, 0x51, 0xa2,
>> +	0x44, 0x89, 0x13, 0xa7, 0x4f, 0x9e, 0x3c, 0xf8, 0x71, 0xe2,
>> +	0x45, 0x8a, 0x14, 0xa8, 0x50, 0xa1, 0x43, 0x86, 0x0c, 0x98,
>> +	0x30, 0xe0, 0x41, 0x82, 0x04, 0x88, 0x10, 0xa0, 0x40, 0x81,
>> +	0x03, 0x87, 0x0f, 0x9f, 0x3f  /* END */
>> +};
>> +
>> +u32 get_fbdv(unsigned long cpr_fbdv)
>> +{
>> +	u32 index;
>> +
>> +	for (index = 0; index < ARRAY_SIZE(fbdv_multi_bits); index++)
>> +		if (cpr_fbdv == (u32)fbdv_multi_bits[index])
>> +			return index + 1;
>> +
>> +	return 0;
>> +}
> 
> Is this generic?  Can we the function and value arrays to get the fbdv for
> all 4xx boards and have the right values pop out?  If not, then all of these
> need to be prefixed with ibm405ex_.
> 

Other 4xx boards have different fwdv_multi_bits[]/fbdv_multi_bits[] array as far
as I know. So I prefer to prefix with ibm405ex as you suggestion.

>> diff --git a/arch/powerpc/boot/dcr.h b/arch/powerpc/boot/dcr.h
>> index 95b9f53..ba41624 100644
>> --- a/arch/powerpc/boot/dcr.h
>> +++ b/arch/powerpc/boot/dcr.h
>> @@ -153,6 +153,18 @@ static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR,
>> #define DCRN_CPC0_PLLMR1  0xf4
>> #define DCRN_CPC0_UCR     0xf5
>>
>> +/* 405EX Clocking Control regs */
>> +#define CPR0_CLKUPD     0x0020
>> +#define CPR0_PLLC       0x0040
>> +#define CPR0_PLLD       0x0060
>> +#define CPR0_CPUD       0x0080
>> +#define CPR0_PLBD       0x00a0
>> +#define CPR0_OPBD       0x00c0
>> +#define CPR0_PERD       0x00e0
>> +#define CPR0_AHBD       0x0100
>> +#define CPR0_ICFG       0x0140
> 
> You duplicated the #defines right below this.  Just change the comment for
> the already existing defines to say "440GX/405EX Clock Control regs".

I want to isolate 405EX with other 4xx for convenient maintaining code as my
original. And although there are same offset as the register of 440GX, they are
defined with different name on manual because of different design mechanism. So
I hope we cannot be confused these when others track the codes.

But this is not problem. I can merge them if you really feel bad :)

  You
> don't need to add CPR0_ICFG either, since you don't use it anywhere.
> 

Ok.

After your reply I will send v2 so thanks your help in advance.

Best Regards
Tiejun

> josh
> 
