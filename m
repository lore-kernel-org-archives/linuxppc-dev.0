Return-Path: <hannes@cmpxchg.org>
Received: from zene.cmpxchg.org (zene.cmpxchg.org
 [IPv6:2a01:238:4224:fa00:ca1f:9ef3:caee:a2bd])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B59A7B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2012 05:46:29 +1100 (EST)
Date: Wed, 29 Feb 2012 19:45:53 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] bootmem/sparsemem: remove limit constraint in
 alloc_bootmem_section
Message-ID: <20120229184553.GB1673@cmpxchg.org>
References: <1330112038-18951-1-git-send-email-nacc@us.ibm.com>
 <20120228154732.GE1199@suse.de>
 <20120229181233.GF5136@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120229181233.GF5136@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 29, 2012 at 10:12:33AM -0800, Nishanth Aravamudan wrote:
> On 28.02.2012 [15:47:32 +0000], Mel Gorman wrote:
> > On Fri, Feb 24, 2012 at 11:33:58AM -0800, Nishanth Aravamudan wrote:
> > > While testing AMS (Active Memory Sharing) / CMO (Cooperative Memory
> > > Overcommit) on powerpc, we tripped the following:
> > > 
> > > kernel BUG at mm/bootmem.c:483!
> > > cpu 0x0: Vector: 700 (Program Check) at [c000000000c03940]
> > >     pc: c000000000a62bd8: .alloc_bootmem_core+0x90/0x39c
> > >     lr: c000000000a64bcc: .sparse_early_usemaps_alloc_node+0x84/0x29c
> > >     sp: c000000000c03bc0
> > >    msr: 8000000000021032
> > >   current = 0xc000000000b0cce0
> > >   paca    = 0xc000000001d80000
> > >     pid   = 0, comm = swapper
> > > kernel BUG at mm/bootmem.c:483!
> > > enter ? for help
> > > [c000000000c03c80] c000000000a64bcc
> > > .sparse_early_usemaps_alloc_node+0x84/0x29c
> > > [c000000000c03d50] c000000000a64f10 .sparse_init+0x12c/0x28c
> > > [c000000000c03e20] c000000000a474f4 .setup_arch+0x20c/0x294
> > > [c000000000c03ee0] c000000000a4079c .start_kernel+0xb4/0x460
> > > [c000000000c03f90] c000000000009670 .start_here_common+0x1c/0x2c
> > > 
> > > This is
> > > 
> > >         BUG_ON(limit && goal + size > limit);
> > > 
> > > and after some debugging, it seems that
> > > 
> > > 	goal = 0x7ffff000000
> > > 	limit = 0x80000000000
> > > 
> > > and sparse_early_usemaps_alloc_node ->
> > > sparse_early_usemaps_alloc_pgdat_section -> alloc_bootmem_section calls
> > > 
> > > 	return alloc_bootmem_section(usemap_size() * count, section_nr);
> > > 
> > > This is on a system with 8TB available via the AMS pool, and as a quirk
> > > of AMS in firmware, all of that memory shows up in node 0. So, we end up
> > > with an allocation that will fail the goal/limit constraints. In theory,
> > > we could "fall-back" to alloc_bootmem_node() in
> > > sparse_early_usemaps_alloc_node(), but since we actually have HOTREMOVE
> > > defined, we'll BUG_ON() instead. A simple solution appears to be to
> > > disable the limit check if the size of the allocation in
> > > alloc_bootmem_secition exceeds the section size.
> > > 
> > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > > Cc: Dave Hansen <haveblue@us.ibm.com>
> > > Cc: Anton Blanchard <anton@au1.ibm.com>
> > > Cc: Paul Mackerras <paulus@samba.org>
> > > Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
> > > Cc: linux-mm@kvack.org
> > > Cc: linuxppc-dev@lists.ozlabs.org
> > > ---
> > >  include/linux/mmzone.h |    2 ++
> > >  mm/bootmem.c           |    5 ++++-
> > >  2 files changed, 6 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > index 650ba2f..4176834 100644
> > > --- a/include/linux/mmzone.h
> > > +++ b/include/linux/mmzone.h
> > > @@ -967,6 +967,8 @@ static inline unsigned long early_pfn_to_nid(unsigned long pfn)
> > >   * PA_SECTION_SHIFT		physical address to/from section number
> > >   * PFN_SECTION_SHIFT		pfn to/from section number
> > >   */
> > > +#define BYTES_PER_SECTION	(1UL << SECTION_SIZE_BITS)
> > > +
> > >  #define SECTIONS_SHIFT		(MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> > >  
> > >  #define PA_SECTION_SHIFT	(SECTION_SIZE_BITS)
> > > diff --git a/mm/bootmem.c b/mm/bootmem.c
> > > index 668e94d..5cbbc76 100644
> > > --- a/mm/bootmem.c
> > > +++ b/mm/bootmem.c
> > > @@ -770,7 +770,10 @@ void * __init alloc_bootmem_section(unsigned long size,
> > >  
> > >  	pfn = section_nr_to_pfn(section_nr);
> > >  	goal = pfn << PAGE_SHIFT;
> > > -	limit = section_nr_to_pfn(section_nr + 1) << PAGE_SHIFT;
> > > +	if (size > BYTES_PER_SECTION)
> > > +		limit = 0;
> > > +	else
> > > +		limit = section_nr_to_pfn(section_nr + 1) << PAGE_SHIFT;
> > 
> > As it's ok to spill the allocation over to an adjacent section, why not
> > just make limit==0 unconditionally. That would avoid defining
> > BYTES_PER_SECTION.
> 
> Something like this?
> 
> Andrew, presuming Mel & Johannes give their, ack this should presumably
> supersede the patch you pulled into -mm.
> 
> Thanks,
> Nish
> 
> -------
> 
> While testing AMS (Active Memory Sharing) / CMO (Cooperative Memory
> Overcommit) on powerpc, we tripped the following:
> 
> kernel BUG at mm/bootmem.c:483!
> cpu 0x0: Vector: 700 (Program Check) at [c000000000c03940]
>     pc: c000000000a62bd8: .alloc_bootmem_core+0x90/0x39c
>     lr: c000000000a64bcc: .sparse_early_usemaps_alloc_node+0x84/0x29c
>     sp: c000000000c03bc0
>    msr: 8000000000021032
>   current = 0xc000000000b0cce0
>   paca    = 0xc000000001d80000
>     pid   = 0, comm = swapper
> kernel BUG at mm/bootmem.c:483!
> enter ? for help
> [c000000000c03c80] c000000000a64bcc
> .sparse_early_usemaps_alloc_node+0x84/0x29c
> [c000000000c03d50] c000000000a64f10 .sparse_init+0x12c/0x28c
> [c000000000c03e20] c000000000a474f4 .setup_arch+0x20c/0x294
> [c000000000c03ee0] c000000000a4079c .start_kernel+0xb4/0x460
> [c000000000c03f90] c000000000009670 .start_here_common+0x1c/0x2c
> 
> This is
> 
>         BUG_ON(limit && goal + size > limit);
> 
> and after some debugging, it seems that
> 
> 	goal = 0x7ffff000000
> 	limit = 0x80000000000
> 
> and sparse_early_usemaps_alloc_node ->
> sparse_early_usemaps_alloc_pgdat_section calls
> 
> 	return alloc_bootmem_section(usemap_size() * count, section_nr);
> 
> This is on a system with 8TB available via the AMS pool, and as a quirk
> of AMS in firmware, all of that memory shows up in node 0. So, we end up
> with an allocation that will fail the goal/limit constraints. In theory,
> we could "fall-back" to alloc_bootmem_node() in
> sparse_early_usemaps_alloc_node(), but since we actually have HOTREMOVE
> defined, we'll BUG_ON() instead. A simple solution appears to be to
> unconditionally remove the limit condition in alloc_bootmem_section,
> meaning allocations are allowed to cross section boundaries (necessary
> for systems of this size).
> 
> Johannes Weiner pointed out that if alloc_bootmem_section() no longer
> guarantees section-locality, we need check_usemap_section_nr() to print
> possible cross-dependencies between node descriptors and the usemaps
> allocated through it. That makes the two loops in
> sparse_early_usemaps_alloc_node() identical, so re-factor the code a
> bit.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
