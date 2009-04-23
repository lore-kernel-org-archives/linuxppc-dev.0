Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 90768DE12D
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 01:54:04 +1000 (EST)
Message-ID: <49F07DF0.5020207@ru.mvista.com>
Date: Thu, 23 Apr 2009 18:40:48 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PPC440EPx SDRAM width
References: <49F06ECC.7030904@harris.com>	<20090423134538.GB3825@zod.rchland.ibm.com>
	<200904231605.22912.sr@denx.de>
In-Reply-To: <200904231605.22912.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Thursday 23 April 2009, Josh Boyer wrote:
>> On Thu, Apr 23, 2009 at 09:36:12AM -0400, Steven A. Falco wrote:
>>> There is an error in the way ibm4xx_denali_fixup_memsize calculates
>>> memory size.  When testing the DDR_REDUC bit, the polarity is
>>> backwards.  A "1" implies 32-bit wide memory while a "0" implies
>>> 64-bit wide memory.
>>>
>>> For a 32-bit wide system, this bug causes twice the memory to be
>>> reported, leading to boot failure.
>>>
>>> Signed-off-by: Steven A. Falco <sfalco@harris.com>
>> So we had a previous patch for this, and a very long discussion on what the
>> right solution was.  Either we never came to a resolution, or I have just
>> forgotten what it was.
>>
>> Stefan, Valentine, do either of you remember?
> 

The patch will break sequia/rainier since u-boot doesn't set the number 
of chipselects correctly for them. IIRC, the last conversation didn't 
come to any conclusion. We sort of wanted to fix that regardless of 
whether we had corrected u-boot or not.

Could we use a "model" property to distinguish between the "real" 
sequoia/rainier and other custom boards?
If yes, we could add a workaround the ibm4xx_denali_fixup_memsize to 
hardcode the chipselect number to 1 for sequoia/rainier.

Thanks,
Val.

> Not really, sorry. Must be longer than 2 weeks ago, so it's already flushed 
> from my cache. :)
> 
>> IIRC, it wasn't something 
>> that effected Sequoia or Rainier, but it could (and obviously does) effect
>> custom boards.  I don't remember what we agreed on for the proper fix.
> 
> It would effect all 32-bit wide 440EPx/GRx boards using the boot wrapper. I 
> never used the wrapper on those platforms though. Sorry, I don't remember the 
> outcome of the discussion either.
> 
> Thanks,
> Stefan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
