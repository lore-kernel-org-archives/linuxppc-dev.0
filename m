Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 11/27] Add book3s_64 Host MMU handling
In-reply-to: <1256917647-6200-12-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
	<1256917647-6200-12-git-send-email-agraf@suse.de>
Date: Mon, 02 Nov 2009 10:39:23 +1100
Message-ID: <7786.1257118763@neuling.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org,
	bphilips@suse.de, Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>
> +static void invalidate_pte(struct hpte_cache *pte)
> +{
> +	dprintk_mmu("KVM: Flushing SPT %d: 0x%llx (0x%llx) -> 0x%llx\n",
> +		    i, pte->pte.eaddr, pte->pte.vpage, pte->host_va);
> +
> +	ppc_md.hpte_invalidate(pte->slot, pte->host_va,
> +			       MMU_PAGE_4K, MMU_SEGSIZE_256M,
> +			       false);

Are we assuming 256M segments here (and elsewhere)?

<snip>
> +static int kvmppc_mmu_next_segment(struct kvm_vcpu *vcpu, ulong esid)
> +{
> +	int i;
> +	int max_slb_size = 64;
> +	int found_inval = -1;
> +	int r;
> +
> +	if (!get_paca()->kvm_slb_max)
> +		get_paca()->kvm_slb_max = 1;
> +
> +	/* Are we overwriting? */
> +	for (i = 1; i < get_paca()->kvm_slb_max; i++) {
> +		if (!(get_paca()->kvm_slb[i].esid & SLB_ESID_V))
> +			found_inval = i;
> +		else if ((get_paca()->kvm_slb[i].esid & ESID_MASK) == esid)
> +			return i;
> +	}
> +
> +	/* Found a spare entry that was invalidated before */
> +	if (found_inval > 0)
> +		return found_inval;
> +
> +	/* No spare invalid entry, so create one */
> +
> +	if (mmu_slb_size < 64)
> +		max_slb_size = mmu_slb_size;

Can we just use the global mmu_slb_size eliminate max_slb_size?

<snip>

Mikey
