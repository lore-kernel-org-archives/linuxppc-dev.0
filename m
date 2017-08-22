Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcDf85MkSzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 01:16:00 +1000 (AEST)
Subject: Re: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
To: nixiaoming <nixiaoming@huawei.com>, agraf@suse.com, pbonzini@redhat.com,
 rkrcmar@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20170822142823.69425-1-nixiaoming@huawei.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <95fe182a-fd21-77a1-33df-0e609c2845fd@redhat.com>
Date: Tue, 22 Aug 2017 17:15:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170822142823.69425-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22.08.2017 16:28, nixiaoming wrote:
> miss kfree(stt) when anon_inode_getfd return fail
> so add check anon_inode_getfd return val, and kfree stt
> 
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index a160c14..a0b4459 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -341,8 +341,11 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  
>  	mutex_unlock(&kvm->lock);
>  
> -	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> +	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>  				stt, O_RDWR | O_CLOEXEC);
> +	if (ret < 0)
> +		goto fail;
> +	return ret;
>  
>  fail:
>  	if (stt) {
> 


stt has already been added to kvm->arch.spapr_tce_tables, so freeing it
is evil IMHO. I don't know that code, so I don't know if there is some
other place that will make sure that everything in
kvm->arch.spapr_tce_tables will properly get freed, even when no release
function has been called (kvm_spapr_tce_release).
-- 

Thanks,

David
