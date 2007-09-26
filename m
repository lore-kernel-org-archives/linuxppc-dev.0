Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id BBB16DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 15:49:43 +1000 (EST)
In-Reply-To: <20070925032705.GA2525@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-01.miltonm@bga.com>
	<20070924025824.GD8058@localhost.localdomain>
	<c76a222305d08e74b878c946d4181078@bga.com>
	<20070925032705.GA2525@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0945801e4a137d002d180f4f362af76d@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/15] boot: find initrd location from device-tree
Date: Wed, 26 Sep 2007 00:49:26 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 24, 2007, at 10:27 PM, David Gibson wrote:

> On Mon, Sep 24, 2007 at 03:02:36AM -0500, Milton Miller wrote:
>>
>> On Sep 23, 2007, at 9:58 PM, David Gibson wrote:
>>
>>> On Fri, Sep 21, 2007 at 06:03:24PM -0500, Milton Miller wrote:
>>>> Some platforms have a boot agent that can create or modify 
>>>> properties
>>>> in
>>>> the device-tree and load images into memory.  Provide a helper to 
>>>> set
>>>> loader_info used by prep_initrd().
>>>>
>>>> Signed-off-by: Milton Miller <miltonm@bga.com>
>>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> Hrm, despite my earlier ack, I'm going to whinge about a few nits
>>> here.
>>>
>>>> ---
>>>> re 12168
>>>> rediffed types.h, offset in ops.h
>>>>
>>>> Index: kernel/arch/powerpc/boot/ops.h
>>>> ===================================================================
>>>> --- kernel.orig/arch/powerpc/boot/ops.h	2007-09-17 
>>>> 22:12:47.000000000
>>>> -0500
>>>> +++ kernel/arch/powerpc/boot/ops.h	2007-09-17 22:12:51.000000000 
>>>> -0500
>>>> @@ -163,6 +163,7 @@ void dt_fixup_clock(const char *path, u3
>>>>  void __dt_fixup_mac_addresses(u32 startindex, ...);
>>>>  #define dt_fixup_mac_addresses(...) \
>>>>  	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
>>>> +void dt_find_initrd(void);
>>>>
>>>>
>>>>  static inline void *find_node_by_linuxphandle(const u32 
>>>> linuxphandle)
>>>> Index: kernel/arch/powerpc/boot/types.h
>>>> ===================================================================
>>>> --- kernel.orig/arch/powerpc/boot/types.h	2007-09-17
>>>> 22:12:47.000000000 -0500
>>>> +++ kernel/arch/powerpc/boot/types.h	2007-09-17 22:12:51.000000000
>>>> -0500
>>>> @@ -12,6 +12,8 @@ typedef short			s16;
>>>>  typedef int			s32;
>>>>  typedef long long		s64;
>>>>
>>>> +#define UINT_MAX	0xFFFFFFFF
>>>
>>> I actually don't like this constant - at the point you compare you
>>> care, explicitly, about the value not being over 32-bits, rather than
>>> whether it fits a uint, so the named constant is more misleading than
>>> helpful.
>>
>> Arguable, I don't like counting F's or zeros in C code.
>
> So check if (addr >> 32) is non-zero.
>
>> It is used as the max address that the wrapper deals with, both here
>> and memranges, which happens to be 32 bits.
>
> Right and the reasons for that being the value it is are not because
> it also hapeens to be the max uint *or* ulong.

Huh?  the code is checking that the value will fit in the ulongs that 
are the type that stores this value in the struct.  Are you aruging for 
max_ptr_type?   If the code were compiled LP64 then it would not need 
to check that the address was 32 bits.   Here you say "check for 32 
bits", while below ...

>
>> Actually it cares about overflowing the unsigned long in loader_info,
>> not that the address fits in 32 bits.
>>
>> So it should be ULONG_MAX now (malloc and all the address code was
>> changed to use unsigned long instead of unsigned int since the patch
>> was written).
>>
>> And dt_xlate needs the same information.  Its is using a hardcoded 64
>> bit constant to provide the a simiar check.
>>
>>
>>>> +
>>>>  #define min(x,y) ({ \
>>>>  	typeof(x) _x = (x);	\
>>>>  	typeof(y) _y = (y);	\
>>>> Index: kernel/arch/powerpc/boot/devtree.c
>>>> ===================================================================
>>>> --- kernel.orig/arch/powerpc/boot/devtree.c	2007-09-17
>>>> 22:12:47.000000000 -0500
>>>> +++ kernel/arch/powerpc/boot/devtree.c	2007-09-17 22:12:51.000000000
>>>> -0500
>>>> @@ -1,6 +1,7 @@
>>>>  /*
>>>>   * devtree.c - convenience functions for device tree manipulation
>>>>   * Copyright 2007 David Gibson, IBM Corporation.
>>>> + * Copyright 2007 Milton Miller, IBM Corporation.
>>>>   * Copyright (c) 2007 Freescale Semiconductor, Inc.
>>>>   *
>>>>   * Authors: David Gibson <david@gibson.dropbear.id.au>
>>>> @@ -333,3 +334,68 @@ int dt_is_compatible(void *node, const c
>>>>
>>>>  	return 0;
>>>>  }
>>>> +
>>>> +/**
>>>> + * dt_find_initrd - set loader initrd location based on existing
>>>> properties
>>>> + *
>>>> + * finds the linux,initrd-start and linux,initrd-end properties in
>>>> + * the /chosen node and sets the loader initrd fields accordingly.
>>>> + *
>>>> + * Use this if your loader sets the properties to allow other code 
>>>> to
>>>> + * relocate the tree and/or cause r3 and r4 to be set on true OF
>>>> + * platforms.
>>>
>>> I am unable to make sense of the paragraph above.
>>
>> The phrase "relocate the tree" should be "relocate the initrd", which
>> the wrapper will do if it located below vmlinux.size.  Also, r3 and r4
>> need to be set when booting the kernel from a client interface with an
>> initrd so it can take it into consideration when choosing the location
>> to build the flat tree.
>>
>> How about:
>>
>> Filling in the loader info allows main.c to be aware of the initrd,
>> meaning prep_initrd will move the initrd if it will be overwritten 
>> when
>> the kernel is copied to its runtime location.  In addition, if you are
>> booting the kernel from a client interface instead of a flat device
>> tree, this also causes r3 and r4 to be set so the kernel can avoid
>> overwriting the initrd when creating the flat tree.
>
> Clearer, but I still don't see that it says anything useful - "finds
> the initrd from the devtree and does all the things that are supposed
> to be done with an initrd" - which is implied in the previous
> paragraph.

I was tring to point out there is additional processing that is done 
when the bootwrapper is aware of the initrd, as opposed to the kernel 
finding it after it processes the flattened the tree.  suggestions?

>>>> + */
>>>> +void dt_find_initrd(void)
>>>> +{
>>>> +	int rc;
>>>> +	unsigned long long initrd_start, initrd_end;
>>>> +	void *devp;
>>>> +	static const char start_prop[] = "linux,initrd-start";
>>>> +	static const char end_prop[] = "linux,initrd-end";
>>>
>>> I think these constants are more obscuring than useful.
>>
>> They are useful to the extent they reduce the number of source
>> characters causing about 8 less line wraps.  Since they are used
>> multiple places, the compiler only needs to emit one copy of this byte
>> sequence.  Admitedly you made this point in a prior review.
>
> The compiler is perfectly capable of folding identical string
> constants.

Yes it is, but are you going to leave the constant strings as %s in the 
printf strings?

Maybe i shold create a function that takes the property and returns the 
int if its either 32 or 64 bits, calling it twice?


>>>> +
>>>> +	devp = finddevice("/chosen");
>>>> +	if (! devp) {
>>>> +		return;
>>>> +	}
>>>
>>> CodingStyle would not put { } here.
>>
>> Yea, nit.  not sure why I have the braces there, I usually follow that
>> one.  And what's that space doing after !?
>>
>>>
>>>> +
>>>> +	rc = getprop(devp, start_prop, &initrd_start, 
>>>> sizeof(initrd_start));
>>>> +	if (rc < 0)
>>>> +		return;				/* not found */
>>>> +	/* The properties had to be 8 bytes until 2.6.22 */
>>>> +	if (rc == sizeof(unsigned long)) {
>>>> +		unsigned long tmp;
>>>> +		memcpy(&tmp, &initrd_start, rc);
>>>> +		initrd_start = tmp;
>>>> +	} else if (rc != sizeof(initrd_start)) {	/* now they
>>>> can be 4 */
>>>
>>> Right.  8 bytes and 4 bytes, so you should be using explicit length
>>> types instead of long and long long.
>>
>> Ok, I guess we ahve u32 and u64 in types.h now.  But there is other
>> code in the wrapper that assumes its compiled 32 bit ILP.
>
> Yes, but that's no reason to propagate the sin.

HAH!  so abvoe you are tring to get me to hard code in 32 bits, and now 
you argue that long == 32 bits is "sinful"?

>
>>>> +		printf("unexpected length of %s in /chosen!\n\r", start_prop);
>>>> +		return;
>>>
>>> All these printf() / return stanzas add a lot of verbosity to this
>>> function.  Any way they can be consolidated a bit, maybe a single
>>> error path that just prints the property values, so the user can
>>> figure out what was wrong with them.
>>
>> On a prior review I got asked to split the reasons for ingoring the
>> values below (the > 32 bit address from end < start cases).  Admitedly
>> without all the detailed errors the justification for the string
>> varables is reduced.
>
> Hrm.  Well, I can't say I'm entirely convinced either way on this
> one.  I guess I'll think about it again once the rest is cleaned up.

I'll make some of these changes when I get back to work (been at the 
power.org conference), but I still think ulong_max is the correct 
check.

milton
