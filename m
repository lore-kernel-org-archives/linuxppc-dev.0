Return-Path: <daniel.black@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxnkc17qxzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:05:43 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8K549cu081085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 01:05:41 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3cbnhp88-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 01:05:40 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <daniel.black@au1.ibm.com>;
 Wed, 20 Sep 2017 15:05:38 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8K55aYk21954804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:05:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8K55Qmr003430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 15:05:27 +1000
Subject: Re: [PATCH] KVM: KVM_MAX_IRQ_ROUTES only defined with
 CONFIG_HAVE_KVM_IRQ_ROUTING
To: linuxppc-dev@lists.ozlabs.org, pbonzini@redhat.com
Cc: trivial@kernel.org, abdhalee@linux.vnet.ibm.com,
 sachinp@linux.vnet.ibm.com, jschoenh@amazon.de
References: <1505579069.9665.22.camel@abdul.in.ibm.com>
 <20170920013139.13329-1-daniel.black@au.ibm.com>
From: Daniel Black <daniel.black@au1.ibm.com>
Date: Wed, 20 Sep 2017 15:05:34 +1000
MIME-Version: 1.0
In-Reply-To: <20170920013139.13329-1-daniel.black@au.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <1361143c-7a68-5f8a-4387-4218bf5935a1@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Apologies, just noticed 95e2a3b3ef177730019e3799917193595133b275 being
the revert of 36ae3c0a36b7

On 20/09/17 11:31, Daniel Black wrote:
> Commit 36ae3c0a36b7 introduced code using KVM_MAX_IRQ_ROUTES. This
> define isn't available on all platforms. As it is dependent on
> CONFIG_HAVE_KVM_IRQ_ROUTING this define is used to enable the code
> in 36ae3c0a36b7.
> 
> Fixes: 36ae3c0a36b7 ("KVM: Don't accept obviously wrong gsi values via KVM_IRQFD")
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Suggested-by: Jan H. Schönherr <jschoenh@amazon.de>
> Signed-off-by: Daniel Black <daniel.black@au.ibm.com>
> ---
>  virt/kvm/eventfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index c608ab4..75910dd 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -565,8 +565,10 @@ kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
>  {
>  	if (args->flags & ~(KVM_IRQFD_FLAG_DEASSIGN | KVM_IRQFD_FLAG_RESAMPLE))
>  		return -EINVAL;
> +#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>  	if (args->gsi >= KVM_MAX_IRQ_ROUTES)
>  		return -EINVAL;
> +#endif
>  
>  	if (args->flags & KVM_IRQFD_FLAG_DEASSIGN)
>  		return kvm_irqfd_deassign(kvm, args);
> 
