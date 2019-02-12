Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823CC282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 18:58:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C244A222C0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 18:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C244A222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zX494hvbzDqQR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 05:58:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=alex.williamson@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zX2K22hPzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 05:56:57 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C9083DE2F;
 Tue, 12 Feb 2019 18:56:54 +0000 (UTC)
Received: from w520.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EC985C22F;
 Tue, 12 Feb 2019 18:56:53 +0000 (UTC)
Date: Tue, 12 Feb 2019 11:56:52 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 2/5] vfio/spapr_tce: use pinned_vm instead of locked_vm
 to account pinned pages
Message-ID: <20190212115652.6cf9a20b@w520.home>
In-Reply-To: <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
References: <20190211224437.25267-1-daniel.m.jordan@oracle.com>
 <20190211224437.25267-3-daniel.m.jordan@oracle.com>
 <ee4d14db-05c3-6208-503c-16e287fa78eb@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 12 Feb 2019 18:56:55 +0000 (UTC)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: dave@stgolabs.net, jack@suse.cz, kvm@vger.kernel.org, linux-mm@kvack.org,
 linux-fpga@vger.kernel.org, atull@kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Daniel Jordan <daniel.m.jordan@oracle.com>,
 jgg@ziepe.ca, mdf@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, cl@linux.com, hao.wu@intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 12 Feb 2019 17:56:18 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 12/02/2019 09:44, Daniel Jordan wrote:
> > Beginning with bc3e53f682d9 ("mm: distinguish between mlocked and pinned
> > pages"), locked and pinned pages are accounted separately.  The SPAPR
> > TCE VFIO IOMMU driver accounts pinned pages to locked_vm; use pinned_vm
> > instead.
> > 
> > pinned_vm recently became atomic and so no longer relies on mmap_sem
> > held as writer: delete.
> > 
> > Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> > ---
> >  Documentation/vfio.txt              |  6 +--
> >  drivers/vfio/vfio_iommu_spapr_tce.c | 64 ++++++++++++++---------------
> >  2 files changed, 33 insertions(+), 37 deletions(-)
> > 
> > diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
> > index f1a4d3c3ba0b..fa37d65363f9 100644
> > --- a/Documentation/vfio.txt
> > +++ b/Documentation/vfio.txt
> > @@ -308,7 +308,7 @@ This implementation has some specifics:
> >     currently there is no way to reduce the number of calls. In order to make
> >     things faster, the map/unmap handling has been implemented in real mode
> >     which provides an excellent performance which has limitations such as
> > -   inability to do locked pages accounting in real time.
> > +   inability to do pinned pages accounting in real time.
> >  
> >  4) According to sPAPR specification, A Partitionable Endpoint (PE) is an I/O
> >     subtree that can be treated as a unit for the purposes of partitioning and
> > @@ -324,7 +324,7 @@ This implementation has some specifics:
> >  		returns the size and the start of the DMA window on the PCI bus.
> >  
> >  	VFIO_IOMMU_ENABLE
> > -		enables the container. The locked pages accounting
> > +		enables the container. The pinned pages accounting
> >  		is done at this point. This lets user first to know what
> >  		the DMA window is and adjust rlimit before doing any real job.

I don't know of a ulimit only covering pinned pages, so for
documentation it seems more correct to continue referring to this as
locked page accounting.

> > @@ -454,7 +454,7 @@ This implementation has some specifics:
> >  
> >     PPC64 paravirtualized guests generate a lot of map/unmap requests,
> >     and the handling of those includes pinning/unpinning pages and updating
> > -   mm::locked_vm counter to make sure we do not exceed the rlimit.
> > +   mm::pinned_vm counter to make sure we do not exceed the rlimit.
> >     The v2 IOMMU splits accounting and pinning into separate operations:
> >  
> >     - VFIO_IOMMU_SPAPR_REGISTER_MEMORY/VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY ioctls
> > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> > index c424913324e3..f47e020dc5e4 100644
> > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > @@ -34,9 +34,11 @@
> >  static void tce_iommu_detach_group(void *iommu_data,
> >  		struct iommu_group *iommu_group);
> >  
> > -static long try_increment_locked_vm(struct mm_struct *mm, long npages)
> > +static long try_increment_pinned_vm(struct mm_struct *mm, long npages)
> >  {
> > -	long ret = 0, locked, lock_limit;
> > +	long ret = 0;
> > +	s64 pinned;
> > +	unsigned long lock_limit;
> >  
> >  	if (WARN_ON_ONCE(!mm))
> >  		return -EPERM;
> > @@ -44,39 +46,33 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
> >  	if (!npages)
> >  		return 0;
> >  
> > -	down_write(&mm->mmap_sem);
> > -	locked = mm->locked_vm + npages;
> > +	pinned = atomic64_add_return(npages, &mm->pinned_vm);
> >  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > -	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> > +	if (pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
> >  		ret = -ENOMEM;
> > -	else
> > -		mm->locked_vm += npages;
> > +		atomic64_sub(npages, &mm->pinned_vm);
> > +	}
> >  
> > -	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
> > +	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%lu%s\n", current->pid,
> >  			npages << PAGE_SHIFT,
> > -			mm->locked_vm << PAGE_SHIFT,
> > -			rlimit(RLIMIT_MEMLOCK),
> > -			ret ? " - exceeded" : "");
> > -
> > -	up_write(&mm->mmap_sem);
> > +			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
> > +			rlimit(RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
> >  
> >  	return ret;
> >  }
> >  
> > -static void decrement_locked_vm(struct mm_struct *mm, long npages)
> > +static void decrement_pinned_vm(struct mm_struct *mm, long npages)
> >  {
> >  	if (!mm || !npages)
> >  		return;
> >  
> > -	down_write(&mm->mmap_sem);
> > -	if (WARN_ON_ONCE(npages > mm->locked_vm))
> > -		npages = mm->locked_vm;
> > -	mm->locked_vm -= npages;
> > -	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
> > +	if (WARN_ON_ONCE(npages > atomic64_read(&mm->pinned_vm)))
> > +		npages = atomic64_read(&mm->pinned_vm);
> > +	atomic64_sub(npages, &mm->pinned_vm);
> > +	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%lu\n", current->pid,
> >  			npages << PAGE_SHIFT,
> > -			mm->locked_vm << PAGE_SHIFT,
> > +			atomic64_read(&mm->pinned_vm) << PAGE_SHIFT,
> >  			rlimit(RLIMIT_MEMLOCK));
> > -	up_write(&mm->mmap_sem);  
> 
> 
> So it used to be down_write+up_write and stuff in between.
> 
> Now it is 3 independent accesses (actually 4 but the last one is
> diagnostic) with no locking around them. Why do not we need a lock
> anymore precisely? Thanks,

The first 2 look pretty sketchy to me, is there a case where you don't
know how many pages you've pinned to unpin them?  And can it ever
really be correct to just unpin whatever remains?  The last access is
diagnostic, which leaves 1.  Daniel's rework to warn on a negative
result looks more sane. Thanks,

Alex
