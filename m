Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37F151A0877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:29:15 +1000 (EST)
Received: by mail-pd0-f175.google.com with SMTP id v10so6731428pde.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 02:29:13 -0700 (PDT)
Message-ID: <53C4F464.2010007@ozlabs.ru>
Date: Tue, 15 Jul 2014 19:29:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 01/13] KVM: PPC: Account TCE pages in locked_vm
References: <1405416333-12477-1-git-send-email-aik@ozlabs.ru>
 <1405416333-12477-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405416333-12477-2-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: Paul Mackerras <paulus@samba.org>, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/15/2014 07:25 PM, Alexey Kardashevskiy wrote:
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


Just realized this should go to "powernv: vfio: Add Dynamic DMA windows (DDW)".

And neither patchset accounts DDW in locked_vm, need to decide how...


> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index 2137836..4ca33f1 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -73,18 +73,48 @@ static long kvmppc_stt_npages(unsigned long window_size)
>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
>  
> +/*
> + * Checks ulimit in order not to let the user space to pin all
> + * available memory for TCE tables.
> + */
> +static long kvmppc_account_memlimit(long npages)
> +{
> +	unsigned long ret = 0, locked, lock_limit;
> +
> +	if (!current->mm)
> +		return -ESRCH; /* process exited */
> +
> +	down_write(&current->mm->mmap_sem);
> +	locked = current->mm->locked_vm + npages;
> +	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> +	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
> +		pr_warn("RLIMIT_MEMLOCK (%ld) exceeded\n",
> +				rlimit(RLIMIT_MEMLOCK));
> +		ret = -ENOMEM;
> +	} else {
> +		current->mm->locked_vm += npages;
> +	}
> +	up_write(&current->mm->mmap_sem);
> +
> +	return ret;
> +}
> +
>  static void release_spapr_tce_table(struct kvmppc_spapr_tce_table *stt)
>  {
>  	struct kvm *kvm = stt->kvm;
>  	int i;
> +	long npages = kvmppc_stt_npages(stt->window_size);
>  
>  	mutex_lock(&kvm->lock);
>  	list_del(&stt->list);
> -	for (i = 0; i < kvmppc_stt_npages(stt->window_size); i++)
> +	for (i = 0; i < npages; i++)
>  		__free_page(stt->pages[i]);
> +
>  	kfree(stt);
>  	mutex_unlock(&kvm->lock);
>  
> +	kvmppc_account_memlimit(-(npages + 1));
> +
>  	kvm_put_kvm(kvm);
>  }
>  
> @@ -140,6 +170,9 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	}
>  
>  	npages = kvmppc_stt_npages(args->window_size);
> +	ret = kvmppc_account_memlimit(npages + 1);
> +	if (ret)
> +		goto fail;
>  
>  	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
>  		      GFP_KERNEL);
> 


-- 
Alexey
