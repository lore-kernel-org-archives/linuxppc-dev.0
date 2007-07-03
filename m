Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABB1BDDF66
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 08:52:14 +1000 (EST)
In-Reply-To: <468ACEC1.5000805@freescale.com>
References: <468ABF4A.60001@freescale.com>
	<513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
	<468ACA6F.5010107@freescale.com> <20070703223612.GA27682@lixom.net>
	<468ACEC1.5000805@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <86F97E62-38AF-4E51-A8E1-B76A720B891E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
Date: Wed, 4 Jul 2007 00:52:04 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> What's the value add in doing this? The code to handle both cases  
>> still
>> has to be in there (just under ifdef now). Is there actually any harm
>> in doing case-insensitive matching today, where things break because
>> there are conflicting properties with different cases?
>
> Not for case insensitivity (that I know of), but the whole reason I  
> posted this was because of time spent trying to figure out why my  
> serial port recently stopped working -- apparently, it's checking  
> nodes in a different order now (or something along those lines),  
> causing the substring match to match against the wrong thing.

Substring matching is WRONG WRONG WRONG.

> It's even more idiotic to break valid device trees just because the  
> kernel has always done so.  Putting it under ifdef, especially once  
> the default is conformant behavior, will make it more likely that  
> future device trees are compliant in that regrad, as long as Linux  
> is involved in the testing process.

We should just implement *targeted* workarounds, not say
"oh, some trees use bad upper/lower casing?  Let's just match
case-insensitive then".

>> Even with the dts files, there are several of them
>> that have errors in them. There will be more in the future as well.
>
> And the earlier we implement stricter checking, the fewer of them  
> there will be.

Yes, unfortunately.


Segher
