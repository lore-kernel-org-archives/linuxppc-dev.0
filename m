Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail1.matrix-vision.com (mail1.matrix-vision.com [78.47.19.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "localhost" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8A6BBB6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Dec 2010 19:52:24 +1100 (EST)
Message-ID: <4D01E90E.8070404@matrix-vision.de>
Date: Fri, 10 Dec 2010 09:47:10 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: MPC831x (and others?) NAND erase performance improvements
References: <20101207031554.GA12731@postdiluvian.org>	<20101207145153.540da45a@udp111988uds.am.freescale.net>	<OFF94B1B01.88594E81-ONC12577F3.002B63AA-C12577F3.002BEE0B@transmode.se>	<20101208111839.1cf95553@udp111988uds.am.freescale.net>	<OF349DC945.8BC48D34-ONC12577F3.00601D94-C12577F3.00605153@transmode.se>	<20101208192616.GA24560@postdiluvian.org>	<OF14047E09.664EC753-ONC12577F3.006CF507-C12577F3.006D97EA@transmode.se>	<20101208135928.0278f97d@udp111988uds.am.freescale.net>	<OFC37E86C9.59866BED-ONC12577F3.006E8F8D-C12577F3.006EE1FA@transmode.se>	<20101208142551.19ea2333@udp111988uds.am.freescale.net>	<OF6F049A4C.3AEB4068-ONC12577F3.00751175-C12577F3.0075D3F5@transmode.se>
	<20101208160531.393bedf1@udp111988uds.am.freescale.net>
In-Reply-To: <20101208160531.393bedf1@udp111988uds.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Mark Mason <mason@postdiluvian.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

do you think this issue also applies to MPC8377 ?

I'm in the middle of a small redesign for series production and would 
like not to miss a thing.
We have Nand, Nor and MRAM connected to LBC.

Since RFS is running from NAND and we use the MRAM as a non-volatile 
SRAM I'd like to avoid being hit by this issue.

Any comments from your side ?

Regards,
André

> On Wed, 8 Dec 2010 22:26:59 +0100
> Joakim Tjernlund<joakim.tjernlund@transmode.se>  wrote:
>
>> Scott Wood<scottwood@freescale.com>  wrote on 2010/12/08 21:25:51:
>>> On Wed, 8 Dec 2010 21:11:08 +0100
>>> Joakim Tjernlund<joakim.tjernlund@transmode.se>  wrote:
>>>
>>>> Scott Wood<scottwood@freescale.com>  wrote on 2010/12/08 20:59:28:
>>>>> On Wed, 8 Dec 2010 20:57:03 +0100
>>>>> Joakim Tjernlund<joakim.tjernlund@transmode.se>  wrote:
>>>>>
>>>>>> Can you think of any workaround such as not connecting the BUSY pin at all?
>>>>> Maybe connect the busy pin to a gpio?
>>>> Is BUSY required for sane operation or it an optimization?
>>> You could probably get away without it by inserting delays if you know
>>> the chip specs well enough.
>> Urgh, that does not feel like a good solution.
> No, but you asked if it could be done, and if it was just a
> performance issue. :-)
>
>>>> Is there any risk that the NAND device will drive the LB and corrupt
>>>> the bus for other devices?
>>> I think the only thing the NAND chip should be driving is the busy pin,
>> OK, good. What function is actually lost if one uses an GPIO instead of
>> BUSY?
> Not much, if you enable interrupts on the GPIO pin.  The driver would
> have to be reworked a bit, of course.
>
>> You think Freescale could test and validate a GPIO solution? I don't
>> think we will be very happy to design our board around an unproven
>> workaround.
> Ask your sales/support contacts.
>
>> An even better workaround would be if one could add logic between the
>> NAND and the CPU which would compensate for this defect without needing
>> special SW fixes.
> The problem with that is when would you assert the chipselect again to
> check if it's done?  Current SW depends on being able to tell the LBC
> to interrupt (or take other action) when busy goes away.
>
> I suppose you could poll with status reads, which could at least be
> preempted if you've got something higher priority to do with the LBC.
>
> -Scott
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
