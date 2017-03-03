Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZVvp26GhzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 00:51:17 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v23DoC1C140935
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 08:51:15 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xs8eh9eb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Mar 2017 08:51:14 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Fri, 3 Mar 2017 06:51:13 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2A2193E40048
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 06:51:12 -0700 (MST)
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v23DpBtq44302554
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Mar 2017 13:51:11 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1C82112047
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 08:51:10 -0500 (EST)
Received: from oc1087654862.ibm.com (unknown [9.80.221.158])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP id B7481112040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 08:51:10 -0500 (EST)
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
 <877f48kx0q.fsf@concordia.ellerman.id.au>
 <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
 <87fuivhuub.fsf@concordia.ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
From: Paul Clarke <pc@us.ibm.com>
Date: Fri, 3 Mar 2017 07:51:11 -0600
MIME-Version: 1.0
In-Reply-To: <87fuivhuub.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <288deec2-a821-316b-5e53-e186deda96f9@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2017 10:01 PM, Michael Ellerman wrote:
> Paul Clarke <pc@us.ibm.com> writes:
>> On 03/02/2017 12:33 AM, Michael Ellerman wrote:
>>> Paul Clarke <pc@us.ibm.com> writes:
>>>> On 02/02/2017 12:22 AM, Benjamin Herrenschmidt wrote:
>>>>> This adds AUX vectors for the L1I,D, L2 and L3 cache levels
>>>>> providing for each cache level the size of the cache in bytes
>>>>> and the geometry (line size and number of ways).
>>>>>
>>>>> We chose to not use the existing alpha/sh definition which
>>>>> packs all the information in a single entry per cache level as
>>>>> it is too restricted to represent some of the geometries used
>>>>> on POWER.
>>>>>
>>>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>> ---
>>>>>
>>>>> v2. Remove some leftovers and fix 32-bit build
>>>>>
>>>>> Paul, can you test & ack this please ? It replaces the last patch of
>>>>> my previous series (the rest is identical).
>>>>
>>>> Sorry for the delay on this, I totally missed this e-mail until this week.
>>>>
>>>> I tested this with the Power Functional Simulator (a.k.a. Mambo), with
>>>> a fairly recent 4.9 kernel from the powerpc git tree.
>>>
>>> You mean 4.9 plus this patch?
>>>
>>>> Using Mambo-P8, I see what I expect for cache line size, but associativity is 0:
>>>> AT_L1I_CACHESIZE: 32768 (0x8000)
>>>> AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
>>>> AT_L1D_CACHESIZE: 32768 (0x8000)
>>>> AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
>>>> AT_L2_CACHESIZE: 524288 (0x80000)
>>>> AT_L2_CACHEGEOMETRY: associativity 0; line size 128
>>>> AT_L3_CACHESIZE: 8388608 (0x800000)
>>>> AT_L3_CACHEGEOMETRY: associativity 0; line size 128
>>>>
>>>> ...shouldn't associativity be 8 for all levels?
>>>
>>> Yes.
>>>
>>> I fixed it in v3: http://patchwork.ozlabs.org/patch/723576/
>>>
>>> Which is now merged in Linus tree, so please test that.
>>
>> It's not working for me, but it's also very likely that I could be
>> doing something stupid. Just pulling from
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, it
>> built (without the "systemsim" patches"), but wouldn't boot in Mambo
>> (not because it couldn't find root...something else not fully
>> explored).
>
> Hmm OK, it's booting for me, but might depend on your config/toolchain
> etc. Linus' tree just before rc1 is a bit of a dangerous place to be.
>
>> I checked out tag "v4.10", and that built (with the
>> "systemsim" patches, Ben's 1-8 and your 9v3) and booted.
>
> I think you need my entire v3, ignore Ben's series.
>
>> On Mambo-P8,
>> the device tree looks correct (to me), but the associativity is still
>> 0.
>
> OK, I think if you use the full v3 the associativity will be fixed.
>
> Though it might still be wrong, because the kernel code hard codes the
> values on P8 bare metal, because on real machines (running skiboot) the
> values provided in the device tree are wrong.
>
> Hopefully those hard coded values are also correct on p8 mambo, but we
> should probably check.
>
> See: https://git.kernel.org/torvalds/c/608b42140e96

OK, thanks for your help.  All is working as expected now.  mambo-p8 looks fine:
--
AT_L1I_CACHESIZE: 32768 (0x8000)
getauxval(AT_L1I_CACHEGEOMETRY) = 0x0000000000080080
AT_L1I_CACHEGEOMETRY: associativity 8; line size 128
AT_L1D_CACHESIZE: 32768 (0x8000)
getauxval(AT_L1D_CACHEGEOMETRY) = 0x0000000000080080
AT_L1D_CACHEGEOMETRY: associativity 8; line size 128
AT_L2_CACHESIZE: 524288 (0x80000)
getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000080080
AT_L2_CACHEGEOMETRY: associativity 8; line size 128
AT_L3_CACHESIZE: 8388608 (0x800000)
getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000080080
AT_L3_CACHEGEOMETRY: associativity 8; line size 128
--

>> On P9, the device tree isn't correct, so I'm not sure what to expect.
>
> Junk :)
>
> On P9 it all comes from the device tree so if that's wrong the AUX
> vectors will definitely be wrong.

mambo-p9 is still falling victim to the device-tree, but "working":
--
getauxval(AT_L1I_CACHEGEOMETRY) = 0x0000000000000080
AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
getauxval(AT_L1D_CACHEGEOMETRY) = 0x0000000000000080
AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000000000
getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000000000
--

>>> Can you try the test program I wrote (which may also have bugs):
>>>
>>>   http://patchwork.ozlabs.org/patch/724418/
>>
>> I couldn't get this working, either, so I'm probably doing something stupid.
>
> Did you apply the first patch of the series also?

I did now, and it works, with expected results:
P8:
--
# ./cache_shape
test: cache_shape
tags: git_version:v4.10-0-gc470abd-dirty
L1I  cache size:     0x8000      32768B         32K
L1I  line size:        0x80       8-way associative
L1D  cache size:     0x8000      32768B         32K
L1D  line size:        0x80       8-way associative
L2   cache size:    0x80000     524288B        512K
L2   line size:        0x80       8-way associative
L3   cache size:   0x800000    8388608B       8192K
L3   line size:        0x80       8-way associative
success: cache_shape
--

P9 (with bad device-tree):
--
# ./cache_shape
test: cache_shape
tags: git_version:v4.10-0-gc470abd-dirty
L1I  cache size:          0          0B          0K
L1I  line size:        0x80       fully associative
L1D  cache size:          0          0B          0K
L1D  line size:        0x80       fully associative
L2   cache size:          0          0B          0K
L2   line size:           0       fully associative
L3   cache size:          0          0B          0K
L3   line size:           0       fully associative
success: cache_shape
--

Do you want me to Ack your v3 patch set in that thread?

PC
