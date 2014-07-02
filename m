Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0E2E1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 15:43:57 +1000 (EST)
Date: Wed, 2 Jul 2014 15:41:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6] KVM: PPC: BOOK3S: Use hpte_update_in_progress to
 track invalid hpte during an hpte update
Message-ID: <20140702054156.GD16865@drongo>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1404040655-12076-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404040655-12076-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 29, 2014 at 04:47:34PM +0530, Aneesh Kumar K.V wrote:
> As per ISA, we first need to mark hpte invalid (V=0) before we update
> the hpte lower half bits. With virtual page class key protection mechanism we want
> to send any fault other than key fault to guest directly without
> searching the hash page table. But then we can get NO_HPTE fault while
> we are updating the hpte. To track that add a vm specific atomic
> variable that we check in the fault path to always send the fault
> to host.

[...]

> @@ -750,13 +751,15 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  	r &= rcbits | ~(HPTE_R_R | HPTE_R_C);
>  
>  	if (be64_to_cpu(hptep[0]) & HPTE_V_VALID) {
> -		/* HPTE was previously valid, so we need to invalidate it */
> +		/*
> +		 * If we had mapped this hpte before, we now need to
> +		 * invalidate that.
> +		 */
>  		unlock_rmap(rmap);
> -		/* Always mark HPTE_V_ABSENT before invalidating */
> -		kvmppc_unmap_host_hpte(kvm, hptep);
>  		kvmppc_invalidate_hpte(kvm, hptep, index);
>  		/* don't lose previous R and C bits */
>  		r |= be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
> +		hpte_invalidated = true;

So now we're not setting the ABSENT bit before invalidating the HPTE.
That means that another guest vcpu could do an H_ENTER which could
think that this HPTE is free and use it for another unrelated guest
HPTE, which would be bad...

> @@ -1144,8 +1149,8 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
>  				npages_dirty = n;
>  			eieio();
>  		}
> -		kvmppc_map_host_hpte(kvm, &v, &r);
> -		hptep[0] = cpu_to_be64(v & ~HPTE_V_HVLOCK);
> +		hptep[0] = cpu_to_be64(v & ~HPTE_V_LOCK);
> +		atomic_dec(&kvm->arch.hpte_update_in_progress);

Why are we using LOCK rather than HVLOCK now?  (And why didn't you
mention this change and its rationale in the patch description?)

Paul.
