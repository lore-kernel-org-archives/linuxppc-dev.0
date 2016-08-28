Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMj1q5pXwzDrg5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:48:31 +1000 (AEST)
Date: Sun, 28 Aug 2016 19:48:26 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 6/6] KVM: PPC: e500: Rename jump labels in
 kvmppc_e500_tlb_init()
In-Reply-To: <165cb42e-f9fe-83ad-7c4c-299a805dbe6e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608281947430.3419@hadrien>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
 <165cb42e-f9fe-83ad-7c4c-299a805dbe6e@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sun, 28 Aug 2016, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 28 Aug 2016 18:45:26 +0200
>
> Adjust jump labels according to the current Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kvm/e500_mmu.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 0a2eeb1..da8f22b 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -933,26 +933,25 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
>  					  sizeof(struct tlbe_ref),
>  					  GFP_KERNEL);
>  	if (!vcpu_e500->gtlb_priv[0])
> -		goto err;
> +		goto free_vcpu;
>
>  	vcpu_e500->gtlb_priv[1] = kcalloc(vcpu_e500->gtlb_params[1].entries,
>  					  sizeof(struct tlbe_ref),
>  					  GFP_KERNEL);
>  	if (!vcpu_e500->gtlb_priv[1])
> -		goto err;
> +		goto free_vcpu;
>
>  	vcpu_e500->g2h_tlb1_map = kcalloc(vcpu_e500->gtlb_params[1].entries,
>  					  sizeof(*vcpu_e500->g2h_tlb1_map),
>  					  GFP_KERNEL);
>  	if (!vcpu_e500->g2h_tlb1_map)
> -		goto err;
> +		goto free_vcpu;
>
>  	vcpu_mmu_init(vcpu, vcpu_e500->gtlb_params);
>
>  	kvmppc_recalc_tlb1map_range(vcpu_e500);
>  	return 0;
> -
> -err:
> + free_vcpu:
>  	free_gtlb(vcpu_e500);
>  	return -1;

I doubt that -1 is the best return value.  One could guess that it should
be -ENOMEM.  But see what the call sites expect.

julia

>  }
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
