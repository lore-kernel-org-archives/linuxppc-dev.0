Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F24381A0254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 14:30:46 +1000 (EST)
Message-ID: <1406521836.4935.44.camel@pasglop>
Subject: Re: [PATCH v3 02/18] KVM: PPC: Use RCU when adding to
 arch.spapr_tce_tables
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 28 Jul 2014 14:30:36 +1000
In-Reply-To: <53D5CD55.9050909@ozlabs.ru>
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
 <1406191691-31441-3-git-send-email-aik@ozlabs.ru>
 <1406508047.4935.21.camel@pasglop> <53D5CD55.9050909@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-28 at 14:11 +1000, Alexey Kardashevskiy wrote:
> ===
> At the moment the spapr_tce_tables list is not protected against races
> which may happen if the userspace issues the KVM_CREATE_SPAPR_TCE ioctl
> to KVM from different threads.
> 
> This makes use of _rcu helpers for list_add()/list_del().
> ===
> 
> and it is missing this bit as well (was under impression that all tables
> get freed at once at KVM exit but this might not be the case for malicious
> guest):
> 
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -211,7 +211,7 @@ static void release_spapr_tce_table(struct
> kvmppc_spapr_tce_table *stt)
>         long npages = kvmppc_stt_npages(stt->size);
> 
>         mutex_lock(&kvm->lock);
> -       list_del(&stt->list);
> +       list_del_rcu(&stt->list);
> 
> 
> 
> Would this be sufficient?

Well, not really, we'd need to see the corresponding RCU'isms when
walking the list including the rcu read lock ... which could be
problematic if we are in real mode....

Cheers,
Ben.


> 
> 
> > 
> > Cheers,
> > Ben.
> > 
> >> ---
> >>  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> >> index 54cf9bc..516f2ee 100644
> >> --- a/arch/powerpc/kvm/book3s_64_vio.c
> >> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> >> @@ -131,7 +131,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
> >>  	kvm_get_kvm(kvm);
> >>  
> >>  	mutex_lock(&kvm->lock);
> >> -	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
> >> +	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
> >>  
> >>  	mutex_unlock(&kvm->lock);
> >>  
> > 
> > 
> 
> 
