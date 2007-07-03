Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BED63DDE36
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 08:33:46 +1000 (EST)
Message-ID: <468ACEC1.5000805@freescale.com>
Date: Tue, 03 Jul 2007 17:33:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
References: <468ABF4A.60001@freescale.com>
	<513A555F-5C7F-4FEF-B215-E0E683FEF9E1@kernel.crashing.org>
	<468ACA6F.5010107@freescale.com> <20070703223612.GA27682@lixom.net>
In-Reply-To: <20070703223612.GA27682@lixom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Tue, Jul 03, 2007 at 05:15:11PM -0500, Scott Wood wrote:
> 
> 
>>How about a CONFIG_NOT_BROKEN_DEVICE_TREE that disables this and other 
>>legacy stuff?  If unset, warnings will be printed whenever broken things 
>>are detected.  Boards which need proper device tree parsing can select 
>>the config option.
>>
>>I'd prefer the other way around (CONFIG_BROKEN_DEVICE_TREE), but it'd 
>>need to default y at first, and kconfig has no unselect command that I 
>>can see...
> 
> 
> What's the value add in doing this? The code to handle both cases still
> has to be in there (just under ifdef now). Is there actually any harm
> in doing case-insensitive matching today, where things break because
> there are conflicting properties with different cases?

Not for case insensitivity (that I know of), but the whole reason I 
posted this was because of time spent trying to figure out why my serial 
port recently stopped working -- apparently, it's checking nodes in a 
different order now (or something along those lines), causing the 
substring match to match against the wrong thing.

I'd really rather not have to go out of my way to avoid picking 
compatible names that break Linux.

> Device trees will never be perfect, and it's idiotic of the kernel to
> expect them to be.

It's even more idiotic to break valid device trees just because the 
kernel has always done so.  Putting it under ifdef, especially once the 
default is conformant behavior, will make it more likely that future 
device trees are compliant in that regrad, as long as Linux is involved 
in the testing process.

> Even with the dts files, there are several of them
> that have errors in them. There will be more in the future as well.

And the earlier we implement stricter checking, the fewer of them there 
will be.

-Scott
