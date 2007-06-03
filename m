Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 5F740DDEF5
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 06:09:14 +1000 (EST)
Message-ID: <4663203F.30301@ru.mvista.com>
Date: Mon, 04 Jun 2007 00:10:39 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<4662FA67.3020107@ru.mvista.com>
	<a5dde31321a50ed198cf4fc199e4af9c@kernel.crashing.org>
	<4663060C.2020906@ru.mvista.com>
	<c077dedaa90bf4fb3af1c5c8c4b39c85@kernel.crashing.org>
	<46630F8F.6080708@ru.mvista.com>
	<bd28eac8eb60db8aaff74f91c76d4196@kernel.crashing.org>
In-Reply-To: <bd28eac8eb60db8aaff74f91c76d4196@kernel.crashing.org>
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
>>>>    No! It doesn't have anything to do with "ranges" of parent (don't 
>>>> even know why it would). :-O
>>
>>
>>> So learn about it please?  "ranges" means exactly that:
>>> child nodes' address space is direct mapped.
>>
>>
>>    Well, now we certainly need a parent node -- which would be static 
>> bus controller?

> I have no clue what a "static bus controller" is.  Your

    As has been pointed out in the previous "fit" of this dispute, the NOR 
flashes are usually behind a kind of bridge between the "host" and 
"peripheral" (static) busses.

> flash node obviously needs _some_ parent node though --
> this is a tree after all.

   Yes, of course it always has a perent. The question is which parent it 
should be. :-)

>> But those have multiple chips selects, so we should know which range 
>> to use. Ugh...

> That is described in the "reg" property of the flash
> node, just like for any other node.

    Ah. So simple. :-)
    What I failed to realize so far was that "ranges" imply 1:1 address 
correspondence. But not all is so simple, I'm afraid. The flash chips 
themselves could be connected to their bus in some weird fashion, I'm afraid 
(not that it's likely to happen on mostly big-endian PPC though).

>>>> And why you haven't complained at MPC5200 IDE driver

>>> Since no one paid me to review the code?  Please don't try

>>    Sigh, nobody pays me for that too. :-)

> Yeah it's a shame isn't it?

    Well, I'm doing it anyway. :-)

>>>>    Anyway, reasonable suggestions on how to make MTD nodes more 
>>>> viable are always welcome. I just haven't seen reasonable enough 
>>>> yet. ;-)

>>> I suggest you read, and try to understand, some of the base
>>> device tree specifications first.

>>    Read them some months ago -- do you think I would have plunged into 
>> that not reading anything first? :-/

> It seems we really need more howto-style docs...

    It may indeed be non-trivial task to find all the necessary specs besides 
1285 itself -- I just happened to know where to grab them beforehand:

http://www.openbios.org/Bindings

> Segher

WBR, Sergei
