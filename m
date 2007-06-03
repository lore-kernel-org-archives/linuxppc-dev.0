Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 493FCDDF0B
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:43:11 +1000 (EST)
In-Reply-To: <4663060C.2020906@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
	<a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
	<4663060C.2020906@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c077dedaa90bf4fb3af1c5c8c4b39c85@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 20:43:03 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
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

>>>> I think "direct-mapped" as compatible is a bit too broad or vague.
>
>>>     It's actually not -- it means simple 1:1 address mapping (w/o 
>>> explicit
>>> byte-swapping and such).
>
>> Which has nothing to do with "compatible"; instead,
>> it is implied by the parent node have a "ranges"
>
>    No! It doesn't have anything to do with "ranges" of parent (don't 
> even know why it would). :-O

So learn about it please?  "ranges" means exactly that:
child nodes' address space is direct mapped.

>> property.  Or you can put some other property in
>> the flash node for all I care, if that seems
>> necessary for certain cases.
>
>    Erm... it's *certainly* necessary to mark this somewhere.

Not if it's redundant information.

>>>> The compatible is supposed to be useable to find and match a driver
>>>> without regard to the name of the node.  Perhaps direct-mapped-rom?
>
>    That really depends on whether we choose to follow the Generic 
> Names spec.

No, it doesn't.  OF before the generic names recommended practice
was different only in that it had "name" be the most specific
of the device descriptions.

Also, it has already been decided to follow this recommended
practice.  It would have been foolish not to, it being collected
wisdom by real-life implementations and all.

> Even if we do, it does *not* preclude OS from using both props for the 
> driver selection.

An OS is *required* (erm, "supposed", if you like) to use
first "name", and then "compatible".  An OS is not supposed
to use "device_type" or any other properties for device
matching.

>>>     Note that we're matching by both "device_type" and "compatible".
>
>> Which is wrong.
>
>    Why?

Because that is a) not what you are supposed to do according
to the standard (so it might very well not work with a
"third-party" device tree that equally conforms to the standard);
b) "device_type" describes some other information (namely, the
OF programming model for the device node) that is completely
unrelated to the process of driver matching; and c) it is wholly
redundant to the information in "compatible" *ANYWAY*.

> And why then it's allowed to match by "device_type"?

Anything is allowed, this is a free world.  It is wrong though.
Linux used to do this wrong, there are many remnants of that
left.  You also might *need* to do this for certain imperfect
device trees.  None of this is an argument to continue this
"tradition".

> And why you haven't complained at MPC5200 IDE driver

Since no one paid me to review the code?  Please don't try
that argument ever again, thank you very much.  I think I
do quite enough work here already, I don't need people
demanding stuff from me.

> which does the same (well, maybe you have :-) or at PowerMac IDE 
> driver which matches wither by "name" or "device_type"? Well, quite a 
> lot of drivers are doing this...

See before why that may be.  Short answer is "history".

>>>     This would serve no purpose, as the driver that would catches 
>>> all these is signle one, drivers/mtd/maps/physmap_of.c...
>
>> With the current kernel version, perhaps.  Did you check
>> out 2.6.28?  Does it work with that?
>
>    For the simply mapped flashes, physmap_of will suffice, for more 
> complex cases, other driver will be needed.

Ah, so you can predict the future of the Linux kernel!

>  If you're hinting at the possibility that MTD subsys will be 
> substantially reworked -- I don't find that likely. If it will -- 
> well, bad luck. :-)

Which is not an acceptable outcome.

>    Anyway, reasonable suggestions on how to make MTD nodes more viable 
> are always welcome. I just haven't seen reasonable enough yet. ;-)

I suggest you read, and try to understand, some of the base
device tree specifications first.


Segher
