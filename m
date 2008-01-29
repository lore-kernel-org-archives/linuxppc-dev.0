Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 65B28DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 01:24:40 +1100 (EST)
Message-ID: <479F36B9.2050308@ru.mvista.com>
Date: Tue, 29 Jan 2008 17:22:49 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH][ppc] logical/bitand typo in powerpc/boot/4xx.c
References: <4797C1AD.3040307@tiscali.nl>
	<20080123191704.2d74073a@zod.rchland.ibm.com>
In-Reply-To: <20080123191704.2d74073a@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Wed, 23 Jan 2008 23:37:33 +0100
> Roel Kluin <12o3l@tiscali.nl> wrote:
> 
>> logical/bitand typo
>>
>> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
>> ---
>> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
>> index ebf9e21..dcfb459 100644
>> --- a/arch/powerpc/boot/4xx.c
>> +++ b/arch/powerpc/boot/4xx.c
>> @@ -104,7 +104,7 @@ void ibm4xx_denali_fixup_memsize(void)
>>  	val = DDR_GET_VAL(val, DDR_CS_MAP, DDR_CS_MAP_SHIFT);
>>  	cs = 0;
>>  	while (val) {
>> -		if (val && 0x1)
>> +		if (val & 0x1)
>>  			cs++;
>>  		val = val >> 1;
>>  	}
> 
> Hm, good catch.

Yes, thanks!

Sequoia and Rainier are currently the only boards using denali 
controller and have both chipselects enabled (val = 0x3).
In this case the problem doesn't show up and we still get the right cs 
value.
Thanks,
Valentine.

> 
> Stefan, have you had problems with this code at all?
> 
> josh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
