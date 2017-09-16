Return-Path: <prvs=42551c893=jschoenh@amazon.com>
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com
 [207.171.190.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvfrK2m7LzDrhx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Sep 2017 03:48:16 +1000 (AEST)
Subject: Re: [mainline][bisected 36ae3c0] Build fail at virt/kvm/eventfd.c:568
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1505579069.9665.22.camel@abdul.in.ibm.com>
Cc: mpe <mpe@ellerman.id>, linux-kernel <linux-kernel@vger.kernel.org>,
 sachinp <sachinp@linux.vnet.ibm.com>
From: "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>
Message-ID: <04cde7c8-d41f-96e2-2b4b-2287b8f04bfc@amazon.de>
Date: Sat, 16 Sep 2017 19:46:59 +0200
MIME-Version: 1.0
In-Reply-To: <1505579069.9665.22.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2017 06:24 PM, Abdul Haleem wrote:
> Hi,
> 
> Today's mainline kernel failed to build on powerpc with below error
> 
> arch/powerpc/kvm/../../../virt/kvm/eventfd.c: In function ‘kvm_irqfd’: 
> arch/powerpc/kvm/../../../virt/kvm/eventfd.c:568:19: error:
> ‘KVM_MAX_IRQ_ROUTES’ undeclared (first use in this function)
>   if (args->gsi >= KVM_MAX_IRQ_ROUTES)

Hmm... the header file for that constant is included...
... but it's only defined when CONFIG_HAVE_KVM_IRQ_ROUTING, which is not the case here.

We can either make that "if" conditional on that, or we revert the commit.

The commit was meant the give user space an early indication that something is wrong.
I was only aware of the IRQ routing use case. This indicates that there are other
use cases. To err on the side of caution, I'd favor a revert as the patch is not strictly
needed -- unless someone else can provide more insight on valid values for GSI.

Paolo, do you want me to prepare a revert for the commit below?

Regards
Jan


> Possible bad commit is :
> 
> commit 36ae3c0a36b7456432fedce38ae2f7bd3e01a563
> Author: Jan H. Schönherr <jschoenh@amazon.de>
> Date:   Thu Sep 7 19:02:48 2017 +0100
> 
>     KVM: Don't accept obviously wrong gsi values via KVM_IRQFD
>     
>     We cannot add routes for gsi values >= KVM_MAX_IRQ_ROUTES -- see
>     kvm_set_irq_routing(). Hence, there is no sense in accepting them
>     via KVM_IRQFD. Prevent them from entering the system in the first
>     place.
>     
>     Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index f2ac53a..c608ab4 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -565,6 +565,8 @@ kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
>  {
>         if (args->flags & ~(KVM_IRQFD_FLAG_DEASSIGN |
> KVM_IRQFD_FLAG_RESAMPLE))
>                 return -EINVAL;
> +       if (args->gsi >= KVM_MAX_IRQ_ROUTES)
> +               return -EINVAL;
>  
>         if (args->flags & KVM_IRQFD_FLAG_DEASSIGN)
>                 return kvm_irqfd_deassign(kvm, args);
> 
> 
