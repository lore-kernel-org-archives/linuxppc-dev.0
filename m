Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZFqJ5CBpzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 15:01:32 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: pc@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
In-Reply-To: <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
 <877f48kx0q.fsf@concordia.ellerman.id.au>
 <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
Date: Fri, 03 Mar 2017 15:01:32 +1100
Message-ID: <87fuivhuub.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Clarke <pc@us.ibm.com> writes:

> On 03/02/2017 12:33 AM, Michael Ellerman wrote:
>> Paul Clarke <pc@us.ibm.com> writes:
>>> On 02/02/2017 12:22 AM, Benjamin Herrenschmidt wrote:
>>>> This adds AUX vectors for the L1I,D, L2 and L3 cache levels
>>>> providing for each cache level the size of the cache in bytes
>>>> and the geometry (line size and number of ways).
>>>>
>>>> We chose to not use the existing alpha/sh definition which
>>>> packs all the information in a single entry per cache level as
>>>> it is too restricted to represent some of the geometries used
>>>> on POWER.
>>>>
>>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> ---
>>>>
>>>> v2. Remove some leftovers and fix 32-bit build
>>>>
>>>> Paul, can you test & ack this please ? It replaces the last patch of
>>>> my previous series (the rest is identical).
>>>
>>> Sorry for the delay on this, I totally missed this e-mail until this week.
>>>
>>> I tested this with the Power Functional Simulator (a.k.a. Mambo), with
>>> a fairly recent 4.9 kernel from the powerpc git tree.
>>
>> You mean 4.9 plus this patch?
>>
>>> Using Mambo-P8, I see what I expect for cache line size, but associativity is 0:
>>> AT_L1I_CACHESIZE: 32768 (0x8000)
>>> AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
>>> AT_L1D_CACHESIZE: 32768 (0x8000)
>>> AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
>>> AT_L2_CACHESIZE: 524288 (0x80000)
>>> AT_L2_CACHEGEOMETRY: associativity 0; line size 128
>>> AT_L3_CACHESIZE: 8388608 (0x800000)
>>> AT_L3_CACHEGEOMETRY: associativity 0; line size 128
>>>
>>> ...shouldn't associativity be 8 for all levels?
>>
>> Yes.
>>
>> I fixed it in v3: http://patchwork.ozlabs.org/patch/723576/
>>
>> Which is now merged in Linus tree, so please test that.
>
> It's not working for me, but it's also very likely that I could be
> doing something stupid. Just pulling from
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, it
> built (without the "systemsim" patches"), but wouldn't boot in Mambo
> (not because it couldn't find root...something else not fully
> explored).

Hmm OK, it's booting for me, but might depend on your config/toolchain
etc. Linus' tree just before rc1 is a bit of a dangerous place to be.

> I checked out tag "v4.10", and that built (with the
> "systemsim" patches, Ben's 1-8 and your 9v3) and booted.

I think you need my entire v3, ignore Ben's series.

> On Mambo-P8,
> the device tree looks correct (to me), but the associativity is still
> 0.

OK, I think if you use the full v3 the associativity will be fixed.

Though it might still be wrong, because the kernel code hard codes the
values on P8 bare metal, because on real machines (running skiboot) the
values provided in the device tree are wrong.

Hopefully those hard coded values are also correct on p8 mambo, but we
should probably check.

See: https://git.kernel.org/torvalds/c/608b42140e96

> On P9, the device tree isn't correct, so I'm not sure what to expect.

Junk :)

On P9 it all comes from the device tree so if that's wrong the AUX
vectors will definitely be wrong.

>> Can you try the test program I wrote (which may also have bugs):
>>
>>   http://patchwork.ozlabs.org/patch/724418/
>
> I couldn't get this working, either, so I'm probably doing something stupid.

Did you apply the first patch of the series also?

If you apply those on top of v4.10 and then do:

$ make TARGETS=powerpc ARCH=powerpc CROSS_COMPILE=ppc64le- -C tools/testing/selftests

You should end up with:

$ file tools/testing/selftests/powerpc/cache_shape/cache_shape
tools/testing/selftests/powerpc/cache_shape/cache_shape: ELF 64-bit LSB executable, 64-bit PowerPC or cisco 7500, version 1 (SYSV), dynamically linked, interpreter /lib64/ld64.so.2, for GNU/Linux 3.2.0, BuildID[sha1]=3535b7ab6ec854eceaa7ad23456a087111b51583, not stripped


cheers
