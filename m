Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tg98m3JslzDt0Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 23:48:24 +1100 (AEDT)
Subject: Re: [PATCH 07/11] powerpc/kvm: Create kvmppc_unmap_hpte_helper()
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
 <20161215055404.29351-8-david@gibson.dropbear.id.au>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c17a2bed-049b-c0cc-2bfe-28aa42ab98db@redhat.com>
Date: Fri, 16 Dec 2016 13:48:18 +0100
MIME-Version: 1.0
In-Reply-To: <20161215055404.29351-8-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.12.2016 06:54, David Gibson wrote:
> The kvm_unmap_rmapp() function, called from certain MMU notifiers, is used
> to force all guest mappings of a particular host page to be set ABSENT, and
> removed from the reverse mappings.
> 
> For HPT resizing, we will have some cases where we want to set just a
> single guest HPTE ABSENT and remove its reverse mappings.  To prepare with
> this, we split out the logic from kvm_unmap_rmapp() to evict a single HPTE,
> moving it to a new helper function.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 77 +++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 8e5ac2f..cd145eb 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -740,13 +740,53 @@ static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
>  	return kvm_handle_hva_range(kvm, hva, hva + 1, handler);
>  }
>  
> +/* Must be called with both HPTE and rmap locked */
> +static void kvmppc_unmap_hpte(struct kvm *kvm, unsigned long i,
> +			      unsigned long *rmapp, unsigned long gfn)
> +{
> +	__be64 *hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
> +	struct revmap_entry *rev = kvm->arch.hpt.rev;
> +	unsigned long j, h;
> +	unsigned long ptel, psize, rcbits;
> +
> +	j = rev[i].forw;
> +	if (j == i) {
> +		/* chain is now empty */
> +		*rmapp &= ~(KVMPPC_RMAP_PRESENT | KVMPPC_RMAP_INDEX);
> +	} else {
> +		/* remove i from chain */
> +		h = rev[i].back;
> +		rev[h].forw = j;
> +		rev[j].back = h;
> +		rev[i].forw = rev[i].back = i;
> +		*rmapp = (*rmapp & ~KVMPPC_RMAP_INDEX) | j;
> +	}
> +
> +	/* Now check and modify the HPTE */
> +	ptel = rev[i].guest_rpte;
> +	psize = hpte_page_size(be64_to_cpu(hptep[0]), ptel);
> +	if ((be64_to_cpu(hptep[0]) & HPTE_V_VALID) &&
> +	    hpte_rpn(ptel, psize) == gfn) {
> +		hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
> +		kvmppc_invalidate_hpte(kvm, hptep, i);
> +		hptep[1] &= ~cpu_to_be64(HPTE_R_KEY_HI | HPTE_R_KEY_LO);
> +		/* Harvest R and C */
> +		rcbits = be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
> +		*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
> +		if (rcbits & HPTE_R_C)
> +			kvmppc_update_rmap_change(rmapp, psize);
> +		if (rcbits & ~rev[i].guest_rpte) {
> +			rev[i].guest_rpte = ptel | rcbits;
> +			note_hpte_modification(kvm, &rev[i]);
> +		}
> +	}	

Superfluous TAB at the end of above line.

Apart from that, the patch looks fine to me.

 Thomas
