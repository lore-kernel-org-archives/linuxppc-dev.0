Return-Path: <miltonm@bga.com>
Received: from kcout01.prserv.net (kcout01.prserv.net [12.154.55.31])
	by ozlabs.org (Postfix) with ESMTP id 3DB30DDE20
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 03:42:25 +1000 (EST)
In-Reply-To: <20070430181954.GB7673@mag.az.mvista.com>
References: <35d250938c0c5d7dae6a8735343059b7@bga.com>
	<20070430181954.GB7673@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b4f15895a468ee9a617acd319a51c328@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 12/13] powerpc: Add bootwrapper support for Motorola
	PrPMC2800 platform
Date: Tue, 1 May 2007 12:06:48 -0500
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2007, at 1:19 PM, Mark A. Greer wrote:

> On Mon, Apr 30, 2007 at 11:15:23AM -0500, Milton Miller wrote:
>> On Thu Apr 26 10:02:27 EST 2007, Mark A. Greer wrote:
>>> Add support for Motorola ECC PrPMC280/PrPMC2800 Platform.
>>> The PrPMC280 sits on an F101 baseboard and the PrPMC2800 sits on a
>>> F101e baseboard.  Logic has been added to determine which board
>>> (and variant thereof) the code is being run on.

>>> +               setprop(devp, "device_type", "mv64362",
>>> strlen("mv64362") + 1);
>> That is not a device_type.   It might be a model,   Or even a
>> compatable.  but not a type.
> How about "host-bridge" or is that too generic?
That would be ok but that could be precompiled, vs set in code.

I was thinking you wanted to expose the vpd determined specific
bridge to the kernel / user.

>>> +/* Following code is put at very beginning of zImage (64KB into ELF
>>> file) */
>>> +asm (" .globl _zimage_start\n\
>>> +       _zimage_start:\n\
>>> +               mfmsr   10\n\
>>> +               rlwinm  10,10,0,~(1<<15)        /* Clear MSR_EE */\n\
>>> +               sync\n\
>>> +               mtmsr   10\n\
>>> +               isync\n\
>>> +               b _zimage_start_lib\n\
>>> +");
>>>
>
> Yes, its a poorly worded comment.
>
>> Also, the 1<<15 seems magic.  I would like to see it as a constant in
>> reg.h,
>
> It probably makes sense to add some MSR definitions to reg.h.
>
>> but to use that you would have to pass it as an i parameter, so
>
> I don't follow.  What's wrong with '#define MSR_EE (1<<15)'
> in reg.h and 'rlwinm  10,10,0,~MSR_EE'?

I think you will find that cpp doesn't replace the define inside
the string.   And by the time you stop the string, stringify the
define, and restart the string, you might as well pass it as a
parameter.  Also, in C we sometimes add things like ULL that
aren't valid in assembler, although that's more of a 64 bit issue.

milton
