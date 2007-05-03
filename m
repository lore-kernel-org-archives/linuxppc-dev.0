Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 31515DDEDD
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 04:08:31 +1000 (EST)
In-Reply-To: <463A1941.3090608@ru.mvista.com>
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
	<4639DDE1.40904@ru.mvista.com>
	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
	<463A1941.3090608@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4e36fd0fc67f14fc4ff2178468c053f0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Date: Thu, 3 May 2007 19:35:04 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>     NOR flashes are at the same level as the "memory" node (where 
>>> else you
>>> expect them to appear I wonder?).
>
>> The "memory" node doesn't describe the RAM devices;
>> it describes the RAM address space, instead.  You can
>> have separate nodes for the actual devices.
>
>    If you can remember our prior discussion, the "rom" nodes don't 
> describe "the actual devices" as well, only their mapping into the 
> address space. ;-)

I don't remember that no.  And having a node for the
"ROM address space" isn't useful in the same way as
having one for the "RAM address space" is -- flash
memory is not a resource you randomly hand out to
anyone who wants a piece.  You also need to know some
_specifics_ about a certain ROM device before you can
map it into CPU address space properly.

>> Now for ROM/flash/NVRAM, nodes _can_ appear directly
>> under the root, but only if that is where they belong
>> on your platform (i.e., they sit directly on the "system
>> bus" (whatever that means on your platform); on most
>> platforms though, such devices are connected via some
>> I/O busses, so the nodes should appear under their
>> respective controllers.
>
>    Yeah, you're right here, and I've probably misunderstood what 
> "memory" node was. In fact, the flash in my system resides on the same 
> local bus as RAM, so the proper place would be behind the "lbc" (or 
> whatever -- it doesn't exist as yet) node on the "soc" bus.  Do you 
> think I need to go and document it as well for such cause? :-]

If the "lbc" isn't software visible, you can/should put
the RAM/ROM nodes directly under the SoC node.

This is all just standard considerations, so I don't think
you need to document it separately no.  An example device
tree will help other implementors using your SoC create a
proper device tree, of course.

>> Most "north bridges" have some bits that enable
>> translation of accesses in the "low bios" area to
>> the 4GB-minus-a-bit area.  There are many variations
>> and it all is a big mess :-)
>
>    Human perversion knows no limits. O:-)

Well it's note like there aren't any groovy things on
some PowerPC systems, but x86 definitely wins :-)

>> Now, back to the case at hand -- it would be nice to
>> have a platform-independent way to probe the simple
>> case -- a single direct-mapped device -- but it isn't
>> obvious how to make that not clash with the not-so-simple
>> cases.  A helper function that does the work but is
>> only called by the platforms that want it would do, I
>> suppose?
>
>    It probably doesn't even worth a helper (since out of those 15 
> lines, 6 were pretty useless anyway)

Sure -- but since it is such a common device to have (a
simple NOR boot flash), it would be nice to avoid any
code duplication.  Compare to the serial port and RTC
situation.


Segher
