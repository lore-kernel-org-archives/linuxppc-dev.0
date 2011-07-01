Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64081B6F5C
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jul 2011 05:12:33 +1000 (EST)
Subject: Re: [PATCH 10/17] KVM: PPC: Add support for Book3S processors in
	hypervisor mode
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1309545462.16582.12.camel@nimitz>
Date: Fri, 1 Jul 2011 21:12:28 +0200
Message-Id: <9F7C3B4B-A39A-453D-95BC-6630638A0C56@suse.de>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
	<20110629102134.GK25406@bloggs.ozlabs.ibm.com>
	<1309545462.16582.12.camel@nimitz>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 01.07.2011, at 20:37, Dave Hansen wrote:

> On Wed, 2011-06-29 at 20:21 +1000, Paul Mackerras wrote:=20
>> +struct kvmppc_pginfo {
>> +	unsigned long pfn;
>> +	atomic_t refcnt;
>> +};
>=20
> I only see this refcnt inc'd in one spot and never decremented or =
read.
> Is the refcnt just the number of hptes we have for this particular =
page
> at the moment? =20
>=20
>> +long kvmppc_alloc_hpt(struct kvm *kvm)
>> +{
>> +	unsigned long hpt;
>> +	unsigned long lpid;
>> +
>> +	hpt =3D =
__get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|__GFP_NOWARN,
>> +			       HPT_ORDER - PAGE_SHIFT);
>> +	if (!hpt) {
>> +		pr_err("kvm_alloc_hpt: Couldn't alloc HPT\n");
>> +		return -ENOMEM;
>> +	}
>> +	kvm->arch.hpt_virt =3D hpt;
>> +
>> +	do {
>> +		lpid =3D find_first_zero_bit(lpid_inuse, NR_LPIDS);
>> +		if (lpid >=3D NR_LPIDS) {
>> +			pr_err("kvm_alloc_hpt: No LPIDs free\n");
>> +			free_pages(hpt, HPT_ORDER - PAGE_SHIFT);
>> +			return -ENOMEM;
>> +		}
>> +	} while (test_and_set_bit(lpid, lpid_inuse));
>> +
>> +	kvm->arch.sdr1 =3D __pa(hpt) | (HPT_ORDER - 18);
>> +	kvm->arch.lpid =3D lpid;
>> +	kvm->arch.host_sdr1 =3D mfspr(SPRN_SDR1);
>> +	kvm->arch.host_lpid =3D mfspr(SPRN_LPID);
>> +	kvm->arch.host_lpcr =3D mfspr(SPRN_LPCR);
>> +
>> +	pr_info("KVM guest htab at %lx, LPID %lx\n", hpt, lpid);
>> +	return 0;
>> +}
>=20
>> +static unsigned long user_page_size(unsigned long addr)
>> +{
>> +	struct vm_area_struct *vma;
>> +	unsigned long size =3D PAGE_SIZE;
>> +
>> +	down_read(&current->mm->mmap_sem);
>> +	vma =3D find_vma(current->mm, addr);
>> +	if (vma)
>> +		size =3D vma_kernel_pagesize(vma);
>> +	up_read(&current->mm->mmap_sem);
>> +	return size;
>> +}
>=20
> That one looks pretty arch-independent and like it could use some
> consolidation with: virt/kvm/kvm_main.c::kvm_host_page_size()

Yep, I'd deem that a cleanup for later though. Good point however! We =
have similar code in e500 kvm today.

>=20
>> +void kvmppc_map_vrma(struct kvm *kvm, struct =
kvm_userspace_memory_region *mem)
>> +{
>> +	unsigned long i;
>> +	unsigned long npages =3D kvm->arch.ram_npages;
>> +	unsigned long pfn;
>> +	unsigned long *hpte;
>> +	unsigned long hash;
>> +	struct kvmppc_pginfo *pginfo =3D kvm->arch.ram_pginfo;
>> +
>> +	if (!pginfo)
>> +		return;
>> +
>> +	/* VRMA can't be > 1TB */
>> +	if (npages > 1ul << (40 - kvm->arch.ram_porder))
>> +		npages =3D 1ul << (40 - kvm->arch.ram_porder);
>=20
> Is that because it can only be a single segment?  Does that mean that =
we
> can't ever have guests larger than 1TB?  Or just that they have to =
live
> with 1TB until they get their own page tables up?

The VRMA is only important in real mode, so this part looks good. The =
RMA is usually a lot smaller than 1TB ;).


Alex
