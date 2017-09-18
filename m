Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xwlVP3bT3zDrWW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 22:21:33 +1000 (AEST)
Subject: Re: [PATCH] Revert "KVM: Don't accept obviously wrong gsi values via
 KVM_IRQFD"
To: =?UTF-8?Q?Jan_H._Sch=c3=b6nherr?= <jschoenh@amazon.de>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 sachinp@linux.vnet.ibm.com, Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 kvm@vger.kernel.org
References: <04cde7c8-d41f-96e2-2b4b-2287b8f04bfc@amazon.de>
 <1505592744-31498-1-git-send-email-jschoenh@amazon.de>
From: David Hildenbrand <david@redhat.com>
Message-ID: <860390d9-2f35-0a08-2858-c472b374c184@redhat.com>
Date: Mon, 18 Sep 2017 14:21:28 +0200
MIME-Version: 1.0
In-Reply-To: <1505592744-31498-1-git-send-email-jschoenh@amazon.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.09.2017 22:12, Jan H. Schönherr wrote:
> This reverts commit 36ae3c0a36b7456432fedce38ae2f7bd3e01a563.
> 
> The commit broke compilation on !CONFIG_HAVE_KVM_IRQ_ROUTING. Also,
> there may be cases with CONFIG_HAVE_KVM_IRQ_ROUTING, where larger
> gsi values make sense.
> 
> As the commit was meant as an early indicator to user space that
> something is wrong, reverting just restores the previous behavior
> where overly large values are ignored when encountered (without
> any direct feedback).
> 
> Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  virt/kvm/eventfd.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index c608ab4..f2ac53a 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -565,8 +565,6 @@ kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
>  {
>  	if (args->flags & ~(KVM_IRQFD_FLAG_DEASSIGN | KVM_IRQFD_FLAG_RESAMPLE))
>  		return -EINVAL;
> -	if (args->gsi >= KVM_MAX_IRQ_ROUTES)
> -		return -EINVAL;
>  
>  	if (args->flags & KVM_IRQFD_FLAG_DEASSIGN)
>  		return kvm_irqfd_deassign(kvm, args);
> 

Makes sense and shouldn't do any harm as you also mentioned.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
