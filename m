Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C47F31A001E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 20:17:56 +1000 (AEST)
Subject: Re: [PATCH] kvm:powerpc:Fix error handling in the function
 mpic_set_default_irq_routing
To: Nicholas Krause <xerofoify@gmail.com>, agraf@suse.com
References: <1438881190-27287-1-git-send-email-xerofoify@gmail.com>
Cc: gleb@kernel.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55C485CD.4040708@redhat.com>
Date: Fri, 7 Aug 2015 12:17:49 +0200
MIME-Version: 1.0
In-Reply-To: <1438881190-27287-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/08/2015 19:13, Nicholas Krause wrote:
> diff --git a/arch/powerpc/kvm/mpic.c b/arch/powerpc/kvm/mpic.c
> index 6249cdc..5a18859 100644
> --- a/arch/powerpc/kvm/mpic.c
> +++ b/arch/powerpc/kvm/mpic.c
> @@ -1641,13 +1641,16 @@ static void mpic_destroy(struct kvm_device *dev)
>  static int mpic_set_default_irq_routing(struct openpic *opp)
>  {
>  	struct kvm_irq_routing_entry *routing;
> +	int ret;
>  
>  	/* Create a nop default map, so that dereferencing it still works */
>  	routing = kzalloc((sizeof(*routing)), GFP_KERNEL);
>  	if (!routing)
>  		return -ENOMEM;
>  
> -	kvm_set_irq_routing(opp->kvm, routing, 0, 0);
> +	ret = kvm_set_irq_routing(opp->kvm, routing, 0, 0);
> +	if (ret)
> +		return ret;
>  
>  	kfree(routing);
>  	return 0;

The patch leaks the "routing" variable if you hit the error path.

Paolo
