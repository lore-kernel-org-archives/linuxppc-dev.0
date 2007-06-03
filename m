Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id D29D4DDF2D
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 04:57:57 +1000 (EST)
Message-ID: <46630F8F.6080708@ru.mvista.com>
Date: Sun, 03 Jun 2007 22:59:27 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
	<a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
	<4663060C.2020906@ru.mvista.com>
	<c077dedaa90bf4fb3af1c5c8c4b39c85@kernel.crashing.org>
In-Reply-To: <c077dedaa90bf4fb3af1c5c8c4b39c85@kernel.crashing.org>
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
>>>>> I think "direct-mapped" as compatible is a bit too broad or vague.

>>>>     It's actually not -- it means simple 1:1 address mapping (w/o 
>>>> explicit
>>>> byte-swapping and such).

>>> Which has nothing to do with "compatible"; instead,
>>> it is implied by the parent node have a "ranges"

>>    No! It doesn't have anything to do with "ranges" of parent (don't 
>> even know why it would). :-O

> So learn about it please?  "ranges" means exactly that:
> child nodes' address space is direct mapped.

    Well, now we certainly need a parent node -- which would be static bus 
controller? But those have multiple chips selects, so we should know which 
range to use. Ugh...

>>> property.  Or you can put some other property in
>>> the flash node for all I care, if that seems
>>> necessary for certain cases.

>>    Erm... it's *certainly* necessary to mark this somewhere.

> Not if it's redundant information.

>>>>     Note that we're matching by both "device_type" and "compatible".

>>> Which is wrong.

>>    Why?

> Because that is a) not what you are supposed to do according
> to the standard (so it might very well not work with a
> "third-party" device tree that equally conforms to the standard);
> b) "device_type" describes some other information (namely, the
> OF programming model for the device node) that is completely
> unrelated to the process of driver matching; and c) it is wholly
> redundant to the information in "compatible" *ANYWAY*.

    Hm, well. Than changing "compatible" prop would make sense.

>> And why then it's allowed to match by "device_type"?

> Anything is allowed, this is a free world.  It is wrong though.
> Linux used to do this wrong, there are many remnants of that
> left.  You also might *need* to do this for certain imperfect
> device trees.  None of this is an argument to continue this
> "tradition".

>> And why you haven't complained at MPC5200 IDE driver

> Since no one paid me to review the code?  Please don't try

    Sigh, nobody pays me for that too. :-)

> that argument ever again, thank you very much.  I think I
> do quite enough work here already, I don't need people
> demanding stuff from me.

   I wasn't demanding anything. I just wanted to clear things out.

>> which does the same (well, maybe you have :-) or at PowerMac IDE 
>> driver which matches wither by "name" or "device_type"? Well, quite a 
>> lot of drivers are doing this...

> See before why that may be.  Short answer is "history".

    Well, at least that's cleared.

>>>>     This would serve no purpose, as the driver that would catches 
>>>> all these is signle one, drivers/mtd/maps/physmap_of.c...

>>> With the current kernel version, perhaps.  Did you check
>>> out 2.6.28?  Does it work with that?
>
>>    For the simply mapped flashes, physmap_of will suffice, for more 
>> complex cases, other driver will be needed.

> Ah, so you can predict the future of the Linux kernel!

    If I could, I'd have taken measures. :-)

>>  If you're hinting at the possibility that MTD subsys will be 
>> substantially reworked -- I don't find that likely. If it will -- 
>> well, bad luck. :-)

> Which is not an acceptable outcome.

>>    Anyway, reasonable suggestions on how to make MTD nodes more viable 
>> are always welcome. I just haven't seen reasonable enough yet. ;-)

> I suggest you read, and try to understand, some of the base
> device tree specifications first.

    Read them some months ago -- do you think I would have plunged into that 
not reading anything first? :-/

> Segher

WBR, Sergei
