Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 252431A00F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 17:00:25 +1000 (EST)
Date: Thu, 21 Aug 2014 15:25:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4 02/16] KVM: PPC: Use RCU for arch.spapr_tce_tables
Message-ID: <20140821052508.GA10082@drongo>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
 <1406712695-9491-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406712695-9491-3-git-send-email-aik@ozlabs.ru>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2014 at 07:31:21PM +1000, Alexey Kardashevskiy wrote:
> At the moment spapr_tce_tables is not protected against races. This makes
> use of RCU-variants of list helpers. As some bits are executed in real
> mode, this makes use of just introduced list_for_each_entry_rcu_notrace().
> 
> This converts release_spapr_tce_table() to a RCU scheduled handler.

...

> @@ -106,7 +108,8 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	int i;
>  
>  	/* Check this LIOBN hasn't been previously allocated */
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> +	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables,
> +			list) {
>  		if (stt->liobn == args->liobn)
>  			return -EBUSY;
>  	}

You need something to protect this traversal of the list.  In fact...

> @@ -131,7 +134,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	kvm_get_kvm(kvm);
>  
>  	mutex_lock(&kvm->lock);
> -	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
> +	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
>  
>  	mutex_unlock(&kvm->lock);
>  

since it is the kvm->lock mutex that protects the list against
changes, you should do the check for whether the liobn is already in
the list inside the same mutex_lock ... unlock pair that protects the
list_add_rcu.

Or, if there is some other reason why two threads can't race and both
add the same liobn here, you need to explain that (and in that case
it's presumably unnecessary to hold kvm->lock).

> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
> index 89e96b3..b1914d9 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -50,7 +50,8 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
>  	/* 	    liobn, ioba, tce); */
>  
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> +	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables,
> +			list) {
>  		if (stt->liobn == liobn) {
>  			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
>  			struct page *page;
> @@ -82,7 +83,8 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>  	struct kvm *kvm = vcpu->kvm;
>  	struct kvmppc_spapr_tce_table *stt;
>  
> -	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
> +	list_for_each_entry_rcu_notrace(stt, &kvm->arch.spapr_tce_tables,
> +			list) {
>  		if (stt->liobn == liobn) {
>  			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
>  			struct page *page;

What protects these list iterations?  Do we know that interrupts are
always disabled here, or that the caller has done an rcu_read_lock or
something?  It seems a little odd that you haven't added any calls to
rcu_read_lock/unlock().

Paul.
