Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3A61E2C02FB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 17:48:40 +1000 (EST)
Message-ID: <51DBC07A.4020809@windriver.com>
Date: Tue, 9 Jul 2013 15:49:14 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Subject: Re: [v2][PATCH 1/7] powerpc/book3e: support CONFIG_RELOCATABLE
References: <1371714797-7898-1-git-send-email-tiejun.chen@windriver.com>
 <1371714797-7898-2-git-send-email-tiejun.chen@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0709474E@039-SN2MPN1-011.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0709474E@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2013 01:00 PM, Bhushan Bharat-R65777 wrote:
>
>
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+bharat.bhushan=freescale.com@lists.ozlabs.org] On Behalf Of Tiejun Chen
>> Sent: Thursday, June 20, 2013 1:23 PM
>> To: benh@kernel.crashing.org
>> Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: [v2][PATCH 1/7] powerpc/book3e: support CONFIG_RELOCATABLE
>>
>> book3e is different with book3s since 3s includes the exception
>> vectors code in head_64.S as it relies on absolute addressing
>> which is only possible within this compilation unit. So we have
>> to get that label address with got.
>>
>> And when boot a relocated kernel, we should reset ipvr properly again
>> after .relocate.
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---

[snip]

>>   	int *src, *dest;
>>   	unsigned long length;
>> +#ifdef CONFIG_PPC_BOOK3E
>> +	extern char interrupt_end_book3e[];
>> +#endif
>
> Cannot we do this in arch/powerpc/kernel/asm/sections.h
>
>>
>>   	if (PHYSICAL_START == 0)
>>   		return;
>>
>>   	src = (int *)(KERNELBASE + PHYSICAL_START);
>>   	dest = (int *)KERNELBASE;
>> +#ifdef CONFIG_PPC_BOOK3E
>> +	length = (interrupt_end_book3e - _stext) / sizeof(int);
>> +#else
>>   	length = (__end_interrupts - _stext) / sizeof(int);
>> +#endif
>
> can we keep same name in books and booke; __end_interrupts ? this way we can avoid such #ifdefs

Yes, I think I can simplify this as you pointed :)

Thanks,

Tiejun
