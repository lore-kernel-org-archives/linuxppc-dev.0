Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46CF2D2C.2050306@ru.mvista.com>
References: <20070730150648.GA5005@ru.mvista.com>	<20070801020836.GB31391@localhost.localdomain>	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>	<20070801050422.GI31391@localhost.localdomain>	<20070801054751.GM31391@localhost.localdomain>	<46B1F6D4.3070707@ru.mvista.com>	<20070803031349.GD6418@localhost.localdomain>	<46B34E1F.5060009@ru.mvista.com>	<20070806042109.GB6103@localhost.localdomain>	<163e1bcdc507ddcde3193e842c96da43@kernel.crashing.org>	<20070807041259.GF13522@localhost.localdomain>
	<b055a84cbb23ef7287c1d585c1810a74@kernel.crashing.org>
	<46CF2D2C.2050306@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <74da1d2452d65fba69ea9b1bade7aac5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Fri, 24 Aug 2007 22:43:45 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> address-permutation = <0 1 3 2 4 5 7 6 e f d c a b 9 8>;
>
>>> Yes, I was contemplating something like that.
>
>> Let's not define this until we need it though :-)
>
>    Let's ot even think of it,

It is good to think about it, for the simple reason that it
validates whether the current design is future-proof or not.

> since this will end up in a "catch all" driver,

Yeah, we shouldn't _define_ anything like this, not until
it is needed anyway.

> and yet this may be not enough when the flash doesn't support 8-but 
> R/W, for example (I've already quoted it...

Yeah.  There is no need to future-proof to insane designs anyway;
whatever can not fit in the "generic" framework can bloody well
just do its own binding, no need to pollute the generic thing.

>>>> I haven't heard or thought of anything better either.  Using 
>>>> "ranges"
>>>> is conceptually wrong, even ignoring the technical problems that 
>>>> come
>>>> with it.
>>> Why is "ranges" conceptually wrong?
>
>> The flash partitions aren't separate devices sitting on a
>
>    Yeah, that's why I decided not to go that from the very start... 
> though wait: I didn't do this simply because they'renot devices.
> That lead me to interesting question: do device tree have something 
> for the disk partitions?

Some do.  Most don't.  There is no standardised binding I know of.

The big huge difference here is that disks typically do contain
partitioning information on the disk itself, and flash doesn't.

>> "flash bus", they are "sub-devices" of their parent.
>
>    They're quite an abstaction of a device -- althogh Linux treats 
> them as separate devices indeed.

Sure, it's a pseudo-device.  Nothing new there.

>>> To be honest this looks rather to me like another case where having
>>> overlapping 'reg' and 'ranges' would actually make sense.
>
>> It never makes sense.  You should give the "master" device
>> the full "reg" range it covers, and have it define its own
>> address space; "sub-devices" can carve out their little hunk
>> from that.  You don't want more than one device owning the
>> same address range in the same address space.
>
>    So, no "ranges" prop in MTD node is necessary? Phew... :-)

Yeah, it would be positively harmful.  They are pseudo-devices
only, the kernel device driver needs to always access the real
device.


Segher
