Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 1DB94DE235
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 02:35:00 +1100 (EST)
Message-ID: <47274F1A.8030301@semihalf.com>
Date: Tue, 30 Oct 2007 16:34:50 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 05/11] [POWERPC] TQM5200 DTS
References: <20071023231302.29359.27417.stgit@hekate.izotz.org>	
	<20071023231333.29359.35252.stgit@hekate.izotz.org>	
	<13403420.post@talk.nabble.com>	
	<fa686aa40710250653o6e7df26y1890d5c485a6d508@mail.gmail.com>	
	<4720BA4B.5090707@semihalf.com>	
	<20071026013343.GD457@localhost.localdomain>	
	<4725EB9E.1030507@semihalf.com>
	<fa686aa40710290840w41e2ffeo38b9497ce76e155@mail.gmail.com>
In-Reply-To: <fa686aa40710290840w41e2ffeo38b9497ce76e155@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org, Martin Krause <Martin.Krause@tqs.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/29/07, Marian Balakowicz <m8@semihalf.com> wrote:
>> David Gibson wrote:
>>> On Thu, Oct 25, 2007 at 05:46:19PM +0200, Marian Balakowicz wrote:
>>>> Grant Likely wrote:
>>>>> On 10/25/07, Martin Krause <Martin.Krause@tqs.de> wrote:
>>> [snip]
>>>>>> On a board with 16 MiB FLASH for example the "big-fs" _and_ the "misc"
>>>>>> partition could not be used. "big-fs", because the memory is too small
>>>>>> (which is OK) and "misc", because it overlaps 1 MiB over the physikal
>>>>>> flash border. So only the first 9 MiB of the flash could be used in Linux.
>>>>>> The remaining 7 MiB couldn't be accessed.
>>>>> Perhaps it would be better to drop the flash layout from the in-kernel
>>>>> dts files entirely since flash layout can be a fluid thing.
>>>> Well, but that would not be really user friendly, I'd rather stick
>>>> with some default config.
>>> Strictly speaking the device-tree is not the right place for flash
>>> partitioning information.  We put it there because it's preferable to
>>> having hardcoded per-board flash layouts in the code itself.
>>>
>>> It only really works well, though, when there are strong conventions
>>> (shared with the firmware) about how to partition the flash.
>>>
>>> Where it's really up to the user to determine how they want to lay out
>>> their flash, putting things in the device tree isn't a really good
>>> idea.
>> In principle, you are right, we should not be putting a user dependent
>> configuration into .dts files. But on the other hand, bindings have
>> been defined for flash-like devices and their partition layouts and
>> physmap_of device driver is expecting to get this information from the
>> blob. So, it is the place for it. But if we are not to put partition
>> layouts into the default kernel .dts files then we should
>> provide/maintain some examples an that may be a even bigger mess.
>>
>>> Incidentally, it's not required that *all* the flash address space be
>>> in partitions, so it is possible only give partitions for those flash
>>> chunks which the firmware needs to know about.
>> That might be nicer solution but different variants of TQM5200 boards
>> do not share the same subset of partitions (default u-boot partitions
>> at least), so it will not help much.
> 
> It's probably more appropriate to have the flash partition layout in
> the u-boot environment and have u-boot populate the partition
> information in the device tree.

Yes, it's more appropriate but such feature is not currently available
in U-boot, so it has to be hand crafted until then. It just seemed
more convenient to have some reference example before there is a
support for passing partition layout from firmware.

But all right, will remove flash layouts from in-kernel .dts files.

Cheers,
m.
