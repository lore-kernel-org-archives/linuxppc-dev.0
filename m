Return-Path: <sfalco@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id BAC9EDE13D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 02:00:11 +1000 (EST)
Message-ID: <49F09082.1040505@harris.com>
Date: Thu, 23 Apr 2009 12:00:02 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PPC440EPx SDRAM width
References: <49F06ECC.7030904@harris.com>	<20090423134538.GB3825@zod.rchland.ibm.com>	<200904231605.22912.sr@denx.de>
	<49F07DF0.5020207@ru.mvista.com>	<20090423145915.GC3825@zod.rchland.ibm.com>
	<49F08636.3080007@ru.mvista.com>
In-Reply-To: <49F08636.3080007@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> 
> Josh Boyer wrote:
>> On Thu, Apr 23, 2009 at 06:40:48PM +0400, Valentine Barshak wrote:
>>> Stefan Roese wrote:
>>>> On Thursday 23 April 2009, Josh Boyer wrote:
>>>>> On Thu, Apr 23, 2009 at 09:36:12AM -0400, Steven A. Falco wrote:
>>>>>> There is an error in the way ibm4xx_denali_fixup_memsize calculates
>>>>>> memory size.  When testing the DDR_REDUC bit, the polarity is
>>>>>> backwards.  A "1" implies 32-bit wide memory while a "0" implies
>>>>>> 64-bit wide memory.
>>>>>>
>>>>>> For a 32-bit wide system, this bug causes twice the memory to be
>>>>>> reported, leading to boot failure.
>>>>>>
>>>>>> Signed-off-by: Steven A. Falco <sfalco@harris.com>
>>>>> So we had a previous patch for this, and a very long discussion on
>>>>> what the
>>>>> right solution was.  Either we never came to a resolution, or I
>>>>> have just
>>>>> forgotten what it was.
>>>>>
>>>>> Stefan, Valentine, do either of you remember?
>>> The patch will break sequia/rainier since u-boot doesn't set the
>>> number  of chipselects correctly for them. 

I had wondered about that.  I was surprised that sequoia uboot
enabled both cs bits - now I know why it worked.  Two wrongs
sometimes do make a right. :-)

>>> IIRC, the last
>>> conversation didn't  come to any conclusion. We sort of wanted to fix
>>> that regardless of  whether we had corrected u-boot or not.

That would have saved me a bit of grief.  It will probably
help someone else someday too.

>>> Could we use a "model" property to distinguish between the "real" 
>>> sequoia/rainier and other custom boards?
>>> If yes, we could add a workaround the ibm4xx_denali_fixup_memsize to 
>>> hardcode the chipselect number to 1 for sequoia/rainier.
>>
>> We could do that perhaps, yes.  In cases where the board has a newer
>> U-Boot
>> with the fix already, it shouldn't really cause any harm, correct?
> 
> Yes, that's correct.

Not sure if you want me to do something further in my patch.
Are you suggesting testing for model = "amcc,sequoia" and
forcing cs to 1, or is there more to it?

	Steve

> 
> Thanks,
> Val
> 
>>
>> josh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
