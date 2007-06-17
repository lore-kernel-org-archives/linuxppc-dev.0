Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3CBDCDDECA
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 03:46:25 +1000 (EST)
In-Reply-To: <200706171920.10898.arnd@arndb.de>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.314570319@arndb.de>
	<91EBCC0C-48B7-4748-A936-E74CEB7685E0@kernel.crashing.org>
	<200706171920.10898.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d3d38f54c208600e6766ccaf8136d520@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 2/9] autoselect optimal -mcpu= flag by platform
Date: Sun, 17 Jun 2007 19:46:14 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Is there a reason we don't distinguish between 7400/7410 and 74{4,5}
>> x?  Is it because we dont have any discrete systems with just a 7400
>> on it?
>
> No, I just didn't know that there was a difference. I had looked at the
> gcc source and found that gcc produces the same instruction for both,
> but I didn't bother to look at the optimizations. From all I can
> tell, -mcpu=7400 is identical to -mcpu=7450 -mtune=750.

7400 is pretty much like a 750 + AltiVec and a few deeper
queues.  The "FP full" stall is also gone IIRC, or maybe
that was not before the 7450.  Nothing that GCC knows how
to model, anyway.

>> Also I'd suggest we have the config options be a 1:1 matching for the
>> -mcpu/-mtune options in gcc for the following cases:
>>
>>> +	default "-mcpu=750" if CPU_7xx
>>> +	default "-mcpu=7450" if CPU_74xx
>>> +	default "-mcpu=860" if PPC_8xx
>>> +	default "-mcpu=8540" if PPC_85xx
>>
>> So if in the future we have code scheduling for 8599 or some other
>> variant we don't have to go change the Kconfig just add to it.
>
> I'm not sure I understand what you would like to see this, would you
> like them to be simply renamed to CPU_750/CPU_7450/CPU_860/CPU_8540
> or rather add more options for 740/801/821/823/8548, which are
> treated as aliases of the others?

GCC treats many of those as aliases, too.


Segher
