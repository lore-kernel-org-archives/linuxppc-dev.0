Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 071E81A03E9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 10:40:57 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 28 Jul 2014 10:40:40 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D76D73578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 10:40:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6S0NkLP66125882
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 10:23:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6S0elEF026881
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 10:40:48 +1000
Message-ID: <1406508047.4935.21.camel@pasglop>
Subject: Re: [PATCH v3 02/18] KVM: PPC: Use RCU when adding to
 arch.spapr_tce_tables
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 28 Jul 2014 10:40:47 +1000
In-Reply-To: <1406191691-31441-3-git-send-email-aik@ozlabs.ru>
References: <1406191691-31441-1-git-send-email-aik@ozlabs.ru>
 <1406191691-31441-3-git-send-email-aik@ozlabs.ru>
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

On Thu, 2014-07-24 at 18:47 +1000, Alexey Kardashevskiy wrote:
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

You need a much better changeset here, explaining what you are
protecting against and why just changing that one list_add is
sufficient.

Cheers,
Ben.

> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index 54cf9bc..516f2ee 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -131,7 +131,7 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>  	kvm_get_kvm(kvm);
>  
>  	mutex_lock(&kvm->lock);
> -	list_add(&stt->list, &kvm->arch.spapr_tce_tables);
> +	list_add_rcu(&stt->list, &kvm->arch.spapr_tce_tables);
>  
>  	mutex_unlock(&kvm->lock);
>  
