Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11A24DDE48
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 05:48:27 +1000 (EST)
In-Reply-To: <46630F8F.6080708@ru.mvista.com>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
	<a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
	<4663060C.2020906@ru.mvista.com>
	<c077dedaa90bf4fb3af1c5c8c4b39c85@kernel.crashing.org>
	<46630F8F.6080708@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <bd28eac8eb60db8aaff74f91c76d4196@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Date: Sun, 3 Jun 2007 21:48:15 +0200
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

>>>    No! It doesn't have anything to do with "ranges" of parent (don't 
>>> even know why it would). :-O
>
>> So learn about it please?  "ranges" means exactly that:
>> child nodes' address space is direct mapped.
>
>    Well, now we certainly need a parent node -- which would be static 
> bus controller?

I have no clue what a "static bus controller" is.  Your
flash node obviously needs _some_ parent node though --
this is a tree after all.

> But those have multiple chips selects, so we should know which range 
> to use. Ugh...

That is described in the "reg" property of the flash
node, just like for any other node.

>> Because that is a) not what you are supposed to do according
>> to the standard (so it might very well not work with a
>> "third-party" device tree that equally conforms to the standard);
>> b) "device_type" describes some other information (namely, the
>> OF programming model for the device node) that is completely
>> unrelated to the process of driver matching; and c) it is wholly
>> redundant to the information in "compatible" *ANYWAY*.
>
>    Hm, well. Than changing "compatible" prop would make sense.

Yes.

>>> And why you haven't complained at MPC5200 IDE driver
>
>> Since no one paid me to review the code?  Please don't try
>
>    Sigh, nobody pays me for that too. :-)

Yeah it's a shame isn't it?

>>> which does the same (well, maybe you have :-) or at PowerMac IDE 
>>> driver which matches wither by "name" or "device_type"? Well, quite 
>>> a lot of drivers are doing this...
>
>> See before why that may be.  Short answer is "history".
>
>    Well, at least that's cleared.

Okido, good to hear.

>>>    Anyway, reasonable suggestions on how to make MTD nodes more 
>>> viable are always welcome. I just haven't seen reasonable enough 
>>> yet. ;-)
>
>> I suggest you read, and try to understand, some of the base
>> device tree specifications first.
>
>    Read them some months ago -- do you think I would have plunged into 
> that not reading anything first? :-/

It seems we really need more howto-style docs...


Segher
