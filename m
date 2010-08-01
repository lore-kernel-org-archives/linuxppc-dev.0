Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 22663B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  2 Aug 2010 00:08:51 +1000 (EST)
Message-ID: <4C557FF1.4000400@redhat.com>
Date: Sun, 01 Aug 2010 17:08:49 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 4/7] KVM: PPC: Add book3s_32 tlbie flush acceleration
References: <1280408662-10328-1-git-send-email-agraf@suse.de>
	<1280408662-10328-5-git-send-email-agraf@suse.de>
In-Reply-To: <1280408662-10328-5-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 07/29/2010 04:04 PM, Alexander Graf wrote:
> On Book3s_32 the tlbie instruction flushed effective addresses by the mask
> 0x0ffff000. This is pretty hard to reflect with a hash that hashes ~0xfff, so
> to speed up that target we should also keep a special hash around for it.
>
>
>   static inline u64 kvmppc_mmu_hash_vpte(u64 vpage)
>   {
>   	return hash_64(vpage&  0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
> @@ -66,6 +72,11 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
>   	index = kvmppc_mmu_hash_pte(pte->pte.eaddr);
>   	hlist_add_head_rcu(&pte->list_pte,&vcpu->arch.hpte_hash_pte[index]);
>
> +	/* Add to ePTE_long list */
> +	index = kvmppc_mmu_hash_pte_long(pte->pte.eaddr);
> +	hlist_add_head_rcu(&pte->list_pte_long,
> +			&vcpu->arch.hpte_hash_pte_long[index]);
> +

Isn't it better to make operations on this list conditional on 
Book3s_32?  Hashes are expensive since they usually cost cache misses.

Can of course be done later as an optimization.

-- 
error compiling committee.c: too many arguments to function
