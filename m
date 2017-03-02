Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYjFd3s1pzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:33:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: pc@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
In-Reply-To: <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
Date: Thu, 02 Mar 2017 17:33:57 +1100
Message-ID: <877f48kx0q.fsf@concordia.ellerman.id.au>
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

> On 02/02/2017 12:22 AM, Benjamin Herrenschmidt wrote:
>> This adds AUX vectors for the L1I,D, L2 and L3 cache levels
>> providing for each cache level the size of the cache in bytes
>> and the geometry (line size and number of ways).
>>
>> We chose to not use the existing alpha/sh definition which
>> packs all the information in a single entry per cache level as
>> it is too restricted to represent some of the geometries used
>> on POWER.
>>
>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> ---
>>
>> v2. Remove some leftovers and fix 32-bit build
>>
>> Paul, can you test & ack this please ? It replaces the last patch of
>> my previous series (the rest is identical).
>
> Sorry for the delay on this, I totally missed this e-mail until this week.
>
> I tested this with the Power Functional Simulator (a.k.a. Mambo), with
> a fairly recent 4.9 kernel from the powerpc git tree.

You mean 4.9 plus this patch?

> Using Mambo-P8, I see what I expect for cache line size, but associativity is 0:
> AT_L1I_CACHESIZE: 32768 (0x8000)
> AT_L1I_CACHEGEOMETRY: associativity 0; line size 128
> AT_L1D_CACHESIZE: 32768 (0x8000)
> AT_L1D_CACHEGEOMETRY: associativity 0; line size 128
> AT_L2_CACHESIZE: 524288 (0x80000)
> AT_L2_CACHEGEOMETRY: associativity 0; line size 128
> AT_L3_CACHESIZE: 8388608 (0x800000)
> AT_L3_CACHEGEOMETRY: associativity 0; line size 128
>
> ...shouldn't associativity be 8 for all levels?

Yes.

I fixed it in v3: http://patchwork.ozlabs.org/patch/723576/

Which is now merged in Linus tree, so please test that.

Can you try the test program I wrote (which may also have bugs):

  http://patchwork.ozlabs.org/patch/724418/

cheers
