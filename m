Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D112FDDF3B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 08:41:59 +1000 (EST)
In-Reply-To: <20070703223612.GA27682@lixom.net>
References: <468ABF4A.60001@freescale.com>
	<513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
	<468ACA6F.5010107@freescale.com> <20070703223612.GA27682@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AD2F3E61-1F50-4B3F-9708-F69D0F319CB7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
Date: Wed, 4 Jul 2007 00:41:46 +0200
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> How about a CONFIG_NOT_BROKEN_DEVICE_TREE that disables this and  
>> other
>> legacy stuff?  If unset, warnings will be printed whenever broken  
>> things
>> are detected.  Boards which need proper device tree parsing can  
>> select
>> the config option.
>>
>> I'd prefer the other way around (CONFIG_BROKEN_DEVICE_TREE), but it'd
>> need to default y at first, and kconfig has no unselect command  
>> that I
>> can see...
>
> What's the value add in doing this?

None.  The kernel should either allow or not allow certain
classes of brokenness; and if it does allow it, it is better
to only allow it in those cases where it expects the brokenness
(i.e., on certain platforms, in this case).

> The code to handle both cases still
> has to be in there (just under ifdef now). Is there actually any harm
> in doing case-insensitive matching today, where things break because
> there are conflicting properties with different cases?

There is a big potential harm in not looking at case for the
part of the name before the comma (upper case is stock symbol,
lower case isn't).  An actual real life example?  Dunno, I'm
sure we'll find some if we change to case-sensitive matching.

> Device trees will never be perfect,

But the kernel applies workarounds _way_ too generously.  This
is starting to cause more problems than it solves.

> and it's idiotic of the kernel to
> expect them to be. Even with the dts files, there are several of them
> that have errors in them. There will be more in the future as well.

Sure, especially since the kernel allows all kinds of wrong
things and second guesses what is meant.  Sometimes it guesses
right, and then the device tree is shipped, since "it works so
it must be right".


Segher
