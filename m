Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 448C3DDE2B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:17:23 +1000 (EST)
Message-ID: <4663060C.2020906@ru.mvista.com>
Date: Sun, 03 Jun 2007 22:18:52 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
	<a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
In-Reply-To: <a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>>> I think "direct-mapped" as compatible is a bit too broad or vague.

>>     It's actually not -- it means simple 1:1 address mapping (w/o 
>> explicit
>> byte-swapping and such).

> Which has nothing to do with "compatible"; instead,
> it is implied by the parent node have a "ranges"

    No! It doesn't have anything to do with "ranges" of parent (don't even 
know why it would). :-O

> property.  Or you can put some other property in
> the flash node for all I care, if that seems
> necessary for certain cases.

    Erm... it's *certainly* necessary to mark this somewhere.

>>> The compatible is supposed to be useable to find and match a driver
>>> without regard to the name of the node.  Perhaps direct-mapped-rom?

    That really depends on whether we choose to follow the Generic Names spec.
Even if we do, it does *not* preclude OS from using both props for the driver 
selection.

>>> (as opossed to a direct-mapped-ram, sram, or some width flash bank).

>>     Note that we're matching by both "device_type" and "compatible".

> Which is wrong.

    Why? And why then it's allowed to match by "device_type"? And why you 
haven't complained at MPC5200 IDE driver which does the same (well, maybe you 
have :-) or at PowerMac IDE driver which matches wither by "name" or 
"device_type"? Well, quite a lot of drivers are doing this...

>>     This would serve no purpose, as the driver that would catches all 
>> these is signle one, drivers/mtd/maps/physmap_of.c...

> With the current kernel version, perhaps.  Did you check
> out 2.6.28?  Does it work with that?

    For the simply mapped flashes, physmap_of will suffice, for more complex 
cases, other driver will be needed. If you're hinting at the possibility that 
MTD subsys will be substantially reworked -- I don't find that likely. If it 
will -- well, bad luck. :-)
    Anyway, reasonable suggestions on how to make MTD nodes more viable are 
always welcome. I just haven't seen reasonable enough yet. ;-)

> Segher

WBR, Sergei
