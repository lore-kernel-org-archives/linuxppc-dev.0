Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRq8w0pWrzDr4H
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Nov 2017 00:40:15 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id g6so2146588pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Nov 2017 06:40:15 -0700 (PDT)
Date: Thu, 2 Nov 2017 00:39:56 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/7] powerpc/64s/radix TLB flush performance
 improvements
Message-ID: <20171102003956.6cbeded3@roar.ozlabs.ibm.com>
In-Reply-To: <c9c80f5a-9a53-1b7b-99c8-b40049355722@linux.vnet.ibm.com>
References: <20171031064504.25245-1-npiggin@gmail.com>
 <c9c80f5a-9a53-1b7b-99c8-b40049355722@linux.vnet.ibm.com>
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

On Wed, 1 Nov 2017 17:35:51 +0530
Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> On 10/31/2017 12:14 PM, Nicholas Piggin wrote:
> > Here's a random mix of performance improvements for radix TLB flushing
> > code. The main aims are to reduce the amount of translation that gets
> > invalidated, and to reduce global flushes where we can do local.
> > 
> > To that end, a parallel kernel compile benchmark using powerpc:tlbie
> > tracepoint shows a reduction in tlbie instructions from about 290,000
> > to 80,000, and a reduction in tlbiel instructions from 49,500,000 to
> > 15,000,000. Looks great, but unfortunately does not translate to a
> > statistically significant performance improvement! The needle on TLB
> > misses does not move much, I suspect because a lot of the flushing is
> > done a startup and shutdown, and because a significant cost of TLB
> > flushing itself is in the barriers.  
> 
> Does memory barrier initiate a single global invalidation with tlbie ?
> 

I'm not quite sure what you're asking, and I don't know the details
of how the hardware handles it, but from the measurements in patch
1 of the series we can see there is a benefit for both tlbie and
tlbiel of batching them up between barriers.

Thanks,
Nick
