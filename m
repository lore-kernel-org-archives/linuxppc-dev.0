Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKCh53H5fzDvmf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 18:39:49 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e9so16556718pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 23:39:49 -0800 (PST)
Subject: Re: [PATCH kernel v5 5/6] vfio/spapr: Reference mm in tce_container
To: linuxppc-dev@lists.ozlabs.org
References: <1478867537-27893-1-git-send-email-aik@ozlabs.ru>
 <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras
 <paulus@samba.org>, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <7bf695fa-502a-80b1-85be-79f0aff55366@ozlabs.ru>
Date: Thu, 17 Nov 2016 18:39:41 +1100
MIME-Version: 1.0
In-Reply-To: <1478867537-27893-6-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/16 23:32, Alexey Kardashevskiy wrote:
> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better have tce_container take a reference to mm_struct and
> use it later when the process is gone (@current or @current->mm is NULL).
> 
> This references mm and stores the pointer in the container; this is done
> in a new helper - tce_iommu_mm_set() - when one of the following happens:
> - a container is enabled (IOMMU v1);
> - a first attempt to pre-register memory is made (IOMMU v2);
> - a DMA window is created (IOMMU v2).
> The @mm stays referenced till the container is destroyed.
> 
> This replaces current->mm with container->mm everywhere except debug
> prints.
> 
> This adds a check that current->mm is the same as the one stored in
> the container to prevent userspace from making changes to a memory
> context of other processes.
> 
> DMA map/unmap ioctls() do not check for @mm as they already check
> for @enabled which is set after tce_iommu_mm_set() is called.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v5:
> * postpone referencing of mm
> 
> v4:
> * added check for container->mm!=current->mm in tce_iommu_ioctl()
> for all ioctls and removed other redundand checks
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 159 ++++++++++++++++++++++--------------
>  1 file changed, 99 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
> index 1c02498..9a81a7e 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -31,49 +31,49 @@
>  static void tce_iommu_detach_group(void *iommu_data,
>  		struct iommu_group *iommu_group);
>  
> -static long try_increment_locked_vm(long npages)
> +static long try_increment_locked_vm(struct mm_struct *mm, long npages)
>  {
>  	long ret = 0, locked, lock_limit;
>  
> -	if (!current || !current->mm)
> -		return -ESRCH; /* process exited */
> +	if (!mm)
> +		return -EPERM;
>  
>  	if (!npages)
>  		return 0;
>  
> -	down_write(&current->mm->mmap_sem);
> -	locked = current->mm->locked_vm + npages;
> +	down_write(&mm->mmap_sem);
> +	locked = mm->locked_vm + npages;
>  	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  	if (locked > lock_limit && !capable(CAP_IPC_LOCK))



Oh boy. Now it seems I have to reference a task, not just mm (which I may
not have to reference at all after all as the task reference should keep mm
alive) as I missed the fact capable() and rlimit() are working with @current.


Alex,

Is there anything else I should fix before posting v6? Thanks.



-- 
Alexey
