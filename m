Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C412D1A0B86
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 13:52:01 +1100 (AEDT)
Message-ID: <1427943118.5567.331.camel@redhat.com>
Subject: Re: [PATCH kernel v7 12/31] powerpc/spapr: vfio: Switch from
 iommu_table to new iommu_table_group
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 01 Apr 2015 20:51:58 -0600
In-Reply-To: <551CAA95.8080903@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
 <1427468115-2224-13-git-send-email-aik@ozlabs.ru>
 <1427924911.5567.304.camel@redhat.com> <551CAA95.8080903@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-02 at 13:33 +1100, Alexey Kardashevskiy wrote:
> On 04/02/2015 08:48 AM, Alex Williamson wrote:
> > On Sat, 2015-03-28 at 01:54 +1100, Alexey Kardashevskiy wrote:
> >> Modern IBM POWERPC systems support multiple (currently two) TCE tables
> >> per IOMMU group (a.k.a. PE). This adds a iommu_table_group container
> >> for TCE tables. Right now just one table is supported.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>   Documentation/vfio.txt                      |  23 ++++++
> >>   arch/powerpc/include/asm/iommu.h            |  18 +++--
> >>   arch/powerpc/kernel/iommu.c                 |  34 ++++----
> >>   arch/powerpc/platforms/powernv/pci-ioda.c   |  38 +++++----
> >>   arch/powerpc/platforms/powernv/pci-p5ioc2.c |  17 ++--
> >>   arch/powerpc/platforms/powernv/pci.c        |   2 +-
> >>   arch/powerpc/platforms/powernv/pci.h        |   4 +-
> >>   arch/powerpc/platforms/pseries/iommu.c      |   9 ++-
> >>   drivers/vfio/vfio_iommu_spapr_tce.c         | 120 ++++++++++++++++++++--------
> >>   9 files changed, 183 insertions(+), 82 deletions(-)
> >>
> >> diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> >> index 96978ec..94328c8 100644
> >> --- a/Documentation/vfio.txt
> >> +++ b/Documentation/vfio.txt
> >> @@ -427,6 +427,29 @@ The code flow from the example above should be slightly changed:
> >>
> >>   	....
> >>
> >> +5) There is v2 of SPAPR TCE IOMMU. It deprecates VFIO_IOMMU_ENABLE/
> >> +VFIO_IOMMU_DISABLE and implements 2 new ioctls:
> >> +VFIO_IOMMU_SPAPR_REGISTER_MEMORY and VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY
> >> +(which are unsupported in v1 IOMMU).
> >> +
> >> +PPC64 paravirtualized guests generate a lot of map/unmap requests,
> >> +and the handling of those includes pinning/unpinning pages and updating
> >> +mm::locked_vm counter to make sure we do not exceed the rlimit.
> >> +The v2 IOMMU splits accounting and pinning into separate operations:
> >> +
> >> +- VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
> >> +receive a user space address and size of the block to be pinned.
> >> +Bisecting is not supported and VFIO_IOMMU_UNREGISTER_MEMORY is expected to
> >> +be called with the exact address and size used for registering
> >> +the memory block. The userspace is not expected to call these often.
> >> +The ranges are stored in a linked list in a VFIO container.
> >> +
> >> +- VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA ioctls only update the actual
> >> +IOMMU table and do not do pinning; instead these check that the userspace
> >> +address is from pre-registered range.
> >> +
> >> +This separation helps in optimizing DMA for guests.
> >> +
> >>   -------------------------------------------------------------------------------
> >>
> >>   [1] VFIO was originally an acronym for "Virtual Function I/O" in its
> >> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
> >> index eb75726..667aa1a 100644
> >> --- a/arch/powerpc/include/asm/iommu.h
> >> +++ b/arch/powerpc/include/asm/iommu.h
> >> @@ -90,9 +90,7 @@ struct iommu_table {
> >>   	struct iommu_pool pools[IOMMU_NR_POOLS];
> >>   	unsigned long *it_map;       /* A simple allocation bitmap for now */
> >>   	unsigned long  it_page_shift;/* table iommu page size */
> >> -#ifdef CONFIG_IOMMU_API
> >> -	struct iommu_group *it_group;
> >> -#endif
> >> +	struct iommu_table_group *it_group;
> >>   	struct iommu_table_ops *it_ops;
> >>   	void (*set_bypass)(struct iommu_table *tbl, bool enable);
> >>   };
> >> @@ -126,14 +124,24 @@ extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
> >>    */
> >>   extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
> >>   					    int nid);
> >> +
> >> +#define IOMMU_TABLE_GROUP_MAX_TABLES	1
> >> +
> >> +struct iommu_table_group {
> >>   #ifdef CONFIG_IOMMU_API
> >> -extern void iommu_register_group(struct iommu_table *tbl,
> >> +	struct iommu_group *group;
> >> +#endif
> >> +	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> >> +};
> >> +
> >> +#ifdef CONFIG_IOMMU_API
> >> +extern void iommu_register_group(struct iommu_table_group *table_group,
> >>   				 int pci_domain_number, unsigned long pe_num);
> >>   extern int iommu_add_device(struct device *dev);
> >>   extern void iommu_del_device(struct device *dev);
> >>   extern int __init tce_iommu_bus_notifier_init(void);
> >>   #else
> >> -static inline void iommu_register_group(struct iommu_table *tbl,
> >> +static inline void iommu_register_group(struct iommu_table_group *table_group,
> >>   					int pci_domain_number,
> >>   					unsigned long pe_num)
> >
> >
> > Not a new problem, but there's some awfully liberal use of the namespace
> > with function names here.  IOMMU API uses iommu_foo() functions.  IOMMU
> > group related interfaces within the IOMMU API include "group" somewhere
> > in that name.  powerpc specific functions should include a tag to avoid
> > causing conflicts there.
> 
> 
> Cannot argue with that but it is kind of late or not for this patchset, no? 
> And iommu_table is way too generic for powerpc/spapr-specific thing.
> 
> I can replace with something better, should I do this now?

I don't think this series makes it (much) worse, but it's something that
should be cleaned up.  Probably in a separate, later series because this
series is plenty long enough.
