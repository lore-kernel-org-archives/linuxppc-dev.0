Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09E901A0CD4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 18:25:31 +1000 (AEST)
Date: Thu, 30 Apr 2015 18:25:25 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 28/32] powerpc/mmu: Add userspace-to-physical
 addresses translation cache
Message-ID: <20150430082525.GA22373@iris.ozlabs.ibm.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-29-git-send-email-aik@ozlabs.ru>
 <20150430063455.GA24886@voom.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150430063455.GA24886@voom.redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 30, 2015 at 04:34:55PM +1000, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:52PM +1000, Alexey Kardashevskiy wrote:
> > We are adding support for DMA memory pre-registration to be used in
> > conjunction with VFIO. The idea is that the userspace which is going to
> > run a guest may want to pre-register a user space memory region so
> > it all gets pinned once and never goes away. Having this done,
> > a hypervisor will not have to pin/unpin pages on every DMA map/unmap
> > request. This is going to help with multiple pinning of the same memory
> > and in-kernel acceleration of DMA requests.
> > 
> > This adds a list of memory regions to mm_context_t. Each region consists
> > of a header and a list of physical addresses. This adds API to:
> > 1. register/unregister memory regions;
> > 2. do final cleanup (which puts all pre-registered pages);
> > 3. do userspace to physical address translation;
> > 4. manage a mapped pages counter; when it is zero, it is safe to
> > unregister the region.
> > 
> > Multiple registration of the same region is allowed, kref is used to
> > track the number of registrations.
> 
> [snip]
> > +long mm_iommu_alloc(unsigned long ua, unsigned long entries,
> > +		struct mm_iommu_table_group_mem_t **pmem)
> > +{
> > +	struct mm_iommu_table_group_mem_t *mem;
> > +	long i, j;
> > +	struct page *page = NULL;
> > +
> > +	list_for_each_entry_rcu(mem, &current->mm->context.iommu_group_mem_list,
> > +			next) {
> > +		if ((mem->ua == ua) && (mem->entries == entries))
> > +			return -EBUSY;
> > +
> > +		/* Overlap? */
> > +		if ((mem->ua < (ua + (entries << PAGE_SHIFT))) &&
> > +				(ua < (mem->ua + (mem->entries << PAGE_SHIFT))))
> > +			return -EINVAL;
> > +	}
> > +
> > +	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > +	if (!mem)
> > +		return -ENOMEM;
> > +
> > +	mem->hpas = vzalloc(entries * sizeof(mem->hpas[0]));
> > +	if (!mem->hpas) {
> > +		kfree(mem);
> > +		return -ENOMEM;
> > +	}
> 
> So, I've thought more about this and I'm really confused as to what
> this is supposed to be accomplishing.
> 
> I see that you need to keep track of what regions are registered, so
> you don't double lock or unlock, but I don't see what the point of
> actualy storing the translations in hpas is.
> 
> I had assumed it was so that you could later on get to the
> translations in real mode when you do in-kernel acceleration.  But
> that doesn't make sense, because the array is vmalloc()ed, so can't be
> accessed in real mode anyway.

We can access vmalloc'd arrays in real mode using real_vmalloc_addr().

> I can't think of a circumstance in which you can use hpas where you
> couldn't just walk the page tables anyway.

The problem with walking the page tables is that there is no guarantee
that the page you find that way is the page that was returned by the
gup_fast() we did earlier.  Storing the hpas means that we know for
sure that the page we're doing DMA to is one that we have an elevated
page count on.

Also, there are various points where a Linux PTE is made temporarily
invalid for a short time.  If we happened to do a H_PUT_TCE on one cpu
while another cpu was doing that, we'd get a spurious failure returned
by the H_PUT_TCE.

Paul.
