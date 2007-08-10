Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070810010723.GB17370@localhost.localdomain>
References: <20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<163e1bcdc507ddcde3193e842c96da43@kernel.crashing.org>
	<20070807041259.GF13522@localhost.localdomain>
	<b055a84cbb23ef7287c1d585c1810a74@kernel.crashing.org>
	<20070808011324.GD25082@localhost.localdomain>
	<019ae19815eb3301065ba732e3e72f44@kernel.crashing.org>
	<20070810010723.GB17370@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5a3735f1484493fdc9825bbc9a3371c2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Fri, 10 Aug 2007 22:48:58 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> Why is "ranges" conceptually wrong?
>>>>
>>>> The flash partitions aren't separate devices sitting on a
>>>> "flash bus", they are "sub-devices" of their parent.
>>>
>>> Well, yes, but nonetheless the partitions show up as part of the
>>> overall physical address space.  How do you encode that other than in
>>> 'ranges'?
>>
>> All that address space shows up in the flash node already.  To
>> access the partitions you have to go via that "master" node
>> anyway (some commands have to be sent to address 0 on the flash,
>> or similar).
>
> Hrm, I suppose.  Although for read-only access that's not relevant.

Sure, for just accessing the data, all you need is a mapping
and off you go.

>> It is a very nice feature to not only be able to translate addresses
>> "up" the device tree, but also "down".
>
> I don't follow, sorry.

Given a host address, it is nice if you can uniquely identify
the device node you access via it.

>> Also, it mimics reality, just like a good OF citizen should:
>> those partitions aren't actually devices at all, so they
>> certainly shouldn't be assigned a part of the host address
>> space.
>
> Hrm.  I'm not entirely convinced that the distinction between
> "actually a device" and "not actually a device" is really as clear cut
> as you imply.

A flash partition isn't an actual device, you cannot do all
needed operations on it without using the actual flash device
as well, even if the partition is neatly aligned on flash
blocks / flash sectors (and the proposed binding doesn't require
that; there is no need to, either, I think).

>>>>> To be honest this looks rather to me like another case where having
>>>>> overlapping 'reg' and 'ranges' would actually make sense.
>>>>
>>>> It never makes sense.  You should give the "master" device
>>>> the full "reg" range it covers, and have it define its own
>>>> address space; "sub-devices" can carve out their little hunk
>>>> from that.  You don't want more than one device owning the
>>>> same address range in the same address space.
>>>
>>> Why not?  After all, the physical address ranges of the flash
>>> partitions really do overlap with that of the flash device as a 
>>> whole.
>>
>> They don't overlap, a partition is a proper subset of the flash.
>
> A proper subset is a form of overlapping (indeed cases of being a
> proper subset form a proper subset of cases of overlapping, to be
> gratuitously meta-set-theoretic).

Yeah well, depends on your viewpoint.

>> Which as usual is shown as "reg" in the child node and #a,#s in
>> the parent node.
>
> That in no way encodes that the child addresses are a subset of the
> parent address space.

It does, via the semantics of the flash binding: its child nodes
are partitions on the flash device.

> Instead #a and #s establish a new, separate
> address space for the children, and without 'ranges', there's no
> information about any sort of connection, overlapping, proper-subset
> or otherwise, with the parent address space.

Such information is there implicitly, per the binding.


Segher
