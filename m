Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2CF71A0748
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 14:46:21 +1100 (AEDT)
Message-ID: <1427946378.5567.340.camel@redhat.com>
Subject: Re: [PATCH kernel v7 04/31] vfio: powerpc/spapr: Use it_page_size
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 01 Apr 2015 21:46:18 -0600
In-Reply-To: <551CBA14.7080707@ozlabs.ru>
References: <1427468115-2224-1-git-send-email-aik@ozlabs.ru>
 <1427468115-2224-5-git-send-email-aik@ozlabs.ru>
 <1427924904.5567.303.camel@redhat.com> <551CA9D7.2060804@ozlabs.ru>
 <1427943033.5567.329.camel@redhat.com> <551CBA14.7080707@ozlabs.ru>
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

On Thu, 2015-04-02 at 14:40 +1100, Alexey Kardashevskiy wrote:
> On 04/02/2015 01:50 PM, Alex Williamson wrote:
> > On Thu, 2015-04-02 at 13:30 +1100, Alexey Kardashevskiy wrote:
> >> On 04/02/2015 08:48 AM, Alex Williamson wrote:
> >>> On Sat, 2015-03-28 at 01:54 +1100, Alexey Kardashevskiy wrote:
> >>>> This makes use of the it_page_size from the iommu_table struct
> >>>> as page size can differ.
> >>>>
> >>>> This replaces missing IOMMU_PAGE_SHIFT macro in commented debug code
> >>>> as recently introduced IOMMU_PAGE_XXX macros do not include
> >>>> IOMMU_PAGE_SHIFT.
> >>>>
> >>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>>> ---
> >>>>    drivers/vfio/vfio_iommu_spapr_tce.c | 26 +++++++++++++-------------
> >>>>    1 file changed, 13 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> index f835e63..8bbee22 100644
> >>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>> @@ -91,7 +91,7 @@ static int tce_iommu_enable(struct tce_container *container)
> >>>>    	 * enforcing the limit based on the max that the guest can map.
> >>>>    	 */
> >>>>    	down_write(&current->mm->mmap_sem);
> >>>> -	npages = (tbl->it_size << IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> >>>> +	npages = (tbl->it_size << tbl->it_page_shift) >> PAGE_SHIFT;
> >>>>    	locked = current->mm->locked_vm + npages;
> >>>>    	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> >>>>    	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> >>>> @@ -120,7 +120,7 @@ static void tce_iommu_disable(struct tce_container *container)
> >>>>
> >>>>    	down_write(&current->mm->mmap_sem);
> >>>>    	current->mm->locked_vm -= (container->tbl->it_size <<
> >>>> -			IOMMU_PAGE_SHIFT_4K) >> PAGE_SHIFT;
> >>>> +			container->tbl->it_page_shift) >> PAGE_SHIFT;
> >>>>    	up_write(&current->mm->mmap_sem);
> >>>>    }
> >>>>
> >>>> @@ -222,7 +222,7 @@ static long tce_iommu_build(struct tce_container *container,
> >>>>    					tce, ret);
> >>>>    			break;
> >>>>    		}
> >>>> -		tce += IOMMU_PAGE_SIZE_4K;
> >>>> +		tce += IOMMU_PAGE_SIZE(tbl);
> >>>
> >>>
> >>> Is PAGE_SIZE ever smaller than IOMMU_PAGE_SIZE(tbl)?  IOW, can the page
> >>> we got from get_user_pages_fast() ever not completely fill the tce
> >>> entry?
> >>
> >>
> >> Yes. IOMMU_PAGE_SIZE is 4K/64K/16M (16M is with huge pages enabled in QEMU
> >> with -mempath), PAGE_SIZE is 4K/64K (normally 64K).
> >
> > Isn't that a problem then that you're filling the tce with processor
> > page sizes via get_user_pages_fast(), but incrementing the tce by by
> > IOMMU page size?  For example, if PAGE_SIZE = 4K and IOMMU_PAGE_SIZE !=
> > 4K have we really pinned all of the memory backed by the tce?Where do
> > you make sure the 4K page is really contiguous for the IOMMU page?
> 
> 
> Aaaah. This is just not supported. Instead, after the previous patch 
> ("vfio: powerpc/spapr: Check that TCE page size is equal to it_page_size", 
> which need fixed subject), tce_page_is_contained(page4K, 64K) will return 
> false and the caller - tce_iommu_build() - will return -EPERM.

Ok, makes sense.  Thanks
