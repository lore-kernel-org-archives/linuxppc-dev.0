Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWDW33x22zDrK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 13:52:47 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id p9so9850667pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 18:52:47 -0800 (PST)
Date: Tue, 7 Nov 2017 13:52:35 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Florian Weimer
 <fweimer@redhat.com>, linuxppc-dev@lists.ozlabs.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 2/5] powerpc/64s/hash: Allow MAP_FIXED allocations to
 cross 128TB boundary
Message-ID: <20171107135235.38042223@roar.ozlabs.ibm.com>
In-Reply-To: <878tfi4ybr.fsf@concordia.ellerman.id.au>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-3-npiggin@gmail.com>
 <87vainsn45.fsf@linux.vnet.ibm.com>
 <20171106225556.79aea9c8@roar.ozlabs.ibm.com>
 <878tfi4ybr.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 07 Nov 2017 13:28:08 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > On Mon, 06 Nov 2017 16:14:10 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> >  
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>   
> >> > While mapping hints with a length that cross 128TB are disallowed,
> >> > MAP_FIXED allocations that cross 128TB are allowed. These are failing
> >> > on hash (on radix they succeed). Add an additional case for fixed
> >> > mappings to expand the addr_limit when crossing 128TB.    
> >> 
> >> Shouldn't that be fixed in radix. But i see x86 also doing this?
> >> 
> >> 
> >> 	if (flags & MAP_FIXED)
> >> 		return addr;
> >> 
> >> Kiril,
> >> 
> >> Is that expected?  
> >
> > I should actually reply to this one because the other did not
> > have Kirill on cc.
> >
> > Generic mapping code appears it will always succeed when given an
> > explicit hint request, even if the address is below the boundary
> > and address + length is above it. Even when !MAP_FIXED. This is the
> > sane behaviour AFAIKS.  
> 
> It's "sane" if you want the 128T boundary to be invisible.

Not invisible: mmap(NULL, length, ...) + length < 128TB

> But the whole goddamn point was that we wanted apps to have to opt-in to
> using > 128T, and having brk accidentally go over the 128T boundary does
> not count as opting in.

If brk() is given an explicit address > 128TB, then that's opting
in, right?

If malloc is doing some allocation scheme which "opts in", such as
using explicit brk or mmap, then there is no way for the kernel to
solve that. Making increasingly convoluted policy to try to allow
the good and reject the bad is not right IMO.

> So it's a mess as usual.

If we wanted to make this ABI-identical with existing systems, then
it can't work without out-of-band opt-in. Why wasn't a personality
+ sysctl used for this, as we apparently have for a previous address
space layout change?

> 
> > So we should switch powerpc to match, shouldn't we?  
> 
> Yes we should do whatever the other arches do. 
> 
> Actually we should do what the man page describes .. except it doesn't.
