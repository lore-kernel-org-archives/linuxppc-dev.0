Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0874ADDECD
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jul 2007 09:42:34 +1000 (EST)
In-Reply-To: <200707082236.36722.arnd@arndb.de>
References: <1179245829.8132.100.camel@rhino> <468FDB8F.4050007@ru.mvista.com>
	<3D4AB802-A3D2-46CC-9BD1-1064EE0AC84C@kernel.crashing.org>
	<200707082236.36722.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D1E49167-F35F-4E6D-BE9E-3F08D0C0B815@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
Date: Mon, 9 Jul 2007 01:42:23 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>>> +                          8042@60 {
>>>>>> +                                  device_type = "8042";
>>>
>>>> Drop the device_type.  A number as a name isn't
>>>> all that great, either.
>>>
>>>   Yet it's kinda accepted years ago, see:
>>>
>>> http://playground.sun.com/1275/proposals/Closed/Accepted/381-it.txt
>>
>> That's not a published recommendation or anything like that.
>
> But still, it's what got used in what appears to be all ISA based  
> machines
> with such a keyboard controller, both PowerPC and i386 ones.

For PowerPC, I only know about CHRP, which has its own binding
for 8042.  For i386 I think you refer to the OLPC?  It does _not_
comply with this #381 (it has a different unit address text
representation, for one thing).  Also, it has "ps2-interrupt-controller"
in its "compatible" property, which is a much nicer thing to match
drivers on for the OS.

> Are you suggesting that we should declare all existing machines  
> wrong and do
> our own thing instead?

You can read in my words whatever you want, but the only thing
I suggested was what I wrote: drop the device_type.  It is
completely useless in a flat device tree whatever binding you
follow here.

And put something more useful than a bare number in the "compatible"
property.  If you feel you really need to you can _also_ put the
number there, but I think you'll find you don't really want to.

And the "name" should be "keyboard-controller" or something like
that, following the generic names recommended practice.

I would argue the 8042 node shouldn't have a device_type at all
btw, since there is no defined effect of "open"ing this node; but
that is a completely separate discussion.


Segher
