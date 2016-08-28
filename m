Return-Path: <julia.lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMj003XKnzDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 03:46:53 +1000 (AEST)
Date: Sun, 28 Aug 2016 19:46:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 5/6] KVM: PPC: e500: Use kmalloc_array() in
 kvmppc_e500_tlb_init()
In-Reply-To: <fd0f443b-eba8-bd99-83dd-476104f2dac0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608281946260.3419@hadrien>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c3fd4483-38d2-af0f-0e19-a7e57e120c5b@users.sourceforge.net>
 <fd0f443b-eba8-bd99-83dd-476104f2dac0@users.sourceforge.net>
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
> Date: Sun, 28 Aug 2016 18:40:08 +0200
>
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
>
> * Replace the specification of a data structure by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/kvm/e500_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> index 2be2afc4..0a2eeb1 100644
> --- a/arch/powerpc/kvm/e500_mmu.c
> +++ b/arch/powerpc/kvm/e500_mmu.c
> @@ -905,8 +905,6 @@ static int vcpu_mmu_init(struct kvm_vcpu *vcpu,
>  int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
>  {
>  	struct kvm_vcpu *vcpu = &vcpu_e500->vcpu;
> -	int entry_size = sizeof(struct kvm_book3e_206_tlb_entry);
> -	int entries = KVM_E500_TLB0_SIZE + KVM_E500_TLB1_SIZE;
>
>  	if (e500_mmu_host_init(vcpu_e500))
>  		goto err;
> @@ -921,7 +919,10 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
>  	vcpu_e500->gtlb_params[1].ways = KVM_E500_TLB1_SIZE;
>  	vcpu_e500->gtlb_params[1].sets = 1;
>
> -	vcpu_e500->gtlb_arch = kmalloc(entries * entry_size, GFP_KERNEL);
> +	vcpu_e500->gtlb_arch = kmalloc_array(KVM_E500_TLB0_SIZE +
> +					     KVM_E500_TLB1_SIZE,
> +					     sizeof(*vcpu_e500->gtlb_arch),
> +					     GFP_KERNEL);

There are changes here that are not mentioned in the commit log.

julia

>  	if (!vcpu_e500->gtlb_arch)
>  		return -ENOMEM;
>
> --
> 2.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
