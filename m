Return-Path: <miltonm@bga.com>
In-Reply-To: <200701311642.42397.arnd@arndb.de>
References: <45BE4FA4.9020105@us.ibm.com>
	<f00c5b64177eafd5445b9da2c8432aa8@bga.com>
	<200701311642.42397.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ca40499f1ef66ec7ca889a02ee2ba7cd@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 4/4] Add support to OProfile for profiling Cell BE SPUs --
	update
Date: Thu, 1 Feb 2007 12:56:46 -0600
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 31, 2007, at 9:42 AM, Arnd Bergmann wrote:

> On Wednesday 31 January 2007 10:24, Milton Miller wrote:
>>> +/* The three functions below are for maintaining and accessing
>>> + * the vma-to-file offset map.
>>> + */
>>> +vma_map_t * create_vma_map(const struct spu * spu, u64 objectid);
>>> +unsigned int vma_map_lookup(vma_map_t *map, unsigned int vma,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =
=A0const struct spu * aSpu);
>>> +void vma_map_free(struct vma_map *map);
>>> +
>>
>> Why would the SPU to cookie translation need to be different
>> than the standard vm one? =A0 Is it that spufs takes refs on the
>> pages but doesn't have the standard vma? =A0 Maybe an approach
>> of creating them would reuse the oprofile code.
>
> It's a two stage process for SPUs:
>
> * samples are relative to the local store, and for each sample
>   we need to know what context was running. The context is
>   identified over a pointer to user space effective addresses.
>

Ok I'm with you so far.   There is a separate address space, the
local store, which you abbreviate ls below.  The trace gives
this local address.

> * The effective address identifies the SPU ELF binary mapped
>   at that address. It may however be in the middle of a VMA,
>   so you get another offset into the mapped file.

I think this is where we start to diverge.

Can you only map 1 linear range of 1 file as the SPU local store?

I thought you were mentioning shared libraries, and had mmap,
shared mappings of text, etc.

>
> For each sample, you then get an offset into the ls, an offset
> into the file to identify the ELF object, and the dcookie
> for the file containing that object

You are supplying
    (1) offset in local store
    (2) offset from dcookie to local store (?   you said ELF object)
    (3) file containing #2

So there is exactly one backing object for the entire local
store, and its mapped linearly?


> As a consequence, you only need dcookies for the case where
> a context switch happens (the executable changes), but not
> for each of the samples during the a time slice, they all
> point to the same object.


My understanding is the dcookie is supposed to represent a backing
file object.  The combination (dcookie, offset) should lead to
the backing object, which userspace can then disassemble, etc.

Therefore, if you allow multiple pieces to be mapped into local store,
then you should be reverse translating each ls address into (file,=20
offset)
of that file system object.   The fact that its contained in a bigger
elf file may mean that userspace needs some more info, but it still
needs the same info.

If you do allow more than 1 backing object, then my suggestion was
to use the common code by setting up a fake vm context that has
kernel vmas and let the generic code lookup the file from this context.

milton=
