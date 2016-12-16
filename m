Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg94v36htzDwBg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 23:45:03 +1100 (AEDT)
Subject: Re: [PATCH 06/11] powerpc/kvm: Allow KVM_PPC_ALLOCATE_HTAB ioctl() to
 change HPT size
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-7-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6c2566ea-cc80-4c02-27a2-258284d8f98b@redhat.com>
Date: Fri, 16 Dec 2016 13:44:57 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-7-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.12.2016 06:53, David Gibson wrote:
> The KVM_PPC_ALLOCATE_HTAB ioctl() is used to set the size of hashed page
> table (HPT) that userspace expects a guest VM to have, and is also used to
> clear that HPT when necessary (e.g. guest reboot).
> 
> At present, once the ioctl() is called for the first time, the HPT size can
> never be changed thereafter - it will be cleared but always sized as from
> the first call.
> 
> With upcoming HPT resize implementation, we're going to need to allow
> userspace to resize the HPT at reset (to change it back to the default size
> if the guest changed it).
> 
> So, we need to allow this ioctl() to change the HPT size.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 53 ++++++++++++++++++++-----------------
>  arch/powerpc/kvm/book3s_hv.c        |  5 +---
>  3 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 41575b8..3b837bc 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -157,7 +157,7 @@ extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
>  
>  extern int kvmppc_allocate_hpt(struct kvm_hpt_info *info, u32 order);
>  extern void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info);
> -extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp);
> +extern long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order);
>  extern void kvmppc_free_hpt(struct kvm_hpt_info *info);
>  extern long kvmppc_prepare_vrma(struct kvm *kvm,
>  				struct kvm_userspace_memory_region *mem);
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 68bb228..8e5ac2f 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -104,10 +104,22 @@ void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
>  		info->virt, (long)info->order, kvm->arch.lpid);
>  }
>  
> -long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
> +void kvmppc_free_hpt(struct kvm_hpt_info *info)
> +{
> +	vfree(info->rev);
> +	if (info->cma)
> +		kvm_free_hpt_cma(virt_to_page(info->virt),
> +				 1 << (info->order - PAGE_SHIFT));
> +	else
> +		free_pages(info->virt, info->order - PAGE_SHIFT);
> +	info->virt = 0;
> +	info->order = 0;
> +}

Why do you need to move kvmppc_free_hpt() around? Seems like unecessary
code churn to me?

> +long kvmppc_alloc_reset_hpt(struct kvm *kvm, int order)
>  {
>  	long err = -EBUSY;
> -	long order;
> +	struct kvm_hpt_info info;
>  
>  	mutex_lock(&kvm->lock);
>  	if (kvm->arch.hpte_setup_done) {
> @@ -119,8 +131,9 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
>  			goto out;
>  		}
>  	}
> -	if (kvm->arch.hpt.virt) {
> -		order = kvm->arch.hpt.order;
> +	if (kvm->arch.hpt.order == order) {
> +		/* We already have a suitable HPT */
> +
>  		/* Set the entire HPT to 0, i.e. invalid HPTEs */
>  		memset((void *)kvm->arch.hpt.virt, 0, 1ul << order);
>  		/*
> @@ -129,33 +142,23 @@ long kvmppc_alloc_reset_hpt(struct kvm *kvm, u32 *htab_orderp)
>  		kvmppc_rmap_reset(kvm);
>  		/* Ensure that each vcpu will flush its TLB on next entry. */
>  		cpumask_setall(&kvm->arch.need_tlb_flush);
> -		*htab_orderp = order;
>  		err = 0;
> -	} else {
> -		struct kvm_hpt_info info;
> -
> -		err = kvmppc_allocate_hpt(&info, *htab_orderp);
> -		if (err < 0)
> -			goto out;
> -		kvmppc_set_hpt(kvm, &info);
> +		goto out;
>  	}
> - out:
> +
> +	if (kvm->arch.hpt.virt)
> +		kvmppc_free_hpt(&kvm->arch.hpt);
> +
> +	err = kvmppc_allocate_hpt(&info, order);
> +	if (err < 0)
> +		goto out;
> +	kvmppc_set_hpt(kvm, &info);
> +
> +out:
>  	mutex_unlock(&kvm->lock);
>  	return err;
>  }
>  
> -void kvmppc_free_hpt(struct kvm_hpt_info *info)
> -{
> -	vfree(info->rev);
> -	if (info->cma)
> -		kvm_free_hpt_cma(virt_to_page(info->virt),
> -				 1 << (info->order - PAGE_SHIFT));
> -	else
> -		free_pages(info->virt, info->order - PAGE_SHIFT);
> -	info->virt = 0;
> -	info->order = 0;
> -}
> -
>  /* Bits in first HPTE dword for pagesize 4k, 64k or 16M */
>  static inline unsigned long hpte0_pgsize_encoding(unsigned long pgsize)
>  {
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 71c5adb..957e473 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -3600,12 +3600,9 @@ static long kvm_arch_vm_ioctl_hv(struct file *filp,
>  		r = -EFAULT;
>  		if (get_user(htab_order, (u32 __user *)argp))
>  			break;
> -		r = kvmppc_alloc_reset_hpt(kvm, &htab_order);
> +		r = kvmppc_alloc_reset_hpt(kvm, htab_order);
>  		if (r)
>  			break;
> -		r = -EFAULT;
> -		if (put_user(htab_order, (u32 __user *)argp))
> -			break;

Now that htab_order is not changed anymore by the kernel, I'm pretty
sure you need some checks on the value here before calling
kvmppc_alloc_reset_hpt(), e.g. return an error code if htab_order <
PPC_MIN_HPT_ORDER.

And, I'm not sure if I got that right, but in former times, the
htab_order from the userspace application was just a suggestion, and now
it's mandatory, right? So if an old userspace used a very high value
here (or even something smaller than PPC_MIN_HPT_ORDER like 0), the
kernel fixed this up and the userspace could run happily with the fixed
value afterwards. But since this value from userspace if mandatory now,
such an userspace application is broken now. So maybe it's better to
introduce a new ioctl for this new behavior instead, to avoid breaking
old userspace applications?

Anyway, you should also update Documentation/virtual/kvm/api.txt to
reflect the new behavior.

>  		r = 0;
>  		break;
>  	}

 Thomas
