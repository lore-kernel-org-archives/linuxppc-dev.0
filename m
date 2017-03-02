Return-Path: <pc@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZ89G3lq7zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Mar 2017 10:46:42 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v22NhuBW023357
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 18:46:39 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28xsst89b5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 18:46:39 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pc@us.ibm.com>;
 Thu, 2 Mar 2017 16:46:38 -0700
Reply-To: pc@us.ibm.com
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
 <877f48kx0q.fsf@concordia.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
From: Paul Clarke <pc@us.ibm.com>
Date: Thu, 2 Mar 2017 17:46:32 -0600
MIME-Version: 1.0
In-Reply-To: <877f48kx0q.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/02/2017 12:33 AM, Michael Ellerman wrote:
> Paul Clarke <pc@us.ibm.com> writes:
>> On 02/02/2017 12:22 AM, Benjamin Herrenschmidt wrote:
>>> This adds AUX vectors for the L1I,D, L2 and L3 cache levels
>>> providing for each cache level the size of the cache in bytes
>>> and the geometry (line size and number of ways).
>>>
>>> We chose to not use the existing alpha/sh definition which
>>> packs all the information in a single entry per cache level as
>>> it is too restricted to represent some of the geometries used
>>> on POWER.
>>>
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> ---
>>>
>>> v2. Remove some leftovers and fix 32-bit build
>>>
>>> Paul, can you test & ack this please ? It replaces the last patch of
>>> my previous series (the rest is identical).
>>
>> Sorry for the delay on this, I totally missed this e-mail until this week.
>>
>> I tested this with the Power Functional Simulator (a.k.a. Mambo), with
>> a fairly recent 4.9 kernel from the powerpc git tree.
>
> You mean 4.9 plus this patch?
>
>> Using Mambo-P8, I see what I expect for cache line size, but associativity is 0:
>> AT_L1I_CACHESIZE: 32768 (0x8000)
>> AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
>> AT_L1D_CACHESIZE: 32768 (0x8000)
>> AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
>> AT_L2_CACHESIZE: 524288 (0x80000)
>> AT_L2_CACHEGEOMETRY: associativity 0; line size 128
>> AT_L3_CACHESIZE: 8388608 (0x800000)
>> AT_L3_CACHEGEOMETRY: associativity 0; line size 128
>>
>> ...shouldn't associativity be 8 for all levels?
>
> Yes.
>
> I fixed it in v3: http://patchwork.ozlabs.org/patch/723576/
>
> Which is now merged in Linus tree, so please test that.

It's not working for me, but it's also very likely that I could be doing something stupid.  Just pulling from git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git, it built (without the "systemsim" patches"), but wouldn't boot in Mambo (not because it couldn't find root...something else not fully explored).  I checked out tag "v4.10", and that built (with the "systemsim" patches, Ben's 1-8 and your 9v3) and booted.  On Mambo-P8, the device tree looks correct (to me), but the associativity is still 0.  On P9, the device tree isn't correct, so I'm not sure what to expect.

I added a bit more debug to my test:
AT_L1I_CACHESIZE: 32768 (0x8000)
getauxval(AT_L1I_CACHEGEOMETRY) = 0x0000000000000080
AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
AT_L1D_CACHESIZE: 32768 (0x8000)
getauxval(AT_L1D_CACHEGEOMETRY) = 0x0000000000000080
AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
AT_L2_CACHESIZE: 524288 (0x80000)
getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000000080
AT_L2_CACHEGEOMETRY: associativity 0; line size 128
AT_L3_CACHESIZE: 8388608 (0x800000)
getauxval(AT_L2_CACHEGEOMETRY) = 0x0000000000000080
AT_L3_CACHEGEOMETRY: associativity 0; line size 128

When I use gdb, and break at main:
(gdb) x/60gx ($r6)
0x3ffffffffca0: 0x0000000000000016      0x0000000000000016
0x3ffffffffcb0: 0x0000000000000016      0x0000000000000016
0x3ffffffffcc0: 0x0000000000000013      0x0000000000000080
0x3ffffffffcd0: 0x0000000000000014      0x0000000000000080
0x3ffffffffce0: 0x0000000000000015      0x0000000000000000
0x3ffffffffcf0: 0x0000000000000021      0x00003fffb7fa0000
0x3ffffffffd00: 0x0000000000000028      0x0000000000008000
0x3ffffffffd10: 0x0000000000000029      0x0000000000000080
0x3ffffffffd20: 0x000000000000002a      0x0000000000008000
0x3ffffffffd30: 0x000000000000002b      0x0000000000000080
0x3ffffffffd40: 0x000000000000002c      0x0000000000080000
0x3ffffffffd50: 0x000000000000002d      0x0000000000000080
0x3ffffffffd60: 0x000000000000002e      0x0000000000800000
0x3ffffffffd70: 0x000000000000002f      0x0000000000000080

and, looking at the device-tree:
# for i in /proc/device-tree/cpus/PowerPC@0/*cache*; do echo $i;
  od -tx1 $i; done
/proc/device-tree/cpus/PowerPC@0/d-cache-block-size
0000000 00 00 00 80
/proc/device-tree/cpus/PowerPC@0/d-cache-line-size
0000000 00 00 00 80
/proc/device-tree/cpus/PowerPC@0/d-cache-sets
0000000 00 00 00 04
/proc/device-tree/cpus/PowerPC@0/d-cache-size
0000000 00 00 80 00
/proc/device-tree/cpus/PowerPC@0/i-cache-block-size
0000000 00 00 00 80
/proc/device-tree/cpus/PowerPC@0/i-cache-line-size
0000000 00 00 00 80
/proc/device-tree/cpus/PowerPC@0/i-cache-sets
0000000 00 00 00 02
/proc/device-tree/cpus/PowerPC@0/i-cache-size
0000000 00 00 80 00
/proc/device-tree/cpus/PowerPC@0/l2-cache-size
0000000 00 0a 00 00

>
> Can you try the test program I wrote (which may also have bugs):
>
>   http://patchwork.ozlabs.org/patch/724418/

I couldn't get this working, either, so I'm probably doing something stupid.

PC
