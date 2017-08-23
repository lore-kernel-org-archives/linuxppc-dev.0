Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xccPf5H8qzDrVh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 16:06:30 +1000 (AEST)
Date: Wed, 23 Aug 2017 16:06:24 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Nixiaoming <nixiaoming@huawei.com>
Cc: David Hildenbrand <david@redhat.com>, "agraf@suse.com" <agraf@suse.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] fix memory leak on kvm_vm_ioctl_create_spapr_tce
Message-ID: <20170823060624.GA13958@fergus.ozlabs.ibm.com>
References: <20170822142823.69425-1-nixiaoming@huawei.com>
 <95fe182a-fd21-77a1-33df-0e609c2845fd@redhat.com>
 <8fd9a878-a8ce-5576-9a5c-1c221ff6ded7@redhat.com>
 <E490CD805F7529488761C40FD9D26EF1299B4667@DGGEMA505-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E490CD805F7529488761C40FD9D26EF1299B4667@DGGEMA505-MBX.china.huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 23, 2017 at 01:43:08AM +0000, Nixiaoming wrote:
> >On 22.08.2017 17:15, David Hildenbrand wrote:
> >> On 22.08.2017 16:28, nixiaoming wrote:
> >>> miss kfree(stt) when anon_inode_getfd return fail so add check 
> >>> anon_inode_getfd return val, and kfree stt
> >>>
> >>> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> >>> ---
> >>>  arch/powerpc/kvm/book3s_64_vio.c | 5 ++++-
> >>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c 
> >>> b/arch/powerpc/kvm/book3s_64_vio.c
> >>> index a160c14..a0b4459 100644
> >>> --- a/arch/powerpc/kvm/book3s_64_vio.c
> >>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> >>> @@ -341,8 +341,11 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm 
> >>> *kvm,
> >>>  
> >>>  	mutex_unlock(&kvm->lock);
> >>>  
> >>> -	return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> >>> +	ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> >>>  				stt, O_RDWR | O_CLOEXEC);
> >>> +	if (ret < 0)
> >>> +		goto fail;
> >>> +	return ret;
> >>>  
> >>>  fail:
> >>>  	if (stt) {
> >>>
> >> 
> >> 
> >> stt has already been added to kvm->arch.spapr_tce_tables, so freeing 
> >> it is evil IMHO. I don't know that code, so I don't know if there is 
> >> some other place that will make sure that everything in
> >> kvm->arch.spapr_tce_tables will properly get freed, even when no 
> >> kvm->release
> >> function has been called (kvm_spapr_tce_release).
> >> 
> >
> >If it is really not freed, than also kvm_put_kvm(stt->kvm) is missing.
> >
> >-- 
> >
> >Thanks,
> >
> >David
> >
> 
> if (!stt) return -ENOMEM;
> kvm_get_kvm(kvm);
> if anon_inode_getfd return -ENOMEM
> The user can not determine whether kvm_get_kvm has been called
> so need add kvm_pet_kvm when anon_inode_getfd fail
> 
> stt has already been added to kvm->arch.spapr_tce_tables,
> but if anon_inode_getfd fail, stt is unused val, 
> so call list_del_rcu, and  free as quickly as possible
> 
> new patch:
> 
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index a160c14..e2228f1 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -341,8 +341,16 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> 
>         mutex_unlock(&kvm->lock);
> 
> -       return anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
> +       ret = anon_inode_getfd("kvm-spapr-tce", &kvm_spapr_tce_fops,
>                                 stt, O_RDWR | O_CLOEXEC);
> +       if (ret < 0) {
> +               mutex_lock(&kvm->lock);
> +               list_del_rcu(&stt->list);
> +               mutex_unlock(&kvm->lock);
> +               kvm_put_kvm(kvm);
> +               goto fail;
> +       }
> +       return ret;

It seems to me that it would be better to do the anon_inode_getfd()
call before the kvm_get_kvm() call, and go to the fail label if it
fails.

Paul.
