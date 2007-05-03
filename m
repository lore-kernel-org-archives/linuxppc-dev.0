Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0C5F8DDF77
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 03:16:18 +1000 (EST)
Message-ID: <463A1941.3090608@ru.mvista.com>
Date: Thu, 03 May 2007 21:17:53 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
	<4639DDE1.40904@ru.mvista.com>
	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
In-Reply-To: <71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:

>>>>   We weren't aware of the of_platform.c work when writing the MTD 
>>>> support.
>>>>   Note that this function usually probes only the specified set of 
>>>> (SoC)
>>>> busses, none of which usully contains NOR flash (which is located at 
>>>> the
>>>> root level).

>>> The root level?  Um... I don't think so...

>>     "Trust me". :-)
>>     NOR flashes are at the same level as the "memory" node (where else 
>> you
>> expect them to appear I wonder?).

> The "memory" node doesn't describe the RAM devices;
> it describes the RAM address space, instead.  You can
> have separate nodes for the actual devices.

    If you can remember our prior discussion, the "rom" nodes don't describe 
"the actual devices" as well, only their mapping into the address space. ;-)

> Now for ROM/flash/NVRAM, nodes _can_ appear directly
> under the root, but only if that is where they belong
> on your platform (i.e., they sit directly on the "system
> bus" (whatever that means on your platform); on most
> platforms though, such devices are connected via some
> I/O busses, so the nodes should appear under their
> respective controllers.

    Yeah, you're right here, and I've probably misunderstood what "memory" 
node was. In fact, the flash in my system resides on the same local bus as 
RAM, so the proper place would be behind the "lbc" (or whatever -- it doesn't 
exist as yet) node on the "soc" bus.  Do you think I need to go and document 
it as well for such cause? :-]

>>> I believe the arrangement is similar for most other 4xx systems.  More
>>> PC or desktop like systems sometimes have boot flash connected to the
>>> south bridge, which I believe puts it on the ISA bus, topologically
>>> speaking.

> Some have it on the LPC bus as an LPC device, some
> have it on the LPC bus but accessed with a separate
> protocol,  some have it attached to another LPC device
> (some "superio" typically), some have it attached
> directly to the "south bridge".

>>     Not exactly. Boot flash is mapped beyond ISA address space on 386+ 
>> -- at
>> the top of 4GB (where the "reset vector" is). Although it may be dual 
>> mapped
>> below 1MB as well (I'm starting to forget x86 :-).

> Most "north bridges" have some bits that enable
> translation of accesses in the "low bios" area to
> the 4GB-minus-a-bit area.  There are many variations
> and it all is a big mess :-)

    Human perversion knows no limits. O:-)

> Now, back to the case at hand -- it would be nice to
> have a platform-independent way to probe the simple
> case -- a single direct-mapped device -- but it isn't
> obvious how to make that not clash with the not-so-simple
> cases.  A helper function that does the work but is
> only called by the platforms that want it would do, I
> suppose?

    It probably doesn't even worth a helper (since out of those 15 lines, 6 
were pretty useless anyway)

> Segher

WBR, Sergei
