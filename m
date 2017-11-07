Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWCyg2X7hzDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 13:28:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Florian Weimer <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/5] powerpc/64s/hash: Allow MAP_FIXED allocations to
 cross 128TB boundary
In-Reply-To: <20171106225556.79aea9c8@roar.ozlabs.ibm.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-3-npiggin@gmail.com>
 <87vainsn45.fsf@linux.vnet.ibm.com>
 <20171106225556.79aea9c8@roar.ozlabs.ibm.com>
Date: Tue, 07 Nov 2017 13:28:08 +1100
Message-ID: <878tfi4ybr.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> On Mon, 06 Nov 2017 16:14:10 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Nicholas Piggin <npiggin@gmail.com> writes:
>> 
>> > While mapping hints with a length that cross 128TB are disallowed,
>> > MAP_FIXED allocations that cross 128TB are allowed. These are failing
>> > on hash (on radix they succeed). Add an additional case for fixed
>> > mappings to expand the addr_limit when crossing 128TB.  
>> 
>> Shouldn't that be fixed in radix. But i see x86 also doing this?
>> 
>> 
>> 	if (flags & MAP_FIXED)
>> 		return addr;
>> 
>> Kiril,
>> 
>> Is that expected?
>
> I should actually reply to this one because the other did not
> have Kirill on cc.
>
> Generic mapping code appears it will always succeed when given an
> explicit hint request, even if the address is below the boundary
> and address + length is above it. Even when !MAP_FIXED. This is the
> sane behaviour AFAIKS.

It's "sane" if you want the 128T boundary to be invisible.

But the whole goddamn point was that we wanted apps to have to opt-in to
using > 128T, and having brk accidentally go over the 128T boundary does
not count as opting in.

So it's a mess as usual.

> So we should switch powerpc to match, shouldn't we?

Yes we should do whatever the other arches do. 

Actually we should do what the man page describes .. except it doesn't.

cheers
