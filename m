Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41JvX515KwzF1D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 14:33:40 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id u16-v6so6873499pfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Jul 2018 21:33:40 -0700 (PDT)
Date: Mon, 2 Jul 2018 14:33:30 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180702143244.3a08ebe2@aik.ozlabs.ibm.com>
In-Reply-To: <20180702040852.GW3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
 <20180629045702.GI3422@umbus.fritz.box>
 <20180629151820.461ae112@aik.ozlabs.ibm.com>
 <20180629170747.471bea35@aik.ozlabs.ibm.com>
 <20180702040852.GW3422@umbus.fritz.box>
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

On Mon, 2 Jul 2018 14:08:52 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Jun 29, 2018 at 05:07:47PM +1000, Alexey Kardashevskiy wrote:
> > On Fri, 29 Jun 2018 15:18:20 +1000
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> > > On Fri, 29 Jun 2018 14:57:02 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >   
> > > > On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevskiy wrote:    
> > > > > On Fri, 29 Jun 2018 14:12:41 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >       
> > > > > > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevskiy wrote:      
> > > > > > > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> > > > > > > an IOMMU page is contained in the physical page so the PCI hardware won't
> > > > > > > get access to unassigned host memory.
> > > > > > > 
> > > > > > > However we do not have this check in KVM fastpath (H_PUT_TCE accelerated
> > > > > > > code) so the user space can pin memory backed with 64k pages and create
> > > > > > > a hardware TCE table with a bigger page size. We were lucky so far and
> > > > > > > did not hit this yet as the very first time the mapping happens
> > > > > > > we do not have tbl::it_userspace allocated yet and fall back to
> > > > > > > the userspace which in turn calls VFIO IOMMU driver and that fails
> > > > > > > because of the check in vfio_iommu_spapr_tce.c which is really
> > > > > > > sustainable solution.
> > > > > > > 
> > > > > > > This stores the smallest preregistered page size in the preregistered
> > > > > > > region descriptor and changes the mm_iommu_xxx API to check this against
> > > > > > > the IOMMU page size.
> > > > > > > 
> > > > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > > > ---
> > > > > > > Changes:
> > > > > > > v2:
> > > > > > > * explicitly check for compound pages before calling compound_order()
> > > > > > > 
> > > > > > > ---
> > > > > > > The bug is: run QEMU _without_ hugepages (no -mempath) and tell it to
> > > > > > > advertise 16MB pages to the guest; a typical pseries guest will use 16MB
> > > > > > > for IOMMU pages without checking the mmu pagesize and this will fail
> > > > > > > at https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/common.c;h=fb396cf00ac40eb35967a04c9cc798ca896eed57;hb=refs/heads/master#l256
> > > > > > > 
> > > > > > > With the change, mapping will fail in KVM and the guest will print:
> > > > > > > 
> > > > > > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 20000000 18 1f returned 0 (liobn = 0x80000001 starting addr = 8000000 0)
> > > > > > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /pci@800000020000000/ethernet@0
> > > > > > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > > > > > /pci@800000020000000/ethernet@0: -1        
> > > > > > 
> > > > > > [snip]      
> > > > > > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> > > > > > >  		struct mm_iommu_table_group_mem_t **pmem)
> > > > > > >  {
> > > > > > >  	struct mm_iommu_table_group_mem_t *mem;
> > > > > > > -	long i, j, ret = 0, locked_entries = 0;
> > > > > > > +	long i, j, ret = 0, locked_entries = 0, pageshift;
> > > > > > >  	struct page *page = NULL;
> > > > > > >  
> > > > > > >  	mutex_lock(&mem_list_mutex);
> > > > > > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> > > > > > >  		goto unlock_exit;
> > > > > > >  	}
> > > > > > >  
> > > > >  > > +	mem->pageshift = 30; /* start from 1G pages - the biggest we have */        
> > > > > > 
> > > > > > What about 16G pages on an HPT system?      
> > > > > 
> > > > > 
> > > > > Below in the loop mem->pageshift will reduce to the biggest actual size
> > > > > which will be 16mb/64k/4k. Or remain 1GB if no memory is actually
> > > > > pinned, no loss there.      
> > > > 
> > > > Are you saying that 16G IOMMU pages aren't supported?  Or that there's
> > > > some reason a guest can never use them?    
> > > 
> > > 
> > > ah, 16_G_, not _M_. My bad. I just never tried such huge pages, I will
> > > lift the limit up to 64 then, easier this way.  
> > 
> > 
> > Ah, no, rather this as the upper limit:
> > 
> > mem->pageshift = ilog2(entries) + PAGE_SHIFT;  
> 
> I can't make sense of this comment in context.  I see how you're
> computing the minimum page size in the reserved region.
> 
> My question is about what the "maximum minimum" is - the starting
> value from which you calculate.  Currently it's 1G, but I can't
> immediately see a reason that 16G is impossible here.


16GB is impossible if the chunk we are preregistering here is smaller
than that, for example, the entire guest ram is 4GB. If that is the
case and we try mapping a 16GB IOMMU page, this should fail as I do not
really know what happens to the memory between 4GB..16GB.

imho if not that, than 1<<64 would make a good upper limit.



> 
> > @entries here is a number of system pages being pinned in that
> > function.
> > 
> > 
> >   
> > >   
> > > >     
> > > > > > >  	for (i = 0; i < entries; ++i) {
> > > > > > >  		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > > > > > >  					1/* pages */, 1/* iswrite */, &page)) {
> > > > > > > @@ -199,6 +202,11 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> > > > > > >  			}
> > > > > > >  		}
> > > > > > >  populate:
> > > > > > > +		pageshift = PAGE_SHIFT;
> > > > > > > +		if (PageCompound(page))
> > > > > > > +			pageshift += compound_order(compound_head(page));
> > > > > > > +		mem->pageshift = min_t(unsigned int, mem->pageshift, pageshift);        
> > > > > > 
> > > > > > Why not make mem->pageshift and pageshift local the same type to avoid
> > > > > > the min_t() ?      
> > > > > 
> > > > > I was under impression min() is deprecated (misinterpret checkpatch.pl
> > > > > may be) and therefore did not pay attention to it. I can fix this and
> > > > > repost if there is no other question.      
> > > > 
> > > > Hm, it's possible.    
> > > 
> > > Nah, tried min(), compiles fine.  
> > 
> > 
> >   
> 
> 
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson



--
Alexey
