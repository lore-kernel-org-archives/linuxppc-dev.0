Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rxHlK2ZsWzDqTb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jul 2016 16:33:17 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id q2so8052977pap.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 23:33:17 -0700 (PDT)
Date: Sat, 23 Jul 2016 16:33:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson
 <david@gibson.dropbear.id.au>
Subject: Re: [kernel,v2,1/2] powerpc/iommu: Stop using @current in mm_iommu_xxx
Message-ID: <20160723163307.628999ce@roar.ozlabs.ibm.com>
In-Reply-To: <1468989271-753-2-git-send-email-aik@ozlabs.ru>
References: <1468989271-753-2-git-send-email-aik@ozlabs.ru>
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

On Wed, 20 Jul 2016 14:34:30 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:



>  static long tce_iommu_register_pages(struct tce_container *container,
> @@ -128,10 +129,17 @@ static long tce_iommu_register_pages(struct
> tce_container *container, ((vaddr + size) < vaddr))
>  		return -EINVAL;
>  
> -	ret = mm_iommu_get(vaddr, entries, &mem);
> +	if (!container->mm) {
> +		if (!current->mm)
> +			return -ESRCH; /* process exited */

This shouldn't happen if we're a userspace process.

> +
> +		atomic_inc(&current->mm->mm_count);
> +		container->mm = current->mm;
> +	}
> +
> +	ret = mm_iommu_get(container->mm, vaddr, entries, &mem);

Is it possible for processes (different mm) to be using the same
container? 


> @@ -354,6 +362,8 @@ static void tce_iommu_release(void *iommu_data)
>  		tce_iommu_free_table(tbl);
>  	}
>  
> +	if (container->mm)
> +		mmdrop(container->mm);
>  	tce_iommu_disable(container);
>  	mutex_destroy(&container->lock);

I'm wondering why keep the mm around at all. There is a bit of
locked_vm accounting there (which maybe doesn't exactly do the
right thing if we're talking about current task's rlimit if the
mm does not belong to current anyway).

The interesting cases are only the ones where a thread does
something with container->mm when current->mm != container->mm
(either a different process or a kernel thread). In what
situations does that happen?

Thanks,
Nick
