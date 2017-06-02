Return-Path: <hughd@google.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com
 [IPv6:2607:f8b0:4003:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf9VN15JSzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 14:00:44 +1000 (AEST)
Received: by mail-oi0-x229.google.com with SMTP id h4so77735920oib.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 21:00:43 -0700 (PDT)
Date: Thu, 1 Jun 2017 21:00:32 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: Hugh Dickins <hughd@google.com>, Christoph Lameter <cl@linux.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <878tlb2igt.fsf@concordia.ellerman.id.au>
Message-ID: <alpine.LSU.2.11.1706012045240.4854@eggly.anvils>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
 <87h9014j7t.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.20.1705310906570.14920@east.gentwo.org>
 <alpine.LSU.2.11.1705311112290.1839@eggly.anvils>
 <alpine.DEB.2.20.1706011027310.8835@east.gentwo.org>
 <alpine.LSU.2.11.1706011002130.3014@eggly.anvils>
 <alpine.DEB.2.20.1706011306560.11993@east.gentwo.org>
 <alpine.LSU.2.11.1706011128490.3622@eggly.anvils>
 <878tlb2igt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2 Jun 2017, Michael Ellerman wrote:
> Hugh Dickins <hughd@google.com> writes:
> > On Thu, 1 Jun 2017, Christoph Lameter wrote:
> >> 
> >> Ok so debugging was off but the slab cache has a ctor callback which
> >> mandates that the free pointer cannot use the free object space when
> >> the object is not in use. Thus the size of the object must be increased to
> >> accomodate the freepointer.
> >
> > Thanks a lot for working that out.  Makes sense, fully understood now,
> > nothing to worry about (though makes one wonder whether it's efficient
> > to use ctors on high-alignment caches; or whether an internal "zero-me"
> > ctor would be useful).
> 
> Or should we just be using kmem_cache_zalloc() when we allocate from
> those slabs?
> 
> Given all the ctor's do is memset to 0.

I'm not sure.  From a memory-utilization point of view, with SLUB,
using kmem_cache_zalloc() there would certainly be better.

But you may be forgetting that the constructor is applied only when a
new slab of objects is allocated, not each time an object is allocated
from that slab (and the user of those objects agrees to free objects
back to the cache in a reusable state: zeroed in this case).

So from a cpu-utilization point of view, it's better to use the ctor:
it's saving you lots of redundant memsets.

SLUB versus SLAB, cpu versus memory?  Since someone has taken the
trouble to write it with ctors in the past, I didn't feel on firm
enough ground to recommend such a change.  But it may be obvious
to someone else that your suggestion would be better (or worse).

Hugh
