Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t0T8S6mtczDvH2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Oct 2016 12:47:52 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id s8so7038439pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 18:47:52 -0700 (PDT)
Date: Fri, 21 Oct 2016 12:47:37 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>, Paul Mackerras
 <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v3 3/4] vfio/spapr: Cache mm in tce_container
Message-ID: <20161021124737.1b65ae8b@roar.ozlabs.ibm.com>
In-Reply-To: <20161021002134.GS11140@umbus.fritz.box>
References: <1476932630-45323-1-git-send-email-aik@ozlabs.ru>
 <1476932630-45323-4-git-send-email-aik@ozlabs.ru>
 <20161020183121.073f01ac@roar.ozlabs.ibm.com>
 <20161021002134.GS11140@umbus.fritz.box>
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

On Fri, 21 Oct 2016 11:21:34 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 20, 2016 at 06:31:21PM +1100, Nicholas Piggin wrote:
> > On Thu, 20 Oct 2016 14:03:49 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >   
> > > In some situations the userspace memory context may live longer than
> > > the userspace process itself so if we need to do proper memory context
> > > cleanup, we better cache @mm and use it later when the process is gone
> > > (@current or @current->mm is NULL).
> > > 
> > > This references mm and stores the pointer in the container; this is done
> > > when a container is just created so checking for !current->mm in other
> > > places becomes pointless.
> > > 
> > > This replaces current->mm with container->mm everywhere except debug
> > > prints.
> > > 
> > > This adds a check that current->mm is the same as the one stored in
> > > the container to prevent userspace from registering memory in other
> > > processes.
> > > 
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > >  drivers/vfio/vfio_iommu_spapr_tce.c | 127 ++++++++++++++++++++----------------
> > >  1 file changed, 71 insertions(+), 56 deletions(-)
> > > 
> > > diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> > > index d0c38b2..6b0b121 100644
> > > --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> > > +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> > > @@ -31,49 +31,46 @@  
> > 
> > Does it make sense to move the rest of these hunks into patch 2?
> > I think they're similarly just moving the mm reference into callers.
> > 
> >   
> > >  static void tce_iommu_detach_group(void *iommu_data,
> > >  		struct iommu_group *iommu_group);
> > >  
> > > -static long try_increment_locked_vm(long npages)
> > > +static long try_increment_locked_vm(struct mm_struct *mm, long npages)
> > >  {
> > >  	long ret = 0, locked, lock_limit;
> > >  
> > > -	if (!current || !current->mm)
> > > -		return -ESRCH; /* process exited */
> > > -
> > >  	if (!npages)
> > >  		return 0;
> > >  
> > > -	down_write(&current->mm->mmap_sem);
> > > -	locked = current->mm->locked_vm + npages;
> > > +	down_write(&mm->mmap_sem);
> > > +	locked = mm->locked_vm + npages;
> > >  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > >  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
> > >  		ret = -ENOMEM;
> > >  	else
> > > -		current->mm->locked_vm += npages;
> > > +		mm->locked_vm += npages;
> > >  
> > >  	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
> > >  			npages << PAGE_SHIFT,
> > > -			current->mm->locked_vm << PAGE_SHIFT,
> > > +			mm->locked_vm << PAGE_SHIFT,
> > >  			rlimit(RLIMIT_MEMLOCK),
> > >  			ret ? " - exceeded" : "");
> > >  
> > > -	up_write(&current->mm->mmap_sem);
> > > +	up_write(&mm->mmap_sem);
> > >  
> > >  	return ret;
> > >  }
> > >  
> > > -static void decrement_locked_vm(long npages)
> > > +static void decrement_locked_vm(struct mm_struct *mm, long npages)
> > >  {
> > > -	if (!current || !current->mm || !npages)
> > > +	if (!mm || !npages)
> > >  		return; /* process exited */  
> > 
> > I know you're trying to be defensive and change as little logic as possible,
> > but some cases should be an error, and I think some of the "process exited"
> > comments were wrong anyway.
> > 
> > Maybe pull the !mm test into the caller and make it WARN_ON?
> > 
> >   
> > > @@ -317,6 +311,9 @@ static void *tce_iommu_open(unsigned long arg)
> > >  		return ERR_PTR(-EINVAL);
> > >  	}
> > >  
> > > +	if (!current->mm)
> > > +		return ERR_PTR(-ESRCH); /* process exited */  
> > 
> > A userspace thread in the kernel can't have its mm disappear, unless you
> > are actually in the exit code. !current->mm is more like a test for a kernel
> > thread.
> > 
> >   
> > > +
> > >  	container = kzalloc(sizeof(*container), GFP_KERNEL);
> > >  	if (!container)
> > >  		return ERR_PTR(-ENOMEM);
> > > @@ -326,13 +323,17 @@ static void *tce_iommu_open(unsigned long arg)
> > >  
> > >  	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
> > >  
> > > +	container->mm = current->mm;
> > > +	atomic_inc(&container->mm->mm_count);
> > > +
> > >  	return container;  
> > 
> > It's a nitpick if you respin the patch, but I guess it would better be
> > described as a reference than a cache of the object. "have tce_container
> > take a reference to mm_struct".
> > 
> >   
> > > @@ -515,13 +526,16 @@ static long tce_iommu_build_v2(struct tce_container *container,
> > >  	unsigned long hpa;
> > >  	enum dma_data_direction dirtmp;
> > >  
> > > +	if (container->mm != current->mm)
> > > +		return -ESRCH;  
> > 
> > Good, is this condition now enforced on all entrypoints that use
> > container->mm (except the final teardown)? (The mlock/rlimit stuff,
> > as we talked about before, doesn't make sense if not).  
> 
> Right.  I don't know that it's actually dangerous, but i think it
> would be needlessly weird for one process to be able to manipulate
> another process's mm via the container fd.  So all the entry points
> that are directly called from userspace (basically, the ioctl()s)
> should verify that current->mm matches container->mm (except the one
> which initiallizes container->mm, obviously).
> 
> One other concern.  If I follow the logic correctly, if a process
> created a container, passed the fd to another process then exited, the
> container fd held by the other process would keep the original
> process's mm alive indefinitely.  I'm not sure if that's a problem.
> Nick?
> 

Keeping the mm alive indefinitely is okay. When a process exits, it
will tear down its user mappings, but the mm struct stays around for
other users. Kernel threads can pick these up and keep them alive for
example, which is what was causing the problem in the first place.

Thanks,
Nick
