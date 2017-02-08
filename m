Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJGbt2VZMzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:48:10 +1100 (AEDT)
Date: Wed, 8 Feb 2017 20:48:06 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: agraf@suse.com, pbonzini@redhat.com, rkrcmar@redhat.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au,
 Wei Yongjun <weiyongjun1@huawei.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH -next] KVM: PPC: Fix error return code in
 kvm_vm_ioctl_create_spapr_tce()
Message-ID: <20170208094806.GB18186@fergus.ozlabs.ibm.com>
References: <20170207153407.22325-1-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170207153407.22325-1-weiyj.lk@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 07, 2017 at 03:34:07PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENOMEM from the memory alloc error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index d71f872..8a4a3f0 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -173,8 +173,10 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  
>  	stt = kzalloc(sizeof(*stt) + npages * sizeof(struct page *),
>  		      GFP_KERNEL);
> -	if (!stt)
> +	if (!stt) {
> +		ret = -ENOMEM;
>  		goto fail;

I think it would be better to set ret unconditionally to -ENOMEM
before the if; that would save you one line here and make the second
hunk unnecessary.

> +	}
>  
>  	stt->liobn = args->liobn;
>  	stt->page_shift = args->page_shift;
> @@ -184,8 +186,10 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  
>  	for (i = 0; i < npages; i++) {
>  		stt->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO);
> -		if (!stt->pages[i])
> +		if (!stt->pages[i]) {
> +			ret = -ENOMEM;
>  			goto fail;
> +		}
>  	}
>  
>  	kvm_get_kvm(kvm);

Paul.
