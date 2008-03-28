Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D3DD0DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 05:07:50 +1100 (EST)
Message-ID: <47ED33FC.3020107@freescale.com>
Date: Fri, 28 Mar 2008 13:07:56 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803281726.47566.laurentp@cse-semaphore.com>
	<47ED26BE.2080507@freescale.com>
	<200803281854.28595.laurentp@cse-semaphore.com>
In-Reply-To: <200803281854.28595.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> On Friday 28 March 2008 18:11, Scott Wood wrote:
>> Laurent Pinchart wrote:
>>> Locating the end of the muram isn't as straightforward as it
>>> could be. As the current code already uses the beginning of the
>>> muram to store the BDs and data buffers, should I really bother
>>> locating the end or can I store the SMC parameter ram at the
>>> beginning as well ?
>> Maybe, but the end would be safer.  What's the problem with finding
>> the end?
> 
> That requires manual parsing of all the cells in the reg property.
> The device-tree API doesn't provide a way to get the length of a
> property,

Sure it does.  Do a getprop with an insufficiently large buffer, and it
tells you how much you really need. :-)

> so I'll have to use a big enough pre-allocated buffer. I'm also not
> sure if resources are guaranteed to be sorted in increasing order.

Ah, good point.

> This doesn't make finding the end of the muram really difficult. I
> was just wondering if the increased code complexity was worth it,
> especially seeing how the cpm_serial code in the boot wrapper seem
> quite unstable.

Unstable in what way?

> I'm not familiar with the boot wrapper code so I'm sometimes not very
>  confident in my assumptions, but isn't the handling of the
> virtual-reg property in cpm_console_init broken ?

Not as far as I can see.

> If I'm not mistaken, getprop will return the address and size of the
> first resource and not the addresses of the first two resources.

No, it'll get as much of the virtual-reg property as will fit in the 
buffer.  There's no size in virtual-reg.

> What is virtual-reg used for ? To report the virtual address without
> requiring a device tree walk ? Does it provide any information that
> dt_xlate_reg can't find ?

Yes, it tells you the virtual address when it's not an identity mapping. 
  It's not currently used on CPM platforms, but might be used down the 
road with a QE device on 85xx.

>> Even the end of the first reg resource would be OK.
> 
> If I use the end of the first resource, can I assume it spans 0x0000
> - 0x8000 to set the default tx BD address in Kconfig ?

No, especially seeing as it doesn't on any existing boards. :-)

You could set the default to just before 0x2000 with board-specific 
exceptions, though.

-Scott
