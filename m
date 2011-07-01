Return-Path: <dave@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF597B6F62
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jul 2011 04:37:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p61IDnIb014904
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jul 2011 14:13:49 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p61IbuNi156202
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jul 2011 14:37:56 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p61Ibuvd031955
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Jul 2011 15:37:56 -0300
Subject: Re: [PATCH 10/17] KVM: PPC: Add support for Book3S processors in
	hypervisor mode
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <20110629102134.GK25406@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629102134.GK25406@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 11:37:42 -0700
Message-ID: <1309545462.16582.12.camel@nimitz>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-06-29 at 20:21 +1000, Paul Mackerras wrote: 
> +struct kvmppc_pginfo {
> +	unsigned long pfn;
> +	atomic_t refcnt;
> +};

I only see this refcnt inc'd in one spot and never decremented or read.
Is the refcnt just the number of hptes we have for this particular page
at the moment?  

> +long kvmppc_alloc_hpt(struct kvm *kvm)
> +{
> +	unsigned long hpt;
> +	unsigned long lpid;
> +
> +	hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|__GFP_NOWARN,
> +			       HPT_ORDER - PAGE_SHIFT);
> +	if (!hpt) {
> +		pr_err("kvm_alloc_hpt: Couldn't alloc HPT\n");
> +		return -ENOMEM;
> +	}
> +	kvm->arch.hpt_virt = hpt;
> +
> +	do {
> +		lpid = find_first_zero_bit(lpid_inuse, NR_LPIDS);
> +		if (lpid >= NR_LPIDS) {
> +			pr_err("kvm_alloc_hpt: No LPIDs free\n");
> +			free_pages(hpt, HPT_ORDER - PAGE_SHIFT);
> +			return -ENOMEM;
> +		}
> +	} while (test_and_set_bit(lpid, lpid_inuse));
> +
> +	kvm->arch.sdr1 = __pa(hpt) | (HPT_ORDER - 18);
> +	kvm->arch.lpid = lpid;
> +	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
> +	kvm->arch.host_lpid = mfspr(SPRN_LPID);
> +	kvm->arch.host_lpcr = mfspr(SPRN_LPCR);
> +
> +	pr_info("KVM guest htab at %lx, LPID %lx\n", hpt, lpid);
> +	return 0;
> +}

> +static unsigned long user_page_size(unsigned long addr)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long size = PAGE_SIZE;
> +
> +	down_read(&current->mm->mmap_sem);
> +	vma = find_vma(current->mm, addr);
> +	if (vma)
> +		size = vma_kernel_pagesize(vma);
> +	up_read(&current->mm->mmap_sem);
> +	return size;
> +}

That one looks pretty arch-independent and like it could use some
consolidation with: virt/kvm/kvm_main.c::kvm_host_page_size()

> +void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
> +{
> +	unsigned long i;
> +	unsigned long npages = kvm->arch.ram_npages;
> +	unsigned long pfn;
> +	unsigned long *hpte;
> +	unsigned long hash;
> +	struct kvmppc_pginfo *pginfo = kvm->arch.ram_pginfo;
> +
> +	if (!pginfo)
> +		return;
> +
> +	/* VRMA can't be > 1TB */
> +	if (npages > 1ul << (40 - kvm->arch.ram_porder))
> +		npages = 1ul << (40 - kvm->arch.ram_porder);

Is that because it can only be a single segment?  Does that mean that we
can't ever have guests larger than 1TB?  Or just that they have to live
with 1TB until they get their own page tables up?

> +	/* Can't use more than 1 HPTE per HPTEG */
> +	if (npages > HPT_NPTEG)
> +		npages = HPT_NPTEG;
> +
> +	for (i = 0; i < npages; ++i) {
> +		pfn = pginfo[i].pfn;
> +		/* can't use hpt_hash since va > 64 bits */
> +		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;

Is that because 'i' could potentially have a very large pfn?  Nish
thought it might have something to do with the hpte entries being larger
than 64-bits themselves with the vsid included, but we got thoroughly
confused. :)

-- Dave
