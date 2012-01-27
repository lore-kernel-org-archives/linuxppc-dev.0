Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 579D01007D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 13:40:50 +1100 (EST)
Message-ID: <1327632040.24487.11.camel@pasglop>
Subject: Re: tlb flushing on Power
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Fri, 27 Jan 2012 13:40:40 +1100
In-Reply-To: <4F21D3F4.7020904@linux.vnet.ibm.com>
References: <4F2160B3.60708@linux.vnet.ibm.com>
 <4F216620.2010509@linux.vnet.ibm.com> <1327613953.24487.9.camel@pasglop>
 <4F21D3F4.7020904@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-01-26 at 14:30 -0800, Dave Hansen wrote:
> On 01/26/2012 01:39 PM, Benjamin Herrenschmidt wrote:
> > Can you explain to me a bit more the whole business in this patch set
> > about doing kmap_atomic() vs. manually trying to populate the PTEs ? 
> 
> They're compressing pages and the allocator is trying getting very poor
> packing of compressed pages in to PAGE_SIZE chunks.  So, they're moving
> to 2-page allocations that they need to be mapped contiguously to make
> it easier on the users of the allocator.
> 
> > Why not just use two kmap atomic entries ? If interrupts are disabled
> > kmap_atomic() should give you contiguous ones I suppose
> 
> I think you and I are at least on the same page on this one:
> 
> https://lkml.org/lkml/2012/1/26/355

Right. We probably want to document this somewhere if we start relying
on that behaviour or at the very least add a WARN_ON() and fail from the
compressed allocator if we end up with non-contiguous pages.

> > (unless NMIs are allowed to use kmap_atomic, are they ?)
> 
> Surely they can't be.  Even if they could use it, they'd have to return
> the __kmap_atomic_idx back to the place where it started before they
> returned, so the interrupted code wouldn't notice.

Ah indeed, that's for talking before I had breakfast :-)

Cheers,
Ben.
