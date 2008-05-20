Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4118DDE4B6
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:32:36 +1000 (EST)
Date: Tue, 20 May 2008 18:32:34 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080520143234.GA19707@polina.dev.rtsoft.ru>
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
	<20080520123226.GB14573@polina.dev.rtsoft.ru>
	<7A841A6C-137D-4784-B7B0-2BAFFFB0CCF7@kernel.crashing.org>
	<20080520140847.GA2430@polina.dev.rtsoft.ru>
	<AB3D8846-D6FA-414B-8023-23DA1A4367EC@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <AB3D8846-D6FA-414B-8023-23DA1A4367EC@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 09:20:50AM -0500, Kumar Gala wrote:
>>>>> This is explained in the .c file with a kernel doc. Basically the
>>>> difference is that timer16 could silently crop the precision, while
>>>> utimer16 could not thus explicitly accepts u16 argument (max. timer
>>>> interval with usec precision fits in u16).
>>>
>>> Maybe I'm confused what the utility is of cropping the precision in  
>>> this
>>> way is.  I'd also say that _timer16 is poorly named to convey the
>>> behavior. I'm not sure what to call it because I still dont get  
>>> exactly
>>> why you'd want the precision cropped.
>>
>> Precision matters for FHCI-like drivers, when driver, for example,
>> schedule transactions via the GTM timers, and there timings matters
>> a lot.
>>
>> Though, timer16 crops the precision _only_ if usecs > 65535, so FHCI
>> _can_ still use the _timer16 (because FHCI does not request intervals
>>> 65535). But I implemented two function because:
>>
>> 1. I think we don't need unnecessary stuff in the ISRs (this is weak
>>   argument since I didn't measure the impact).
>> 2. I wanted to make the API clear (seem to fail this undertaking :-),
>>   which functions will behave exactly the way you asked it (utimer16),
>>   and which functions will _silently_ crop the precision (timer16)
>>   (if asked for 1001000 usecs, it will give you ~~1001000, depending
>>   on the GTM frequency).
>
> I'm fine w/having both. I think they are poorly named.  I'd also call  
> them _set_timer but that's just me.
>
> Maybe something w/the term _exact_ in the name.  Is it the case w/the  
> precise form we'd have no prescaling (if so maybe a comment in the API  
> about that would help clarity)?

We're always prescale [to 1000000 MHz for usec precision]. Otherwise
these functions would be non-deterministic (will purely depend on the GTM
frequency, so "usec" argument would not have defined boundaries).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
