Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 2246CDDFC3
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 23:02:58 +1000 (EST)
Message-ID: <4639DDE1.40904@ru.mvista.com>
Date: Thu, 03 May 2007 17:04:33 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc_flash_init(), wtf!?
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
In-Reply-To: <20070503123055.GE26659@localhost.localdomain>
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

Hello.

David Gibson wrote:

>>>powerpc_flash_init(), the only function in arch/powerpc/sysdev/rom.c,
>>>goes through the device tree finding anything with device_type=="rom"
>>>and creating of_platform devices for them, which will be picked up by
>>>the physmap_of mtd driver.  This has two serious conceptual errors and
>>>one bad implementation error which is quite an accomplishment for 15
>>>lines of code.

>>>Most seriously, this "find all roms" approach to probing is
>>>fundamentally incompatible with the normal way of probing for
>>>of_platform devices, to wit, using of_platform_bus_probe().  If a

>>   We weren't aware of the of_platform.c work when writing the MTD support.
>>   Note that this function usually probes only the specified set of (SoC) 
>>busses, none of which usully contains NOR flash (which is located at the 
>>root level).

> The root level?  Um... I don't think so...

    "Trust me". :-)
    NOR flashes are at the same level as the "memory" node (where else you 
expect them to appear I wonder?).

>>>flash is on a bus probed with of_platform_bus_probe()
>>>powerpc_flash_init() will create a duplicate of_platform device for it.

>>   Flash on a SoC bus?  Well, that's more likely to happen for NAND.
>>But generally, I'd agree with you.

> Well, on Ebony, the (NOR) flash is on the bus controlled by the
> 440gp's external bus controller (EBC).  So it's not an SoC bus as
> such, but it's still a "dumb bus" (to use BenH's terminology) which
> can be suitably probed by of_platform_bus_probe().

   Interesting...

> I believe the arrangement is similar for most other 4xx systems.  More
> PC or desktop like systems sometimes have boot flash connected to the
> south bridge, which I believe puts it on the ISA bus, topologically
> speaking.

    Not exactly. Boot flash is mapped beyond ISA address space on 386+ -- at 
the top of 4GB (where the "reset vector" is). Although it may be dual mapped 
below 1MB as well (I'm starting to forget x86 :-).

>>>powerpc_flash_init() could also mistakenly probe roms which
>>>appear on other random busses which should use their own probe logic
>>>instead of going straight off the device tree (admittedly flash is
>>>unlikely to appear on such a bus).

>>   Well, if you consider NAND...

>>>Also, it uses the device node's name without unit address as the
>>>of_platform device's name.  So if a bus somewhere has two flash
>>>devices named, say "flash@0" and "flash@800000", the device code will
>>>give a stack dump during boot as powerpc_flash_init() attempts to
>>>register them both under the name "flash".

>>   Well, we didn't think about 2 flashes named the same way. :-/

>>>I observe that none of the dts files actually present in the kernel
>>>tree use physmap_of's format for describing flash devices (and
>>>therefore don't use this code).  I'm therefore rather tempted to

>>   Which means I still haven't submitted the patch. :-<

    I hope to post a patch soon.

>>>simply blow arch/powerpc/sysdev/rom.c away, and anyone out-of-tree
>>>relying on this code will have to fix their platform probing code to
>>>create the flash of_platform devices properly.

>>   You mean creating the "rom" devices from the platform-specific code?
>>I doubt that it's really a flexible approach...

> Since it's handled on a per-platform basis, it's more-or-less by
> definition more flexible than the current broken approach.

    I'm worried about the code duplication.

>>>Unless someone who actually knows how this code was intended to be
>>>used can suggest a more polite way of fixing it.

>>   Well, probably it needs to only look up the root bus...

> Really, truly on the root bus?  Even so I don't think such a probe
> should be conducted as an initcall whenever CONFIG_MTD is set.  A
> helper function invoked from the platform code might be reasonable.

    Yeah, I agree.  Probably doesn't even worth a function since for most 
cases there's only one flash.

WBR, Sergei
