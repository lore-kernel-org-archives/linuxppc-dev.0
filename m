Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 360E81A032F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 16:42:30 +1000 (EST)
Message-ID: <1406529741.4935.48.camel@pasglop>
Subject: Re: [PATCH] powerpc: kvm: make the setup of hpte under the
 protection of KVMPPC_RMAP_LOCK_BIT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Date: Mon, 28 Jul 2014 16:42:21 +1000
In-Reply-To: <1406527744-25316-1-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1406527744-25316-1-git-send-email-pingfank@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-07-28 at 14:09 +0800, Liu Ping Fan wrote:
> In current code, the setup of hpte is under the risk of race with
> mmu_notifier_invalidate, i.e we may setup a hpte with a invalid pfn.
> Resolve this issue by sync the two actions by KVMPPC_RMAP_LOCK_BIT.

Please describe the race you think you see. I'm quite sure both Paul and
I went over that code and somewhat convinced ourselves that it was ok
but it's possible that we were both wrong :-)

Cheers,
Ben.

> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 8056107..e6dcff4 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -754,19 +754,24 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  
>  	if (hptep[0] & HPTE_V_VALID) {
>  		/* HPTE was previously valid, so we need to invalidate it */
> -		unlock_rmap(rmap);
>  		hptep[0] |= HPTE_V_ABSENT;
>  		kvmppc_invalidate_hpte(kvm, hptep, index);
>  		/* don't lose previous R and C bits */
>  		r |= hptep[1] & (HPTE_R_R | HPTE_R_C);
> +
> +		hptep[1] = r;
> +		eieio();
> +		hptep[0] = hpte[0];
> +		asm volatile("ptesync" : : : "memory");
> +		unlock_rmap(rmap);
>  	} else {
> +		hptep[1] = r;
> +		eieio();
> +		hptep[0] = hpte[0];
> +		asm volatile("ptesync" : : : "memory");
>  		kvmppc_add_revmap_chain(kvm, rev, rmap, index, 0);
>  	}
>  
> -	hptep[1] = r;
> -	eieio();
> -	hptep[0] = hpte[0];
> -	asm volatile("ptesync" : : : "memory");
>  	preempt_enable();
>  	if (page && hpte_is_writable(r))
>  		SetPageDirty(page);
