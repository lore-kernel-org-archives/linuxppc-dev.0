Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yS9XV4vlczDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 14:28:26 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id k7so3882029pga.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 20:28:26 -0700 (PDT)
Date: Thu, 2 Nov 2017 14:27:59 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/7] powerpc/64s/radix TLB flush performance
 improvements
Message-ID: <20171102142759.716f72d9@roar.ozlabs.ibm.com>
In-Reply-To: <e8aa154c-35ef-bb47-a180-463315cfee86@linux.vnet.ibm.com>
References: <20171031064504.25245-1-npiggin@gmail.com>
 <c9c80f5a-9a53-1b7b-99c8-b40049355722@linux.vnet.ibm.com>
 <20171102003956.6cbeded3@roar.ozlabs.ibm.com>
 <e8aa154c-35ef-bb47-a180-463315cfee86@linux.vnet.ibm.com>
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

On Thu, 2 Nov 2017 08:49:49 +0530
Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 11/01/2017 07:09 PM, Nicholas Piggin wrote:
> > On Wed, 1 Nov 2017 17:35:51 +0530
> > Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> >   
> >> On 10/31/2017 12:14 PM, Nicholas Piggin wrote:  
> >>> Here's a random mix of performance improvements for radix TLB flushing
> >>> code. The main aims are to reduce the amount of translation that gets
> >>> invalidated, and to reduce global flushes where we can do local.
> >>>
> >>> To that end, a parallel kernel compile benchmark using powerpc:tlbie
> >>> tracepoint shows a reduction in tlbie instructions from about 290,000
> >>> to 80,000, and a reduction in tlbiel instructions from 49,500,000 to
> >>> 15,000,000. Looks great, but unfortunately does not translate to a
> >>> statistically significant performance improvement! The needle on TLB
> >>> misses does not move much, I suspect because a lot of the flushing is
> >>> done a startup and shutdown, and because a significant cost of TLB
> >>> flushing itself is in the barriers.    
> >>
> >> Does memory barrier initiate a single global invalidation with tlbie ?
> >>  
> > 
> > I'm not quite sure what you're asking, and I don't know the details
> > of how the hardware handles it, but from the measurements in patch
> > 1 of the series we can see there is a benefit for both tlbie and
> > tlbiel of batching them up between barriers.  
> 
> Ahh, I might have got the statement "a significant cost of TLB flushing
> itself is in the barriers" wrong. I guess you were mentioning about the
> total cost of multiple TLB flushes with memory barriers in between each
> of them which is causing the high execution cost. This got reduced by
> packing multiple tlbie(l) instruction between a single memory barrier.
> 

Yes that did get reduced for the va range flush in my patches. However
the big reduction in the number of tlbiel calls came from more use of
range flushes and fewer use of PID flushes. But the PID flushes already
have such optimization. Therefore despite tlbiel being reduced, the
number of barriers probably has not gone down a great deal on this
workload, which may explain why performance numbers are basically in
the noise.

Thanks,
Nick
