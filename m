Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BE6367B20
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 14:32:10 +1000 (EST)
In-Reply-To: <20060629140217.4a07f05a.kim.phillips@freescale.com>
References: <20060628211317.7b21d085.kim.phillips@freescale.com>
	<99F42AA0-3028-4C80-86C1-14A210C41229@kernel.crashing.org>
	<20060629095839.55cb8e5f.kim.phillips@freescale.com>
	<B0F8A9DE-8841-4404-BF8D-D712322FB20E@kernel.crashing.org>
	<20060629140217.4a07f05a.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2D577A2B-8D1F-4DC3-A957-2A769FC9E57E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Add support for the Freescale MPC8349E-mITX eval board
Date: Thu, 29 Jun 2006 23:32:04 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2006, at 2:02 PM, Kim Phillips wrote:

> On Thu, 29 Jun 2006 11:38:04 -0500
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>>
>>> It removes rtc chip-specific code from the platform code.  It
>>> accomplishes this by using the new "RTC-framework" glue.
>>
>> I'm aware of the new RTC framework.
>>
>> This code seems pretty generic for any RTC using the new framework.
>> If so, we should put it somewhere more generic like setup.c
>>
> yeah, I'd like to clean up some more of the existing rtc specific  
> code and do that in one fell swoop..

well we can drop the rtc code for now and get the ITX base into the  
tree.

>>> <snip>
>>>>> diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
>>>>> index 02ed2c3..80076be 100644
>>>>> --- a/include/asm-ppc/mpc83xx.h
>>>>> +++ b/include/asm-ppc/mpc83xx.h
>>>>> @@ -25,6 +25,10 @@
>>>>>  #include <platforms/83xx/mpc834x_sys.h>
>>>>>  #endif
>>>>>
>>>>> +#ifdef CONFIG_MPC834x_ITX
>>>>> +#include <platforms/83xx/mpc834x_itx.h>
>>>>> +#endif
>>>>> +
>>>>
>>>> This shouldn't be needed, its a hold over from arch/ppc
>>>>
>>> Unfortunately it won't build without it.
>>
>> What's the build error?
>>
> ..
>   CC      arch/powerpc/platforms/83xx/mpc834x_itx.o
> arch/powerpc/platforms/83xx/mpc834x_itx.c: In function  
> `mpc83xx_map_irq':
> arch/powerpc/platforms/83xx/mpc834x_itx.c:57: error: `PIRQB'  
> undeclared (first use in this function)
> ..

Include the header in mpc834x_itc.c since its what's using it.

- k
