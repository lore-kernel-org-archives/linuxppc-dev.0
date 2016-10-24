Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2SG33SfpzDvYs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 18:14:35 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r16so15714478pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 00:14:35 -0700 (PDT)
Date: Mon, 24 Oct 2016 18:14:24 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson
 <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel v4 3/4] vfio/spapr: Reference mm in tce_container
Message-ID: <20161024181424.2887fc03@roar.ozlabs.ibm.com>
In-Reply-To: <1477291990-2872-4-git-send-email-aik@ozlabs.ru>
References: <1477291990-2872-1-git-send-email-aik@ozlabs.ru>
 <1477291990-2872-4-git-send-email-aik@ozlabs.ru>
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

On Mon, 24 Oct 2016 17:53:09 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> In some situations the userspace memory context may live longer than
> the userspace process itself so if we need to do proper memory context
> cleanup, we better have tce_container take a reference to mm_struct and
> use it later when the process is gone (@current or @current->mm is NULL).
> 
> This references mm and stores the pointer in the container; this is done
> when a container is just created so checking for !current->mm in other
> places becomes pointless.
> 
> This replaces current->mm with container->mm everywhere except debug
> prints.
> 
> This adds a check that current->mm is the same as the one stored in
> the container to prevent userspace from making changes to a memory
> context of other processes; in order to add this check,
> VFIO_CHECK_EXTENSION is moved out of the switch(cmd) as it is
> quite special anyway - it is the only ioctl() called when neither
> container nor container->mm is initialized.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v4:
> * added check for container->mm!=current->mm in tce_iommu_ioctl()
> for all ioctls and removed other redundand checks

[...]

> @@ -326,13 +314,18 @@ static void *tce_iommu_open(unsigned long arg)
>  
>  	container->v2 = arg == VFIO_SPAPR_TCE_v2_IOMMU;
>  
> +	/* current->mm cannot be NULL in this context */
> +	container->mm = current->mm;
> +	atomic_inc(&container->mm->mm_count);

[...]

> @@ -733,7 +728,13 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		}
>  
>  		return (ret < 0) ? 0 : ret;
> +	}
>  
> +	/* tce_iommu_open() initializes container->mm so it can't be NULL here */
> +	if (container->mm != current->mm)
> +		return -ESRCH;
> +
> +	switch (cmd) {
>  	case VFIO_IOMMU_SPAPR_TCE_GET_INFO: {
>  		struct vfio_iommu_spapr_tce_info info;
>  		struct tce_iommu_group *tcegrp;

I think doing the mm checks like this is a great improvement.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick
