Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BCC75DE0CB
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 01:08:03 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n3NF4p31018855
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:04:51 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n3NF7i7e074364
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:07:45 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n3NF6jDc000825
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 09:07:26 -0600
Date: Thu, 23 Apr 2009 10:59:15 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PPC440EPx SDRAM width
Message-ID: <20090423145915.GC3825@zod.rchland.ibm.com>
References: <49F06ECC.7030904@harris.com>
	<20090423134538.GB3825@zod.rchland.ibm.com>
	<200904231605.22912.sr@denx.de> <49F07DF0.5020207@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49F07DF0.5020207@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 06:40:48PM +0400, Valentine Barshak wrote:
> Stefan Roese wrote:
>> On Thursday 23 April 2009, Josh Boyer wrote:
>>> On Thu, Apr 23, 2009 at 09:36:12AM -0400, Steven A. Falco wrote:
>>>> There is an error in the way ibm4xx_denali_fixup_memsize calculates
>>>> memory size.  When testing the DDR_REDUC bit, the polarity is
>>>> backwards.  A "1" implies 32-bit wide memory while a "0" implies
>>>> 64-bit wide memory.
>>>>
>>>> For a 32-bit wide system, this bug causes twice the memory to be
>>>> reported, leading to boot failure.
>>>>
>>>> Signed-off-by: Steven A. Falco <sfalco@harris.com>
>>> So we had a previous patch for this, and a very long discussion on what the
>>> right solution was.  Either we never came to a resolution, or I have just
>>> forgotten what it was.
>>>
>>> Stefan, Valentine, do either of you remember?
>>
>
> The patch will break sequia/rainier since u-boot doesn't set the number  
> of chipselects correctly for them. IIRC, the last conversation didn't  
> come to any conclusion. We sort of wanted to fix that regardless of  
> whether we had corrected u-boot or not.
>
> Could we use a "model" property to distinguish between the "real"  
> sequoia/rainier and other custom boards?
> If yes, we could add a workaround the ibm4xx_denali_fixup_memsize to  
> hardcode the chipselect number to 1 for sequoia/rainier.

We could do that perhaps, yes.  In cases where the board has a newer U-Boot
with the fix already, it shouldn't really cause any harm, correct?

josh
