Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4DD51A0023
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 23:59:37 +1000 (AEST)
Subject: Re: [PATCH] kvm:powerpc:Fix error handling in the function
 mpic_set_default_irq_routing
To: Nicholas Krause <xerofoify@gmail.com>, agraf@suse.com
References: <1438955228-30116-1-git-send-email-xerofoify@gmail.com>
Cc: gleb@kernel.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <55C4B9C0.5030102@redhat.com>
Date: Fri, 7 Aug 2015 15:59:28 +0200
MIME-Version: 1.0
In-Reply-To: <1438955228-30116-1-git-send-email-xerofoify@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/08/2015 15:47, Nicholas Krause wrote:
> -	kvm_set_irq_routing(opp->kvm, routing, 0, 0);
> +	ret = kvm_set_irq_routing(opp->kvm, routing, 0, 0);
> +	if (ret) {
> +		kfree(routing);
> +		return ret;
> +	}
>  
>  	kfree(routing);
>  	return 0;

You could just return ret here.  The new "if" is not necessary.

Paolo
