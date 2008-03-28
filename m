Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B1BF4DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 23:29:55 +1100 (EST)
Message-ID: <47ECE513.2040501@ru.mvista.com>
Date: Fri, 28 Mar 2008 15:31:15 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251914.24021.laurentp@cse-semaphore.com>
	<47EA4741.2050402@ru.mvista.com>
	<200803271013.32612.laurentp@cse-semaphore.com>
	<20080327100304.GC10397@localhost.localdomain>
	<47EB91D2.60100@ru.mvista.com>
	<20080328000711.GC16141@localhost.localdomain>
In-Reply-To: <20080328000711.GC16141@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

>>>>>   Heh, we've gone thru "physmap" before -- it was labelled 
>>>>>Linux-specific name (well, I'd agree with that).

>>>>physmap stands for physically mapped. That doesn't sound
>>>>Linux-specific to me, the fact that the MTD driver has the same name
>>>>is a pure coincidence.  linmap-rom and linmap-rom sound even more
>>>>Linux-specific :-)

>>>It may not be Linux specific per se, but it's a bad name, because the
>>>fact that the device is physically direct mapped isn't a useful
>>>distinguishing feature of the device.

>>   Yeah, it's not a propery of a device itself (yet, the device would be 
>>useless if this information is not supplied in the tree somehow). Yet 
>>remember the now ungoing discussion about "reg-shift" property for UARTs -- 
>>some people said that the fact that this property may not be a feature of 
>>device is irrelevant WRT the binding. :-)

>>>Main memory is also direct physically mapped, after all,  but that's not 
>>>what you want to cover
>>>with this description.

>>  Haven't ever seen the description of memory as a device (unless you mean 
>>the "memory" node which can hardly be considered proper device -- mainly 
>>because of their usual placement at the top of the tree, and not where a 
>>RAM device logically should be in the bus hierarchy).

> Yes, I mean the memory node.  And although it's no very likely,
> there's no inherent reason a RAM device couldn't also be at the top of
> the tree, on a CPU with the right sort of localbus.

    Yeah, according to the spec. this represents a RAM device. Too bad it's 
too often misplaced in the tree being on the top layer, and creating confusion 
(I used to misplace MTD device because of that)... :-(

>>>In general how a device is wired is described by where it sits in the 
>>>tree, not by its properties.

>>   Oh, another argument against "reg-shift" in the Xilinx UART quarry... 
>>:-)

> Not really.  I was perhaps a bit strong, wiring information in the
> properties isn't necessarily wrong, but it does need a close look.
> "reg-shift" is a useful compromise.

    And I've heard it's been spec'ed already. :-)
    And MTD could surely a subject to alike compromise since it can be wired 
to the bus in a weird way too (not very likely though).

>>>not inherent; it could be trivially extended to also instantiate a
>>>non-direct-mapped device (as long as the underlying mtd layer
>>>supported it, of course).   It bears no relation at all to the
>>>"physmap" driver, except historical accident.

>>   This driver resides on the "top", device mapping layer of the MTD 

    Which is actually bottom of course call-wise since it reads/writes the 
actual data for the upper layers.

>>hierarchy, and I don't see a point of cramming support for all the possible 
>>mappings into one driver vs doing it as the *separate* specific drivers in 
>>drivers/mtd/mapps/

> Because doing it as separate drivers would mean duplicating most of
> physmap_of for absolutely no reason.  I'll say it again there is

    Duplicating what, device probe/remove code? Partition parsing has been at 
last factored out into separate module by somebody (that patch should be 
queued in the MTD tree though I'm not sure), the old probing/partition code 
(i.e. our lame one) is not needed for the newly added devices...

> *nothing* that actually relies on the direct mapping in physmap_of;

    Really? Even simple_map_init() call it does?

> the *only* thing it does is take the device tree information and
> marshal it into an initialization call for the appropriate mtd chip
> drivers.

    No, not only that...

> I really should get around to sending a patch to rename physmap_of to
> "of_mtd.c".

    I don't think you should bother with that.

>>-- as it has been done in the MTD tree before "the great 
>>OF revolution". This is really strange idea...

> The only reason mtd needs heaps of little "map drivers" (which barely
> deserve the title of "driver")

    It's a layered driver structure

> is because there wasn't a single
> generally available source of information about where and how flash
> was mapped

    Not entirely true. You could try passing extra info with the platform 
device information...

> so a whole pile of platform or sitation specific ways of
> getting that information were needed.

    Some drivers read the h/w registers to determine the right type of mapping 
-- well, this probably could be replaced with reading this info from the 
device tree...

> With a device tree all that can
> be replaced with just getting the information from the device tree.

    Don't forget that such a universal driver would be taking extra kernel 
memory space as well, being loaded with the unused code handling all known 
mappings as well as extra probe/remove code...

WBR, Sergei
